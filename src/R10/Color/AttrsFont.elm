module R10.Color.AttrsFont exposing (buttonPrimary, buttonPrimaryDisabled, buttonPrimaryDisabledOver, error, inputFieldCheckboxOver, link, linkOver, normal, normalLighter, valid)

{-| Font colors

@docs buttonPrimary, buttonPrimaryDisabled, buttonPrimaryDisabledOver, error, inputFieldCheckboxOver, link, linkOver, normal, normalLighter, valid

-}

import Element
import Element.Font
import R10.Color.Internal.Derived
import R10.Color.Utils
import R10.Theme


{-| -}
normal : R10.Theme.Theme -> Element.Attr decorative msg
normal theme =
    R10.Color.Internal.Derived.FontHighEmphasis
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Font.color


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
buttonPrimary : R10.Theme.Theme -> Element.Attr decorative msg
buttonPrimary theme =
    R10.Color.Internal.Derived.FontHighEmphasisWithMaximumContrast
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Font.color


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
