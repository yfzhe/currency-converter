module Msgs exposing (Msg(..))

import Models exposing (Rates, Currency, ConverterInputs, Position)
import RemoteData exposing (WebData)


type Msg 
    = OnFetchRates (WebData Rates)
    | SelectCurrency Position Currency
    | InputValue Position Float
    | UpdateValues ConverterInputs
    | NewError String