module Msgs exposing (Msg(..))

import RemoteData exposing (WebData)
import Type exposing (Rates, Currency, Position)


type Msg 
    = OnFetchRates (WebData Rates)
    | SelectCurrency Position Currency
    | InputValue Position Float
    | UpdateValues (Float, Float)
    | NewError String