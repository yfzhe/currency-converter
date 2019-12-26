module View exposing (view)

import Chart.View
import Converter.View
import Html exposing (Html, a, div, li, nav, p, span, text, ul)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Models exposing (Model, Route(..))
import Msgs exposing (Msg)
import RemoteData


view : Model -> Html Msg
view model =
    div []
        [ header

        --, navbar
        , main_ model
        , pageInfo
        ]


main_ : Model -> Html Msg
main_ model =
    case model.route of
        ConverterRoute ->
            Converter.View.view model.converter

        ChartRoute ->
            Chart.View.view model.chart


header : Html msg
header =
    let
        title =
            Html.header [ class "title" ] [ text "简单的汇率转换" ]
    in
    div [ class "header" ] [ title ]


navbar : Html Msg
navbar =
    nav [ class "navbar" ]
        [ ul []
            [ li [ onClick <| Msgs.Router ConverterRoute ] [ text "汇率转换" ]
            , li [ onClick <| Msgs.Router ChartRoute ] [ text "历史汇率" ]
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
                    ""

                RemoteData.Failure error ->
                    "Fetch error"
    in
    div [ class "info-update" ] [ text dataStateInfo ]


pageInfo : Html msg
pageInfo =
    div [ class "about" ]
        [ p []
            [ a
                [ class "lang-en"
                , href "https://github.com/yfzhe"
                ]
                [ text "@yfzhe" ]
            , text "制作 "
            , a
                [ class "lang-en"
                , href "https://github.com/yfzhe/currency-converter"
                ]
                [ span [ class "leng-en" ]
                    [ text "GitHub" ]
                , text "仓库"
                ]
            ]
        , p []
            [ text "使用"
            , a [ href "http://exchangerate-api.com" ] [ text "ExchangeRate-API" ]
            , text "提供的汇率"
            , span [ class "lang-en" ] [ text "api" ]
            ]
        ]
