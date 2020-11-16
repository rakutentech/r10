module R10.Color.AttrsBackground exposing (buttonMinorOver, buttonPrimary, buttonPrimaryDisabled, buttonPrimaryDisabledOver, buttonPrimaryOver, debugger, debuggerOver, dropdown, dropdownHover, dropdownSelected, inputFieldCheckboxOver, inputFieldCheckboxSelected, normal, sameAsBorderNormal, underModal)

{-| Background colors

@docs buttonMinorOver, buttonPrimary, buttonPrimaryDisabled, buttonPrimaryDisabledOver, buttonPrimaryOver, debugger, debuggerOver, dropdown, dropdownHover, dropdownSelected, inputFieldCheckboxOver, inputFieldCheckboxSelected, normal, sameAsBorderNormal, underModal

-}

import Color.Manipulate
import Element
import Element.Background
import R10.Color.Internal.Derived
import R10.Color.Utils
import R10.Theme



-- NORMAL


{-| -}
normal : R10.Theme.Theme -> Element.Attr decorative msg
normal theme =
    R10.Color.Internal.Derived.BackgroundNormal
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- UNDER MODAL


{-| -}
underModal : R10.Theme.Theme -> Element.Attr decorative msg
underModal theme =
    R10.Color.Internal.Derived.BackgroundButtonMinorOver
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- BUTTON PRIMARY


{-| -}
buttonPrimary : R10.Theme.Theme -> Element.Attr decorative msg
buttonPrimary theme =
    R10.Color.Internal.Derived.BackgroundButtonPrimary
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- BUTTON PRIMARY OVER


{-| -}
buttonPrimaryOver : R10.Theme.Theme -> Element.Attr decorative msg
buttonPrimaryOver theme =
    R10.Color.Internal.Derived.BackgroundButtonPrimaryOver
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- BUTTON PRIMARY DISABLED


{-| -}
buttonPrimaryDisabled : R10.Theme.Theme -> Element.Attr decorative msg
buttonPrimaryDisabled theme =
    R10.Color.Internal.Derived.BackgroundButtonPrimaryDisabled
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- BUTTON PRIMARY DISABLED OVER


{-| -}
buttonPrimaryDisabledOver : R10.Theme.Theme -> Element.Attr decorative msg
buttonPrimaryDisabledOver theme =
    R10.Color.Internal.Derived.BackgroundButtonPrimaryDisabledOver
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- BUTTON MINOR OVER


{-| -}
buttonMinorOver : R10.Theme.Theme -> Element.Attr decorative msg
buttonMinorOver theme =
    R10.Color.Internal.Derived.BackgroundButtonMinorOver
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- SELECT


{-| -}
dropdown : R10.Theme.Theme -> Element.Attr decorative msg
dropdown theme =
    R10.Color.Internal.Derived.BackgroundPhoneDropdown
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color


{-| -}
dropdownHover : R10.Theme.Theme -> Element.Attr decorative msg
dropdownHover theme =
    R10.Color.Internal.Derived.BackgroundPhoneDropdown
        |> R10.Color.Internal.Derived.toColor theme
        |> Color.Manipulate.darken 0.01
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color


{-| -}
dropdownSelected : R10.Theme.Theme -> Element.Attr decorative msg
dropdownSelected theme =
    R10.Color.Internal.Derived.BackgroundPhoneDropdown
        |> R10.Color.Internal.Derived.toColor theme
        |> Color.Manipulate.darken 0.03
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- OTHERS


{-| -}
inputFieldCheckboxSelected : R10.Theme.Theme -> Element.Attr decorative msg
inputFieldCheckboxSelected theme =
    R10.Color.Internal.Derived.Primary
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color


{-| -}
inputFieldCheckboxOver : R10.Theme.Theme -> Element.Attr decorative msg
inputFieldCheckboxOver theme =
    R10.Color.Internal.Derived.Primary
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color


{-| -}
sameAsBorderNormal : R10.Theme.Theme -> Element.Attr decorative msg
sameAsBorderNormal theme =
    R10.Color.Internal.Derived.Border
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color



-- DEBUGGER


{-| -}
debugger : R10.Theme.Theme -> Element.Attr decorative msg
debugger theme =
    R10.Color.Internal.Derived.Debugger
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color


{-| -}
debuggerOver : R10.Theme.Theme -> Element.Attr decorative msg
debuggerOver theme =
    R10.Color.Internal.Derived.Debugger
        |> R10.Color.Internal.Derived.toColor theme
        |> R10.Color.Utils.colorToElementColor
        |> Element.Background.color
