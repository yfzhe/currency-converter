module View exposing (view)

import Html exposing (Html, div, text, p, a, span, nav, ul, li)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Msgs exposing (Msg)
import Models exposing (Model, Route(..))
import RemoteData
import View.Converter
import View.Multiline


view : Model -> Html Msg
view model =
    let 
        main = 
            case model.route of
                ConverterRoute ->
                    View.Converter.view model
        
                MultilineRoute ->
                    View.Multiline.view model
    in
        div []
            [ navbar
            , header 
            , main 
            , dataState model
            , pageInfo
            ]



header : Html msg
header = 
    Html.header [] [ text "简单的汇率转换" ]

navbar : Html Msg
navbar = 
    nav []
        [ ul []
            [ li [ onClick <| Msgs.ChangeLocation ConverterRoute ] [ text "汇率转换" ]
            , li [ onClick <| Msgs.ChangeLocation MultilineRoute ] [ text "多数据处理" ]
            , li [] [ text "历史汇率" ]
            ]
        ]


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