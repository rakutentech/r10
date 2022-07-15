module R10.Color.AttrsBorder exposing (buttonSecondary, inputFieldCheckboxNormal, inputFieldCheckboxOver, inputFieldCheckboxSelected, inputFieldError, inputFieldFocused, inputFieldNormal, inputFieldSuccess, normal, shadow)

{-| Border colors

@docs buttonSecondary, inputFieldCheckboxNormal, inputFieldCheckboxOver, inputFieldCheckboxSelected, inputFieldError, inputFieldFocused, inputFieldNormal, inputFieldSuccess, normal, shadow

-}

import Element.WithContext exposing (..)
import Element.WithContext.Border as Border
import R10.Color.Internal.Derived
import R10.Color.Utils
import R10.Context



-- NORMAL


{-| -}
normal : Attribute (R10.Context.ContextInternal z) msg
normal =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Border
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color



-- SHADOW


{-| -}
shadow : { offset : ( Float, Float ), size : Float, blur : Float } -> Attribute (R10.Context.ContextInternal z) msg
shadow { offset, size, blur } =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Border
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> (\color -> { offset = offset, size = size, blur = blur, color = color })
                |> Border.shadow



-- BUTTON SECONDARY


{-| -}
buttonSecondary : Attribute (R10.Context.ContextInternal z) msg
buttonSecondary =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Border
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color



-- INPUT FIELD


{-| -}
inputFieldNormal : Attribute (R10.Context.ContextInternal z) msg
inputFieldNormal =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Border
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color


{-| -}
inputFieldFocused : Attribute (R10.Context.ContextInternal z) msg
inputFieldFocused =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Primary
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color


{-| -}
inputFieldError : Attribute (R10.Context.ContextInternal z) msg
inputFieldError =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.FontAlertDanger
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color


{-| -}
inputFieldSuccess : Attribute (R10.Context.ContextInternal z) msg
inputFieldSuccess =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.FontAlertSuccess
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color



-- CHECKBOX


{-| -}
inputFieldCheckboxNormal : Attribute (R10.Context.ContextInternal z) msg
inputFieldCheckboxNormal =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Border
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color


{-| -}
inputFieldCheckboxSelected : Attribute (R10.Context.ContextInternal z) msg
inputFieldCheckboxSelected =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Primary
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color


{-| -}
inputFieldCheckboxOver : Decoration (R10.Context.ContextInternal z)
inputFieldCheckboxOver =
    withContextDecoration <|
        \c ->
            R10.Color.Internal.Derived.Primary
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color
