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
import R10.Palette
import R10.SimpleMarkdown
import R10.Svg.Icons
import R10.Svg.IconsExtra
import R10.Transition


borderEntityWithBorder : R10.Palette.Palette -> List (Attribute (R10.Context.ContextInternal z) msg)
borderEntityWithBorder palette =
    [ Border.width 1
    , Border.color <| R10.FormComponents.Internal.UI.Color.container palette
    , Border.rounded 5
    ]


fontSizeSubTitle : Attr (R10.Context.ContextInternal z) decorative msg
fontSizeSubTitle =
    Font.size 18


fontSizeTitle : Attr (R10.Context.ContextInternal z) decorative msg
fontSizeTitle =
    Font.size 24


genericSpacing : Int
genericSpacing =
    8


viewHelperText : R10.Palette.Palette -> List (Attr (R10.Context.ContextInternal z) () msg) -> Maybe String -> Element (R10.Context.ContextInternal z) msg
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
    { top = paddingCenterY
    , right = max 16 (iconWidth args.trailingIcon)
    , bottom = paddingCenterY
    , left = max 16 (iconWidth args.leadingIcon)
    }


icons :
    { check : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
    , checkBold : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
    , combobox_arrow : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
    , eye_ban_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
    , eye_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
    , grid : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
    , notice_generic_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
    , search : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
    , sign_warning_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
    , sign_warning_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
    , validation_check : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
    , validation_clear : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
    , validation_error : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
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
        , maybeValid : Maybe Bool
        , displayValidation : Bool
    }
    -> { size : Float, offset : ( Float, Float ) }
getTextfieldBorderSizeOffset { focused } =
    if focused then
        { size = 2, offset = ( 0, 0 ) }

    else
        { size = 1, offset = ( 0, 0 ) }


getSelectShadowColor : R10.Palette.Palette -> Bool -> Bool -> Bool -> Color
getSelectShadowColor palette selected focused mouseOver =
    case ( selected, focused, mouseOver ) of
        ( True, _, _ ) ->
            R10.FormComponents.Internal.UI.Color.primaryA 0.21 palette

        ( _, True, True ) ->
            R10.FormComponents.Internal.UI.Color.primaryA 0.21 palette

        ( _, True, False ) ->
            R10.FormComponents.Internal.UI.Color.primaryA 0.14 palette

        ( _, False, True ) ->
            R10.FormComponents.Internal.UI.Color.background palette

        _ ->
            R10.FormComponents.Internal.UI.Color.primaryA 0 palette


viewSelectShadowCustomSize :
    { a
        | palette : R10.Palette.Palette
        , focused : Bool
        , disabled : Bool
        , size : { x : Int, y : Int }
        , rounded : Int
        , over : Bool
        , selected : Bool
    }
    -> Element (R10.Context.ContextInternal z) msg
    -> Element (R10.Context.ContextInternal z) msg
viewSelectShadowCustomSize { palette, focused, disabled, size, over, rounded, selected } element =
    el
        ([ width <| px size.x
         , height <| px size.y
         , Border.rounded rounded
         , R10.Transition.transition "all 0.15s"
         ]
            ++ (if disabled then
                    []

                else if over then
                    [ Background.color <| getSelectShadowColor palette selected focused True ]

                else
                    [ htmlAttribute <| Html.Attributes.class "ripple-primary"
                    , Background.color <| getSelectShadowColor palette selected focused False
                    , mouseOver
                        [ Background.color <| getSelectShadowColor palette selected focused True

                        -- XXX
                        -- , Border.shadow
                        --     { offset = ( 0, 0 )
                        --     , size = 2
                        --     , blur = 0
                        --     , color =
                        --         (if focused then
                        --             R10.FormComponents.Internal.UI.Color.primary
                        --          else
                        --             R10.FormComponents.Internal.UI.Color.borderA 0.7
                        --         )
                        --             palette
                        --     }
                        ]
                    ]
               )
        )
        element


viewSelectShadow : { a | palette : R10.Palette.Palette, focused : Bool, disabled : Bool, over : Bool, value : Bool } -> Element (R10.Context.ContextInternal z) msg -> Element (R10.Context.ContextInternal z) msg
viewSelectShadow { palette, focused, disabled, value, over } =
    viewSelectShadowCustomSize
        { palette = palette
        , focused = focused
        , disabled = disabled
        , size = { x = 40, y = 40 }
        , rounded = 40
        , selected = value
        , over = over
        }


onClickWithStopPropagation : msg -> Attribute (R10.Context.ContextInternal z) msg
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

        -- , leadingIcon : Maybe (Element (R10.Context.ContextInternal z) msg)
        -- , trailingIcon : Maybe (Element (R10.Context.ContextInternal z) msg)
        , maybeValid : Maybe Bool
        , displayValidation : Bool
        , style : R10.FormComponents.Internal.Style.Style
        , palette : R10.Palette.Palette
        , floatingLabelAlwaysUp : Bool
    }
    -> Element (R10.Context.ContextInternal z) msg
floatingLabel args =
    let
        labelIsAbove : Bool
        labelIsAbove =
            args.focused || String.length args.value > 0 || args.floatingLabelAlwaysUp

        labelAboveAttrs : List (Attribute (R10.Context.ContextInternal z) msg)
        labelAboveAttrs =
            case args.style of
                R10.FormComponents.Internal.Style.FixedLabels ->
                    [ paddingEach { top = 0, right = 16, bottom = 7, left = 16 } ]

                R10.FormComponents.Internal.Style.FloatingLabels ->
                    if labelIsAbove then
                        [ moveRight 8
                        , moveUp <| 23 - 16
                        , Font.size 14
                        ]

                    else
                        [ moveRight 8
                        , moveUp <| 0 - 16
                        , Font.size R10.FormComponents.Internal.UI.Const.inputTextFontSize
                        ]

        requiredEl : Element (R10.Context.ContextInternal z) msg
        requiredEl =
            case args.requiredLabel of
                Just required ->
                    el [ alpha 0.7 ] <| text required

                Nothing ->
                    none

        labelEl : Element (R10.Context.ContextInternal z) msg
        labelEl =
            (case args.style of
                R10.FormComponents.Internal.Style.FixedLabels ->
                    -- Due to issue with vertical alignement
                    -- https://jira.rakuten-it.com/jira/browse/OMN-5507
                    -- we bring back the `row` here, instead of the
                    -- `paragraph`. In the future we can have `paragraph` for
                    -- fields that don't need to stay on the same row. But
                    -- for now we don't have such information.
                    --
                    -- 2022.06.21 - Trying with paragraph again, now that we
                    --              changed the "magic" value for when fields
                    --              should stay in two columns
                    --              https://jira.rakuten-it.com/jira/browse/OMN-5844
                    paragraph

                R10.FormComponents.Internal.Style.FloatingLabels ->
                    -- If the label is too long, it doesn't wrap. I tried adding a
                    -- paragraph here, but then the label overlap with the
                    -- input field.
                    row
            )
                ([ R10.Transition.transition "all 0.15s"
                 , htmlAttribute <| Html.Attributes.style "pointer-events" "none"
                 , Font.color <| R10.FormComponents.Internal.TextColors.getLabelColor args
                 , paddingXY 8 0
                 , centerY
                 ]
                    ++ (case args.style of
                            R10.FormComponents.Internal.Style.FixedLabels ->
                                []

                            R10.FormComponents.Internal.Style.FloatingLabels ->
                                if labelIsAbove then
                                    -- Need to cover the border underneath. Probably
                                    -- this "surface" color is not always correct.
                                    [ Background.color <| R10.FormComponents.Internal.UI.Color.surface args.palette ]

                                else
                                    []
                       )
                    ++ labelAboveAttrs
                )
                -- 160 == &nbsp;
                -- This is to add some extra space between the label and "(Required)"
                [ text args.label, text <| String.fromList [ ' ', Char.fromCode 160, ' ' ], requiredEl ]
    in
    if String.isEmpty args.label && args.requiredLabel == Nothing then
        none

    else
        case args.style of
            R10.FormComponents.Internal.Style.FixedLabels ->
                labelEl

            R10.FormComponents.Internal.Style.FloatingLabels ->
                el [ height <| px 0 ] labelEl


showValidationIcon_ :
    { a
        | maybeValid : Maybe Bool
        , displayValidation : Bool
        , palette : R10.Palette.Palette
        , style : R10.FormComponents.Internal.Style.Style
    }
    -> Element (R10.Context.ContextInternal z) msg
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
                    + 16

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
