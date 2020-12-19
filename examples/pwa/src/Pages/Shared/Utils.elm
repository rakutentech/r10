module Pages.Shared.Utils exposing (maxWidth)

import Element exposing (..)


maxWidthPx : Int
maxWidthPx =
    1000


maxWidth : Attribute msg
maxWidth =
    width (fill |> maximum maxWidthPx)
