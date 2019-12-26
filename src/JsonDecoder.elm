module JsonDecoder exposing (ratesDecoder)

import Json.Decode as Decode exposing (Decoder, dict, float, string)
import Json.Decode.Pipeline exposing (required)
import Models exposing (Rates)


ratesDecoder : Decoder Rates
ratesDecoder =
    Decode.succeed Rates
        |> required "result" string
        |> required "from" string
        |> required "rates" (dict float)
