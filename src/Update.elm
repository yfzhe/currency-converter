module Update exposing (update)

import Command exposing (updateValues)
import Dict
import Msgs exposing (Msg)
import Models exposing (Model)
import RemoteData 
import Type exposing (Rates, Currency, Position)
import Type.Position exposing (opposite, updateOn)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchRates response ->
            ( { model | rates = response }, Cmd.none )
        
        Msgs.SelectCurrency pos currency ->
            let
                updatedCurrencies = 
                    updateOn pos currency model.currencies
                updatedModel = 
                        { model | currencies = updatedCurrencies }
            in
                ( updatedModel, updateValues pos updatedModel )
        
        Msgs.InputValue pos num ->
            let
                updatedValues =
                    updateOn pos num model.values
                updatedModel =
                        { model | values = updatedValues } 
            in
                ( updatedModel, updateValues (opposite pos) updatedModel )
        
        Msgs.UpdateValues values ->
            ( { model | values = values }, Cmd.none )

        Msgs.NewError error ->
            -- TODO: update error info
            ( model, Cmd.none )

