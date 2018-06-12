module Update exposing (update)

import Converter.Update exposing (updateConverterData)
import Models exposing (Currency, Model, Rates)
import Msgs exposing (Msg)
import Position exposing (Position, getOn, opposite, updateOn)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchRates response ->
            ( { model | rates = response }, Cmd.none )

        Msgs.Router route ->
            ( { model | route = route }, Cmd.none )

        Msgs.SelectCurrency pos currency ->
            let
                data =
                    model.converter
                currencies =
                    data.currencies
                tempData =
                    { data | currencies = updateOn pos currency currencies }
                tempModel = 
                    { model | converter = tempData}
            in
            updateConverterData pos tempModel

        Msgs.InputValue pos num ->
            let
                data = 
                    model.converter
                tempValues =
                    updateOn pos num data.values
                tempData = 
                    { data | values = tempValues }
                tempModel =
                    { model | converter = tempData }
            in
                updateConverterData (opposite pos) tempModel

        Msgs.NewError error ->
            -- TODO: update error info
            ( model, Cmd.none )
