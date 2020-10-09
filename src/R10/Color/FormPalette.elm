module R10.Color.FormPalette exposing (palette)

import Element exposing (..)
import R10.Color.Derived
import R10.FormComponents.UI.Palette
import R10.Theme


palette : R10.Theme.Theme -> R10.FormComponents.UI.Palette.Palette
palette theme =
    { -- Colors
      primary = R10.Color.Derived.toColor theme R10.Color.Derived.Primary
    , primaryVariant = R10.Color.Derived.toColor theme R10.Color.Derived.Primary
    , success = R10.Color.Derived.toColor theme R10.Color.Derived.Success
    , error = R10.Color.Derived.toColor theme R10.Color.Derived.Error

    -- Text Colors
    , onSurface = R10.Color.Derived.toColor theme R10.Color.Derived.FontHighEmphasis
    , onPrimary = R10.Color.Derived.toColor theme R10.Color.Derived.FontMediumEmphasis

    -- Background Colors
    , surface = R10.Color.Derived.toColor theme R10.Color.Derived.BackgroundNormal
    , background = R10.Color.Derived.toColor theme R10.Color.Derived.BackgroundNormal
    }
