module R10.FormComponents.Internal.UI exposing
    ( borderEntityWithBorder
    , floatingLabel
    , fontSizeSubTitle
    , fontSizeTitle
    , genericSpacing
    , getBorderColor
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
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.UI.Const
import R10.FormTypes
import R10.SimpleMarkdown
import R10.Svg.Icons
import R10.Svg.IconsExtra


borderEntityWithBorder : R10.FormTypes.Palette -> List (Attribute msg)
borderEntityWithBorder palette =
    [ Border.width 1
    , Border.color <| R10.FormComponents.Internal.UI.Color.container palette
    , Border.rounded 5
    ]


fontSizeSubTitle : Attr decorative msg
fontSizeSubTitle =
    Font.size 18


fontSizeTitle : Attr decorative msg
fontSizeTitle =
    Font.size 24


genericSpacing : Int
genericSpacing =
    8


viewHelperText : R10.FormTypes.Palette -> List (Attr () msg) -> Maybe String -> Element msg
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
    { check : List (Attribute msg) -> Color -> Int -> Element msg
    , checkBold : List (Attribute msg) -> Color -> Int -> Element msg
    , combobox_arrow : List (Attribute msg) -> Color -> Int -> Element msg
    , eye_ban_l : List (Attribute msg) -> Color -> Int -> Element msg
    , eye_l : List (Attribute msg) -> Color -> Int -> Element msg
    , grid : List (Attribute msg) -> Color -> Int -> Element msg
    , notice_generic_l : List (Attribute msg) -> Color -> Int -> Element msg
    , search : List (Attribute msg) -> Color -> Int -> Element msg
    , sign_warning_f : List (Attribute msg) -> Color -> Int -> Element msg
    , sign_warning_l : List (Attribute msg) -> Color -> Int -> Element msg
    , validation_check : List (Attribute msg) -> Color -> Int -> Element msg
    , validation_clear : List (Attribute msg) -> Color -> Int -> Element msg
    , validation_error : List (Attribute msg) -> Color -> Int -> Element msg
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


getBorderColor :
    { a
        | focused : Bool
        , disabled : Bool
        , style : R10.FormComponents.Internal.Style.Style
        , maybeValid : Maybe Bool
        , displayValidation : Bool
        , isMouseOver : Bool
        , palette : R10.FormTypes.Palette
    }
    -> Color
getBorderColor { disabled, focused, style, maybeValid, displayValidation, isMouseOver, palette } =
    let
        validationActive : Bool
        validationActive =
            displayValidation && maybeValid == Just False

        alpha : Float
        alpha =
            if not disabled && (focused || isMouseOver || validationActive) then
                1

            else
                0.5
    in
    case style of
        R10.FormComponents.Internal.Style.Filled ->
            case ( displayValidation, maybeValid, focused ) of
                ( True, Just True, _ ) ->
                    R10.FormComponents.Internal.UI.Color.successA alpha palette

                ( True, Just False, _ ) ->
                    R10.FormComponents.Internal.UI.Color.errorA alpha palette

                ( _, _, _ ) ->
                    R10.FormComponents.Internal.UI.Color.onSurfaceA (0.3 * alpha) palette

        R10.FormComponents.Internal.Style.Outlined ->
            case ( displayValidation, maybeValid, focused ) of
                ( True, Just False, _ ) ->
                    R10.FormComponents.Internal.UI.Color.errorA alpha palette

                ( _, _, True ) ->
                    R10.FormComponents.Internal.UI.Color.primaryA alpha palette

                ( _, _, False ) ->
                    R10.FormComponents.Internal.UI.Color.containerA alpha palette


textfieldLabelColor :
    { a
        | focused : Bool
        , style : R10.FormComponents.Internal.Style.Style
        , maybeValid : Maybe Bool
        , displayValidation : Bool
        , palette : R10.FormTypes.Palette
    }
    -> Color
textfieldLabelColor { focused, style, maybeValid, displayValidation, palette } =
    case style of
        R10.FormComponents.Internal.Style.Filled ->
            case ( displayValidation, maybeValid, focused ) of
                --( True, Just True, True ) ->
                --    R10.FormComponents.Internal.UI.Color.success palette
                ( True, Just False, True ) ->
                    -- TODO(This is a temporary fix for OMNI (Originally was R10.FormComponents.Internal.UI.Color.error))
                    R10.FormComponents.Internal.UI.Color.label palette

                ( _, _, _ ) ->
                    R10.FormComponents.Internal.UI.Color.label palette

        R10.FormComponents.Internal.Style.Outlined ->
            case ( displayValidation, maybeValid, focused ) of
                ( True, Just False, True ) ->
                    R10.FormComponents.Internal.UI.Color.error palette

                ( _, _, True ) ->
                    R10.FormComponents.Internal.UI.Color.primary palette

                ( _, _, False ) ->
                    R10.FormComponents.Internal.UI.Color.label palette


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


viewSelectShadowCustomSize : { a | palette : R10.FormTypes.Palette, focused : Bool, disabled : Bool, size : { x : Int, y : Int } } -> Element msg -> Element msg
viewSelectShadowCustomSize { palette, focused, disabled, size } element =
    el
        ([ width <| px size.x
         , height <| px size.y
         , Border.rounded 20
         , htmlAttribute <| Html.Attributes.style "transition" "all 0.15s"
         ]
            ++ (if disabled then
                    []

                else
                    [ htmlAttribute <| Html.Attributes.class "ripple-primary"
                    , Background.color <| getSelectShadowColor palette focused False
                    , mouseOver [ Background.color <| getSelectShadowColor palette focused True ]
                    ]
               )
        )
        element


viewSelectShadow : { a | palette : R10.FormTypes.Palette, focused : Bool, disabled : Bool } -> Element msg -> Element msg
viewSelectShadow { palette, focused, disabled } =
    viewSelectShadowCustomSize { palette = palette, focused = focused, disabled = disabled, size = { x = 40, y = 40 } }


onClickWithStopPropagation : msg -> Attribute msg
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

        -- , leadingIcon : Maybe (Element msg)
        -- , trailingIcon : Maybe (Element msg)
        , maybeValid : Maybe Bool
        , displayValidation : Bool
        , style : R10.FormComponents.Internal.Style.Style
        , palette : R10.FormTypes.Palette
    }
    -> Element msg
floatingLabel args =
    let
        labelIsAbove : Bool
        labelIsAbove =
            args.focused || String.length args.value > 0

        notchClearance : Int
        notchClearance =
            case args.style of
                R10.FormComponents.Internal.Style.Filled ->
                    0

                R10.FormComponents.Internal.Style.Outlined ->
                    6

        labelAboveAttrs : List (Attribute msg)
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

        requiredEl : Element msg
        requiredEl =
            case args.requiredLabel of
                Just required ->
                    el [ alpha 0.7 ] <| text required

                Nothing ->
                    none

        labelEl : Element msg
        labelEl =
            -- If the label is too long, it doesn't wrap. I tried adding a
            -- paragraph here, but then the label overlap with the
            -- input field.
            row
                ([ htmlAttribute (Html.Attributes.style "transition" "all 0.15s")
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
            , Font.color <| textfieldLabelColor args
            , moveRight 8
            ]
            labelEl


showValidationIcon_ :
    { a
        | maybeValid : Maybe Bool
        , displayValidation : Bool
        , palette : R10.FormTypes.Palette
    }
    -> Element msg
showValidationIcon_ { maybeValid, displayValidation, palette } =
    let
        iconSize : Int
        iconSize =
            18

        widthPx : Int
        widthPx =
            if displayValidation then
                -- Extra 16 px for the margin on the left. This icon is always
                -- the last on the right. This is to have it entering with
                -- an animation
                iconSize + 16

            else
                0
    in
    if maybeValid == Just False then
        icons.sign_warning_f
            [ htmlAttribute <| Html.Attributes.style "transition" "width 0.4s"
            , width <| px widthPx
            , height <| px iconSize
            , clip
            ]
            (R10.FormComponents.Internal.UI.Color.error palette)
            iconSize

    else
        icons.check
            [ htmlAttribute <| Html.Attributes.style "transition" "width 0.4s"
            , width <| px widthPx
            , height <| px iconSize
            , clip
            ]
            (R10.FormComponents.Internal.UI.Color.success palette)
            iconSize
