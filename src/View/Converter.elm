module View.Converter exposing (view)

import Html exposing (Html, div, text, input, hr)
import Html.Attributes exposing (type_, value, class)
import Html.Events exposing (on, targetValue)
import Json.Decode as Decode
import Msgs exposing (Msg)
import Models exposing (Model)
import View.Info exposing (dataState, pageInfo)
import View.Select.Currency exposing (currencySelect)
import Type.Position exposing (Position(..), getOn)


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

