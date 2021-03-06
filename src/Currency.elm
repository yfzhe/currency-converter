module Currency exposing (Currency, currencyDict)

import Dict exposing (Dict, fromList)

type alias Currency = String

currencyDict : Dict Currency String
currencyDict =
  fromList
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
