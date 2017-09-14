module View.Info exposing (dataState, pageInfo)

import Html exposing (Html, div, text, p, a, span)
import Html.Attributes exposing (class, href)
import Models exposing (Model)
import RemoteData


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