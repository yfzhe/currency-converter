module Type exposing ( Rates, Currency, Position(..))

import Dict exposing (Dict)
import Tuple

type alias Rates = 
    { base : Currency
    , date : String
    , rates_ : Dict Currency Float
    }

type alias Currency = String

type Position
    = Left 
    | Right
