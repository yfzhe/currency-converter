module Models exposing
    ( ConverterData
    , Currency
    , Model
    , Rates
    , Route(..)
    , initialModel
    )

import Dict exposing (Dict)
import RemoteData exposing (WebData)

type alias Model =
    { rates : WebData Rates
    , route : Route
    , converter : ConverterData
    }


initialModel : Model
initialModel =
    { rates = RemoteData.Loading
    , route = ConverterRoute
    , converter = initialConverterData
    }


type alias Rates =
    { result : String
    , base : Currency
    , rates_ : Dict Currency Float
    }


type alias Currency =
    String


type alias ConverterData =
    { currencies : ( Currency, Currency )
    , values : ( Float, Float )
    }


initialConverterData : ConverterData
initialConverterData =
    { currencies = ( "CNY", "USD" )
    , values = ( 100, 100 )
    }


type Route
    = ConverterRoute
