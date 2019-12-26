module Command exposing (fetchRates)

import Http exposing (expectJson)
import JsonDecoder exposing (ratesDecoder)
import Msgs exposing (Msg(..))
import RemoteData


fetchRates : Cmd Msg
fetchRates =
    Http.get
        { url = ratesUrl
        , expect = expectJson (OnFetchRates << RemoteData.fromResult) ratesDecoder
        }


key : String
key =
    "f9da0153c57de664ed34921f"


ratesUrlBase : String
ratesUrlBase =
    "https://v3.exchangerate-api.com/bulk/" ++ key


ratesUrl : String
ratesUrl =
    ratesUrlBase ++ "/USD"
