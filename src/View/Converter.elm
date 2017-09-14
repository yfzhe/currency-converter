module View.Converter exposing (view)

import Html exposing (Html, div, text, input)
import Html.Attributes exposing (type_, value, class)
import Html.Events exposing (on, targetValue)
import Json.Decode as Decode
import Msgs exposing (Msg)
import Models exposing (Model)
import View.Select.Currency exposing (currencySelect)
import Type.Position exposing (Position(..), getOn)


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ div [ class "form-part" ]
            [ currencySelect Left model.currencies
            , valueInput Left model.values
            ]
        , div [ class "equals-sign" ]
            [ text "=" ]
        ,  div [ class "form-part" ]
            [ currencySelect Right model.currencies
            , valueInput Right model.values
            ]
        ]


valueInput : Position -> ( Float, Float ) -> Html Msg
valueInput pos values =
    input 
        [ class "input-value"
        , type_ "number"
        , value <| toString <| getOn pos values
        , on "input"
            <| Decode.map
                ( Msgs.InputValue pos << Result.withDefault 0 << String.toFloat )
                targetValue
        ]
        []

