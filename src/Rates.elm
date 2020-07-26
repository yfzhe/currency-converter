module Rates exposing (Rates, getRate, fetchRates)

import Currency exposing (Currency)
import Dict exposing (Dict)
import Http exposing (expectJson)
import Json.Decode as Decode exposing (Decoder, dict, float, string)
import Json.Decode.Pipeline exposing (required)
import RemoteData exposing (WebData)

-- TYPE
type alias Rates =
  { base : Currency
  , rates : Dict Currency Float
  }

-- FUNCTIONS
getRate : Rates -> Currency -> Float
getRate rates currency =
  Dict.get currency rates.rates
    |> Maybe.withDefault 0

-- API
fetchRates : Cmd (WebData Rates)
fetchRates =
  Http.get
    { url = ratesUrl
    , expect = expectJson RemoteData.fromResult ratesDecoder
    }

ratesDecoder : Decoder Rates
ratesDecoder =
  Decode.succeed Rates
    |> required "from" Decode.string
    |> required "rates" (Decode.dict Decode.float)

key : String
key =
    "f9da0153c57de664ed34921f"

ratesUrlBase : String
ratesUrlBase =
    "https://v3.exchangerate-api.com/bulk/" ++ key

ratesUrl : String
ratesUrl =
    ratesUrlBase ++ "/USD"
