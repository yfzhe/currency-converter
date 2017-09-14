module Command exposing (fetchRates, updateValues)

import Convert exposing (convert)
import Http 
import JsonDecoder exposing (ratesDecoder)
import Msgs exposing (Msg)
import Models exposing (Model, Rates, Currency)
import RemoteData
import Result exposing (Result(..))
import Task exposing (Task)
import Type.Position exposing (Position, opposite, getOn, updateOn)


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
    "https://api.fixer.io/latest"

ratesUrlBase : Currency -> String
ratesUrlBase currency = 
    "https://api.fixer.io/latest?base=" ++ currency


updateValues : Position -> Model -> Cmd Msg
updateValues pos model =
    Task.attempt handleUpdateResult <| updateValuesTask pos model

handleUpdateResult : Result String (Float, Float) -> Msg
handleUpdateResult result =
    case result of
        Ok values ->
            Msgs.UpdateValues values
        
        Err error ->
            Msgs.NewError error

updateValuesTask : Position -> Model -> Task String (Float, Float)
updateValuesTask pos model = 
    case model.rates of
        RemoteData.NotAsked ->
            Task.fail ""
        
        RemoteData.Loading ->
            Task.fail "Loading..."
        
        RemoteData.Success rates ->
            let
                values = 
                    model.values
                currencies = 
                    model.currencies
                value = 
                    getOn (opposite pos) values
                base = 
                    getOn (opposite pos) currencies
                target = 
                    getOn pos currencies
                result = 
                    convert value base target rates
            in
                case result of
                    Just num ->
                        Task.succeed <| updateOn pos num values
                    Nothing ->
                        Task.fail "Can't find relative data."
                
        RemoteData.Failure error ->
            Task.fail <| toString error
