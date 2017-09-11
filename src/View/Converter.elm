module View.Converter exposing (view)

import Html exposing (Html, div, text, select, option, input)
import Html.Attributes exposing (type_, selected, value, class)
import Html.Events exposing (on, targetValue)
import Json.Decode as Decode
import Msgs exposing (Msg)
import Models exposing (Model, Currency, currencyList, Rates, ConverterInputs, Position(..))
import RemoteData exposing (WebData)


view : Model -> Html Msg
view model =
    div [] 
        [ div [ class "board" ]
            [ div [ class "header" ]
                [ text "简单的汇率转换" ]
            , div [ class "form" ]
                [ div [ class "form-part" ]
                    [ valueInputLeft model.converterInputs
                    , currencySelectLeft model.converterInputs
                    ]
                , div [ class "equals-sign" ]
                    [ text "=" ]
                ,  div [ class "form-part" ]
                    [ valueInputRight model.converterInputs
                    , currencySelectRight model.converterInputs
                    ]
                ]
            ]
        , info model
        ]


currencySelectLeft : ConverterInputs -> Html Msg
currencySelectLeft inputs =
    select 
        [ on "change" 
            <| Decode.map (Msgs.SelectCurrency Left) targetValue 
        , class "select-currency"
        ]
        <| List.map (currencySelectOption inputs.currencyLeft) currencyList

currencySelectRight : ConverterInputs -> Html Msg
currencySelectRight inputs =
    select 
        [ on "change" 
            <| Decode.map (Msgs.SelectCurrency Right) targetValue 
        , class "select-currency"
        ]
        <| List.map (currencySelectOption inputs.currencyRight) currencyList


currencySelectOption : Currency -> ( Currency, String ) -> Html Msg
currencySelectOption default ( currency, name ) =
    option
        [ selected <| if currency == default then True else False
        , value currency 
        , class "option-currency" 
        ]
        [ text <| name ++ " (" ++ currency ++ ")" ]

valueInputLeft : ConverterInputs -> Html Msg
valueInputLeft inputs =
    input 
        [ type_ "number"
        , value <| toString inputs.valueLeft
        , on "input" 
            <| Decode.map 
                ((Msgs.InputValue Left) << Result.withDefault 0 << String.toFloat) 
                targetValue 
        , class "input-value"
        ] 
        []

valueInputRight : ConverterInputs -> Html Msg
valueInputRight inputs =
    input 
        [ type_ "number"
        , value <| toString inputs.valueRight
        , on "input"
            <| Decode.map
                  ((Msgs.InputValue Right) << Result.withDefault 0 << String.toFloat)
                  targetValue
        , class "input-value"
        ]
        []


info : Model -> Html msg
info model = 
    let
        responseInfo = 
            case model.rates of
                RemoteData.NotAsked ->
                    ""

                RemoteData.Loading ->
                    "Loading"
        
                RemoteData.Success rates ->
                    "汇率数据更新时间: " ++ rates.date
        
                RemoteData.Failure error ->
                    toString error 
    in
        div [ class "info" ] [ text responseInfo ]
