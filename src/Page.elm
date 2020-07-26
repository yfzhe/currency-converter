module Page exposing (base)

import Html exposing (Html, div, text, p, span, a)
import Html.Attributes exposing (class, href)

base : (a -> msg) -> List (Html a) -> Html msg
base transformer main_ =
  let
    wrappedMain_ =
      div [ class "main" ] main_
        |> Html.map transformer
  in
    div []
        [ header
        , wrappedMain_
        , pageInfo
        ]

header : Html msg
header =
  let
    title =
      Html.header [ class "title" ] [ text "简单的汇率转换" ]
  in
    div [ class "header" ] [ title ]

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
