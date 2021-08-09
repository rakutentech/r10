module R10.FormComponents.Internal.UI exposing
    ( borderEntityWithBorder
    , floatingLabel
    , fontSizeSubTitle
    , fontSizeTitle
    , genericSpacing
    , getTextfieldBorderSizeOffset
    , getTextfieldPaddingEach
    , iconWidth
    , icons
    , keyCode
    , onClickWithStopPropagation
    , onEnter
    , onKeyPressBatch
    , onScroll
    , onSelectKey
    , showValidationIcon_
    , viewHelperText
    , viewSelectShadow
    , viewSelectShadowCustomSize
    )

import Dict
import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import R10.Context exposing (..)
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.TextColors
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.UI.Const
import R10.FormTypes
import R10.SimpleMarkdown
import R10.Svg.Icons
import R10.Svg.IconsExtra
import R10.Transition


borderEntityWithBorder : R10.FormTypes.Palette -> List (AttributeC msg)
borderEntityWithBorder palette =
    [ Border.width 1
    , Border.color <| R10.FormComponents.Internal.UI.Color.container palette
    , Border.rounded 5
    ]


fontSizeSubTitle : AttrC decorative msg
fontSizeSubTitle =
    Font.size 18


fontSizeTitle : AttrC decorative msg
fontSizeTitle =
    Font.size 24


genericSpacing : Int
genericSpacing =
    8


viewHelperText : R10.FormTypes.Palette -> List (AttrC () msg) -> Maybe String -> ElementC msg
viewHelperText palette attrs maybeHelperText =
    case maybeHelperText of
        Just helperText ->
            -- styles inspired by from https://material.io/components/text-fields/#specs
            paragraph
                -- Ugly IE fix for Omni
                ([ htmlAttribute <| Html.Attributes.id "ie-flex-fix-320", Font.color (R10.FormComponents.Internal.UI.Color.label palette) ]
                    ++ attrs
                )
            <|
                R10.SimpleMarkdown.elementMarkdownAdvanced
                    { link = [ Font.color <| R10.FormComponents.Internal.UI.Color.primary palette ] }
                    helperText

        Nothing ->
            none


iconWidth : Maybe a -> number
iconWidth icon =
    case icon of
        Just _ ->
            40

        Nothing ->
            0


getTextfieldPaddingEach : { a | style : R10.FormComponents.Internal.Style.Style, trailingIcon : Maybe b, leadingIcon : Maybe c } -> { top : Int, right : Int, bottom : Int, left : Int }
getTextfieldPaddingEach args =
    let
        paddingCenterY : Int
        paddingCenterY =
            ceiling <| (R10.FormComponents.Internal.UI.Const.inputTextHeight - toFloat R10.FormComponents.Internal.UI.Const.inputTextFontSize) / 2
    in
    case args.style of
        R10.FormComponents.Internal.Style.Filled ->
            { top = paddingCenterY + R10.FormComponents.Internal.UI.Const.inputTextFilledDown
            , right = 0
            , bottom = paddingCenterY - R10.FormComponents.Internal.UI.Const.inputTextFilledDown
            , left = 0 + iconWidth args.leadingIcon
            }

        R10.FormComponents.Internal.Style.Outlined ->
            { top = paddingCenterY
            , right = max 16 (iconWidth args.trailingIcon)
            , bottom = paddingCenterY
            , left = max 16 (iconWidth args.leadingIcon)
            }


icons :
    { check : List (AttributeC msg) -> Color -> Int -> ElementC msg
    , checkBold : List (AttributeC msg) -> Color -> Int -> ElementC msg
    , combobox_arrow : List (AttributeC msg) -> Color -> Int -> ElementC msg
    , eye_ban_l : List (AttributeC msg) -> Color -> Int -> ElementC msg
    , eye_l : List (AttributeC msg) -> Color -> Int -> ElementC msg
    , grid : List (AttributeC msg) -> Color -> Int -> ElementC msg
    , notice_generic_l : List (AttributeC msg) -> Color -> Int -> ElementC msg
    , search : List (AttributeC msg) -> Color -> Int -> ElementC msg
    , sign_warning_f : List (AttributeC msg) -> Color -> Int -> ElementC msg
    , sign_warning_l : List (AttributeC msg) -> Color -> Int -> ElementC msg
    , validation_check : List (AttributeC msg) -> Color -> Int -> ElementC msg
    , validation_clear : List (AttributeC msg) -> Color -> Int -> ElementC msg
    , validation_error : List (AttributeC msg) -> Color -> Int -> ElementC msg
    }
icons =
    { check = R10.Svg.Icons.check
    , checkBold = R10.Svg.IconsExtra.checkBold
    , combobox_arrow = R10.Svg.IconsExtra.keyboardArrowDown
    , eye_ban_l = R10.Svg.Icons.eye_ban_l
    , eye_l = R10.Svg.IconsExtra.email
    , grid = R10.Svg.IconsExtra.grid
    , notice_generic_l = R10.Svg.Icons.notice_generic_l
    , search = R10.Svg.IconsExtra.search
    , sign_warning_f = R10.Svg.Icons.sign_warning_f
    , sign_warning_l = R10.Svg.Icons.sign_warning_l
    , validation_check = R10.Svg.IconsExtra.validation_check
    , validation_clear = R10.Svg.IconsExtra.validation_clear
    , validation_error = R10.Svg.IconsExtra.validation_error
    }


getTextfieldBorderSizeOffset :
    { a
        | focused : Bool
        , style : R10.FormComponents.Internal.Style.Style
        , maybeValid : Maybe Bool
        , displayValidation : Bool
    }
    -> { size : Float, offset : ( Float, Float ) }
getTextfieldBorderSizeOffset { focused, style, maybeValid, displayValidation } =
    case ( focused, style ) of
        ( True, R10.FormComponents.Internal.Style.Filled ) ->
            { size = 0, offset = ( 0, -2.5 ) }

        ( False, R10.FormComponents.Internal.Style.Filled ) ->
            { size = 0, offset = ( 0, -1.5 ) }

        ( True, R10.FormComponents.Internal.Style.Outlined ) ->
            { size = 2, offset = ( 0, 0 ) }

        ( False, R10.FormComponents.Internal.Style.Outlined ) ->
            { size = 1, offset = ( 0, 0 ) }


getSelectShadowColor : R10.FormTypes.Palette -> Bool -> Bool -> Color
getSelectShadowColor palette focused mouseOver =
    let
        alpha : Float
        alpha =
            case ( focused, mouseOver ) of
                ( True, True ) ->
                    0.21

                ( True, False ) ->
                    0.14

                ( False, True ) ->
                    0.07

                ( False, False ) ->
                    0
    in
    R10.FormComponents.Internal.UI.Color.primaryA alpha palette


viewSelectShadowCustomSize :
    { a
        | palette : R10.FormTypes.Palette
        , focused : Bool
        , disabled : Bool
        , size : { x : Int, y : Int }
        , rounded : Int
        , value : Bool
    }
    -> ElementC msg
    -> ElementC msg
viewSelectShadowCustomSize { palette, focused, disabled, size, value, rounded } element =
    el
        ([]
            ++ [ width <| px size.x
               , height <| px size.y
               , Border.rounded rounded
               , R10.Transition.transition "all 0.15s"
               ]
            ++ (if disabled then
                    []

                else
                    [ htmlAttribute <| Html.Attributes.class "ripple-primary"
                    , Background.color <| getSelectShadowColor palette focused False
                    , mouseOver
                        [ Background.color <| getSelectShadowColor palette focused True

                        -- XXX
                        , Border.shadow
                            { offset = ( 0, 0 )
                            , size = 2
                            , blur = 0
                            , color =
                                (if value then
                                    R10.FormComponents.Internal.UI.Color.primary

                                 else
                                    R10.FormComponents.Internal.UI.Color.borderA 0.7
                                )
                                    palette
                            }
                        ]
                    ]
               )
        )
        element


viewSelectShadow : { a | palette : R10.FormTypes.Palette, focused : Bool, disabled : Bool, value : Bool } -> ElementC msg -> ElementC msg
viewSelectShadow { palette, focused, disabled, value } =
    viewSelectShadowCustomSize
        { palette = palette
        , focused = focused
        , disabled = disabled
        , size = { x = 40, y = 40 }
        , rounded = 40
        , value = value
        }


onClickWithStopPropagation : msg -> AttributeC msg
onClickWithStopPropagation message =
    htmlAttribute <| Html.Events.stopPropagationOn "click" (Json.Decode.succeed ( message, True ))


onScroll : (Float -> msg) -> Html.Attribute msg
onScroll msg =
    Html.Events.on "scroll"
        (Json.Decode.at [ "target", "scrollTop" ] Json.Decode.float
            |> Json.Decode.map msg
        )


keyCode : { esc : number, up : number, down : number, enter : number, space : number, backspace : number, del : number }
keyCode =
    { esc = 27
    , up = 38
    , down = 40
    , enter = 13
    , space = 32
    , backspace = 8
    , del = 46
    }


onSelectKey : msg -> Html.Attribute msg
onSelectKey msg =
    onKeyPressBatch [ ( keyCode.enter, msg ), ( keyCode.space, msg ) ]


onEnter : msg -> Html.Attribute msg
onEnter msg =
    onKeyPressBatch [ ( keyCode.enter, msg ) ]


onKeyPressBatch : List ( Int, msg ) -> Html.Attribute msg
onKeyPressBatch codesMsg =
    let
        codesMsgDict : Dict.Dict Int msg
        codesMsgDict =
            Dict.fromList codesMsg
    in
    Html.Events.keyCode
        |> Json.Decode.andThen
            (\key ->
                case Dict.get key codesMsgDict of
                    Just msg ->
                        Json.Decode.succeed ( msg, True )

                    Nothing ->
                        Json.Decode.fail "Not code"
            )
        |> Html.Events.preventDefaultOn "keydown"


floatingLabel :
    { a
        | label : String
        , value : String
        , focused : Bool
        , requiredLabel : Maybe String

        -- , leadingIcon : Maybe (ElementC msg)
        -- , trailingIcon : Maybe (ElementC msg)
        , maybeValid : Maybe Bool
        , displayValidation : Bool
        , style : R10.FormComponents.Internal.Style.Style
        , palette : R10.FormTypes.Palette
        , floatingLabelAlwaysUp : Bool
    }
    -> ElementC msg
floatingLabel args =
    let
        labelIsAbove : Bool
        labelIsAbove =
            args.focused || String.length args.value > 0 || args.floatingLabelAlwaysUp

        notchClearance : Int
        notchClearance =
            case args.style of
                R10.FormComponents.Internal.Style.Filled ->
                    0

                R10.FormComponents.Internal.Style.Outlined ->
                    6

        labelAboveAttrs : List (AttributeC msg)
        labelAboveAttrs =
            if labelIsAbove then
                case args.style of
                    R10.FormComponents.Internal.Style.Filled ->
                        [ moveUp <| 28 - 16, moveRight 0 ]

                    R10.FormComponents.Internal.Style.Outlined ->
                        [ moveUp <| 23 - 16, Font.size 14, moveRight 0 ]

            else
                [ moveUp <| 0 - 16

                -- , moveRight labelBelowLeftPadding
                , Font.size R10.FormComponents.Internal.UI.Const.inputTextFontSize
                ]

        requiredEl : ElementC msg
        requiredEl =
            case args.requiredLabel of
                Just required ->
                    el [ alpha 0.7 ] <| text required

                Nothing ->
                    none

        labelEl : ElementC msg
        labelEl =
            -- If the label is too long, it doesn't wrap. I tried adding a
            -- paragraph here, but then the label overlap with the
            -- input field.
            row
                ([ R10.Transition.transition "all 0.15s"
                 , htmlAttribute <| Html.Attributes.style "pointer-events" "none"
                 , spacing 6
                 , paddingXY 8 0
                 , centerY
                 ]
                    ++ (if labelIsAbove then
                            [ Background.color <| R10.FormComponents.Internal.UI.Color.surface args.palette ]

                        else
                            []
                       )
                    ++ labelAboveAttrs
                )
                [ text args.label, requiredEl ]
    in
    if String.isEmpty args.label && args.requiredLabel == Nothing then
        none

    else
        el
            [ height <| px 0
            , Font.color <| R10.FormComponents.Internal.TextColors.getLabelColor args
            , moveDown
                (case args.style of
                    R10.FormComponents.Internal.Style.Filled ->
                        6

                    R10.FormComponents.Internal.Style.Outlined ->
                        0
                )
            , moveRight
                (case args.style of
                    R10.FormComponents.Internal.Style.Filled ->
                        -8

                    R10.FormComponents.Internal.Style.Outlined ->
                        8
                )
            ]
            labelEl


showValidationIcon_ :
    { a
        | maybeValid : Maybe Bool
        , displayValidation : Bool
        , palette : R10.FormTypes.Palette
        , style : R10.FormComponents.Internal.Style.Style
    }
    -> ElementC msg
showValidationIcon_ args =
    let
        iconSize : Int
        iconSize =
            18

        widthPx : Int
        widthPx =
            if args.displayValidation then
                -- Extra 16 px for the margin on the left. This icon is always
                -- the last on the right. This is to have it entering with
                -- an animation
                iconSize
                    + (case args.style of
                        R10.FormComponents.Internal.Style.Filled ->
                            4

                        R10.FormComponents.Internal.Style.Outlined ->
                            16
                      )

            else
                0
    in
    if args.maybeValid == Just False then
        icons.sign_warning_f
            [ R10.Transition.transition "width 0.4s"
            , width <| px widthPx
            , height <| px iconSize
            , clip
            ]
            (R10.FormComponents.Internal.UI.Color.error args.palette)
            iconSize

    else
        icons.check
            [ R10.Transition.transition "width 0.4s"
            , width <| px widthPx
            , height <| px iconSize
            , clip
            ]
            (R10.FormComponents.Internal.UI.Color.success args.palette)
            iconSize
