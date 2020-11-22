module R10.Color.Svg exposing (logo, fontNormal, primary, fontButtonPrimary, mediumEmphasis, backgroundButtonMinorOver, backgroundPhoneDropdown, logoHex, error, success, background, surface, primaryVariant, surface2dp)

{-|


# SVG Colors

These are colors that can be used for SVGs because SVGs don't accept `Element.Attr` as they are not part of the `elm-ui` package.

For all other colors, look into `R10.Color.Attrs...` modules.

@docs logo, fontNormal, primary, fontButtonPrimary, mediumEmphasis, backgroundButtonMinorOver, backgroundPhoneDropdown, logoHex, error, success, background, surface, primaryVariant, surface2dp

-}

import Color
import R10.Color.Internal.Derived
import R10.Theme



-- SVG COLORS


{-| -}
background : R10.Theme.Theme -> Color.Color
background theme =
    R10.Color.Internal.Derived.Background
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
surface : R10.Theme.Theme -> Color.Color
surface theme =
    R10.Color.Internal.Derived.Surface
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
surface2dp : R10.Theme.Theme -> Color.Color
surface2dp theme =
    R10.Color.Internal.Derived.Surface2dp
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
logo : R10.Theme.Theme -> Color.Color
logo theme =
    R10.Color.Internal.Derived.Logo
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
fontNormal : R10.Theme.Theme -> Color.Color
fontNormal theme =
    R10.Color.Internal.Derived.FontHighEmphasis
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
primary : R10.Theme.Theme -> Color.Color
primary theme =
    R10.Color.Internal.Derived.Primary
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
primaryVariant : R10.Theme.Theme -> Color.Color
primaryVariant theme =
    R10.Color.Internal.Derived.PrimaryVariant
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
fontButtonPrimary : R10.Theme.Theme -> Color.Color
fontButtonPrimary theme =
    R10.Color.Internal.Derived.FontHighEmphasisWithMaximumContrast
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
mediumEmphasis : R10.Theme.Theme -> Color.Color
mediumEmphasis theme =
    R10.Color.Internal.Derived.FontMediumEmphasis
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
backgroundButtonMinorOver : R10.Theme.Theme -> Color.Color
backgroundButtonMinorOver theme =
    R10.Color.Internal.Derived.BackgroundButtonMinorOver
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
backgroundPhoneDropdown : R10.Theme.Theme -> Color.Color
backgroundPhoneDropdown theme =
    R10.Color.Internal.Derived.BackgroundPhoneDropdown
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
logoHex : R10.Theme.Theme -> Color.Color
logoHex theme =
    R10.Color.Internal.Derived.Logo
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
error : R10.Theme.Theme -> Color.Color
error theme =
    R10.Color.Internal.Derived.Error
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
success : R10.Theme.Theme -> Color.Color
success theme =
    R10.Color.Internal.Derived.Success
        |> R10.Color.Internal.Derived.toColor theme
