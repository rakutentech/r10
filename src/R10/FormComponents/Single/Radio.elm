module R10.FormComponents.Single.Radio exposing (viewRadio)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import R10.FormComponents.Single.Common as Common
import R10.FormComponents.Style
import R10.FormComponents.UI
import R10.FormComponents.UI.Color
import R10.FormComponents.UI.Palette
import R10.FormComponents.Validations


isSelected : Input.OptionState -> Bool
isSelected optionState =
    case optionState of
        Input.Selected ->
            True

        Input.Idle ->
            False

        Input.Focused ->
            False


viewRadioOption : Common.Args msg -> String -> Input.OptionState -> Element msg
viewRadioOption args label optionState =
    let
        { innerCircleSize, innerCircleColor, outerCircleColor } =
            case ( isSelected optionState, args.disabled ) of
                ( True, True ) ->
                    { innerCircleSize = 10
                    , innerCircleColor = R10.FormComponents.UI.Color.primaryA 0.5 args.palette
                    , outerCircleColor = R10.FormComponents.UI.Color.primaryA 0.5 args.palette
                    }

                ( True, False ) ->
                    { innerCircleSize = 10
                    , innerCircleColor = R10.FormComponents.UI.Color.primaryA 1 args.palette
                    , outerCircleColor = R10.FormComponents.UI.Color.primaryA 1 args.palette
                    }

                ( False, True ) ->
                    { innerCircleSize = 0
                    , innerCircleColor = R10.FormComponents.UI.Color.primaryA 0 args.palette
                    , outerCircleColor = R10.FormComponents.UI.Color.containerA 0.5 args.palette
                    }

                ( False, False ) ->
                    { innerCircleSize = 0
                    , innerCircleColor = R10.FormComponents.UI.Color.primaryA 0 args.palette
                    , outerCircleColor = R10.FormComponents.UI.Color.containerA 1 args.palette
                    }

        innerCircle : Element msg
        innerCircle =
            el
                [ htmlAttribute <| Html.Attributes.style "transition" "all 0.13s"
                , Background.color <| innerCircleColor
                , width <| px innerCircleSize
                , height <| px innerCircleSize
                , Border.rounded 20
                , centerX
                , centerY
                ]
                none

        selector : Element msg
        selector =
            el
                [ htmlAttribute <| Html.Attributes.style "transition" "all 0.13s"
                , width <| px 20
                , height <| px 20
                , centerX
                , centerY
                , behindContent <| innerCircle
                , Border.rounded 20
                , Border.width 2
                , Border.color outerCircleColor
                ]
                none
    in
    row
        ([ spacing 5
         , width fill
         , height fill
         ]
            ++ (if args.disabled then
                    [ htmlAttribute <| Html.Attributes.style "cursor" "auto" ]

                else
                    []
               )
        )
        [ R10.FormComponents.UI.viewSelectShadow { args | focused = args.focused && isSelected optionState } selector
        , paragraph [] [ text label ]
        ]


viewRadioOptions : Common.Args msg -> Common.FieldOption -> Input.Option String msg
viewRadioOptions args fieldOption =
    Input.optionWith fieldOption.value (viewRadioOption args fieldOption.label)


viewRadioLabel : R10.FormComponents.UI.Palette.Palette -> String -> Maybe String -> Element msg
viewRadioLabel palette label helperText =
    if label == "" then
        none

    else
        column
            [ paddingEach { top = 10, right = 0, bottom = 24, left = 10 }
            , R10.FormComponents.UI.fontSizeSubTitle
            , spacing R10.FormComponents.UI.genericSpacing
            ]
            [ paragraph [] [ text label ]
            , R10.FormComponents.UI.viewHelperText
                palette
                [ Font.size 14
                , alpha 0.5
                , paddingEach { top = R10.FormComponents.UI.genericSpacing, right = 0, bottom = 0, left = 0 }
                ]
                helperText
            ]


viewRadio : List (Attribute msg) -> Common.Args msg -> Element msg
viewRadio attrs args =
    let
        --isOneOptionSelected =
        --    (List.length <| List.filter (\option -> option.value == args.value) args.fieldOptions) > 0
        valid : Maybe Bool
        valid =
            R10.FormComponents.Validations.isValid args.validation

        displayValidation : Bool
        displayValidation =
            valid /= Nothing

        fixedValue : String
        fixedValue =
            --
            -- TODO
            --
            -- -- Radio button should always have one option selected
            -- -- https://uxplanet.org/radio-buttons-ux-design-588e5c0a50dc
            -- if isOneOptionSelected then
            --     args.value
            --
            -- else
            --     Maybe.withDefault "" <| Maybe.map .value (List.head args.fieldOptions)
            args.value

        styleArgs :
            { disabled : Bool
            , displayValidation : Bool
            , focused : Bool
            , inputText : Bool
            , isMouseOver : Bool
            , label : String
            , leadingIcon : Maybe a1
            , palette : R10.FormComponents.UI.Palette.Palette
            , requiredLabel : Maybe String
            , style : R10.FormComponents.Style.Style
            , trailingIcon : Maybe a
            , valid : Maybe Bool
            , value : String
            }
        styleArgs =
            { label = args.label
            , value = args.value
            , focused = args.focused
            , disabled = args.disabled
            , requiredLabel = args.requiredLabel
            , style = args.style
            , palette = args.palette
            , leadingIcon = Nothing
            , trailingIcon = Nothing
            , valid = valid
            , inputText = False
            , displayValidation = displayValidation
            , isMouseOver = False
            }
    in
    el
        ([ spacing 10
         , alignTop
         , width fill
         , height fill
         ]
            ++ attrs
        )
    <|
        Input.radio
            ([ spacing 5
             , alignTop
             , Events.onFocus <| args.msgOnFocus (Common.getSelectedOrFirst args.fieldOptions args.value)
             , Events.onLoseFocus <| args.msgOnLoseFocus args.value
             , width fill
             ]
                ++ (if args.disabled then
                        [ htmlAttribute <| Html.Attributes.tabindex -1 ]

                    else
                        []
                   )
            )
            { onChange =
                if args.disabled then
                    always <| args.msgOnOptionSelect args.value

                else
                    args.msgOnOptionSelect
            , options = List.map (viewRadioOptions args) args.fieldOptions
            , selected = Just fixedValue
            , label = Input.labelAbove [] <| viewRadioLabel args.palette args.label args.helperText
            }
