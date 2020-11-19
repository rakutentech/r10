module R10.FormComponents.Binary exposing
    ( Args
    , TypeBinary(..)
    , view
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import R10.FormComponents.UI
import R10.FormComponents.UI.Color
import R10.FormComponents.UI.Palette
import R10.FormComponents.Validations
import Html.Attributes


type TypeBinary
    = BinaryCheckbox
    | BinarySwitch


type alias Args msg =
    { -- Stuff that change
      value : Bool
    , focused : Bool
    , validation : R10.FormComponents.Validations.Validation

    -- Messages
    , msgOnChange : Bool -> msg
    , msgOnFocus : msg
    , msgOnLoseFocus : msg
    , msgOnClick : msg

    -- Stuff that doesn't change
    , label : String
    , disabled : Bool
    , helperText : Maybe String
    , palette : R10.FormComponents.UI.Palette.Palette

    -- Specific stuff
    , typeBinary : TypeBinary
    }


viewBinarySwitch : List (Attribute msg) -> Args msg -> Element msg
viewBinarySwitch attrs args =
    let
        { trackColor, thumbColor } =
            if args.value then
                { trackColor = R10.FormComponents.UI.Color.primaryVariant
                , thumbColor = R10.FormComponents.UI.Color.primary
                }

            else
                { trackColor = R10.FormComponents.UI.Color.onSurfaceA 0.37
                , thumbColor = R10.FormComponents.UI.Color.surface
                }

        track : Element msg
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

        thumb : Element msg
        thumb =
            el
                [ height <| px 20
                , width <| px 20
                , Border.rounded 24
                , htmlAttribute <| Html.Attributes.style "transition" "all 0.14s "
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

        switch : Element msg
        switch =
            el
                [ width <| px 56
                , height <| px 40
                , inFront <|
                    el
                        [ htmlAttribute <| Html.Attributes.style "transition" "all 0.13s"
                        , if args.value then
                            moveRight 16

                          else
                            moveRight 0
                        ]
                    <|
                        R10.FormComponents.UI.viewSelectShadow args thumb
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
                    , htmlAttribute <| R10.FormComponents.UI.onSelectKey args.msgOnClick
                    , Events.onFocus args.msgOnFocus
                    , Events.onLoseFocus args.msgOnLoseFocus
                    ]
               )
            ++ attrs
        )
        [ paragraph [] [ text <| args.label ]
        , switch
        ]


viewBinaryCheckbox : List (Attribute msg) -> Args msg -> Element msg
viewBinaryCheckbox attrs args =
    row
        ([ height <| px 20
         , spacing 15
         ]
            ++ (if args.disabled then
                    [ alpha 0.38 ]

                else
                    [ Events.onClick args.msgOnClick
                    , pointer
                    , htmlAttribute <| Html.Attributes.tabindex 0
                    , htmlAttribute <| R10.FormComponents.UI.onSelectKey args.msgOnClick
                    , Events.onFocus args.msgOnFocus
                    , Events.onLoseFocus args.msgOnLoseFocus
                    ]
               )
            ++ attrs
        )
        [ checkboxIcon args args.value
        , paragraph
            [ width fill
            , Font.alignLeft
            , htmlAttribute <| Html.Attributes.id "ie-flex-fix"
            ]
          <|
            [ text <| args.label ]
        ]


checkboxIcon : Args msg -> Bool -> Element msg
checkboxIcon args value =
    let
        checkMark : Element msg
        checkMark =
            if value then
                el
                    [ centerX
                    , centerY
                    ]
                <|
                    html <|
                        R10.FormComponents.UI.icons.checkBold_ (R10.FormComponents.UI.Color.onPrimary args.palette |> R10.FormComponents.UI.Color.toCssString) 10

            else
                none

        boxBorderAndFill : Element msg
        boxBorderAndFill =
            el
                ([ htmlAttribute <| Html.Attributes.style "transition" "all 0.2s "
                 , width <| px 18
                 , height <| px 18
                 , Border.rounded 3
                 , centerY
                 , centerX
                 ]
                    ++ (if value then
                            [ Background.color <| R10.FormComponents.UI.Color.primary args.palette
                            , Border.innerShadow
                                { offset = ( 0, 0 )
                                , size = 0
                                , blur = 0
                                , color = R10.FormComponents.UI.Color.onSurfaceA 0.54 args.palette
                                }
                            ]

                        else
                            [ Background.color <| R10.FormComponents.UI.Color.transparent
                            , Border.innerShadow
                                { offset = ( 0, 0 )
                                , size = 2
                                , blur = 0
                                , color = R10.FormComponents.UI.Color.onSurfaceA 0.54 args.palette
                                }
                            ]
                       )
                )
                checkMark
    in
    el [ width <| px 18, moveLeft 11 ] <| R10.FormComponents.UI.viewSelectShadow args boxBorderAndFill


view : List (Attribute msg) -> Args msg -> Element msg
view attrs args =
    column [ width fill, centerY ] <|
        [ case args.typeBinary of
            BinarySwitch ->
                viewBinarySwitch attrs args

            BinaryCheckbox ->
                viewBinaryCheckbox attrs args
        , R10.FormComponents.UI.viewHelperText args.palette
            [ Font.size 14, alpha 0.5, paddingEach { top = R10.FormComponents.UI.genericSpacing, right = 0, bottom = 0, left = 0 } ]
            args.helperText
        ]
