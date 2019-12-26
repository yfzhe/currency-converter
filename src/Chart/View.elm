module Chart.View exposing (view)

import Html exposing (Html, div, p, text, textarea)
import Html.Attributes exposing (class, rows)
import Html.Events exposing (onInput)
import Models exposing (ChartData, Currency, Rates)
import Msgs exposing (Msg)
import Position exposing (Position(..))
import RemoteData


view : ChartData -> Html Msg
view data =
    div [] []
