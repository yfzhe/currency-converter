module Commands exposing (fetchRates, updateConverterValues)

import Dict
import Http 
import JsonDecoder exposing (ratesDecoder)
import Msgs exposing (Msg)
import Models exposing (Model, Rates, Currency, ConverterInputs, Position(..))
import RemoteData
import Result exposing (Result(..))
import Task exposing (Task)


fetchRates : Cmd Msg
fetchRates = 
    Http.get ratesUrl ratesDecoder 
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchRates


fetchRatesBase : Currency -> Cmd Msg
fetchRatesBase currency =
    Http.get (ratesUrlBase currency) ratesDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchRates


ratesUrl : String
ratesUrl = 
    "http://api.fixer.io/latest"

ratesUrlBase : Currency -> String
ratesUrlBase currency = 
    "http://api.fixer.io/latest?base=" ++ currency


updateConverterValues : Position -> Model -> Cmd Msg
updateConverterValues pos model =
    Task.attempt handleUpdateResult <| updateValuesTask pos model

handleUpdateResult : Result String ConverterInputs -> Msg
handleUpdateResult result =
    case result of
        Ok values ->
            Msgs.UpdateValues values
        
        Err error ->
            Msgs.NewError error

updateValuesTask : Position -> Model -> Task String ConverterInputs
updateValuesTask pos model =
    case model.rates of
        RemoteData.NotAsked ->
            Task.fail ""

        RemoteData.Loading ->
            Task.fail "Loading..."
        
        RemoteData.Success rates ->
            let 
                inputs =
                    model.converterInputs
                valueL =
                    inputs.valueLeft
                valueR =
                    inputs.valueRight
                currencyL =
                    inputs.currencyLeft
                currencyR =
                    inputs.currencyRight
            in
                if 
                    pos == Left
                then
                    case convert valueR currencyR currencyL rates of
                        Just num ->
                            Task.succeed { inputs | valueLeft = num }
                        
                        Nothing ->
                            Task.fail "Can't find relative data."
                else
                    case convert valueL currencyL currencyR rates of
                        Just num ->
                            Task.succeed { inputs | valueRight = num }
                        
                        Nothing ->
                            Task.fail "Can't find relative data."
        
        RemoteData.Failure error ->
            Task.fail <| toString error 


convert : Float -> Currency -> Currency -> Rates -> Maybe Float
convert value base target rates =
    let 
        rate = 
            getRate base rates
        rate_ =
            getRate target rates
    in
        Maybe.map2 (\r r_ -> value * r_ / r) rate rate_

getRate : Currency -> Rates -> Maybe Float
getRate currency rates =
    if
        currency == rates.base
    then
        Just 1
    else
        Dict.get currency rates.rates_