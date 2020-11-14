module R10.Color.AttrBorder exposing (buttonSecondary, inputFieldCheckboxNormal, inputFieldCheckboxOver, inputFieldCheckboxSelected, inputFieldError, inputFieldFocused, inputFieldNormal, inputFieldSuccess, normal, shadow)

{-| Border colors

@docs buttonSecondary, inputFieldCheckboxNormal, inputFieldCheckboxOver, inputFieldCheckboxSelected, inputFieldError, inputFieldFocused, inputFieldNormal, inputFieldSuccess, normal, shadow

-}

import Element
import Element.Border
import R10.Color.Internal.Derived
import R10.Color.Utils
import R10.Theme



-- NORMAL


{-| -}
normal : R10.Theme.Theme -> Element.Attr decorative msg
normal theme =
    R10.Color.Internal.Derived.Border
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Border.color



-- SHADOW


{-| -}
shadow : R10.Theme.Theme -> { offset : ( Float, Float ), size : Float, blur : Float } -> Element.Attr decorative msg
shadow theme { offset, size, blur } =
    R10.Color.Internal.Derived.Border
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> (\color -> { offset = offset, size = size, blur = blur, color = color })
        |> Element.Border.shadow



-- BUTTON SECONDARY


{-| -}
buttonSecondary : R10.Theme.Theme -> Element.Attr decorative msg
buttonSecondary theme =
    R10.Color.Internal.Derived.Border
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Border.color



-- INPUT FIELD


{-| -}
inputFieldNormal : R10.Theme.Theme -> Element.Attr decorative msg
inputFieldNormal theme =
    R10.Color.Internal.Derived.Border
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Border.color


{-| -}
inputFieldFocused : R10.Theme.Theme -> Element.Attr decorative msg
inputFieldFocused theme =
    R10.Color.Internal.Derived.Primary
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Border.color


{-| -}
inputFieldError : R10.Theme.Theme -> Element.Attr decorative msg
inputFieldError theme =
    R10.Color.Internal.Derived.Error
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Border.color


{-| -}
inputFieldSuccess : R10.Theme.Theme -> Element.Attr decorative msg
inputFieldSuccess theme =
    R10.Color.Internal.Derived.Success
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Border.color



-- CHECKBOX


{-| -}
inputFieldCheckboxNormal : R10.Theme.Theme -> Element.Attr decorative msg
inputFieldCheckboxNormal theme =
    R10.Color.Internal.Derived.Border
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Border.color


{-| -}
inputFieldCheckboxSelected : R10.Theme.Theme -> Element.Attr decorative msg
inputFieldCheckboxSelected theme =
    R10.Color.Internal.Derived.Primary
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Border.color


{-| -}
inputFieldCheckboxOver : R10.Theme.Theme -> Element.Attr decorative msg
inputFieldCheckboxOver theme =
    R10.Color.Internal.Derived.Primary
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Border.color
