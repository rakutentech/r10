module R10.Color.Border exposing
    ( borderButtonSecondary
    , borderInputFieldCheckboxNormal
    , borderInputFieldCheckboxOver
    , borderInputFieldCheckboxSelected
    , borderInputFieldError
    , borderInputFieldFocused
    , borderInputFieldNormal
    , borderInputFieldSuccess
    , borderNormal
    , borderShadow
    )

import Element
import Element.Border
import R10.Color
import R10.Color.Derived
import R10.Theme



-- NORMAL


borderNormal : R10.Theme.Theme -> Element.Attr decorative msg
borderNormal theme =
    R10.Color.Derived.Border
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Border.color



-- SHADOW


borderShadow : R10.Theme.Theme -> { offset : ( Float, Float ), size : Float, blur : Float } -> Element.Attr decorative msg
borderShadow theme { offset, size, blur } =
    R10.Color.Derived.Border
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> (\color -> { offset = offset, size = size, blur = blur, color = color })
        |> Element.Border.shadow



-- BUTTON SECONDARY


borderButtonSecondary : R10.Theme.Theme -> Element.Attr decorative msg
borderButtonSecondary theme =
    R10.Color.Derived.Border
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Border.color



-- INPUT FIELD


borderInputFieldNormal : R10.Theme.Theme -> Element.Attr decorative msg
borderInputFieldNormal theme =
    R10.Color.Derived.Border
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Border.color


borderInputFieldFocused : R10.Theme.Theme -> Element.Attr decorative msg
borderInputFieldFocused theme =
    R10.Color.Derived.Primary
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Border.color


borderInputFieldError : R10.Theme.Theme -> Element.Attr decorative msg
borderInputFieldError theme =
    R10.Color.Derived.Error
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Border.color


borderInputFieldSuccess : R10.Theme.Theme -> Element.Attr decorative msg
borderInputFieldSuccess theme =
    R10.Color.Derived.Success
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Border.color



-- CHECKBOX


borderInputFieldCheckboxNormal : R10.Theme.Theme -> Element.Attr decorative msg
borderInputFieldCheckboxNormal theme =
    R10.Color.Derived.Border
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Border.color


borderInputFieldCheckboxSelected : R10.Theme.Theme -> Element.Attr decorative msg
borderInputFieldCheckboxSelected theme =
    R10.Color.Derived.Primary
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Border.color


borderInputFieldCheckboxOver : R10.Theme.Theme -> Element.Attr decorative msg
borderInputFieldCheckboxOver theme =
    R10.Color.Derived.Primary
        |> R10.Color.Derived.toColor theme
        |> R10.Color.colorToElementColor
        |> Element.Border.color
