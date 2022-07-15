module R10.Color.AttrsBackground exposing (buttonMinorOver, buttonPrimary, buttonPrimaryDisabled, buttonPrimaryDisabledOver, buttonPrimaryOver, debugger, debuggerOver, dropdown, dropdownHover, dropdownSelected, inputFieldCheckboxOver, inputFieldCheckboxSelected, surface, sameAsBorderNormal, background, surface2dp, backgroundAlertDanger, backgroundAlertInfo, backgroundAlertSuccess, backgroundAlertWarning)

{-| Background colors

@docs buttonMinorOver, buttonPrimary, buttonPrimaryDisabled, buttonPrimaryDisabledOver, buttonPrimaryOver, debugger, debuggerOver, dropdown, dropdownHover, dropdownSelected, inputFieldCheckboxOver, inputFieldCheckboxSelected, surface, sameAsBorderNormal, background, surface2dp, backgroundAlertDanger, backgroundAlertInfo, backgroundAlertSuccess, backgroundAlertWarning

-}

import Color.Manipulate
import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import R10.Color.Internal.Derived
import R10.Color.Utils
import R10.Context exposing (..)



-- BACKGROUND


{-| -}
background : Attribute (R10.Context.ContextInternal context) msg
background =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Background
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color


{-| -}
backgroundAlertDanger : Attribute (R10.Context.ContextInternal context) msg
backgroundAlertDanger =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.BackgroundAlertDanger
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color


{-| -}
backgroundAlertInfo : Attribute (R10.Context.ContextInternal context) msg
backgroundAlertInfo =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.BackgroundAlertInfo
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color


{-| -}
backgroundAlertSuccess : Attribute (R10.Context.ContextInternal context) msg
backgroundAlertSuccess =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.BackgroundAlertSuccess
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color


{-| -}
backgroundAlertWarning : Attribute (R10.Context.ContextInternal context) msg
backgroundAlertWarning =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.BackgroundAlertWarning
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color



-- SURFACE


{-| -}
surface : Attribute (R10.Context.ContextInternal context) msg
surface =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Surface
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color


{-| -}
surface2dp : Attribute (R10.Context.ContextInternal context) msg
surface2dp =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Surface2dp
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color



-- BUTTON PRIMARY


{-| -}
buttonPrimary : Attribute (R10.Context.ContextInternal context) msg
buttonPrimary =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.BackgroundButtonPrimary
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color



-- BUTTON PRIMARY OVER


{-| -}
buttonPrimaryOver : Decoration (R10.Context.ContextInternal context)
buttonPrimaryOver =
    withContextDecoration <|
        \c ->
            R10.Color.Internal.Derived.BackgroundButtonPrimaryOver
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color



-- BUTTON PRIMARY DISABLED


{-| -}
buttonPrimaryDisabled : Attribute (R10.Context.ContextInternal context) msg
buttonPrimaryDisabled =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.BackgroundButtonPrimaryDisabled
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color



-- BUTTON PRIMARY DISABLED OVER


{-| -}
buttonPrimaryDisabledOver : Decoration (R10.Context.ContextInternal context)
buttonPrimaryDisabledOver =
    withContextDecoration <|
        \c ->
            R10.Color.Internal.Derived.BackgroundButtonPrimaryDisabledOver
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color



-- BUTTON MINOR OVER


{-| -}
buttonMinorOver : Decoration (R10.Context.ContextInternal context)
buttonMinorOver =
    withContextDecoration <|
        \c ->
            R10.Color.Internal.Derived.BackgroundButtonMinorOver
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color



-- SELECT


{-| -}
dropdown : Attribute (R10.Context.ContextInternal context) msg
dropdown =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.BackgroundPhoneDropdown
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color


{-| -}
dropdownHover : Decoration (R10.Context.ContextInternal context)
dropdownHover =
    withContextDecoration <|
        \c ->
            R10.Color.Internal.Derived.BackgroundPhoneDropdown
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> Color.Manipulate.darken 0.01
                |> R10.Color.Utils.fromColorColor
                |> Background.color


{-| -}
dropdownSelected : Decoration (R10.Context.ContextInternal context)
dropdownSelected =
    withContextDecoration <|
        \c ->
            R10.Color.Internal.Derived.BackgroundPhoneDropdown
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> Color.Manipulate.darken 0.03
                |> R10.Color.Utils.fromColorColor
                |> Background.color



-- OTHERS


{-| -}
inputFieldCheckboxSelected : Attribute (R10.Context.ContextInternal context) msg
inputFieldCheckboxSelected =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Primary
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color


{-| -}
inputFieldCheckboxOver : Decoration (R10.Context.ContextInternal context)
inputFieldCheckboxOver =
    withContextDecoration <|
        \c ->
            R10.Color.Internal.Derived.Primary
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color


{-| -}
sameAsBorderNormal : Attribute (R10.Context.ContextInternal context) msg
sameAsBorderNormal =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Border
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color



-- DEBUGGER


{-| -}
debugger : Attribute (R10.Context.ContextInternal context) msg
debugger =
    withContextAttribute <|
        \c ->
            R10.Color.Internal.Derived.Debugger
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color


{-| -}
debuggerOver : Decoration (R10.Context.ContextInternal context)
debuggerOver =
    withContextDecoration <|
        \c ->
            R10.Color.Internal.Derived.Debugger
                |> R10.Color.Internal.Derived.toColor c.contextR10.theme
                |> R10.Color.Utils.fromColorColor
                |> Background.color
