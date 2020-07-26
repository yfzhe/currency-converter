module Converter exposing
  ( Model
  , initialModel
  , Msg
  , update
  , view
  )

import Currency exposing (Currency, currencyDict)
import Dict
import Json.Decode as Decode
import Html exposing (Html, div, text, select, option, input)
import Html.Attributes as Attr exposing (class, value)
import Html.Events exposing (on, targetValue)
import Rates exposing (Rates, getRate)
import RemoteData exposing (WebData)

-- MODEL
type alias Part =
  { currency : Currency
  , value : Float
  }

type Position = Left | Right

type alias Model =
  { left : Part
  , right : Part
  , usd : Float
  }

initialModel : Model
initialModel =
  { left = Part "CNY" 0
  , right = Part "USD" 0
  , usd = 0
  }

usdToPart : Rates -> Float -> Currency -> Part
usdToPart rates usd currency =
  let
    rate = getRate rates currency
  in
    Part currency (usd * rate)

partToUsd : Rates -> Part -> Float
partToUsd rates { currency, value } =
  let
    rate = getRate rates currency
  in
    value / rate

-- MESSAGES
type Msg
  = Noop
  | SelectCurrecy Position Currency
  | ChangeValue Position Float

update : Msg -> Model -> Rates -> ( Model, Cmd Msg )
update msg model rates =
  case msg of
    Noop ->
      ( model, Cmd.none )

    -- NOTE: how to abstact the pattern below?
    SelectCurrecy Left currency ->
      let
        left = model.left
        newLeft = usdToPart rates model.usd currency
        newModel = { model | left = newLeft }
      in
        ( newModel, Cmd.none )

    SelectCurrecy Right currency ->
      let
        right = model.right
        newRight = usdToPart rates model.usd currency
        newModel = { model | right = newRight }
      in
        ( newModel, Cmd.none )

    ChangeValue Left value ->
      let
        left = model.left
        newLeft = { left | value = value }
        usd = partToUsd rates newLeft
        newRight = usdToPart rates usd model.right.currency
        newModel = Model newLeft newRight usd
      in
        ( newModel, Cmd.none )

    ChangeValue Right value ->
      let
        right = model.right
        newRight = { right | value = value }
        usd = partToUsd rates newRight
        newLeft = usdToPart rates usd model.left.currency
        newModel = Model newLeft newRight usd
      in
        ( newModel, Cmd.none )

-- VIEW
view : Model -> WebData Rates -> List (Html Msg)
view model rates =
  let
    loaded =
      RemoteData.isSuccess rates

    partView { currency, value } pos =
      div [ class "currency" ]
          [ currencySelect currency <| SelectCurrecy pos
          , valueInput value (not loaded) <| ChangeValue pos
          ]
  in
    [ partView model.left Left
    , div [ class "equals-sign" ]
          [ text "=" ]
    , partView model.right Right
    ]

-- COMPONENTS
currencySelect : Currency -> (Currency -> msg) -> Html msg
currencySelect selected mkMsg =
  let
    makeOption (currency, name) =
      option [ value currency
             , Attr.selected (selected == currency)
             , class "option-currency"
             ]
             [ text <| name ++ " (" ++ currency ++ ")" ]
  in
    Dict.toList currencyDict
      |> List.map makeOption
      |> select [ class "select-currency"
                , on "change" <| Decode.map mkMsg targetValue
                ]

valueInput : Float -> Bool -> (Float -> msg) -> Html msg
valueInput value disabled mkMsg =
  input
    [ class "input-value"
    , Attr.type_ "string"
    , Attr.disabled disabled
    , Attr.value <| String.fromFloat value
    , on "input" <|
        Decode.map
          (mkMsg << Maybe.withDefault 0 << String.toFloat)
          targetValue
    ]
    []
