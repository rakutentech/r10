module R10.Color.Svg exposing
    ( logo, primary, error, success, primaryVariant
    , background, surface, surface2dp, backgroundButtonMinorOver, backgroundPhoneDropdown
    , fontHighEmphasis, fontMediumEmphasis, fontButtonPrimary
    )

{-|


# SVG Colors

These are colors that can be used directly.

In general is better to use colors from `R10.Color.Attrs...` modules.

@docs logo, primary, error, success, primaryVariant


# Background

@docs background, surface, surface2dp, backgroundButtonMinorOver, backgroundPhoneDropdown


# Font

@docs fontHighEmphasis, fontMediumEmphasis, fontButtonPrimary

-}

import Element
import R10.Color.Internal.Derived
import R10.Color.Utils
import R10.Theme



-- SVG COLORS


{-| -}
background : R10.Theme.Theme -> Element.Color
background theme =
    R10.Color.Internal.Derived.Background
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
surface : R10.Theme.Theme -> Element.Color
surface theme =
    R10.Color.Internal.Derived.Surface
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
surface2dp : R10.Theme.Theme -> Element.Color
surface2dp theme =
    R10.Color.Internal.Derived.Surface2dp
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| Used for the logo. Similar to the primary color but in dark mode it is white.
-}
logo : R10.Theme.Theme -> Element.Color
logo theme =
    R10.Color.Internal.Derived.Logo
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
primary : R10.Theme.Theme -> Element.Color
primary theme =
    R10.Color.Internal.Derived.Primary
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
primaryVariant : R10.Theme.Theme -> Element.Color
primaryVariant theme =
    R10.Color.Internal.Derived.PrimaryVariant
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
error : R10.Theme.Theme -> Element.Color
error theme =
    R10.Color.Internal.Derived.Error
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
success : R10.Theme.Theme -> Element.Color
success theme =
    R10.Color.Internal.Derived.Success
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
backgroundButtonMinorOver : R10.Theme.Theme -> Element.Color
backgroundButtonMinorOver theme =
    R10.Color.Internal.Derived.BackgroundButtonMinorOver
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| -}
backgroundPhoneDropdown : R10.Theme.Theme -> Element.Color
backgroundPhoneDropdown theme =
    R10.Color.Internal.Derived.BackgroundPhoneDropdown
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| Font color used in most places.
-}
fontHighEmphasis : R10.Theme.Theme -> Element.Color
fontHighEmphasis theme =
    R10.Color.Internal.Derived.FontHighEmphasis
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| Weak font color for text with minor importance.
-}
fontMediumEmphasis : R10.Theme.Theme -> Element.Color
fontMediumEmphasis theme =
    R10.Color.Internal.Derived.FontMediumEmphasis
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor


{-| Font color to be used above a primary color, like in primary buttons.
-}
fontButtonPrimary : R10.Theme.Theme -> Element.Color
fontButtonPrimary theme =
    R10.Color.Internal.Derived.FontHighEmphasisWithMaximumContrast
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.fromColorColor
