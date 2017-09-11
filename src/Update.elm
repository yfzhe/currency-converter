module Update exposing (update)

import Commands exposing (updateConverterValues)
import Msgs exposing (Msg)
import Models exposing (Model, Currency, Rates, ConverterInputs, Position(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchRates response ->
            ( { model | rates = response }, Cmd.none )
        
        Msgs.SelectCurrency pos currency ->
            let
                inputs =
                    model.converterInputs
                updatedValues =
                    if 
                        pos == Left
                    then
                        { inputs | currencyLeft = currency }
                    else 
                        { inputs | currencyRight = currency }
                updatedModel =
                        { model | converterInputs = updatedValues }
            in
                ( updatedModel, updateConverterValues pos updatedModel )
        
        Msgs.InputValue pos num ->
            let
                inputs =
                    model.converterInputs
                updatedValues =
                    if 
                        pos == Left
                    then
                        { inputs | valueLeft = num }
                    else 
                        { inputs | valueRight = num }
                pos_ =
                    if pos == Left then Right else Left
                updatedModel =
                        { model | converterInputs = updatedValues } 
            in
                ( updatedModel, updateConverterValues pos_ updatedModel )
        
        Msgs.UpdateValues values ->
            ( { model | converterInputs = values }, Cmd.none )

        Msgs.NewError error ->
            -- TODO: update error info
            ( model, Cmd.none )

