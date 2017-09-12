module Models exposing (Model, initialModel, Route)

import RemoteData exposing (WebData)
import Type exposing (Rates, Currency)


type alias Model = 
    { rates : WebData Rates
    , currencies : ( Currency, Currency )
    , values : ( Float, Float )
    }

initialModel : Model
initialModel =
    { rates = RemoteData.Loading
    , currencies = ( "CNY", "USD" )
    , values = ( 0, 0 )
    }


type Route 
    = ConveterRoute
    | MultilineRoute
