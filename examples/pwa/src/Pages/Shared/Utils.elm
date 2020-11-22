module Pages.Shared.Utils exposing
    ( maxWidth
    , maxWidthPx
    , toFormPalette
    )

import Color
import Element exposing (..)
import R10.Color.Svg
import R10.Form
import R10.Theme


{-| get Palette for use with R10.FormComponents lib
-}
toFormPalette : R10.Theme.Theme -> R10.Form.Palette
toFormPalette theme =
    -- TODO
    { primary = R10.Color.Svg.primary theme
    , primaryVariant = R10.Color.Svg.primary theme
    , success = R10.Color.Svg.success theme
    , error = R10.Color.Svg.error theme
    , onSurface = R10.Color.Svg.fontNormal theme
    , onPrimary = R10.Color.Svg.fontButtonPrimary theme
    , surface = R10.Color.Svg.backgroundNormal theme
    , background = R10.Color.Svg.underModal theme
    }


maxWidthPx : Int
maxWidthPx =
    1000


maxWidth : Attribute msg
maxWidth =
    width (fill |> maximum maxWidthPx)
