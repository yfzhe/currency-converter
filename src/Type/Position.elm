module Type.Position exposing 
    ( Position(..)
    , opposite, getOn, updateOn
    )


type Position
    = Left 
    | Right

opposite : Position -> Position
opposite pos =
    case pos of 
        Left -> Right
        Right -> Left

getOn : Position -> (a, a) -> a
getOn pos =
    case pos of
        Left ->
            Tuple.first
        
        Right ->
            Tuple.second

updateOn : Position -> a -> (a, a) -> (a, a)
updateOn pos x pair =
    let 
        (xl, xr) = pair
    in
        case pos of
            Left ->
                (x, xr)
            
            Right ->
                (xl, x)