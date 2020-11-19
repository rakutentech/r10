module R10.FormComponents.UI exposing
    ( borderEntityWithBorder
    , fontSizeSubTitle
    , fontSizeTitle
    , genericSpacing
    , getBorderColor
    , getTextfieldBorderSizeOffset
    , getTextfieldPaddingEach
    , icons
    , keyCode
    , labelBuilder
    , onClickWithStopPropagation
    , onEnter
    , onKeyPressBatch
    , onScroll
    , onSelectKey
    , showValidationIcon_
    , viewHelperText
    , viewSelectShadow
    )

import Dict
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import R10.FormComponents.Style
import R10.FormComponents.UI.Color
import R10.FormComponents.UI.Const
import R10.FormComponents.UI.Icon
import R10.FormComponents.UI.Palette
import R10.FormComponents.Utils.SimpleMarkdown
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Svg


borderEntityWithBorder : R10.FormComponents.UI.Palette.Palette -> List (Attribute msg)
borderEntityWithBorder palette =
    [ Border.width 1
    , Border.color <| R10.FormComponents.UI.Color.container palette
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


viewHelperText : R10.FormComponents.UI.Palette.Palette -> List (Attr () msg) -> Maybe String -> Element msg
viewHelperText palette attrs maybeHelperText =
    case maybeHelperText of
        Just helperText ->
            -- styles inspired by from https://material.io/components/text-fields/#specs
            paragraph
                ([ Font.color (R10.FormComponents.UI.Color.label palette) ]
                    ++ attrs
                )
            <|
                R10.FormComponents.Utils.SimpleMarkdown.elementMarkdownAdvanced
                    { link = [ Font.color <| R10.FormComponents.UI.Color.primary palette ] }
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


getTextfieldPaddingEach : { a | style : R10.FormComponents.Style.Style, trailingIcon : Maybe b, leadingIcon : Maybe c } -> { top : Int, right : Int, bottom : Int, left : Int }
getTextfieldPaddingEach args =
    let
        paddingCenterY : Int
        paddingCenterY =
            ceiling <| (R10.FormComponents.UI.Const.inputTextHeight - R10.FormComponents.UI.Const.inputTextFontSize) / 2
    in
    case args.style of
        R10.FormComponents.Style.Filled ->
            { top = paddingCenterY + R10.FormComponents.UI.Const.inputTextFilledDown
            , right = 0 + iconWidth args.trailingIcon
            , bottom = paddingCenterY - R10.FormComponents.UI.Const.inputTextFilledDown
            , left = 0 + iconWidth args.leadingIcon
            }

        R10.FormComponents.Style.Outlined ->
            { top = paddingCenterY
            , right = max 16 (iconWidth args.trailingIcon)
            , bottom = paddingCenterY
            , left = max 16 (iconWidth args.leadingIcon)
            }


icons :
    { checkBold_ : String -> Int -> Svg.Svg msg1
    , combobox_arrow_ : String -> Int -> Svg.Svg msg3
    , eye_ban_l_ : String -> Int -> Svg.Svg msg4
    , eye_l_ : String -> Int -> Svg.Svg msg5
    , grid : String -> Int -> Svg.Svg msg6
    , notice_generic_l_ : String -> Int -> Svg.Svg msg7
    , search_ : String -> Int -> Svg.Svg msg8
    , sign_warning_f_ : String -> Int -> Svg.Svg msg9
    , sign_warning_l_ : String -> Int -> Svg.Svg msg10
    , validation_check_ : String -> Int -> Svg.Svg msg11
    , validation_clear_ : String -> Int -> Svg.Svg msg12
    , validation_error_ : String -> Int -> Svg.Svg msg13
    }
icons =
    { checkBold_ = R10.FormComponents.UI.Icon.checkBold_
    , combobox_arrow_ = R10.FormComponents.UI.Icon.keyboardArrowDown
    , eye_ban_l_ = R10.FormComponents.UI.Icon.eye_ban_l_
    , eye_l_ = R10.FormComponents.UI.Icon.eye_l_
    , grid = R10.FormComponents.UI.Icon.grid
    , notice_generic_l_ = R10.FormComponents.UI.Icon.notice_generic_l_
    , search_ = R10.FormComponents.UI.Icon.search_
    , sign_warning_f_ = R10.FormComponents.UI.Icon.sign_warning_f_
    , sign_warning_l_ = R10.FormComponents.UI.Icon.sign_warning_l_
    , validation_check_ = R10.FormComponents.UI.Icon.validation_check_
    , validation_clear_ = R10.FormComponents.UI.Icon.validation_clear_
    , validation_error_ = R10.FormComponents.UI.Icon.validation_error_
    }


getTextfieldBorderSizeOffset :
    { a
        | focused : Bool
        , style : R10.FormComponents.Style.Style
        , valid : Maybe Bool
        , displayValidation : Bool
    }
    -> { size : Float, offset : ( Float, Float ) }
getTextfieldBorderSizeOffset { focused, style, valid, displayValidation } =
    let
        validationActive : Bool
        validationActive =
            displayValidation && valid == Just False
    in
    case ( validationActive || focused, style ) of
        ( True, R10.FormComponents.Style.Filled ) ->
            { size = 0, offset = ( 0, -2 ) }

        ( True, R10.FormComponents.Style.Outlined ) ->
            { size = 2, offset = ( 0, 0 ) }

        ( False, R10.FormComponents.Style.Filled ) ->
            { size = 0, offset = ( 0, -1 ) }

        ( False, R10.FormComponents.Style.Outlined ) ->
            { size = 1, offset = ( 0, 0 ) }


getBorderColor :
    { a
        | focused : Bool
        , disabled : Bool
        , style : R10.FormComponents.Style.Style
        , valid : Maybe Bool
        , displayValidation : Bool
        , isMouseOver : Bool
        , palette : R10.FormComponents.UI.Palette.Palette
    }
    -> Color
getBorderColor { disabled, focused, style, valid, displayValidation, isMouseOver, palette } =
    let
        validationActive : Bool
        validationActive =
            displayValidation && valid == Just False

        alpha : Float
        alpha =
            if not disabled && (focused || isMouseOver || validationActive) then
                1

            else
                0.5
    in
    case style of
        R10.FormComponents.Style.Filled ->
            case ( displayValidation, valid, focused ) of
                --( True, Just True, _ ) ->
                --    R10.FormComponents.UI.Color.successA alpha palette
                ( True, Just False, _ ) ->
                    R10.FormComponents.UI.Color.errorA alpha palette

                ( _, _, _ ) ->
                    R10.FormComponents.UI.Color.onSurfaceA (0.3 * alpha) palette

        R10.FormComponents.Style.Outlined ->
            case ( displayValidation, valid, focused ) of
                ( True, Just False, _ ) ->
                    R10.FormComponents.UI.Color.errorA alpha palette

                ( _, _, True ) ->
                    R10.FormComponents.UI.Color.primaryA alpha palette

                ( _, _, False ) ->
                    R10.FormComponents.UI.Color.containerA alpha palette


textfieldLabelColor :
    { a
        | focused : Bool
        , style : R10.FormComponents.Style.Style
        , valid : Maybe Bool
        , displayValidation : Bool
        , palette : R10.FormComponents.UI.Palette.Palette
    }
    -> Color
textfieldLabelColor { focused, style, valid, displayValidation, palette } =
    case style of
        R10.FormComponents.Style.Filled ->
            case ( displayValidation, valid, focused ) of
                --( True, Just True, True ) ->
                --    R10.FormComponents.UI.Color.success palette
                ( True, Just False, True ) ->
                    R10.FormComponents.UI.Color.error palette

                ( _, _, _ ) ->
                    R10.FormComponents.UI.Color.label palette

        R10.FormComponents.Style.Outlined ->
            case ( displayValidation, valid, focused ) of
                ( True, Just False, True ) ->
                    R10.FormComponents.UI.Color.error palette

                ( _, _, True ) ->
                    R10.FormComponents.UI.Color.primary palette

                ( _, _, False ) ->
                    R10.FormComponents.UI.Color.label palette


getSelectShadowColor : R10.FormComponents.UI.Palette.Palette -> Bool -> Bool -> Color
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
    R10.FormComponents.UI.Color.primaryA alpha palette


viewSelectShadow : { a | palette : R10.FormComponents.UI.Palette.Palette, focused : Bool, disabled : Bool } -> Element msg -> Element msg
viewSelectShadow { palette, focused, disabled } element =
    el
        ([ width <| px 40
         , height <| px 40
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


onClickWithStopPropagation : msg -> Attribute msg
onClickWithStopPropagation message =
    htmlAttribute <| Html.Events.stopPropagationOn "click" (Json.Decode.succeed ( message, True ))


onScroll : (Float -> msg) -> Html.Attribute msg
onScroll msg =
    Html.Events.on "scroll"
        (Json.Decode.at [ "target", "scrollTop" ] Json.Decode.float
            |> Json.Decode.map msg
        )


keyCode : { esc : number, up : number, down : number, enter : number, space : number }
keyCode =
    { esc = 27
    , up = 38
    , down = 40
    , enter = 13
    , space = 32
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


labelBuilder :
    { a
        | label : String
        , value : String
        , focused : Bool
        , requiredLabel : Maybe String
        , leadingIcon : Maybe (Element msg)
        , trailingIcon : Maybe (Element msg)
        , valid : Maybe Bool
        , displayValidation : Bool
        , style : R10.FormComponents.Style.Style
        , palette : R10.FormComponents.UI.Palette.Palette
    }
    -> Element msg
labelBuilder args =
    let
        labelIsAbove : Bool
        labelIsAbove =
            args.focused || String.length args.value > 0

        containerPaddingAttrs :
            { bottom : Int
            , left : Int
            , right : Int
            , top : Int
            }
        containerPaddingAttrs =
            getTextfieldPaddingEach { args | leadingIcon = Nothing }

        labelBelowLeftPadding : Float
        labelBelowLeftPadding =
            -- while below, label should make space for a leading icon
            -- but label's container already have some padding on its own, so we subtract it
            ((getTextfieldPaddingEach args |> .left) - containerPaddingAttrs.left)
                |> toFloat

        notchClearance : Int
        notchClearance =
            case args.style of
                R10.FormComponents.Style.Filled ->
                    0

                R10.FormComponents.Style.Outlined ->
                    3

        notch : Element msg
        notch =
            case args.style of
                R10.FormComponents.Style.Filled ->
                    none

                R10.FormComponents.Style.Outlined ->
                    el
                        [ htmlAttribute (Html.Attributes.style "transition" "all 0.15s")
                        , height <| px 2
                        , width fill
                        , Background.color <| R10.FormComponents.UI.Color.surface args.palette
                        , alpha
                            (if labelIsAbove then
                                1

                             else
                                0
                            )
                        ]
                        none

        labelAboveAttrs : List (Attribute msg)
        labelAboveAttrs =
            if labelIsAbove then
                case args.style of
                    R10.FormComponents.Style.Filled ->
                        [ moveUp 28, moveRight 0 ]

                    R10.FormComponents.Style.Outlined ->
                        [ moveUp 21, Font.size 12, moveRight 0 ]

            else
                [ moveUp 0, moveRight labelBelowLeftPadding, Font.size R10.FormComponents.UI.Const.inputTextFontSize ]

        requiredEl : Element msg
        requiredEl =
            case args.requiredLabel of
                Just required ->
                    el [ alpha 0.7 ] <| text required

                Nothing ->
                    none

        labelEl : Element msg
        labelEl =
            el
                [ htmlAttribute (Html.Attributes.style "transition" "all 0.15s")
                , paddingEach
                    { top = containerPaddingAttrs.top
                    , bottom = containerPaddingAttrs.bottom
                    , right = notchClearance
                    , left = notchClearance
                    }
                , htmlAttribute <| Html.Attributes.style "pointer-events" "none"
                , behindContent <| notch
                , Border.width 0
                ]
            <|
                row
                    ([ htmlAttribute (Html.Attributes.style "transition" "all 0.15s")
                     , spacing 6
                     , centerY
                     ]
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
            , paddingEach { top = 0, bottom = 0, right = containerPaddingAttrs.right, left = containerPaddingAttrs.left - notchClearance }
            ]
            labelEl


showValidationIcon_ : { a | maybeValid : Maybe Bool, displayValidation : Bool, palette : R10.FormComponents.UI.Palette.Palette } -> Element msg
showValidationIcon_ { maybeValid, displayValidation, palette } =
    let
        widthPx : Int
        widthPx =
            if displayValidation && maybeValid == Just False then
                24

            else
                0
    in
    el
        [ htmlAttribute <| Html.Attributes.style "transition" "width 0.4s"
        , width <| px widthPx
        , height <| px 24
        , clip
        ]
    <|
        html <|
            icons.sign_warning_f_
                (R10.FormComponents.UI.Color.toCssString <| R10.FormComponents.UI.Color.error palette)
                24
