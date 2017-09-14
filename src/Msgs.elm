module Msgs exposing (Msg(..))

import Models exposing (Rates, Currency, Route)
import RemoteData exposing (WebData)
import Type.Position exposing (Position)


type Msg 
    = OnFetchRates (WebData Rates)
    | ChangeLocation Route
    | SelectCurrency Position Currency
    | InputValue Position Float
    | MultilineInput String
    | UpdateValues (Float, Float)
    | NewError String