module Main exposing (main)

import Browser
import Converter
import Html exposing (Html)
import Page
import Rates exposing (Rates, fetchRates)
import RemoteData exposing (WebData)

-- MODEL
type alias Model =
  { rates : WebData Rates
  , converter : Converter.Model
  }

initialModel : Model
initialModel =
  { rates = RemoteData.NotAsked
  , converter = Converter.initialModel
  }

-- MESSAGES
type Msg
  = OnFetchRates (WebData Rates)
  | ConverterMsg Converter.Msg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    OnFetchRates response ->
      let
        newModel =
          { model | rates = response }
      in
        ( newModel, Cmd.none )

    ConverterMsg subMsg ->
      case model.rates of
        RemoteData.Success rates ->
          let
            ( subModel, subCmd ) =
              Converter.update subMsg model.converter rates

            newModel =
              { model | converter = subModel }
          in
            ( newModel, Cmd.map ConverterMsg subCmd)

        -- FIXME: update when not loaded
        _ ->
          ( model, Cmd.none)

-- VIEW
view : Model -> Html Msg
view model =
  let
    main_ =
      Converter.view model.converter model.rates
  in
    Page.base ConverterMsg main_

-- MAIN
init : () -> ( Model, Cmd Msg )
init _ =
  ( initialModel
  , Cmd.map OnFetchRates fetchRates
  )

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

main : Program () Model Msg
main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
