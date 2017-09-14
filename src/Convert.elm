module Convert exposing (convert, formatNumber)

import Dict
import Models exposing (Currency, Rates)

convert : Float -> Currency -> Currency -> Rates -> Maybe Float
convert value base target rates =
    let 
        rate = 
            getRate base rates
        rate_ =
            getRate target rates
    in
        Maybe.map2 (\r r_ -> formatNumber <| value * r_ / r) rate rate_

getRate : Currency -> Rates -> Maybe Float
getRate currency rates =
    if
        currency == rates.base
    then
        Just 1
    else
        Dict.get currency rates.rates_

formatNumber : Float -> Float
formatNumber num =
    ( toFloat <| round <| num * 100 ) / 100 