module R10.Color.AttrsFont exposing (buttonPrimary, buttonPrimaryDisabled, buttonPrimaryDisabledOver, error, inputFieldCheckboxOver, link, linkOver, normal, normalLighter, valid)

{-| Font colors

@docs buttonPrimary, buttonPrimaryDisabled, buttonPrimaryDisabledOver, error, inputFieldCheckboxOver, link, linkOver, normal, normalLighter, valid

-}

import Color.Manipulate
import Element.WithContext exposing (..)
import Element.WithContext.Font as Font
import R10.Color.Internal.Derived
import R10.Color.Utils
import R10.Context exposing (..)


{-| -}
normal : AttributeC msg
normal =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.FontHighEmphasis
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Font.color


{-| -}
inputFieldCheckboxOver : Decoration Context
inputFieldCheckboxOver =
    withContextDecoration <|
        \c ->
            R10.Color.Internal.Derived.FontHighEmphasis
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Font.color


{-| -}
normalLighter : AttributeC msg
normalLighter =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.FontMediumEmphasis
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Font.color


{-| -}
link : AttributeC msg
link =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.FontLink
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Font.color


{-| -}
linkOver : Decoration Context
linkOver =
    withContextDecoration <|
        \c ->
            R10.Color.Internal.Derived.FontLink
                |> R10.Color.Internal.Derived.toColor c.theme
                |> Color.Manipulate.scaleHsl
                    { saturationScale = 0.3
                    , lightnessScale = -0.2
                    , alphaScale = 0
                    }
                |> R10.Color.Utils.fromColorColor
                |> Font.color


{-| -}
error : AttributeC msg
error =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Error
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Font.color


{-| -}
valid : AttributeC msg
valid =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Success
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Font.color



-- BUTTON PRIMARY


{-| -}
buttonPrimary : AttributeC msg
buttonPrimary =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.FontHighEmphasisWithMaximumContrast
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Font.color


{-| -}
buttonPrimaryDisabled : AttributeC msg
buttonPrimaryDisabled =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.FontMediumEmphasisWithMaximumContrast
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Font.color


{-| -}
buttonPrimaryDisabledOver : Decoration Context
buttonPrimaryDisabledOver =
    withContextDecoration <|
        \c ->
            R10.Color.Internal.Derived.FontMediumEmphasisWithMaximumContrast
                |> R10.Color.Internal.Derived.toColor c.theme
                |> R10.Color.Utils.fromColorColor
                |> Font.color
