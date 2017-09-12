module View.Converter exposing (view)

import Html exposing (Html, div, text, input, hr, p, a, span)
import Html.Attributes exposing (type_, value, class, href)
import Html.Events exposing (on, targetValue)
import Json.Decode as Decode
import Msgs exposing (Msg)
import Models exposing (Model)
import RemoteData 
import View.Select.Currency exposing (currencySelect)
import Type exposing (Position(..))
import Type.Position exposing (getOn)


view : Model -> Html Msg
view model =
    div [ class "main" ] 
        [ div [ class "board" ]
            [ div [ class "header" ]
                [ text "简单的汇率转换" ]
            , div [ class "form" ]
                [ div [ class "form-part" ]
                    [ valueInput Left model.values
                    , hr [] []
                    , currencySelect Left model.currencies
                    ]
                , div [ class "equals-sign" ]
                    [ text "=" ]
                ,  div [ class "form-part" ]
                    [ valueInput Right model.values
                    , hr [] [] 
                    , currencySelect Right model.currencies
                    ]
                ]
            , dataState model
            ]
        , pageInfo
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


dataState : Model -> Html msg
dataState model = 
    let
        dataStateInfo = 
            case model.rates of
                RemoteData.NotAsked ->
                    ""

                RemoteData.Loading ->
                    "Loading..."
        
                RemoteData.Success rates ->
                    "汇率数据更新时间: " ++ rates.date
        
                RemoteData.Failure error ->
                    toString error 
    in
        div [ class "info-update" ] [ text dataStateInfo ]


pageInfo : Html msg
pageInfo = 
    div [ class "info-page" ] 
        [ p [] 
            [ text "使用"
            , a [ href "http://fixer.io"] [ text "fixer.io" ]
            , text "提供的汇率"
            , span [ class "lang-en" ] [ text "api" ]
            ]
        , p []
            [ text "Made by @yfzhe with 🧡" ]
        ]