module R10.FormComponents.Internal.Binary exposing
    ( Args
    , tagReplacer
    , view
    , viewBinarySwitch
    )

import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Events as Events
import Element.WithContext.Font as Font
import Html.Attributes
import R10.Color.AttrsFont
import R10.Context exposing (..)
import R10.Device
import R10.FontSize
import R10.Form.Internal.FieldConf
import R10.Form.Internal.Key
import R10.Form.Internal.Shared
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormTypes
import R10.I18n
import R10.Palette
import R10.Transition


type alias Args msg =
    --
    -- Stuff that usually doesn't change
    -- during the life of the component
    --
    { label : String
    , helperText : Maybe String
    , typeBinary : R10.FormTypes.TypeBinary
    , palette : R10.Palette.Palette
    , clickableLabel : Bool
    , style : R10.FormComponents.Internal.Style.Style

    -- Stuff that usually change
    -- during the life of the component
    --
    , value : Bool
    , focused : Bool
    , maybeValid : Maybe Bool
    , disabled : Bool
    , over : Maybe String
    , fieldConf : R10.Form.Internal.FieldConf.FieldConf

    -- Messages
    --
    , msgOnChange : Bool -> msg
    , msgOnFocus : msg
    , msgOnLoseFocus : msg
    , msgOnClick : msg
    , msgNoOp : msg
    , msgHover : Maybe String -> msg
    }


viewBinarySwitch : List (Attribute (R10.Context.ContextInternal z) msg) -> Args msg -> Element (R10.Context.ContextInternal z) msg
viewBinarySwitch attrs args =
    let
        { trackColor, thumbColor } =
            if args.value then
                { trackColor = R10.FormComponents.Internal.UI.Color.primaryVariant
                , thumbColor = R10.FormComponents.Internal.UI.Color.primary
                }

            else
                { trackColor = R10.FormComponents.Internal.UI.Color.onSurfaceA 0.37
                , thumbColor = R10.FormComponents.Internal.UI.Color.surface
                }

        track : Element (R10.Context.ContextInternal z) msg
        track =
            el
                [ centerX
                , centerY
                , Border.rounded 36
                , width <| px 36
                , height <| px 14
                , Background.color <| trackColor args.palette
                ]
                none

        thumb : Element (R10.Context.ContextInternal z) msg
        thumb =
            el
                [ height <| px 20
                , width <| px 20
                , Border.rounded 24
                , R10.Transition.transition "all 0.14s "
                , centerY
                , centerX
                , Background.color <| thumbColor args.palette
                , Border.shadow
                    { offset = ( 0, 1 )
                    , size = 1
                    , blur = 2
                    , color = trackColor args.palette
                    }
                ]
                none

        switch : Element (R10.Context.ContextInternal z) msg
        switch =
            el
                [ width <| px 56
                , height <| px 40
                , inFront <|
                    el
                        [ R10.Transition.transition "all 0.13s"
                        , if args.value then
                            moveRight 16

                          else
                            moveRight 0
                        ]
                    <|
                        let
                            args2 =
                                { palette = args.palette
                                , focused = args.focused
                                , disabled = args.disabled
                                , over = args |> .over |> Maybe.map (always True) |> Maybe.withDefault False
                                , value = args.value
                                }
                        in
                        R10.FormComponents.Internal.UI.viewSelectShadow args2 thumb
                , behindContent <| track
                ]
            <|
                none
    in
    row
        ([ spacing 15
         , height <| px 20
         ]
            ++ (if args.disabled then
                    [ alpha 0.38 ]

                else
                    [ Events.onClick args.msgOnClick
                    , pointer
                    , htmlAttribute <| Html.Attributes.tabindex 0
                    , htmlAttribute <| R10.FormComponents.Internal.UI.onSelectKey args.msgOnClick
                    , Events.onFocus args.msgOnFocus
                    , Events.onLoseFocus args.msgOnLoseFocus
                    ]
               )
            ++ attrs
        )
        [ paragraph [] [ text <| args.label ]
        , switch
        ]


viewBinaryCheckbox : List (Attribute (R10.Context.ContextInternal z) msg) -> Args msg -> Element (R10.Context.ContextInternal z) msg
viewBinaryCheckbox attrs args =
    let
        elementThatReceiveClicks =
            [ Events.onClick args.msgOnClick
            , pointer
            , htmlAttribute <| Html.Attributes.tabindex 0
            , htmlAttribute <| R10.FormComponents.Internal.UI.onSelectKey args.msgOnClick
            , Events.onFocus args.msgOnFocus
            , Events.onLoseFocus args.msgOnLoseFocus
            ]

        label : String
        label =
            args.label
                ++ Maybe.withDefault "" args.fieldConf.requiredLabel

        withFillForIE : R10.Context.ContextR10 -> List (Attribute (R10.Context.ContextInternal z) msg)
        withFillForIE c =
            if R10.Device.isInternetExplorer c.device then
                -- Fixcan not break line for IE
                -- The `width fill` will generate the `flex-grow` style in some case.
                -- So using the way to set width
                [ htmlAttribute <| Html.Attributes.style "width" "calc(100% - 16px)" ]

            else
                []
    in
    withContext
        (\c ->
            el
                ([ spacing 26 ]
                    ++ (if args.disabled then
                            [ alpha 0.38 ]

                        else if args.clickableLabel then
                            elementThatReceiveClicks

                        else
                            []
                       )
                    ++ attrs
                    ++ withFillForIE c.contextR10
                )
                (row
                    ([ width fill ]
                        ++ (if args.fieldConf.id /= R10.Form.Internal.Key.toString R10.Form.Internal.Shared.copyEmailIntoUsernameCheckboxKey then
                                [ htmlAttribute <| Html.Attributes.attribute "role" "checkbox"
                                , htmlAttribute <|
                                    Html.Attributes.attribute "aria-checked" <|
                                        if args.value then
                                            "true"

                                        else
                                            "false"
                                ]

                            else
                                []
                           )
                    )
                    [ el
                        ([ moveUp 2, alignTop ]
                            ++ (if args.clickableLabel then
                                    []

                                else
                                    elementThatReceiveClicks
                               )
                        )
                      <|
                        checkboxIcon args args.value
                    , R10.I18n.paragraphFromString
                        ([ R10.FontSize.small
                         , R10.Color.AttrsFont.normalLighter
                         , Events.onMouseEnter (args.msgHover (Just ""))
                         , Events.onMouseLeave (args.msgHover Nothing)
                         , paddingEach { top = 0, left = 12, bottom = 0, right = 0 }
                         ]
                            ++ withFillForIE c.contextR10
                        )
                        { renderingMode = R10.I18n.Normal
                        , tagReplacer = tagReplacer
                        , string = label
                        , msgNoOp = Just args.msgNoOp
                        }
                    , R10.FormComponents.Internal.UI.showValidationIcon_
                        { maybeValid = Just False -- Only display on not valid, so always passed False, otherwise the checked-icon will flashed.
                        , displayValidation = args.maybeValid == Just False
                        , palette = args.palette
                        , style = args.style
                        }
                    ]
                )
        )


tagReplacer : R10.Context.ContextInternal z -> String -> String
tagReplacer c string =
    --
    -- This is a minimal version of the other "tagReplacer". This is only
    -- used for checkboxes (Newsletter subscribtion and Policies agreements.
    --
    string
        |> String.replace "{privacy}" c.contextR10.urlPrivacyPolicy
        |> String.replace "{tac}" c.contextR10.urlTermsAndConditions
        |> String.replace "{cookie}" c.contextR10.urlCookiePolicy
        |> String.replace "{referenceClientNameOrClientName}"
            (if String.isEmpty c.contextR10.referenceExternalServiceName then
                c.contextR10.clientName

             else
                c.contextR10.referenceExternalServiceName
            )


checkboxIcon : Args msg -> Bool -> Element (R10.Context.ContextInternal z) msg
checkboxIcon args value =
    let
        checkMark : Element (R10.Context.ContextInternal z) msg
        checkMark =
            if value then
                R10.FormComponents.Internal.UI.icons.check
                    [ centerX
                    , centerY
                    ]
                    (R10.FormComponents.Internal.UI.Color.onPrimary args.palette)
                    18

            else
                none

        boxBorderAndFill : Element (R10.Context.ContextInternal z) msg
        boxBorderAndFill =
            el
                ([ R10.Transition.transition "all 0.2s "
                 , width <| px 24
                 , height <| px 24
                 , Border.rounded 3
                 , centerY
                 , centerX
                 ]
                    ++ (if value then
                            [ Background.color <| R10.FormComponents.Internal.UI.Color.primary args.palette
                            , Border.innerShadow
                                { offset = ( 0, 0 )
                                , size = 0
                                , blur = 0
                                , color = R10.FormComponents.Internal.UI.Color.onSurfaceA 0.25 args.palette
                                }
                            ]

                        else
                            [ Background.color <| R10.FormComponents.Internal.UI.Color.transparent
                            , Border.innerShadow
                                { offset = ( 0, 0 )
                                , size = 2
                                , blur = 0
                                , color = R10.FormComponents.Internal.UI.Color.onSurfaceA 0.25 args.palette
                                }
                            ]
                       )
                )
                checkMark

        isSPDevice : R10.Context.ContextR10 -> Bool
        isSPDevice contextR10 =
            R10.Device.isMobileOS contextR10.device
    in
    withContext
        (\c ->
            if isSPDevice c.contextR10 then
                boxBorderAndFill

            else
                R10.FormComponents.Internal.UI.viewSelectShadowCustomSize
                    { palette = args.palette
                    , focused = args.focused
                    , disabled = args.disabled
                    , selected = value
                    , size = { x = 28, y = 28 }
                    , rounded = 4
                    , over = args |> .over |> Maybe.map (always True) |> Maybe.withDefault False
                    }
                    boxBorderAndFill
        )


view : List (Attribute (R10.Context.ContextInternal z) msg) -> Args msg -> Element (R10.Context.ContextInternal z) msg
view attrs args =
    column
        [ width fill
        , centerY
        ]
    <|
        [ case args.typeBinary of
            R10.FormTypes.BinarySwitch ->
                viewBinarySwitch attrs args

            R10.FormTypes.BinaryCheckbox ->
                viewBinaryCheckbox attrs args
        , R10.FormComponents.Internal.UI.viewHelperText args.palette
            [ Font.size 14
            , alpha 0.5
            , paddingEach { top = R10.FormComponents.Internal.UI.genericSpacing, right = 0, bottom = 0, left = 0 }
            ]
            args.helperText
        ]
