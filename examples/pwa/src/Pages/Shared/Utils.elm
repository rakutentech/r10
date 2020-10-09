module Pages.Shared.Utils exposing (toFormPalette)

import Color
import R10.FormComponents.UI.Palette


{-| get Palette for use with R10.FormComponents lib
-}
toFormPalette : R10.FormComponents.UI.Palette.Palette
toFormPalette =
    -- TODO
    { primary = Color.rgb255 17 123 180
    , primaryVariant = Color.rgb 18 147 216
    , success = Color.rgb 1 0 0
    , error = Color.rgb 0 1 0
    , onSurface = Color.rgb 0 0 0
    , onPrimary = Color.rgb 0.2 0.2 0.2
    , surface = Color.rgb 1 1 1
    , background = Color.rgb 0.8 0.8 0.8
    }
