module Rates exposing (Rates, getRate, fetchRates)

import Currency exposing (Currency)
import Dict exposing (Dict)
import Http exposing (expectJson)
import Json.Decode as Decode exposing (Decoder)
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
    |> required "base_code" Decode.string
    |> required "rates" (Decode.dict Decode.float)

ratesUrl : String
ratesUrl =
  "https://open.exchangerate-api.com/v6/latest"
