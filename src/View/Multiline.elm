module View.Multiline exposing (view)

import Convert exposing (convert)
import Html exposing (Html, div, text, textarea, p)
import Html.Attributes exposing (class, rows)
import Html.Events exposing (onInput)
import Msgs exposing (Msg)
import Models exposing (Model, Currency, Rates)
import RemoteData 
import Type.Position exposing (Position(..))
import View.Select.Currency exposing (currencySelect)

view : Model -> Html Msg
view model = 
    div [ class "main" ]
        [ div [ class "form-part" ]
            [ currencySelect Left model.currencies
            , input
            ]
        , div [ class "equals-sign" ]
            [ text "=" ]
        ,  div [ class "form-part" ]
            [ currencySelect Right model.currencies
            , output model
            ]
        ]


input : Html Msg
input = 
    textarea 
        [ onInput Msgs.MultilineInput 
        , rows 10
        , class "input-multiline"
        ]
        []

output : Model -> Html msg
output model = 
    let 
        response = 
            model.rates
        inputs = 
            model.multiline
    in
        case response of
            RemoteData.Success rates ->
                div 
                    [ class "output-multiline" ]
                    <| List.map 
                        (convertLine model.currencies rates)
                        <| String.lines inputs
            
            _ ->
                div [ class "output-multiline" ]
                    [ text "Error" ]


convertLine : (Currency, Currency) -> Rates -> String -> Html msg
convertLine ( base, target ) rates str =
    let 
        value = 
            String.toFloat str
    in
        case value of
            Ok num ->
                let 
                    result = 
                        convert num base target rates
                in
                    case result of
                        Just converted ->
                            p [] 
                                [ text <| toString converted ]
                        
                        Nothing ->
                            p []
                                [ text "NaN" ]
            
            Err error ->
                p []
                    [ text "NaN" ] 
                            
                            
