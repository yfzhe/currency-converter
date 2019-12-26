module Main exposing (main)

import Browser
import Command exposing (fetchRates)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Update exposing (update)
import View exposing (view)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, fetchRates )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
