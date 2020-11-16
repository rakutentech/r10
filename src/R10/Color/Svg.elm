module R10.Color.Svg exposing (logo, fontNormal, primary, fontButtonPrimary, mediumEmphasis, backgroundButtonMinorOver, backgroundPhoneDropdown, logoHex, fontError, fontValid)

{-|


# SVG Colors

These are colors that can be used for SVGs because SVGs don't accept `Element.Attr` as they are not part of the `elm-ui` package.

For all other colors, look into `R10.Color.Attr...` modules.

@docs logo, fontNormal, primary, fontButtonPrimary, mediumEmphasis, backgroundButtonMinorOver, backgroundPhoneDropdown, logoHex, fontError, fontValid

-}

import Color
import R10.Color.Internal.Derived
import R10.Theme



-- SVG COLORS


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
fontError : R10.Theme.Theme -> Color.Color
fontError theme =
    R10.Color.Internal.Derived.Error
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
fontValid : R10.Theme.Theme -> Color.Color
fontValid theme =
    R10.Color.Internal.Derived.Success
        |> R10.Color.Internal.Derived.toColor theme
