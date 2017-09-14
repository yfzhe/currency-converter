module View exposing (view)

import Html exposing (Html, text)
import Msgs exposing (Msg)
import Models exposing (Model, Route(..))
import View.Converter
import View.Multiline


view : Model -> Html Msg
view model =
    case model.route of
        ConverterRoute ->
            View.Converter.view model
        
        MultilineRoute ->
            View.Multiline.view model
