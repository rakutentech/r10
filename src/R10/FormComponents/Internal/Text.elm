module R10.FormComponents.Internal.Text exposing
    ( Args
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
import R10.Color.Utils
import R10.FormComponents.Internal.IconButton
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.UI.Const
import R10.FormTypes
import R10.Svg.Icons
import Regex


viewShowHidePasswordButton : { a | msgOnTogglePasswordShow : Maybe msg, showPassword : Bool, palette : R10.FormTypes.Palette } -> Element msg
viewShowHidePasswordButton { msgOnTogglePasswordShow, showPassword, palette } =
    let
        icon : Element msg
        icon =
            if showPassword then
                R10.Svg.Icons.eye_ban_l [] (R10.Color.Utils.elementColorToColor <| R10.FormComponents.Internal.UI.Color.label palette) 24

            else
                R10.Svg.Icons.eye_l [] (R10.Color.Utils.elementColorToColor <| R10.FormComponents.Internal.UI.Color.label palette) 24
    in
    case msgOnTogglePasswordShow of
        Just msgOnTogglePasswordShow_ ->
            R10.FormComponents.Internal.IconButton.view [] { palette = palette, icon = icon, msgOnClick = Just msgOnTogglePasswordShow_, size = 24 }

        Nothing ->
            none


needShowHideIcon : R10.FormTypes.TypeText -> Bool
needShowHideIcon fieldType =
    fieldType == R10.FormTypes.TextPasswordCurrent || fieldType == R10.FormTypes.TextPasswordNew


type alias Args msg =
    { -- Stuff that change during
      -- the life of the component
      --
      value : String
    , focused : Bool
    , valid : Maybe Bool
    , disabled : Bool
    , showPassword : Bool
    , leadingIcon : Maybe (Element msg)
    , trailingIcon : Maybe (Element msg)

    -- Messages
    , msgOnChange : String -> msg
    , msgOnFocus : msg
    , msgOnLoseFocus : Maybe msg
    , msgOnTogglePasswordShow : Maybe msg
    , msgOnEnter : Maybe msg

    -- Stuff that doesn't change during
    -- the life of the component
    --
    , label : String
    , helperText : Maybe String
    , requiredLabel : Maybe String
    , idDom : Maybe String
    , style : R10.FormComponents.Internal.Style.Style
    , palette : R10.FormTypes.Palette

    -- Specific
    , textType : R10.FormTypes.TypeText
    }


getBorder :
    { a
        | focused : Bool
        , style : R10.FormComponents.Internal.Style.Style
        , palette : R10.FormTypes.Palette
        , valid : Maybe Bool
        , displayValidation : Bool
        , isMouseOver : Bool
        , disabled : Bool
    }
    -> Attr decorative msg
getBorder args =
    let
        { offset, size } =
            R10.FormComponents.Internal.UI.getTextfieldBorderSizeOffset args
    in
    Border.innerShadow
        { offset = offset
        , size = size
        , blur = 0
        , color = R10.FormComponents.Internal.UI.getBorderColor args
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
        , palette : R10.FormTypes.Palette
        , showPassword : Bool
        , style : R10.FormComponents.Internal.Style.Style
        , textType : R10.FormTypes.TypeText
        , trailingIcon : Maybe (Element msg)
        , value : String
    }
    -> List (Attribute msg)
viewBehindPattern args =
    case args.textType of
        R10.FormTypes.TextWithPattern pattern ->
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
                    [ alpha 0.6
                    , htmlAttribute <| Html.Attributes.attribute "disabled" "true"
                    ]
                    { args
                        | value = valueWithTrailingPattern
                        , textType = R10.FormTypes.TextPlain
                    }
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
    if pattern == inputChar || pattern == '_' || pattern == 'M' || pattern == 'Y' then
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
        displayValidation : Bool
        displayValidation =
            args.valid /= Nothing

        newArgs : Args msg
        newArgs =
            { args
                | trailingIcon =
                    if needShowHideIcon args.textType then
                        Just <| viewShowHidePasswordButton args

                    else if args.trailingIcon /= Nothing then
                        args.trailingIcon

                    else
                        Just <|
                            R10.FormComponents.Internal.UI.showValidationIcon_
                                { maybeValid = args.valid
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
            , palette : R10.FormTypes.Palette
            , requiredLabel : Maybe String
            , style : R10.FormComponents.Internal.Style.Style
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
            , valid = args.valid
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
         , inFront <| R10.FormComponents.Internal.UI.labelBuilder styleArgs
         ]
            ++ (if newArgs.disabled then
                    [ alpha 0.6 ]

                else
                    [ alpha 1 ]
               )
            ++ attrs
         -- Some other section of the form is setting a min width
         -- here that cause the field not squeezing in small devices.
         -- As a temporary fix, I am overwriting it to `width <| fill`
         -- ++ [ width <| fill ]
         -- ++ [ width <| (fill |> minimum 100) ]
        )
        [ viewInput
            ([ getBorder styleArgs
             , mouseOver [ getBorder { styleArgs | isMouseOver = True } ]
             , case newArgs.style of
                R10.FormComponents.Internal.Style.Filled ->
                    Border.rounded 0

                R10.FormComponents.Internal.Style.Outlined ->
                    Border.rounded 5
             , height <|
                px <|
                    if newArgs.textType == R10.FormTypes.TextMultiline then
                        200

                    else
                        R10.FormComponents.Internal.UI.Const.inputTextHeight
             ]
                ++ (case args.idDom of
                        Just id ->
                            [ htmlAttribute <| Html.Attributes.id id ]

                        Nothing ->
                            []
                   )
                ++ extraInputAttrs
            )
            newArgs
        , R10.FormComponents.Internal.UI.viewHelperText newArgs.palette
            [ spacing 2
            , alpha 0.5
            , Font.size 14
            , paddingEach { top = R10.FormComponents.Internal.UI.genericSpacing, right = 0, bottom = 0, left = 0 }
            ]
            newArgs.helperText
        ]


viewInput :
    List (Attribute msg)
    ->
        { a
            | disabled : Bool
            , focused : Bool
            , label : String
            , leadingIcon : Maybe (Element msg)
            , msgOnChange : String -> msg
            , msgOnEnter : Maybe msg
            , msgOnFocus : msg
            , msgOnLoseFocus : Maybe msg
            , palette : R10.FormTypes.Palette
            , showPassword : Bool
            , style : R10.FormComponents.Internal.Style.Style
            , textType : R10.FormTypes.TypeText
            , trailingIcon : Maybe (Element msg)
            , value : String
        }
    -> Element msg
viewInput extraAttr args =
    let
        inputDisabledAttrs : List (Attribute msg)
        inputDisabledAttrs =
            [ htmlAttribute <| Html.Attributes.attribute "disabled" "true" ]

        iconCommonAttrs : List (Attr () msg)
        iconCommonAttrs =
            [ -- in order to icon to be aligned with the input, move icon down
              moveDown <|
                case args.style of
                    R10.FormComponents.Internal.Style.Filled ->
                        8

                    R10.FormComponents.Internal.Style.Outlined ->
                        0
            , paddingXY 8 13
            ]

        paddingValues : { top : Int, right : Int, bottom : Int, left : Int }
        paddingValues =
            R10.FormComponents.Internal.UI.getTextfieldPaddingEach args

        paddingOffset =
            12

        inputAttrs : List (Attribute msg)
        inputAttrs =
            [ -- IOS fix that remove autocorrect, autocapitalize and spellcheck
              htmlAttribute <| Html.Attributes.attribute "spellcheck" "false"
            , htmlAttribute <| Html.Attributes.attribute "autocorrect" "off"
            , htmlAttribute <| Html.Attributes.attribute "autocapitalize" "off"
            , htmlAttribute <| Html.Attributes.style "transition" "all 0.15s"
            , width fill
            , Font.size R10.FormComponents.Internal.UI.Const.inputTextFontSize
            , Border.width 0
            , Background.color <| R10.FormComponents.Internal.UI.Color.transparent
            , Font.color <| R10.FormComponents.Internal.UI.Color.font args.palette
            , Events.onFocus args.msgOnFocus

            -- Remove part of the top padding and re-apply it as a margin,
            -- fixes issue with chrome auto-fill styles. more info: https://jira.rakuten-it.com/jira/browse/OMN-2279
            -- Please feel free to modify it if you would find some better solution.
            -- Possibly could be fixed in elm-ui 2.0. At the time 1.1.8 in use
            , paddingEach <| { paddingValues | top = paddingValues.top - paddingOffset }
            , htmlAttribute <| Html.Attributes.style "margin-top" (String.fromInt paddingOffset ++ "px")

            -- We want selection tab order to be: leadingIcon <-> input  <-> trailingIcon
            , behindContent <| el (alignLeft :: iconCommonAttrs) (Maybe.withDefault none args.leadingIcon)
            , inFront <| el (alignRight :: iconCommonAttrs) (Maybe.withDefault none args.trailingIcon)
            ]
                ++ (case args.msgOnEnter of
                        Just msgOnEnter_ ->
                            [ htmlAttribute <| R10.FormComponents.Internal.UI.onEnter msgOnEnter_ ]

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
        R10.FormTypes.TextUsername ->
            Input.username inputAttrs behavioursText

        R10.FormTypes.TextEmail ->
            Input.email inputAttrs behavioursText

        R10.FormTypes.TextPasswordCurrent ->
            Input.currentPassword inputAttrs (behavioursPassword args.showPassword)

        R10.FormTypes.TextPasswordNew ->
            Input.newPassword inputAttrs (behavioursPassword args.showPassword)

        R10.FormTypes.TextPlain ->
            Input.text inputAttrs behavioursText

        R10.FormTypes.TextMultiline ->
            Input.multiline inputAttrs behavioursMultiline

        R10.FormTypes.TextWithPattern pattern ->
            Input.text inputAttrs <| behavioursTextWithPattern pattern
