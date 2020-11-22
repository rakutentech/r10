module Pages.Shared.Utils exposing
    ( maxWidth
    , maxWidthPx
    )

import Color
import Element exposing (..)
import R10.Color.Svg
import R10.Form
import R10.Theme


maxWidthPx : Int
maxWidthPx =
    1000


maxWidth : Attribute msg
maxWidth =
    width (fill |> maximum maxWidthPx)
