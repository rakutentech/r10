module R10.Color.FormPalette exposing (palette)

import Element exposing (..)
import R10.Color.Internal.Derived
import R10.FormComponents.UI.Palette
import R10.Theme


palette : R10.Theme.Theme -> R10.FormComponents.UI.Palette.Palette
palette theme =
    { -- Colors
      primary = R10.Color.Internal.Derived.toColor theme R10.Color.Internal.Derived.Primary
    , primaryVariant = R10.Color.Internal.Derived.toColor theme R10.Color.Internal.Derived.Primary
    , success = R10.Color.Internal.Derived.toColor theme R10.Color.Internal.Derived.Success
    , error = R10.Color.Internal.Derived.toColor theme R10.Color.Internal.Derived.Error

    -- Text Colors
    , onSurface = R10.Color.Internal.Derived.toColor theme R10.Color.Internal.Derived.FontHighEmphasis
    , onPrimary = R10.Color.Internal.Derived.toColor theme R10.Color.Internal.Derived.FontMediumEmphasis

    -- Background Colors
    , surface = R10.Color.Internal.Derived.toColor theme R10.Color.Internal.Derived.BackgroundNormal
    , background = R10.Color.Internal.Derived.toColor theme R10.Color.Internal.Derived.BackgroundNormal
    }
