module View exposing (view)

import Html exposing (Html, text)
import Msgs exposing (Msg)
import Models exposing (Model)
import View.Converter


view : Model -> Html Msg
view model =
    View.Converter.view model
