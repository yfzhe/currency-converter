module Models exposing 
    ( Model, initialModel
    , Rates, Currency
    , Route(..)
    )

import Dict exposing (Dict)
import RemoteData exposing (WebData)


type alias Model = 
    { rates : WebData Rates
    , currencies : (Currency, Currency)
    , values : (Float, Float)
    , multiline : String
    , route : Route
    }

initialModel : Model
initialModel =
    { rates = RemoteData.Loading
    , currencies = ( "CNY", "USD" )
    , values = ( 0, 0 )
    , multiline = ""
    , route = ConverterRoute
    }


type alias Rates = 
    { base : Currency
    , date : String
    , rates_ : Dict Currency Float
    }


type alias Currency = String


type Route 
    = ConverterRoute
    | MultilineRoute
