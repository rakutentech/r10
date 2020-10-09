module R10.Color.Font exposing
    ( fontButtonPrimary
    , fontButtonPrimaryDisabled
    , fontButtonPrimaryDisabledOver
    , fontError
    , fontInputFieldCheckboxOver
    , fontLink
    , fontLinkOver
    , fontNormal
    , fontNormalLighter
    , fontValid
    )

import Element
import Element.Font
import R10.Color
import R10.Color.Derived
import R10.Theme


fontNormal : R10.Theme.Theme -> Element.Attr decorative msg
fontNormal theme =
    R10.Color.Derived.FontHighEmphasis
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Font.color


fontNormalLighter : R10.Theme.Theme -> Element.Attr decorative msg
fontNormalLighter theme =
    R10.Color.Derived.FontMediumEmphasis
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Font.color


fontLink : R10.Theme.Theme -> Element.Attr decorative msg
fontLink theme =
    R10.Color.Derived.FontLink
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Font.color


fontLinkOver : R10.Theme.Theme -> Element.Attr decorative msg
fontLinkOver theme =
    R10.Color.Derived.FontLink
        |> R10.Color.Derived.toColor theme
        |> R10.Color.setAlpha 0.8
        |> R10.Color.colorToElementColor
        |> Element.Font.color


fontError : R10.Theme.Theme -> Element.Attr decorative msg
fontError theme =
    R10.Color.Derived.Error
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Font.color


fontValid : R10.Theme.Theme -> Element.Attr decorative msg
fontValid theme =
    R10.Color.Derived.Success
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Font.color



-- BUTTON PRIMARY


fontButtonPrimary : R10.Theme.Theme -> Element.Attr decorative msg
fontButtonPrimary theme =
    --
    -- Font color on primary color can be either white or black.
    -- We chose the one with maximumContrast
    --
    R10.Color.Derived.FontHighEmphasisWithMaximumContrast
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Font.color


fontButtonPrimaryDisabled : R10.Theme.Theme -> Element.Attr decorative msg
fontButtonPrimaryDisabled theme =
    R10.Color.Derived.FontMediumEmphasisWithMaximumContrast
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Font.color


fontButtonPrimaryDisabledOver : R10.Theme.Theme -> Element.Attr decorative msg
fontButtonPrimaryDisabledOver theme =
    R10.Color.Derived.FontMediumEmphasisWithMaximumContrast
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Font.color


fontInputFieldCheckboxOver : R10.Theme.Theme -> Element.Attr decorative msg
fontInputFieldCheckboxOver theme =
    fontNormal theme
