module R10.FormComponents.Internal.Binary exposing
    ( Args
    , tagReplacer
    , view
    )

import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Events as Events
import Element.WithContext.Font as Font
import Html.Attributes
import R10.Context exposing (..)
import R10.FontSize
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormTypes
import R10.I18n
import R10.Paragraph
import R10.Transition


type alias Args msg =
    --
    -- Stuff that usually doesn't change
    -- during the life of the component
    --
    { label : String
    , helperText : Maybe String
    , typeBinary : R10.FormTypes.TypeBinary
    , palette : R10.FormTypes.Palette
    , clickableLabel : Bool

    -- Stuff that usually change
    -- during the life of the component
    --
    , value : Bool
    , focused : Bool
    , maybeValid : Maybe Bool
    , disabled : Bool

    -- Messages
    --
    , msgOnChange : Bool -> msg
    , msgOnFocus : msg
    , msgOnLoseFocus : msg
    , msgOnClick : msg
    }


viewBinarySwitch : List (AttributeC msg) -> Args msg -> ElementC msg
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

        track : ElementC msg
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

        thumb : ElementC msg
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

        switch : ElementC msg
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
                        R10.FormComponents.Internal.UI.viewSelectShadow args thumb
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


viewBinaryCheckbox : List (AttributeC msg) -> Args msg -> ElementC msg
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
    in
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
        )
        (row [ width fill ]
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
                [ R10.FontSize.small
                , paddingEach { top = 0, left = 12, bottom = 0, right = 0 }
                ]
                { renderingMode = R10.I18n.Normal
                , tagReplacer = tagReplacer
                , string = args.label
                }
            ]
        )


tagReplacer : Context -> String -> String
tagReplacer c string =
    --
    -- This is a minimal version of the other "tagReplacer". This is only
    -- used for checkboxes (Newsletter subscribtion and Policies agreements.
    --
    string
        |> String.replace "{privacy}" c.privacyPolicyLink
        |> String.replace "{tac}" c.termsAndConditionsLink
        |> String.replace "{cookie}" c.cookiePolicyLink


checkboxIcon : Args msg -> Bool -> ElementC msg
checkboxIcon args value =
    let
        checkMark : ElementC msg
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

        boxBorderAndFill : ElementC msg
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
    in
    R10.FormComponents.Internal.UI.viewSelectShadowCustomSize
        { palette = args.palette
        , focused = args.focused
        , disabled = args.disabled
        , value = value
        , size = { x = 28, y = 28 }
        , rounded = 4
        }
        boxBorderAndFill


view : List (AttributeC msg) -> Args msg -> ElementC msg
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
