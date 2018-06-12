module Command exposing (fetchRates)

import Http
import JsonDecoder exposing (ratesDecoder)
import Msgs exposing (Msg)
import RemoteData


fetchRates : Cmd Msg
fetchRates =
    Http.get ratesUrl ratesDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchRates

key : String
key = "f9da0153c57de664ed34921f"

ratesUrlBase : String 
ratesUrlBase =
    "https://v3.exchangerate-api.com/bulk/" ++ key

ratesUrl : String
ratesUrl = 
    ratesUrlBase ++ "/USD"
