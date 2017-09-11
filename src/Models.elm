module Models exposing 
    ( Model, initialModel
    , Rates
    , Currency, currencyList
    , ConverterInputs
    , Position(..)
    )

import Dict exposing (Dict)
import RemoteData exposing (WebData)


type alias Model = 
    { rates : WebData Rates
    , converterInputs : ConverterInputs
    }

initialModel : Model
initialModel =
    { rates = RemoteData.Loading
    , converterInputs = ConverterInputs 0 0 "CNY" "USD"
    }


type alias Rates = 
    { base : Currency
    , date : String
    , rates_ : Dict Currency Float
    }

type alias Currency = String

type alias ConverterInputs = 
    { valueLeft : Float
    , valueRight : Float
    , currencyLeft : Currency
    , currencyRight : Currency
    }

type Position
    = Left
    | Right

currencyList : List ( Currency, String )
currencyList =
    [ ( "AUD", "Australian Dollar" )
    , ( "BGN", "Bulgarian Lev" )
    , ( "BRL", "Brazilian Real" )
    , ( "CAD", "Canadian Dollar" )
    , ( "CHF", "Swiss Franc" )
    , ( "CNY", "Chinese Yuan" )
    , ( "CZK", "Czech Koruna" )
    , ( "DKK", "Danish Krone" )
    , ( "EUR", "Euro" )
    , ( "GBP", "Great British Pound" )
    , ( "HKD", "Hong Kong Dollar" )
    , ( "HRK", "Croatian Kuna" )
    , ( "HUF", "Hungarian Forint" )
    , ( "IDR", "Indonesian Rupiah" )
    , ( "ILS", "Israeli Shekel" )
    , ( "INR", "Indian Rupee" )
    , ( "JPY", "Japanese Yen" )
    , ( "KRW", "South Korean Won" )
    , ( "MXN", "Mexican Peso" )
    , ( "MYR", "Malaysian Ringgit" )
    , ( "NOK", "Norwegian Krone" )
    , ( "NZD", "New Zealand Dollar" )
    , ( "PHP", "Philippine Peso" )
    , ( "PLN", "Polish Zloty" )
    , ( "RON", "Romanian New Leu" )
    , ( "RUB", "Russian Ruble" )
    , ( "SEK", "Swedish Krona" )
    , ( "SGD", "Singapore Dollar" )
    , ( "THB", "Thai Baht" )
    , ( "TRY", "Turkish Lira" )
    , ( "USD", "US Dollar" )
    , ( "ZAR", "South African Rand" )
    ]
