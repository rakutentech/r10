module R10.FormComponents.Internal.TextColors exposing
    ( getBorderColor
    , getLabelColor
    )

import Element.WithContext exposing (..)
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.UI.Color
import R10.Palette


getBorderColor :
    { a
        | focused : Bool
        , disabled : Bool
        , style : R10.FormComponents.Internal.Style.Style
        , maybeValid : Maybe Bool
        , displayValidation : Bool
        , isMouseOver : Bool
        , palette : R10.Palette.Palette
    }
    -> Color
getBorderColor { disabled, focused, style, maybeValid, displayValidation, isMouseOver, palette } =
    let
        validationActive : Bool
        validationActive =
            displayValidation && maybeValid == Just False

        alpha : Float
        alpha =
            if not disabled && (focused || isMouseOver || validationActive) then
                1

            else
                0.7
    in
    case style of
        R10.FormComponents.Internal.Style.Filled ->
            case ( displayValidation, maybeValid, focused ) of
                ( True, Just True, _ ) ->
                    -- VALID
                    R10.FormComponents.Internal.UI.Color.successA alpha palette

                ( True, Just False, _ ) ->
                    -- NOT VALID
                    R10.FormComponents.Internal.UI.Color.errorA alpha palette

                ( _, _, _ ) ->
                    -- NORMAL
                    R10.FormComponents.Internal.UI.Color.borderA alpha palette

        R10.FormComponents.Internal.Style.Outlined ->
            case ( displayValidation, maybeValid, focused ) of
                ( True, Just True, _ ) ->
                    -- VALID
                    R10.FormComponents.Internal.UI.Color.successA alpha palette

                ( True, Just False, _ ) ->
                    -- NOT VALID
                    R10.FormComponents.Internal.UI.Color.errorA alpha palette

                ( _, _, _ ) ->
                    -- NORMAL
                    R10.FormComponents.Internal.UI.Color.borderA alpha palette


getLabelColor :
    { a
        | focused : Bool
        , style : R10.FormComponents.Internal.Style.Style
        , maybeValid : Maybe Bool
        , displayValidation : Bool
        , palette : R10.Palette.Palette
    }
    -> Color
getLabelColor { focused, style, maybeValid, displayValidation, palette } =
    case style of
        R10.FormComponents.Internal.Style.Filled ->
            case ( displayValidation, maybeValid, focused ) of
                --( True, Just True, True ) ->
                --    R10.FormComponents.Internal.UI.Color.success palette
                ( True, Just False, True ) ->
                    -- TODO(This is a temporary fix for OMNI (Originally was R10.FormComponents.Internal.UI.Color.error))
                    R10.FormComponents.Internal.UI.Color.label palette

                ( _, _, _ ) ->
                    R10.FormComponents.Internal.UI.Color.label palette

        R10.FormComponents.Internal.Style.Outlined ->
            case ( displayValidation, maybeValid, focused ) of
                ( True, Just True, _ ) ->
                    -- VALID
                    R10.FormComponents.Internal.UI.Color.success palette

                ( True, Just False, _ ) ->
                    -- NOT VALID
                    R10.FormComponents.Internal.UI.Color.error palette

                ( _, _, _ ) ->
                    -- NORMAL
                    R10.FormComponents.Internal.UI.Color.label palette
