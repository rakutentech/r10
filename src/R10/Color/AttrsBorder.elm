module R10.Color.AttrsBorder exposing (buttonSecondary, inputFieldCheckboxNormal, inputFieldCheckboxOver, inputFieldCheckboxSelected, inputFieldError, inputFieldFocused, inputFieldNormal, inputFieldSuccess, normal, shadow)

{-| Border colors

@docs buttonSecondary, inputFieldCheckboxNormal, inputFieldCheckboxOver, inputFieldCheckboxSelected, inputFieldError, inputFieldFocused, inputFieldNormal, inputFieldSuccess, normal, shadow

-}

import Element.WithContext exposing (..)
import Element.WithContext.Border as Border
import R10.Color.Internal.Derived
import R10.Color.Utils
import R10.Context exposing (Context)
import R10.Context exposing (..)



-- NORMAL


{-| -}
normal : AttributeC msg
normal =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Border
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color



-- SHADOW


{-| -}
shadow : { offset : ( Float, Float ), size : Float, blur : Float } -> AttributeC msg
shadow { offset, size, blur } =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Border
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> (\color -> { offset = offset, size = size, blur = blur, color = color })
                |> Border.shadow



-- BUTTON SECONDARY


{-| -}
buttonSecondary : AttributeC msg
buttonSecondary =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Border
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color



-- INPUT FIELD


{-| -}
inputFieldNormal : AttributeC msg
inputFieldNormal =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Border
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color


{-| -}
inputFieldFocused : AttributeC msg
inputFieldFocused =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Primary
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color


{-| -}
inputFieldError : AttributeC msg
inputFieldError =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Error
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color


{-| -}
inputFieldSuccess : AttributeC msg
inputFieldSuccess =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Success
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color



-- CHECKBOX


{-| -}
inputFieldCheckboxNormal : AttributeC msg
inputFieldCheckboxNormal =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Border
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color


{-| -}
inputFieldCheckboxSelected : AttributeC msg
inputFieldCheckboxSelected =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Primary
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color


{-| -}
inputFieldCheckboxOver : Decoration Context
inputFieldCheckboxOver =
    withContextDecoration <|
        \c ->
            R10.Color.Internal.Derived.Primary
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Border.color
