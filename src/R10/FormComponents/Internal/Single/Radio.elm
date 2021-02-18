module R10.FormComponents.Internal.Single.Radio exposing (view, viewRow)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import R10.FormComponents.Internal.Single.Common
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormTypes


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
        , palette : R10.FormTypes.Palette
        , focused : Bool
        , label : String
    }
    -> Input.OptionState
    -> Element msg
viewRadioOption { disabled, palette, focused, label } optionState =
    let
        { innerCircleSize, innerCircleColor, outerCircleColor } =
            case ( isSelected optionState, disabled ) of
                ( True, True ) ->
                    { innerCircleSize = 10
                    , innerCircleColor = R10.FormComponents.Internal.UI.Color.primaryA 0.5 palette
                    , outerCircleColor = R10.FormComponents.Internal.UI.Color.primaryA 0.5 palette
                    }

                ( True, False ) ->
                    { innerCircleSize = 10
                    , innerCircleColor = R10.FormComponents.Internal.UI.Color.primaryA 1 palette
                    , outerCircleColor = R10.FormComponents.Internal.UI.Color.primaryA 1 palette
                    }

                ( False, True ) ->
                    { innerCircleSize = 0
                    , innerCircleColor = R10.FormComponents.Internal.UI.Color.primaryA 0 palette
                    , outerCircleColor = R10.FormComponents.Internal.UI.Color.containerA 0.5 palette
                    }

                ( False, False ) ->
                    { innerCircleSize = 0
                    , innerCircleColor = R10.FormComponents.Internal.UI.Color.primaryA 0 palette
                    , outerCircleColor = R10.FormComponents.Internal.UI.Color.containerA 1 palette
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
                , Border.innerShadow
                    { offset = ( 0, 0 )
                    , size = 2
                    , blur = 0
                    , color = outerCircleColor
                    }
                , Border.rounded 20
                , inFront <|
                    el [ moveUp 10, moveLeft 10, Border.rounded 20 ] <|
                        R10.FormComponents.Internal.UI.viewSelectShadow
                            { palette = palette
                            , focused = focused && isSelected optionState
                            , disabled = disabled
                            }
                            none
                ]
                none
    in
    row
        ([ spacing 17
         , width fill
         , height fill
         ]
            ++ (if disabled then
                    [ htmlAttribute <| Html.Attributes.style "cursor" "auto" ]

                else
                    []
               )
        )
        [ selector
        , paragraph [] [ text label ]
        ]


viewRadioOptions : R10.FormComponents.Internal.Single.Common.Args msg -> Bool -> R10.FormComponents.Internal.Single.Common.FieldOption -> Input.Option String msg
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


viewRadioLabel : R10.FormTypes.Palette -> String -> Maybe String -> Element msg
viewRadioLabel palette label helperText =
    if label == "" then
        none

    else
        column
            [ paddingEach { top = 10, right = 0, bottom = 24, left = 0 }
            , R10.FormComponents.Internal.UI.fontSizeSubTitle
            , spacing R10.FormComponents.Internal.UI.genericSpacing
            ]
            [ paragraph [] [ text label ]
            , R10.FormComponents.Internal.UI.viewHelperText
                palette
                [ Font.size 14
                , alpha 0.5
                , paddingEach { top = R10.FormComponents.Internal.UI.genericSpacing, right = 0, bottom = 0, left = 0 }
                ]
                helperText
            ]


viewRow : List (Attribute msg) -> R10.FormComponents.Internal.Single.Common.Model -> R10.FormComponents.Internal.Single.Common.Args msg -> Element msg
viewRow attrs model args =
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
    column
        ([ width fill
         ]
            ++ attrs
        )
    <|
        [ Input.radioRow
            ([ spacing 15

             --, alignTop
             , Events.onFocus <| args.toMsg <| R10.FormComponents.Internal.Single.Common.OnFocus (R10.FormComponents.Internal.Single.Common.getSelectedOrFirst args.fieldOptions model.value model.select)
             , Events.onLoseFocus <| args.toMsg <| R10.FormComponents.Internal.Single.Common.OnLoseFocus model.value
             , width fill
             , height <| px 20
             , centerY
             ]
                ++ (if args.disabled then
                        [ htmlAttribute <| Html.Attributes.tabindex -1 ]

                    else
                        []
                   )
            )
            { onChange =
                if args.disabled then
                    always <| args.toMsg <| R10.FormComponents.Internal.Single.Common.OnOptionSelect model.value

                else
                    args.toMsg << R10.FormComponents.Internal.Single.Common.OnOptionSelect
            , options = List.map (viewRadioOptions args model.focused) args.fieldOptions
            , selected = Just fixedValue
            , label = Input.labelLeft [ width fill, centerY ] <| text args.label
            }
        , R10.FormComponents.Internal.UI.viewHelperText
            args.palette
            [ Font.size 14
            , alpha 0.5
            , paddingEach { top = R10.FormComponents.Internal.UI.genericSpacing, right = 0, bottom = 0, left = 0 }
            ]
            args.helperText
        ]


view : List (Attribute msg) -> R10.FormComponents.Internal.Single.Common.Model -> R10.FormComponents.Internal.Single.Common.Args msg -> Element msg
view attrs model args =
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
            ([ spacing 26
             , alignTop
             , Events.onFocus <| args.toMsg <| R10.FormComponents.Internal.Single.Common.OnFocus (R10.FormComponents.Internal.Single.Common.getSelectedOrFirst args.fieldOptions model.value model.select)
             , Events.onLoseFocus <| args.toMsg <| R10.FormComponents.Internal.Single.Common.OnLoseFocus model.value
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
                    always <| args.toMsg <| R10.FormComponents.Internal.Single.Common.OnOptionSelect model.value

                else
                    args.toMsg << R10.FormComponents.Internal.Single.Common.OnOptionSelect
            , options = List.map (viewRadioOptions args model.focused) args.fieldOptions
            , selected = Just fixedValue
            , label = Input.labelAbove [] <| viewRadioLabel args.palette args.label args.helperText
            }
