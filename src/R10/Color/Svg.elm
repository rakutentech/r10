module R10.Color.Svg exposing
    ( logo, primary, error, success, primaryVariant, border
    , background, surface, surface2dp, backgroundButtonMinorOver, backgroundPhoneDropdown
    , fontHighEmphasis, fontMediumEmphasis, fontHighEmphasisWithMaximumContrast, link
    )

{-|


# SVG Colors

These are colors that can be used directly.

In general is better to use colors from `R10.Color.Attrs...` modules.

@docs logo, primary, error, success, primaryVariant, border


# Background

@docs background, surface, surface2dp, backgroundButtonMinorOver, backgroundPhoneDropdown


# Font

@docs fontHighEmphasis, fontMediumEmphasis, fontHighEmphasisWithMaximumContrast, link

-}

import Element.WithContext exposing (..)
import R10.Color.Internal.Derived
import R10.Color.Utils
import R10.Context exposing (..)
import R10.Theme



-- SVG COLORS


{-| -}
background : R10.Theme.Theme -> Color
background theme =
    R10.Color.Internal.Derived.Background
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
surface : R10.Theme.Theme -> Color
surface theme =
    R10.Color.Internal.Derived.Surface
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
surface2dp : R10.Theme.Theme -> Color
surface2dp theme =
    R10.Color.Internal.Derived.Surface2dp
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| Used for the logo. Similar to the primary color but in dark mode it is white.
-}
logo : R10.Theme.Theme -> Color
logo theme =
    R10.Color.Internal.Derived.Logo
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
link : R10.Theme.Theme -> Color
link theme =
    R10.Color.Internal.Derived.FontLink
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
primary : R10.Theme.Theme -> Color
primary theme =
    R10.Color.Internal.Derived.Primary
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
primaryVariant : R10.Theme.Theme -> Color
primaryVariant theme =
    R10.Color.Internal.Derived.PrimaryVariant
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
error : R10.Theme.Theme -> Color
error theme =
    R10.Color.Internal.Derived.Error
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
success : R10.Theme.Theme -> Color
success theme =
    R10.Color.Internal.Derived.Success
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
backgroundButtonMinorOver : R10.Theme.Theme -> Color
backgroundButtonMinorOver theme =
    R10.Color.Internal.Derived.BackgroundButtonMinorOver
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
backgroundPhoneDropdown : R10.Theme.Theme -> Color
backgroundPhoneDropdown theme =
    R10.Color.Internal.Derived.BackgroundPhoneDropdown
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| Font color used in most places.
-}
fontHighEmphasis : R10.Theme.Theme -> Color
fontHighEmphasis theme =
    R10.Color.Internal.Derived.FontHighEmphasis
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| Weak font color for text with minor importance.
-}
fontMediumEmphasis : R10.Theme.Theme -> Color
fontMediumEmphasis theme =
    R10.Color.Internal.Derived.FontMediumEmphasis
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| Font color to be used above a primary color, like in primary buttons.
-}
fontHighEmphasisWithMaximumContrast : R10.Theme.Theme -> Color
fontHighEmphasisWithMaximumContrast theme =
    R10.Color.Internal.Derived.FontHighEmphasisWithMaximumContrast
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


border : R10.Theme.Theme -> Color
border theme =
    R10.Color.Internal.Derived.Border
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor



-- MISSING COLORS
--
-- | FontMediumEmphasisWithMaximumContrast
-- | FontLink
-- | Debugger
-- | BackgroundInputFieldText
-- | BackgroundButtonPrimaryOver
-- | BackgroundButtonPrimaryDisabledOver
-- | BackgroundButtonPrimaryDisabled
-- | BackgroundButtonPrimary
