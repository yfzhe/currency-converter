module Models
    exposing
        ( Currency
        , Model
        , Rates
        , Route(..)
        , ConverterData, ChartData
        , initialModel
        )

import Dict exposing (Dict)
import RemoteData exposing (WebData)


type alias Model =
    { rates : WebData Rates
    , route : Route
    , converter : ConverterData
    , chart : ChartData
    }

initialModel : Model
initialModel =
    { rates = RemoteData.Loading
    , route = ConverterRoute
    , converter = initialConverterData
    , chart = initialChartData
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

type alias ChartData =
    {}

initialConverterData : ConverterData
initialConverterData =
    { currencies = ( "CNY", "USD" )
    , values = ( 100, 100 )
    }

initialChartData : ChartData
initialChartData =
    {}


type Route
    = ConverterRoute
    | ChartRoute
