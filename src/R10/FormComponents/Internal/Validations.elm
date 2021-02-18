module R10.FormComponents.Internal.Validations exposing
    ( Validation(..)
    , ValidationMessage(..)
    , extraCss
    , isValid
    , validationToString
    , viewValidation
    )

import Element exposing (..)
import Element.Font as Font
import Html.Attributes
import R10.Color.Utils
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormTypes


isValid : Validation -> Maybe Bool
isValid validation =
    case validation of
        NotYetValidated ->
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


validationToString : Validation -> String
validationToString validation =
    case validation of
        NotYetValidated ->
            "NotYetValidated"

        Validated validationMessageList ->
            "Validated [" ++ String.join "," (List.map validationMessageToString validationMessageList) ++ "]"


type ValidationMessage
    = MessageOk String
    | MessageErr String


type Validation
    = NotYetValidated
    | Validated (List ValidationMessage)


extraCss : String
extraCss =
    ".markdown p {margin: 0}"


viewValidationIcon : R10.FormTypes.Palette -> R10.FormTypes.ValidationIcon -> { validIcon : Element msg, invalidIcon : Element msg }
viewValidationIcon palette validationIcon =
    let
        iconAttrs : List (Attribute msg)
        iconAttrs =
            [ width <| px 16, height <| px 16 ]
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
                    24
            , validIcon =
                R10.FormComponents.Internal.UI.icons.validation_check
                    iconAttrs
                    (R10.FormComponents.Internal.UI.Color.success palette)
                    24
            }

        R10.FormTypes.ErrorOrCheck ->
            { invalidIcon =
                R10.FormComponents.Internal.UI.icons.validation_error
                    iconAttrs
                    (R10.FormComponents.Internal.UI.Color.error palette)
                    24
            , validIcon =
                R10.FormComponents.Internal.UI.icons.validation_check
                    iconAttrs
                    (R10.FormComponents.Internal.UI.Color.success palette)
                    24
            }


viewValidationMessage : R10.FormTypes.Palette -> R10.FormTypes.ValidationIcon -> ValidationMessage -> Element msg
viewValidationMessage palette validationIcon validationMessage =
    case validationMessage of
        MessageOk string ->
            row [ width fill, height fill, spacing 4 ]
                [ .validIcon <| viewValidationIcon palette validationIcon
                , R10.FormComponents.Internal.UI.viewHelperText
                    palette
                    [ Font.color <| R10.FormComponents.Internal.UI.Color.success palette ]
                    (Just string)
                ]

        MessageErr string ->
            row [ width fill, height fill, spacing 4 ]
                [ .invalidIcon <| viewValidationIcon palette validationIcon
                , R10.FormComponents.Internal.UI.viewHelperText
                    palette
                    [ Font.color <| R10.FormComponents.Internal.UI.Color.error palette ]
                    (Just string)
                ]


viewValidation : R10.FormTypes.Palette -> R10.FormTypes.ValidationIcon -> Validation -> Element msg
viewValidation palette validationIcon validation =
    case validation of
        NotYetValidated ->
            animatedList []

        Validated listValidationMessage ->
            animatedList
                (List.map
                    (viewValidationMessage palette validationIcon)
                    listValidationMessage
                )


animatedList : List (Element msg) -> Element msg
animatedList elements =
    let
        transition : Attribute msg
        transition =
            htmlAttribute <| Html.Attributes.style "transition" "all 0.15s ease-in, opacity 0.15s 0.2s ease-in"

        wrappedLine : Element msg
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

        expandedLine : Element msg -> Element msg
        expandedLine =
            el
                [ paddingEach { top = 6, right = 0, bottom = 0, left = 0 }
                , Font.size 14
                , alpha 1
                , htmlAttribute <| Html.Attributes.style "min-height" "24px"
                , htmlAttribute <| Html.Attributes.style "max-height" "64px"
                , transition
                , clipY
                ]
    in
    column
        ([ alignTop
         , transition
         ]
            ++ (if List.length elements > 0 then
                    [ paddingEach { top = R10.FormComponents.Internal.UI.genericSpacing, right = 0, bottom = 0, left = 0 } ]

                else
                    [ padding 0 ]
               )
        )
    <|
        (elements
            |> List.map expandedLine
        )
            ++ List.repeat 5 wrappedLine
