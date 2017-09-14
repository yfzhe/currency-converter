module Navbar exposing (navbar)

import Html exposing (Html, nav, ul, li, text)
import Html.Attributes 
import Html.Events exposing (onClick)
import Msgs exposing (Msg)

navbar : Html Msg
navbar = 
    nav []
        [ ul []
            [ li [] [ text "汇率转换" ]
            , li [] [ text "多数据处理" ]
            , li [] [ text "历史汇率" ]
            ]
        ]