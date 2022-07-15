module R10.FormComponents.Internal.TextColors exposing
    ( getBorderColor
    , getLabelColor
    )

import Element.WithContext exposing (..)
import R10.FormComponents.Internal.UI.Color
import R10.Palette


getBorderColor :
    { a
        | focused : Bool
        , disabled : Bool
        , maybeValid : Maybe Bool
        , displayValidation : Bool
        , isMouseOver : Bool
        , palette : R10.Palette.Palette
    }
    -> Color
getBorderColor { disabled, focused, maybeValid, displayValidation, isMouseOver, palette } =
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
        | maybeValid : Maybe Bool
        , displayValidation : Bool
        , palette : R10.Palette.Palette
    }
    -> Color
getLabelColor { maybeValid, displayValidation, palette } =
    case ( displayValidation, maybeValid ) of
        ( True, Just True ) ->
            -- VALID
            R10.FormComponents.Internal.UI.Color.success palette

        ( True, Just False ) ->
            -- NOT VALID
            R10.FormComponents.Internal.UI.Color.error palette

        ( _, _ ) ->
            -- NORMAL
            R10.FormComponents.Internal.UI.Color.label palette
