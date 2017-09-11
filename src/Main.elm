module Main exposing (..)

import Commands exposing (fetchRates)
import Html
import Msgs exposing (Msg)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)


main : Program Never Model Msg
main = 
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

init : ( Model, Cmd Msg )
init = 
    ( initialModel, fetchRates )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
