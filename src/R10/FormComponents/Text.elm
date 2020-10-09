module R10.FormComponents.Text exposing
    ( Args
    , TextType(..)
    , extraCss
    , view
    , viewInput
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import R10.FormComponents.IconButton
import R10.FormComponents.Style
import R10.FormComponents.UI
import R10.FormComponents.UI.Color
import R10.FormComponents.UI.Const as Constants
import R10.FormComponents.UI.Palette
import R10.FormComponents.Validations
import Regex


type TextType
    = TextPlain
    | TextEmail
    | TextUsername
    | TextPasswordNew
    | TextPasswordCurrent
    | TextMultiline
    | TextWithPattern String


viewShowHidePasswordButton : { a | msgOnTogglePasswordShow : Maybe msg, showPassword : Bool, palette : R10.FormComponents.UI.Palette.Palette } -> Element msg
viewShowHidePasswordButton { msgOnTogglePasswordShow, showPassword, palette } =
    let
        icon : Element msg
        icon =
            if showPassword then
                html <| R10.FormComponents.UI.icons.eye_ban_l_ (R10.FormComponents.UI.Color.label palette |> R10.FormComponents.UI.Color.toCssString) 24

            else
                html <| R10.FormComponents.UI.icons.eye_l_ (R10.FormComponents.UI.Color.label palette |> R10.FormComponents.UI.Color.toCssString) 24
    in
    case msgOnTogglePasswordShow of
        Just msgOnTogglePasswordShow_ ->
            R10.FormComponents.IconButton.view [] { palette = palette, icon = icon, msgOnClick = Just msgOnTogglePasswordShow_, size = 24 }

        Nothing ->
            none


needShowHideIcon : TextType -> Bool
needShowHideIcon fieldType =
    fieldType == TextPasswordCurrent || fieldType == TextPasswordNew


type alias Args msg =
    { -- Stuff that change
      value : String
    , focused : Bool
    , validation : R10.FormComponents.Validations.Validation
    , showPassword : Bool
    , leadingIcon : Maybe (Element msg)
    , trailingIcon : Maybe (Element msg)

    -- Messages
    , msgOnChange : String -> msg
    , msgOnFocus : msg
    , msgOnLoseFocus : Maybe msg
    , msgOnTogglePasswordShow : Maybe msg
    , msgOnEnter : Maybe msg

    -- Stuff that doesn't change
    , label : String
    , helperText : Maybe String
    , disabled : Bool
    , requiredLabel : Maybe String
    , idDom : Maybe String
    , style : R10.FormComponents.Style.Style
    , palette : R10.FormComponents.UI.Palette.Palette

    -- Specific
    , textType : TextType
    }


getBorder :
    { a
        | focused : Bool
        , style : R10.FormComponents.Style.Style
        , palette : R10.FormComponents.UI.Palette.Palette
        , valid : Maybe Bool
        , displayValidation : Bool
        , isMouseOver : Bool
        , disabled : Bool
    }
    -> Attr decorative msg
getBorder args =
    let
        { offset, size } =
            R10.FormComponents.UI.getTextfieldBorderSizeOffset args
    in
    Border.innerShadow
        { offset = offset
        , size = size
        , blur = 0
        , color = R10.FormComponents.UI.getBorderColor args
        }


viewBehindPattern :
    { a
        | disabled : Bool
        , focused : Bool
        , label : String
        , leadingIcon : Maybe (Element msg)
        , msgOnChange : String -> msg
        , msgOnEnter : Maybe msg
        , msgOnFocus : msg
        , msgOnLoseFocus : Maybe msg
        , palette : R10.FormComponents.UI.Palette.Palette
        , showPassword : Bool
        , style : R10.FormComponents.Style.Style
        , textType : TextType
        , trailingIcon : Maybe (Element msg)
        , value : String
    }
    -> List (Attribute msg)
viewBehindPattern args =
    case args.textType of
        TextWithPattern pattern ->
            let
                valueWithTrailingPattern : String
                valueWithTrailingPattern =
                    if args.focused then
                        let
                            lengthDifference : Int
                            lengthDifference =
                                String.length pattern - String.length args.value
                        in
                        args.value
                            ++ String.right lengthDifference pattern

                    else
                        ""
            in
            [ behindContent <|
                viewInput
                    { args
                        | value = valueWithTrailingPattern
                        , textType = TextPlain
                    }
                    [ alpha 0.6
                    , htmlAttribute <| Html.Attributes.attribute "disabled" "true"
                    ]
            ]

        _ ->
            []


extraCss : String
extraCss =
    ""



-- TextWithPattern Internal


handleWithPatternChange : String -> String -> String -> String
handleWithPatternChange pattern oldValue newValue =
    let
        isDeleteAction : Bool
        isDeleteAction =
            removeTrailingChar oldValue == newValue

        value : String
        value =
            newValue
                |> onlyDigit
                |> appendPattern pattern
    in
    if value == oldValue && isDeleteAction then
        -- if user would remove part of a pattern, it would be restored.
        -- To prevent this,
        -- if user removes one char of trailing pattern, remove trailing pattern + one char
        value
            |> removeTrailingPattern
            |> removeTrailingChar

    else
        value


regexNotDigit : Regex.Regex
regexNotDigit =
    Maybe.withDefault Regex.never (Regex.fromString "[^0-9]")


regexNotDigitAtTheEnd : Regex.Regex
regexNotDigitAtTheEnd =
    Maybe.withDefault Regex.never (Regex.fromString "[^0-9]*$")


removeTrailingChar : String -> String
removeTrailingChar str =
    String.left (String.length str - 1) str


removeTrailingPattern : String -> String
removeTrailingPattern str =
    Regex.replace regexNotDigitAtTheEnd (\_ -> "") str


onlyDigit : String -> String
onlyDigit str =
    Regex.replace regexNotDigit (\_ -> "") str


type Token
    = InputValue
    | Other Char


format : List Token -> String -> String
format tokens input =
    if String.isEmpty input then
        input

    else
        append tokens (String.toList input) ""


appendPattern : String -> String -> String
appendPattern template string =
    format (parse '0' template) string


parse : Char -> String -> List Token
parse inputChar pattern =
    String.toList pattern
        |> List.map (tokenize inputChar)


tokenize : Char -> Char -> Token
tokenize inputChar pattern =
    if pattern == inputChar || pattern == '_' then
        InputValue

    else
        Other pattern


append : List Token -> List Char -> String -> String
append tokens input formatted =
    let
        appendInput : String
        appendInput =
            List.head input
                |> Maybe.map (\char -> formatted ++ String.fromChar char)
                |> Maybe.map (append (Maybe.withDefault [] (List.tail tokens)) (Maybe.withDefault [] (List.tail input)))
                |> Maybe.withDefault formatted

        maybeToken : Maybe Token
        maybeToken =
            List.head tokens
    in
    case maybeToken of
        Nothing ->
            formatted

        Just token ->
            case token of
                InputValue ->
                    appendInput

                Other char ->
                    append (Maybe.withDefault [] <| List.tail tokens) input (formatted ++ String.fromChar char)


view :
    List (Attribute msg)
    -> List (Attribute msg)
    -> Args msg
    -> Element msg
view attrs extraInputAttrs args =
    let
        valid : Maybe Bool
        valid =
            R10.FormComponents.Validations.isValid args.validation

        displayValidation : Bool
        displayValidation =
            valid /= Nothing

        newArgs :
            { disabled : Bool
            , focused : Bool
            , helperText : Maybe String
            , idDom : Maybe String
            , label : String
            , leadingIcon : Maybe (Element msg)
            , msgOnChange : String -> msg
            , msgOnEnter : Maybe msg
            , msgOnFocus : msg
            , msgOnLoseFocus : Maybe msg
            , msgOnTogglePasswordShow : Maybe msg
            , palette : R10.FormComponents.UI.Palette.Palette
            , requiredLabel : Maybe String
            , showPassword : Bool
            , style : R10.FormComponents.Style.Style
            , textType : TextType
            , trailingIcon : Maybe (Element msg)
            , validation : R10.FormComponents.Validations.Validation
            , value : String
            }
        newArgs =
            { args
                | trailingIcon =
                    if needShowHideIcon args.textType then
                        Just <| viewShowHidePasswordButton args

                    else if args.trailingIcon /= Nothing then
                        args.trailingIcon

                    else
                        Just <|
                            R10.FormComponents.UI.showValidationIcon_
                                { maybeValid = valid
                                , displayValidation = displayValidation
                                , palette = args.palette
                                }
            }

        styleArgs :
            { disabled : Bool
            , displayValidation : Bool
            , focused : Bool
            , isMouseOver : Bool
            , label : String
            , leadingIcon : Maybe (Element msg)
            , palette : R10.FormComponents.UI.Palette.Palette
            , requiredLabel : Maybe String
            , style : R10.FormComponents.Style.Style
            , trailingIcon : Maybe (Element msg)
            , valid : Maybe Bool
            , value : String
            }
        styleArgs =
            { label = newArgs.label
            , value = newArgs.value
            , focused = newArgs.focused
            , disabled = newArgs.disabled
            , requiredLabel = newArgs.requiredLabel
            , style = newArgs.style
            , palette = newArgs.palette
            , leadingIcon = newArgs.leadingIcon
            , trailingIcon = newArgs.trailingIcon
            , valid = valid
            , displayValidation = displayValidation
            , isMouseOver = False
            }
    in
    column
        ([ -- This spacing need to be zero because errors need always have to have
           -- a div in the DOM also if there are no errors (for the animation.
           -- If there is spacing and no error, it will appear as a double spacing.
           spacing 0
         , width (fill |> minimum 150)
         , inFront <| R10.FormComponents.UI.labelBuilder styleArgs
         ]
            ++ (if newArgs.disabled then
                    [ alpha 0.6 ]

                else
                    [ alpha 1 ]
               )
            ++ attrs
        )
        [ viewInput newArgs <|
            [ getBorder styleArgs
            , mouseOver [ getBorder { styleArgs | isMouseOver = True } ]
            , case newArgs.style of
                R10.FormComponents.Style.Filled ->
                    Border.rounded 0

                R10.FormComponents.Style.Outlined ->
                    Border.rounded 5
            , height <|
                px <|
                    if newArgs.textType == TextMultiline then
                        200

                    else
                        Constants.inputTextHeight
            ]
                ++ (case args.idDom of
                        Just id ->
                            [ htmlAttribute <| Html.Attributes.id id ]

                        Nothing ->
                            []
                   )
                ++ extraInputAttrs
        , R10.FormComponents.UI.viewHelperText newArgs.palette
            [ spacing 2
            , alpha 0.5
            , Font.size 14
            , paddingEach { top = R10.FormComponents.UI.genericSpacing, right = 0, bottom = 0, left = 0 }
            ]
            newArgs.helperText
        ]


viewInput :
    { a
        | disabled : Bool
        , focused : Bool
        , label : String
        , leadingIcon : Maybe (Element msg)
        , msgOnChange : String -> msg
        , msgOnEnter : Maybe msg
        , msgOnFocus : msg
        , msgOnLoseFocus : Maybe msg
        , palette : R10.FormComponents.UI.Palette.Palette
        , showPassword : Bool
        , style : R10.FormComponents.Style.Style
        , textType : TextType
        , trailingIcon : Maybe (Element msg)
        , value : String
    }
    -> List (Attribute msg)
    -> Element msg
viewInput args extraAttr =
    let
        inputDisabledAttrs : List (Attribute msg)
        inputDisabledAttrs =
            [ htmlAttribute <| Html.Attributes.attribute "disabled" "true" ]

        iconCommonAttrs : List (Attr () msg)
        iconCommonAttrs =
            [ -- in order to icon to be aligned with the input, move icon down
              moveDown <|
                case args.style of
                    R10.FormComponents.Style.Filled ->
                        8

                    R10.FormComponents.Style.Outlined ->
                        0
            , centerY
            , paddingXY 8 0
            ]

        inputAttrs : List (Attribute msg)
        inputAttrs =
            [ -- IOS fix that remove autocorrect, autocapitalize and spellcheck
              htmlAttribute <| Html.Attributes.attribute "spellcheck" "false"
            , htmlAttribute <| Html.Attributes.attribute "autocorrect" "off"
            , htmlAttribute <| Html.Attributes.attribute "autocapitalize" "off"
            , htmlAttribute <| Html.Attributes.style "transition" "all 0.15s"
            , width fill
            , Font.size Constants.inputTextFontSize
            , Border.width 0
            , Background.color <| R10.FormComponents.UI.Color.transparent
            , Font.color <| R10.FormComponents.UI.Color.font args.palette
            , Events.onFocus args.msgOnFocus
            , paddingEach <| R10.FormComponents.UI.getTextfieldPaddingEach args

            -- We want selection tab order to be: leadingIcon <-> input  <-> trailingIcon
            , behindContent <| el (alignLeft :: iconCommonAttrs) (Maybe.withDefault none args.leadingIcon)
            , inFront <| el (alignRight :: iconCommonAttrs) (Maybe.withDefault none args.trailingIcon)
            ]
                ++ (case args.msgOnEnter of
                        Just msgOnEnter_ ->
                            [ htmlAttribute <| R10.FormComponents.UI.onEnter msgOnEnter_ ]

                        Nothing ->
                            []
                   )
                ++ (case args.msgOnLoseFocus of
                        Just msgOnLoseFocus_ ->
                            [ Events.onLoseFocus msgOnLoseFocus_ ]

                        Nothing ->
                            []
                   )
                ++ (if args.disabled then
                        inputDisabledAttrs

                    else
                        []
                   )
                ++ viewBehindPattern args
                ++ extraAttr

        behavioursText :
            { label : Input.Label msg1
            , onChange : String -> msg
            , placeholder : Maybe (Input.Placeholder msg)
            , text : String
            }
        behavioursText =
            { onChange = args.msgOnChange
            , placeholder = Nothing
            , text = args.value
            , label = Input.labelHidden args.label
            }

        behavioursTextWithPattern :
            String
            ->
                { label : Input.Label msg1
                , onChange : String -> msg
                , placeholder : Maybe (Input.Placeholder msg)
                , text : String
                }
        behavioursTextWithPattern pattern =
            { onChange = handleWithPatternChange pattern args.value >> args.msgOnChange
            , placeholder = Nothing
            , text = args.value
            , label = Input.labelHidden args.label
            }

        behavioursPassword :
            Bool
            ->
                { label : Input.Label msg1
                , onChange : String -> msg
                , placeholder : Maybe a1
                , show : Bool
                , text : String
                }
        behavioursPassword show =
            { onChange = args.msgOnChange
            , placeholder = Nothing
            , text = args.value
            , label = Input.labelHidden args.label
            , show = show
            }

        behavioursMultiline :
            { label : Input.Label msg1
            , onChange : String -> msg
            , placeholder : Maybe (Input.Placeholder msg)
            , spellcheck : Bool
            , text : String
            }
        behavioursMultiline =
            { onChange = args.msgOnChange
            , placeholder = Nothing
            , text = args.value
            , label = Input.labelHidden args.label
            , spellcheck = False
            }
    in
    case args.textType of
        TextUsername ->
            Input.username inputAttrs behavioursText

        TextEmail ->
            Input.email inputAttrs behavioursText

        TextPasswordCurrent ->
            Input.currentPassword inputAttrs (behavioursPassword args.showPassword)

        TextPasswordNew ->
            Input.newPassword inputAttrs (behavioursPassword args.showPassword)

        TextPlain ->
            Input.text inputAttrs behavioursText

        TextMultiline ->
            Input.multiline inputAttrs behavioursMultiline

        TextWithPattern pattern ->
            Input.text inputAttrs <| behavioursTextWithPattern pattern
