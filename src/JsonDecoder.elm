module JsonDecoder exposing (ratesDecoder)

import Json.Decode as Decoder exposing (Decoder, string, float, dict)
import Json.Decode.Pipeline exposing (decode, required) 
import Models exposing (Rates)

ratesDecoder : Decoder Rates
ratesDecoder =
    decode Rates
        |> required "base" string
        |> required "date" string
        |> required "rates" (dict float)