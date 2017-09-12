module View.Select.Currency exposing (currencySelect)

import Html exposing (Html, select, option, text)
import Html.Attributes exposing (class, selected, value)
import Html.Events exposing (on, targetValue)
import Json.Decode as Decode
import Msgs exposing (Msg)
import Type exposing (Currency, Position)
import Type.Currency exposing (currencyList)
import Type.Position exposing (getOn)

currencySelect : Position -> ( Currency, Currency ) -> Html Msg
currencySelect pos currencies =
    select 
        [ class "select-currency"
        , on "change" 
            <| Decode.map (Msgs.SelectCurrency pos) targetValue 
        ]
        <| List.map 
            (currencySelectOption <| getOn pos currencies) 
            currencyList

currencySelectOption : Currency -> ( Currency, String ) -> Html Msg
currencySelectOption default ( currency, name ) =
    option
        [ selected <| if currency == default then True else False
        , value currency 
        , class "option-currency" 
        ]
        [ text <| name ++ " (" ++ currency ++ ")" ]