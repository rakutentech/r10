module FormComponents.Single.Radio exposing (viewRadio)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import FormComponents.Single.Common as Common
import FormComponents.UI
import FormComponents.UI.Color
import FormComponents.UI.Palette
import Html.Attributes


isSelected : Input.OptionState -> Bool
isSelected optionState =
    case optionState of
        Input.Selected ->
            True

        Input.Idle ->
            False

        Input.Focused ->
            False


viewRadioOption :
    { a
        | disabled : Bool
        , palette : FormComponents.UI.Palette.Palette
        , focused : Bool
        , value : String
        , label : String
    }
    -> Input.OptionState
    -> Element msg
viewRadioOption { disabled, palette, focused, value, label } optionState =
    let
        { innerCircleSize, innerCircleColor, outerCircleColor } =
            case ( isSelected optionState, disabled ) of
                ( True, True ) ->
                    { innerCircleSize = 10
                    , innerCircleColor = FormComponents.UI.Color.primaryA 0.5 palette
                    , outerCircleColor = FormComponents.UI.Color.primaryA 0.5 palette
                    }

                ( True, False ) ->
                    { innerCircleSize = 10
                    , innerCircleColor = FormComponents.UI.Color.primaryA 1 palette
                    , outerCircleColor = FormComponents.UI.Color.primaryA 1 palette
                    }

                ( False, True ) ->
                    { innerCircleSize = 0
                    , innerCircleColor = FormComponents.UI.Color.primaryA 0 palette
                    , outerCircleColor = FormComponents.UI.Color.containerA 0.5 palette
                    }

                ( False, False ) ->
                    { innerCircleSize = 0
                    , innerCircleColor = FormComponents.UI.Color.primaryA 0 palette
                    , outerCircleColor = FormComponents.UI.Color.containerA 1 palette
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
            ++ (if disabled then
                    [ htmlAttribute <| Html.Attributes.style "cursor" "auto" ]

                else
                    []
               )
        )
        [ FormComponents.UI.viewSelectShadow
            { palette = palette
            , focused = focused && isSelected optionState
            , disabled = disabled
            }
            selector
        , paragraph [] [ text label ]
        ]


viewRadioOptions : Common.Args msg -> Bool -> Common.FieldOption -> Input.Option String msg
viewRadioOptions args focused fieldOption =
    Input.optionWith
        fieldOption.value
        (viewRadioOption
            { disabled = args.disabled
            , palette = args.palette
            , focused = focused
            , value = fieldOption.value
            , label = fieldOption.label
            }
        )


viewRadioLabel : FormComponents.UI.Palette.Palette -> String -> Maybe String -> Element msg
viewRadioLabel palette label helperText =
    if label == "" then
        none

    else
        column
            [ paddingEach { top = 10, right = 0, bottom = 24, left = 10 }
            , FormComponents.UI.fontSizeSubTitle
            , spacing FormComponents.UI.genericSpacing
            ]
            [ paragraph [] [ text label ]
            , FormComponents.UI.viewHelperText
                palette
                [ Font.size 14
                , alpha 0.5
                , paddingEach { top = FormComponents.UI.genericSpacing, right = 0, bottom = 0, left = 0 }
                ]
                helperText
            ]


viewRadio : List (Attribute msg) -> Common.Model -> Common.Args msg -> Element msg
viewRadio attrs model args =
    let
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
            model.value
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
             , Events.onFocus <| args.toMsg <| Common.OnFocus (Common.getSelectedOrFirst args.fieldOptions model.value model.select)
             , Events.onLoseFocus <| args.toMsg <| Common.OnLoseFocus model.value
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
                    always <| args.toMsg <| Common.OnOptionSelect model.value

                else
                    args.toMsg << Common.OnOptionSelect
            , options = List.map (viewRadioOptions args model.focused) args.fieldOptions
            , selected = Just fixedValue
            , label = Input.labelAbove [] <| viewRadioLabel args.palette args.label args.helperText
            }
