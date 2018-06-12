module Component.CurrencySelect exposing (currencySelect)

import Data.Currency exposing (currencyDict)
import Dict
import Html exposing (Html, option, select, text)
import Html.Attributes exposing (class, selected, value)
import Html.Events exposing (on, targetValue)
import Json.Decode as Decode
import Models exposing (Currency)
import Msgs exposing (Msg)
import Position exposing (Position, getOn)


currencySelect : Position -> ( Currency, Currency ) -> Html Msg
currencySelect pos currencies =
    select
        [ class "select-currency"
        , on "change" <|
            Decode.map (Msgs.SelectCurrency pos) targetValue
        ]
    <|
        List.map
            (currencySelectOption <| getOn pos currencies)
        <|
            Dict.toList currencyDict


currencySelectOption : Currency -> ( Currency, String ) -> Html Msg
currencySelectOption default ( currency, name ) =
    option
        [ selected <|
            if currency == default then
                True
            else
                False
        , value currency
        , class "option-currency"
        ]
        [ text <| name ++ " (" ++ currency ++ ")" ]
