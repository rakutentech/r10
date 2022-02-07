module R10.FormComponents.Internal.Single.Radio exposing (view, viewRow)

import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Events as Events
import Element.WithContext.Font as Font
import Element.WithContext.Input as Input
import Html.Attributes
import R10.Color.AttrsFont
import R10.Context exposing (..)
import R10.Device
import R10.FormComponents.Internal.Single.Common
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.Palette
import R10.Paragraph
import R10.Transition


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
        , palette : R10.Palette.Palette
        , focused : Bool
        , label : String
        , value : Bool
    }
    -> Input.OptionState
    -> Element (R10.Context.ContextInternal z) msg
viewRadioOption { disabled, palette, focused, label, value } optionState =
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

        innerCircle : Element (R10.Context.ContextInternal z) msg
        innerCircle =
            el
                [ R10.Transition.transition "all 0.13s"
                , Background.color <| innerCircleColor
                , width <| px innerCircleSize
                , height <| px innerCircleSize
                , Border.rounded 20
                , centerX
                , centerY
                ]
                none

        isSPDevice : R10.Context.ContextR10 -> Bool
        isSPDevice contextR10 =
            R10.Device.isMobileOS contextR10.userAgent

        selector : R10.Context.ContextR10 -> Element (R10.Context.ContextInternal z) msg
        selector c =
            el
                [ R10.Transition.transition "all 0.13s"
                , width <| px 24
                , height <| px 24
                , moveRight 2
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
                    if isSPDevice c then
                        none

                    else
                        el [ moveUp 2, moveLeft 2 ] <|
                            R10.FormComponents.Internal.UI.viewSelectShadowCustomSize
                                { palette = palette
                                , focused = focused && isSelected optionState
                                , disabled = disabled
                                , value = value
                                , size = { x = 28, y = 28 }
                                , rounded = 50
                                }
                                none
                ]
                none
    in
    withContext
        (\c ->
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
                [ selector c.contextR10
                , paragraph [ R10.Color.AttrsFont.normalLighter ] [ text label ]
                ]
        )


viewRadioOptions :
    String
    -> R10.FormComponents.Internal.Single.Common.Args z msg
    -> Bool
    -> R10.FormComponents.Internal.Single.Common.FieldOption
    -> Input.Option (R10.Context.ContextInternal z) String msg
viewRadioOptions selected args focused fieldOption =
    Input.optionWith
        fieldOption.value
        (viewRadioOption
            { disabled = args.disabled
            , palette = args.palette
            , focused = focused
            , value = fieldOption.value == selected
            , label = fieldOption.label
            }
        )


viewRadioLabel : R10.Palette.Palette -> String -> Maybe String -> Maybe String -> Element (R10.Context.ContextInternal z) msg
viewRadioLabel palette label helperText requiredLabel =
    if label == "" then
        none

    else
        column
            [ paddingEach { top = 10, right = 0, bottom = 24, left = 0 }
            , spacing R10.FormComponents.Internal.UI.genericSpacing
            ]
            [ R10.Paragraph.normal []
                [ text label
                , el [ R10.Color.AttrsFont.normalLighter, paddingXY 6 0 ] <| text <| Maybe.withDefault "" requiredLabel
                ]
            , R10.FormComponents.Internal.UI.viewHelperText
                palette
                [ Font.size 14
                , alpha 0.5
                , paddingEach { top = R10.FormComponents.Internal.UI.genericSpacing, right = 0, bottom = 0, left = 0 }
                ]
                helperText
            ]


viewRow : List (Attribute (R10.Context.ContextInternal z) msg) -> R10.FormComponents.Internal.Single.Common.Model -> R10.FormComponents.Internal.Single.Common.Args z msg -> Element (R10.Context.ContextInternal z) msg
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
            , options = List.map (viewRadioOptions fixedValue args model.focused) args.fieldOptions
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


view : List (Attribute (R10.Context.ContextInternal z) msg) -> R10.FormComponents.Internal.Single.Common.Model -> R10.FormComponents.Internal.Single.Common.Args z msg -> Element (R10.Context.ContextInternal z) msg
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
        ([ alignTop
         , width fill
         , height fill
         , inFront <|
            el [ alignRight, moveDown 5 ]
                (R10.FormComponents.Internal.UI.showValidationIcon_
                    { maybeValid = args.maybeValid
                    , displayValidation = args.maybeValid == Just False
                    , palette = args.palette
                    , style = args.style
                    }
                )
         ]
            ++ attrs
        )
    <|
        Input.radio
            ([ spacing 16
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
            , options = List.map (viewRadioOptions fixedValue args model.focused) args.fieldOptions
            , selected = Just fixedValue
            , label = Input.labelAbove [] <| viewRadioLabel args.palette args.label args.helperText args.requiredLabel
            }
