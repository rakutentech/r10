module R10.Color.AttrFont exposing (buttonPrimary, buttonPrimaryDisabled, buttonPrimaryDisabledOver, buttonPrimaryString, error, inputFieldCheckboxOver, link, linkOver, normal, normalLighter, normalString, valid)

{-| Font colors

@docs buttonPrimary, buttonPrimaryDisabled, buttonPrimaryDisabledOver, buttonPrimaryString, error, inputFieldCheckboxOver, link, linkOver, normal, normalLighter, normalString, valid

-}

import Color
import Color.Convert
import Element
import Element.Font
import R10.Color.Internal.Derived
import R10.Color.Utils
import R10.Theme


{-| -}
normal_ : R10.Theme.Theme -> Color.Color
normal_ theme =
    R10.Color.Internal.Derived.FontHighEmphasis
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
normal : R10.Theme.Theme -> Element.Attr decorative msg
normal theme =
    normal_ theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Font.color


{-| -}
normalString : R10.Theme.Theme -> String
normalString theme =
    normal_ theme
        |> Color.Convert.colorToCssRgba


{-| -}
normalLighter : R10.Theme.Theme -> Element.Attr decorative msg
normalLighter theme =
    R10.Color.Internal.Derived.FontMediumEmphasis
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Font.color


{-| -}
link : R10.Theme.Theme -> Element.Attr decorative msg
link theme =
    R10.Color.Internal.Derived.FontLink
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Font.color


{-| -}
linkOver : R10.Theme.Theme -> Element.Attr decorative msg
linkOver theme =
    R10.Color.Internal.Derived.FontLink
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.setAlpha 0.8
        |> R10.Color.Utils.colorToElementColor
        |> Element.Font.color


{-| -}
error : R10.Theme.Theme -> Element.Attr decorative msg
error theme =
    R10.Color.Internal.Derived.Error
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Font.color


{-| -}
valid : R10.Theme.Theme -> Element.Attr decorative msg
valid theme =
    R10.Color.Internal.Derived.Success
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Font.color



-- BUTTON PRIMARY


{-| -}
buttonPrimary_ : R10.Theme.Theme -> Color.Color
buttonPrimary_ theme =
    --
    -- Font color on primary color can be either white or black.
    -- We chose the one with maximumContrast
    --
    R10.Color.Internal.Derived.FontHighEmphasisWithMaximumContrast
        |> R10.Color.Internal.Derived.toColor theme


{-| -}
buttonPrimary : R10.Theme.Theme -> Element.Attr decorative msg
buttonPrimary theme =
    buttonPrimary_ theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Font.color


{-| -}
buttonPrimaryString : R10.Theme.Theme -> String
buttonPrimaryString theme =
    buttonPrimary_ theme
        |> Color.Convert.colorToCssRgba



--


{-| -}
buttonPrimaryDisabled : R10.Theme.Theme -> Element.Attr decorative msg
buttonPrimaryDisabled theme =
    R10.Color.Internal.Derived.FontMediumEmphasisWithMaximumContrast
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Font.color


{-| -}
buttonPrimaryDisabledOver : R10.Theme.Theme -> Element.Attr decorative msg
buttonPrimaryDisabledOver theme =
    R10.Color.Internal.Derived.FontMediumEmphasisWithMaximumContrast
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Font.color


{-| -}
inputFieldCheckboxOver : R10.Theme.Theme -> Element.Attr decorative msg
inputFieldCheckboxOver theme =
    normal theme
