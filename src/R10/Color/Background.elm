module R10.Color.Background exposing (backgroundButtonMinorOver, backgroundButtonPrimary, backgroundButtonPrimaryDisabled, backgroundButtonPrimaryDisabledOver, backgroundButtonPrimaryOver, backgroundDebugger, backgroundDebuggerOver, backgroundDropdown, backgroundDropdownHover, backgroundDropdownSelected, backgroundInputFieldCheckboxOver, backgroundInputFieldCheckboxSelected, backgroundNormal, backgroundSameAsBorderNormal, underModal)

{-| Background colors

@docs backgroundButtonMinorOver, backgroundButtonPrimary, backgroundButtonPrimaryDisabled, backgroundButtonPrimaryDisabledOver, backgroundButtonPrimaryOver, backgroundDebugger, backgroundDebuggerOver, backgroundDropdown, backgroundDropdownHover, backgroundDropdownSelected, backgroundInputFieldCheckboxOver, backgroundInputFieldCheckboxSelected, backgroundNormal, backgroundSameAsBorderNormal, underModal

-}

import Color.Manipulate
import Element
import Element.Background
import R10.Color.Derived
import R10.Color.Utils
import R10.Theme



-- NORMAL


{-| -}
backgroundNormal : R10.Theme.Theme -> Element.Attr decorative msg
backgroundNormal theme =
    R10.Color.Derived.BackgroundNormal
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- UNDER MODAL


{-| -}
underModal : R10.Theme.Theme -> Element.Attr decorative msg
underModal theme =
    R10.Color.Derived.BackgroundButtonMinorOver
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- BUTTON PRIMARY


{-| -}
backgroundButtonPrimary : R10.Theme.Theme -> Element.Attr decorative msg
backgroundButtonPrimary theme =
    R10.Color.Derived.BackgroundButtonPrimary
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- BUTTON PRIMARY OVER


{-| -}
backgroundButtonPrimaryOver : R10.Theme.Theme -> Element.Attr decorative msg
backgroundButtonPrimaryOver theme =
    R10.Color.Derived.BackgroundButtonPrimaryOver
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- BUTTON PRIMARY DISABLED


{-| -}
backgroundButtonPrimaryDisabled : R10.Theme.Theme -> Element.Attr decorative msg
backgroundButtonPrimaryDisabled theme =
    R10.Color.Derived.BackgroundButtonPrimaryDisabled
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- BUTTON PRIMARY DISABLED OVER


{-| -}
backgroundButtonPrimaryDisabledOver : R10.Theme.Theme -> Element.Attr decorative msg
backgroundButtonPrimaryDisabledOver theme =
    R10.Color.Derived.BackgroundButtonPrimaryDisabledOver
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- BUTTON MINOR OVER


{-| -}
backgroundButtonMinorOver : R10.Theme.Theme -> Element.Attr decorative msg
backgroundButtonMinorOver theme =
    R10.Color.Derived.BackgroundButtonMinorOver
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- SELECT


{-| -}
backgroundDropdown : R10.Theme.Theme -> Element.Attr decorative msg
backgroundDropdown theme =
    R10.Color.Derived.BackgroundPhoneDropdown
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color


{-| -}
backgroundDropdownHover : R10.Theme.Theme -> Element.Attr decorative msg
backgroundDropdownHover theme =
    R10.Color.Derived.BackgroundPhoneDropdown
        |> R10.Color.Derived.toColor theme
        |> Color.Manipulate.darken 0.01
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color


{-| -}
backgroundDropdownSelected : R10.Theme.Theme -> Element.Attr decorative msg
backgroundDropdownSelected theme =
    R10.Color.Derived.BackgroundPhoneDropdown
        |> R10.Color.Derived.toColor theme
        |> Color.Manipulate.darken 0.03
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- OTHERS


{-| -}
backgroundInputFieldCheckboxSelected : R10.Theme.Theme -> Element.Attr decorative msg
backgroundInputFieldCheckboxSelected theme =
    R10.Color.Derived.Primary
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color


{-| -}
backgroundInputFieldCheckboxOver : R10.Theme.Theme -> Element.Attr decorative msg
backgroundInputFieldCheckboxOver theme =
    R10.Color.Derived.Primary
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color


{-| -}
backgroundSameAsBorderNormal : R10.Theme.Theme -> Element.Attr decorative msg
backgroundSameAsBorderNormal theme =
    R10.Color.Derived.Border
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- DEBUGGER


{-| -}
backgroundDebugger : R10.Theme.Theme -> Element.Attr decorative msg
backgroundDebugger theme =
    R10.Color.Derived.Debugger
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color


{-| -}
backgroundDebuggerOver : R10.Theme.Theme -> Element.Attr decorative msg
backgroundDebuggerOver theme =
    R10.Color.Derived.Debugger
        |> R10.Color.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color
