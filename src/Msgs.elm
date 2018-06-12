module Msgs exposing (Msg(..))

import Models exposing (Currency, Rates, Route)
import Position exposing (Position)
import RemoteData exposing (WebData)


type Msg
    = OnFetchRates (WebData Rates)
    | Router Route
    | SelectCurrency Position Currency
    | InputValue Position Float
    | NewError String
