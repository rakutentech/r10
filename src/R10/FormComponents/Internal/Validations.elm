module R10.FormComponents.Internal.Validations exposing
    ( ValidationForView(..)
    , ValidationMessage(..)
    , extraCss
    , isValid
    , validationToString
    , viewValidation
    )

import Element.WithContext exposing (..)
import Element.WithContext.Font as Font
import Html.Attributes
import R10.Context exposing (..)
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormTypes
import R10.Palette
import R10.Transition


isValid : ValidationForView -> Maybe Bool
isValid validation =
    case validation of
        PretendIsNotYetValidated ->
            Nothing

        Validated listValidationMessage ->
            Just <|
                List.foldl
                    (\validationMessage acc ->
                        case validationMessage of
                            MessageErr _ ->
                                False

                            MessageOk _ ->
                                acc
                    )
                    True
                    listValidationMessage


validationMessageToString : ValidationMessage -> String
validationMessageToString validationMessage =
    case validationMessage of
        MessageOk string ->
            "MessageOk \"" ++ string ++ "\""

        MessageErr string ->
            "MessageErr \"" ++ string ++ "\""


validationToString : ValidationForView -> String
validationToString validation =
    case validation of
        PretendIsNotYetValidated ->
            "NotYetValidated"

        Validated validationMessageList ->
            "Validated [" ++ String.join "," (List.map validationMessageToString validationMessageList) ++ "]"


type ValidationForView
    = PretendIsNotYetValidated
    | Validated (List ValidationMessage)


type ValidationMessage
    = MessageOk String
    | MessageErr String


extraCss : String
extraCss =
    ".markdown p {margin: 0}"


viewValidationIcon : R10.Palette.Palette -> R10.FormTypes.ValidationIcon -> { validIcon : Element (R10.Context.ContextInternal z) msg, invalidIcon : Element (R10.Context.ContextInternal z) msg }
viewValidationIcon palette validationIcon =
    let
        iconAttrs : List (Attribute (R10.Context.ContextInternal z) msg)
        iconAttrs =
            [ width <| px 16, height <| px 16, alignTop, moveDown 2 ]
    in
    case validationIcon of
        R10.FormTypes.NoIcon ->
            { invalidIcon = none
            , validIcon = none
            }

        R10.FormTypes.ClearOrCheck ->
            { invalidIcon =
                R10.FormComponents.Internal.UI.icons.validation_clear
                    iconAttrs
                    (R10.FormComponents.Internal.UI.Color.error palette)
                    16
            , validIcon =
                R10.FormComponents.Internal.UI.icons.validation_check
                    iconAttrs
                    (R10.FormComponents.Internal.UI.Color.success palette)
                    16
            }

        R10.FormTypes.ErrorOrCheck ->
            { invalidIcon =
                R10.FormComponents.Internal.UI.icons.sign_warning_f
                    iconAttrs
                    (R10.FormComponents.Internal.UI.Color.error palette)
                    16
            , validIcon =
                R10.FormComponents.Internal.UI.icons.validation_check
                    iconAttrs
                    (R10.FormComponents.Internal.UI.Color.success palette)
                    16
            }


viewValidationMessage : R10.Palette.Palette -> R10.FormTypes.ValidationIcon -> ValidationMessage -> Element (R10.Context.ContextInternal z) msg
viewValidationMessage palette validationIcon validationMessage =
    case validationMessage of
        MessageOk string ->
            row [ width fill, height fill, spacing 6 ]
                [ .validIcon <| viewValidationIcon palette validationIcon
                , R10.FormComponents.Internal.UI.viewHelperText
                    palette
                    [ Font.color <| R10.FormComponents.Internal.UI.Color.success palette ]
                    (Just string)
                ]

        MessageErr string ->
            row [ width fill, height fill, spacing 6 ]
                [ .invalidIcon <| viewValidationIcon palette validationIcon
                , R10.FormComponents.Internal.UI.viewHelperText
                    palette
                    [ Font.color <| R10.FormComponents.Internal.UI.Color.error palette ]
                    (Just string)
                ]


viewValidation : R10.Palette.Palette -> R10.FormTypes.ValidationIcon -> ValidationForView -> Element (R10.Context.ContextInternal z) msg
viewValidation palette validationIcon validation =
    case validation of
        PretendIsNotYetValidated ->
            animatedList []

        Validated listValidationMessage ->
            animatedList
                (List.map
                    (viewValidationMessage palette validationIcon)
                    listValidationMessage
                )


animatedList : List (Element (R10.Context.ContextInternal z) msg) -> Element (R10.Context.ContextInternal z) msg
animatedList elements =
    let
        transition : Attribute (R10.Context.ContextInternal z) msg
        transition =
            R10.Transition.transition "all 0.15s ease-in, opacity 0.15s 0.2s ease-in"

        wrappedLine : Element (R10.Context.ContextInternal z) msg
        wrappedLine =
            el
                [ padding 0
                , alpha 0
                , htmlAttribute <| Html.Attributes.style "min-height" "0px"
                , htmlAttribute <| Html.Attributes.style "max-height" "0px"
                , Font.size 0
                , transition
                ]
                none

        expandedLine : Element (R10.Context.ContextInternal z) msg -> Element (R10.Context.ContextInternal z) msg
        expandedLine =
            el
                [ paddingEach { top = 6, right = 16, bottom = 0, left = 16 }
                , Font.size 14
                , alpha 1
                , htmlAttribute <| Html.Attributes.style "min-height" "24px"
                -- 2022.06.14 We don't remember why the max-height was set here.
                -- We remove because is hiding part of the error if very long. 
                -- Leaving this comment here in case we realize there was a purpose for it. 
                -- More history could be found in the R10 repo. Reference: https://jira.rakuten-it.com/jira/browse/OMN-5836
                -- , htmlAttribute <| Html.Attributes.style "max-height" "64px"
                , transition
                , clipY
                , htmlAttribute <| Html.Attributes.tabindex -1
                ]
    in
    column [ alignTop, transition ] <|
        (elements |> List.map expandedLine)
            ++ List.repeat 5 wrappedLine
