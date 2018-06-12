module JsonDecoder exposing (ratesDecoder)

import Json.Decode as Decoder exposing (Decoder, dict, float, string)
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (Rates)


ratesDecoder : Decoder Rates
ratesDecoder =
    decode Rates
        |> required "result" string
        |> required "from" string
        |> required "rates" (dict float)
