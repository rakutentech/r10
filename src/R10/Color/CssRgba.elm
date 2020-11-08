module R10.Color.CssRgba exposing (backgroundButtonMinorOver, backgroundPhoneDropdown, fontButtonPrimary, icon, iconError, iconPrimaryHex, iconValid, logoHex, mediumEmphasis, primary, spinner, fontNormal)

{-| Background in CSS Rgba format, like `rgba(127, 0, 0, 0.5)`.

@docs backgroundButtonMinorOver, backgroundPhoneDropdown, fontButtonPrimary, icon, iconError, iconPrimaryHex, iconValid, logoHex, mediumEmphasis, primary, spinner, fontNormal

-}

import Color.Convert
import R10.Color.Derived
import R10.Color.Font
import R10.Theme


{-| -}
fontNormal : R10.Theme.Theme -> String
fontNormal theme =
    R10.Color.Font.fontNormalString theme


{-| -}
primary : R10.Theme.Theme -> String
primary theme =
    R10.Color.Derived.Primary
        |> R10.Color.Derived.toColor theme
        |> Color.Convert.colorToCssRgba


{-| -}
fontButtonPrimary : R10.Theme.Theme -> String
fontButtonPrimary theme =
    R10.Color.Font.fontButtonPrimaryString theme


{-| -}
mediumEmphasis : R10.Theme.Theme -> String
mediumEmphasis theme =
    R10.Color.Derived.FontMediumEmphasis
        |> R10.Color.Derived.toColor theme
        |> Color.Convert.colorToCssRgba


{-| -}
backgroundButtonMinorOver : R10.Theme.Theme -> String
backgroundButtonMinorOver theme =
    R10.Color.Derived.BackgroundButtonMinorOver
        |> R10.Color.Derived.toColor theme
        |> Color.Convert.colorToCssRgba


{-| -}
backgroundPhoneDropdown : R10.Theme.Theme -> String
backgroundPhoneDropdown theme =
    R10.Color.Derived.BackgroundPhoneDropdown
        |> R10.Color.Derived.toColor theme
        |> Color.Convert.colorToCssRgba


{-| -}
icon : R10.Theme.Theme -> String
icon theme =
    R10.Color.Derived.FontHighEmphasis
        |> R10.Color.Derived.toColor theme
        |> Color.Convert.colorToCssRgba


{-| -}
logoHex : R10.Theme.Theme -> String
logoHex theme =
    R10.Color.Derived.Logo
        |> R10.Color.Derived.toColor theme
        |> Color.Convert.colorToCssRgba


{-| -}
iconPrimaryHex : R10.Theme.Theme -> String
iconPrimaryHex theme =
    R10.Color.Derived.Primary
        |> R10.Color.Derived.toColor theme
        |> Color.Convert.colorToCssRgba


{-| -}
iconError : R10.Theme.Theme -> String
iconError theme =
    R10.Color.Derived.Error
        |> R10.Color.Derived.toColor theme
        |> Color.Convert.colorToCssRgba


{-| -}
iconValid : R10.Theme.Theme -> String
iconValid theme =
    R10.Color.Derived.Success
        |> R10.Color.Derived.toColor theme
        |> Color.Convert.colorToCssRgba


{-| -}
spinner : R10.Theme.Theme -> String
spinner theme =
    R10.Color.Derived.Primary
        |> R10.Color.Derived.toColor theme
        |> Color.Convert.colorToCssRgba
