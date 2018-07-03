module Converter.View exposing (view)

import Component.CurrencySelect exposing (currencySelect)
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (class, type_, value)
import Html.Events exposing (on, targetValue)
import Json.Decode as Decode
import Models exposing (ConverterData)
import Msgs exposing (Msg)
import Position exposing (Position(..), getOn)


view : ConverterData -> Html Msg
view data =
    div [ class "main" ]
        [ div [ class "currency" ]
            [ currencySelect Left data.currencies
            , valueInput Left data.values
            ]
        , div [ class "equals-sign" ]
            [ text "=" ]
        , div [ class "currency" ]
            [ currencySelect Right data.currencies
            , valueInput Right data.values
            ]
        ]


valueInput : Position -> ( Float, Float ) -> Html Msg
valueInput pos values =
    input
        [ class "input-value"
        , type_ "number"
        , value <| toString <| getOn pos values
        , on "input" <|
            Decode.map
                (Msgs.InputValue pos << Result.withDefault 0 << String.toFloat)
                targetValue
        ]
        []
