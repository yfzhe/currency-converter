module Converter.Update exposing (updateConverterData)

import Dict
import Models exposing (Currency, Model, Rates)
import Msgs exposing (Msg)
import Position exposing (..)
import RemoteData


updateConverterData : Position -> Model -> ( Model, Cmd Msg )
updateConverterData pos model =
    case model.rates of
        RemoteData.NotAsked ->
            ( model, Cmd.none )

        RemoteData.Loading ->
            ( model, Cmd.none )

        RemoteData.Failure error ->
            ( model, Cmd.none )

        RemoteData.Success rates ->
            let
                data =
                    model.converter

                currencies =
                    data.currencies

                values =
                    data.values

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
                    let
                        newData =
                            { data | values = updateOn pos num values }
                    in
                    ( { model | converter = newData }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )


convert : Float -> Currency -> Currency -> Rates -> Maybe Float
convert value base target rates =
    let
        rate =
            getRate base rates

        rate_ =
            getRate target rates
    in
    Maybe.map2 (\r r_ -> formatNumber <| value * r_ / r) rate rate_


getRate : Currency -> Rates -> Maybe Float
getRate currency rates =
    if currency == rates.base then
        Just 1

    else
        Dict.get currency rates.rates_


formatNumber : Float -> Float
formatNumber num =
    (toFloat <| round <| num * 100) / 100
