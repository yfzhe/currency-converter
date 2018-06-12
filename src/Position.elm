module Position
    exposing
        ( Position(..)
        , getOn
        , opposite
        , updateOn
        )


type Position
    = Left
    | Right


opposite : Position -> Position
opposite pos =
    case pos of
        Left ->
            Right

        Right ->
            Left


getOn : Position -> ( a, a ) -> a
getOn pos =
    case pos of
        Left ->
            Tuple.first

        Right ->
            Tuple.second


updateOn : Position -> a -> ( a, a ) -> ( a, a )
updateOn pos x ( left, right ) =
    case pos of
        Left ->
            ( x, right )

        Right ->
            ( left, x )
