module R10.FormComponents.Internal.Text exposing
    ( Args
    , extraCss
    , handleWithPatternChange
    , processValue
    , view
    , viewInput
    )

import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Events as Events
import Element.WithContext.Font as Font
import Element.WithContext.Input as Input
import Html.Attributes
import Html.Events
import Json.Decode
import R10.Context exposing (..)
import R10.Device
import R10.FormComponents.Internal.EmailAutoSuggest
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.TextColors
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.UI.Const
import R10.FormTypes
import R10.KatakanaConverter
import R10.Palette
import R10.Paragraph
import R10.Transition
import Regex


textWithPatternLargeAttrs : List (Attribute (R10.Context.ContextInternal z) msg)
textWithPatternLargeAttrs =
    [ withContextAttribute <| \c -> Font.size c.contextR10.inputFieldWithLargePattern_fontSize
    , Font.family [ Font.monospace ]
    , withContextAttribute <| \c -> htmlAttribute <| Html.Attributes.style "letter-spacing" (String.fromInt c.contextR10.inputFieldWithLargePattern_letterSpacing ++ "px")
    ]


textWithPatternLargeAttrsExtra : List (Attribute (R10.Context.ContextInternal z) msg)
textWithPatternLargeAttrsExtra =
    [ centerX
    , withContextAttribute <| \c -> width <| px c.contextR10.inputFieldWithLargePattern_width
    ]


textWithPatternLargeWithoutLabelAttrs : List (Attribute (R10.Context.ContextInternal z) msg)
textWithPatternLargeWithoutLabelAttrs =
    [ Font.size 52
    , Font.family [ Font.monospace ]
    , htmlAttribute <| Html.Attributes.style "letter-spacing" "10px"
    ]


textWithPatternLargeWithoutLabelAttrsExtra : List (Attribute (R10.Context.ContextInternal z) msg)
textWithPatternLargeWithoutLabelAttrsExtra =
    [ centerX
    , width <| px 280
    ]


textWithPatternAttrs : List (Attribute (R10.Context.ContextInternal z) msg)
textWithPatternAttrs =
    --
    -- Regular input field with patter, like brithday
    --
    -- [ Font.size 18
    -- , Font.family [ Font.monospace ]
    -- , htmlAttribute <| Html.Attributes.style "letter-spacing" "1px"
    -- ]
    [ htmlAttribute <| Html.Attributes.style "letter-spacing" "2px"
    ]


type alias Args z msg =
    { -- Stuff that change during
      -- the life of the component
      --
      value : String
    , focused : Bool
    , maybeValid : Maybe Bool
    , disabled : Bool
    , showPassword : Bool
    , leadingIcon : List (Element (R10.Context.ContextInternal z) msg)
    , trailingIcon : List (Element (R10.Context.ContextInternal z) msg)

    -- Messages
    , msgOnChange : String -> msg
    , msgOnFocus : msg
    , msgOnLoseFocus : Maybe msg
    , msgOnTogglePasswordShow : Maybe msg
    , msgOnEnter : Maybe msg
    , msgOnKeyDown : Maybe (Int -> msg)

    -- Stuff that doesn't change during
    -- the life of the component
    --
    , label : String
    , helperText : Maybe String
    , requiredLabel : Maybe String
    , idDom : Maybe String
    , style : R10.FormComponents.Internal.Style.Style
    , palette : R10.Palette.Palette
    , autocomplete : Maybe String
    , floatingLabelAlwaysUp : Bool
    , placeholder : Maybe String

    -- Specific
    , textType : R10.FormTypes.TypeText
    , fieldType : Maybe R10.FormTypes.FieldType
    }


getBorder :
    { a
        | focused : Bool
        , style : R10.FormComponents.Internal.Style.Style
        , palette : R10.Palette.Palette
        , maybeValid : Maybe Bool
        , displayValidation : Bool
        , isMouseOver : Bool
        , disabled : Bool
    }
    -> Attr (R10.Context.ContextInternal z) decorative msg
getBorder args =
    let
        { offset, size } =
            R10.FormComponents.Internal.UI.getTextfieldBorderSizeOffset args
    in
    Border.innerShadow
        { offset = offset
        , size = size
        , blur = 0
        , color = R10.FormComponents.Internal.TextColors.getBorderColor args
        }


viewBehindPattern2 :
    { a
        | floatingLabelAlwaysUp : Bool
        , focused : Bool
        , msgOnChange : String -> msg
        , style : R10.FormComponents.Internal.Style.Style
        , textType : R10.FormTypes.TypeText
        , value : String
    }
    -> String
    -> List (Attribute (R10.Context.ContextInternal z) msg)
viewBehindPattern2 args pattern =
    let
        valueWithTrailingPattern : String
        valueWithTrailingPattern =
            if args.focused || args.floatingLabelAlwaysUp then
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
        --
        -- This show the pattern underneath the real input field.
        -- We could use just an Element.el, but the pattern is not
        -- perfectly aligned in that case.
        --
        Input.text
            ([ alpha 0.4
             , Border.color <| rgba 0 0 0 0
             , Background.color <| rgba 0 0 0 0
             , htmlAttribute <| Html.Attributes.attribute "disabled" "true"
             ]
                ++ (case args.textType of
                        R10.FormTypes.TextWithPatternLarge _ ->
                            textWithPatternLargeAttrs ++ textWithPatternLargeAttrsExtra

                        R10.FormTypes.TextWithPattern _ ->
                            textWithPatternAttrs

                        R10.FormTypes.TextWithPatternLargeWithoutLabel _ ->
                            textWithPatternLargeWithoutLabelAttrs ++ textWithPatternLargeWithoutLabelAttrsExtra

                        _ ->
                            []
                   )
                ++ [ moveDown 7, moveRight 3 ]
            )
            { label = Input.labelHidden ""
            , onChange = args.msgOnChange
            , placeholder = Nothing
            , text = valueWithTrailingPattern
            }
    ]


viewBehindPattern : Args z msg -> List (Attribute (R10.Context.ContextInternal z) msg)
viewBehindPattern args =
    case args.textType of
        R10.FormTypes.TextWithPattern pattern ->
            viewBehindPattern2 args pattern

        R10.FormTypes.TextWithPatternLarge pattern ->
            viewBehindPattern2 args pattern

        R10.FormTypes.TextWithPatternLargeWithoutLabel pattern ->
            viewBehindPattern2 args pattern

        _ ->
            []


extraCss : String
extraCss =
    -- https://jira.rakuten-it.com/jira/browse/OMN-5167
    -- https://dev-cdn.rex.contents.rakuten.co.jp/rex-form/v1.7.0/components/button.html
    ".s.u:hover { text-decoration-thickness: 0.125rem !important }"



-- TextWithPattern Internal


handleWithPatternChange : { pattern : String, oldValue : String, newValue : String } -> String
handleWithPatternChange args =
    let
        isDeleteAction : Bool
        isDeleteAction =
            removeTrailingChar args.oldValue == args.newValue

        value : String
        value =
            args.newValue
                |> onlyDigit
                |> appendPattern args.pattern
    in
    if value == args.oldValue && isDeleteAction then
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


regexNotDigitOrDash : Regex.Regex
regexNotDigitOrDash =
    Maybe.withDefault Regex.never (Regex.fromString "[^0-9-]")


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


processValue : { b | pattern : String, previousValue : String, value : String } -> String
processValue { value, previousValue, pattern } =
    let
        removeLastCharacter =
            String.slice 0 -1

        lastCharacter =
            String.right 1

        removeNonDigits =
            Regex.replace regexNotDigit (\_ -> "")

        previousValueLessLastCharacter =
            removeLastCharacter previousValue

        previousValueLastCHaracter =
            lastCharacter previousValue

        previousValueLastCHaracterIsDigit =
            String.length (removeNonDigits previousValueLastCHaracter) == 1

        lastCharacterWasDeleted =
            value == previousValueLessLastCharacter

        onlyDigits =
            removeNonDigits value

        removeOneDigitIfLastCharacterWasDeleted =
            if lastCharacterWasDeleted && not previousValueLastCHaracterIsDigit then
                removeLastCharacter onlyDigits

            else
                onlyDigits

        withPattern =
            formatResult pattern removeOneDigitIfLastCharacterWasDeleted
    in
    withPattern


formatResult : String -> String -> String
formatResult template string =
    format (parse '0' template) string


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
tokenize _ pattern =
    if List.member pattern (String.toList "_MYD年月日AG0123456789") then
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


toEmailInput :
    List (Attribute (R10.Context.ContextInternal z) msg)
    ->
        { onChange : String -> msg
        , text : String
        , placeholder : Maybe (Input.Placeholder (R10.Context.ContextInternal z) msg)
        , label : Input.Label (R10.Context.ContextInternal z) msg
        }
    -> Element (R10.Context.ContextInternal z) msg
toEmailInput attrs args =
    -- https://jira.rakuten-it.com/jira/browse/OMN-5778
    -- https://jira.rakuten-it.com/jira/browse/OMN-5386
    -- The Chrome on Desktop and on Andriod were auto convert punycode for the domain part of the value, but still displayed the origin characters.
    -- For example aa@Ⅳ.com => aa@iv.com, aa@aa。com => aa@aa.com
    -- In that case was hard to do validate and might made confus for users.
    -- So for the Chrome, to use the Input.text instead of the Input.email.
    -- And align the attributes from the Input.email to minimize the impact.
    withContext
        (\context ->
            if R10.Device.isChromeDesktop context.contextR10.device || R10.Device.isChromeAndroid context.contextR10.device then
                Input.text
                    ((htmlAttribute <| Html.Attributes.attribute "autocomplete" "email")
                        :: attrs
                    )
                    args

            else
                Input.email attrs args
        )


view :
    List (Attribute (R10.Context.ContextInternal z) msg)
    -> List (Attribute (R10.Context.ContextInternal z) msg)
    -> Args z msg
    -> Element (R10.Context.ContextInternal z) msg
view attrs extraInputAttrs args =
    let
        displayValidation : Bool
        displayValidation =
            args.maybeValid /= Nothing

        newArgs : Args z msg
        newArgs =
            -- Adding extra icons to the arguments:
            --
            -- * Validation result
            --
            { args
                | trailingIcon =
                    args.trailingIcon
                        |> (\icons ->
                                -- Adding the validation icon. Should not this be conditional?
                                icons
                                    ++ [ R10.FormComponents.Internal.UI.showValidationIcon_
                                            { maybeValid = args.maybeValid
                                            , displayValidation = displayValidation
                                            , palette = args.palette
                                            , style = args.style
                                            }
                                       ]
                           )
            }

        ( label, requiredLabel ) =
            case newArgs.textType of
                R10.FormTypes.TextWithPatternLargeWithoutLabel _ ->
                    ( "", Nothing )

                _ ->
                    ( newArgs.label, newArgs.requiredLabel )

        styleArgs :
            { disabled : Bool
            , displayValidation : Bool
            , focused : Bool
            , isMouseOver : Bool
            , label : String
            , leadingIcon : List (Element (R10.Context.ContextInternal z) msg)
            , palette : R10.Palette.Palette
            , requiredLabel : Maybe String
            , style : R10.FormComponents.Internal.Style.Style
            , trailingIcon : List (Element (R10.Context.ContextInternal z) msg)
            , maybeValid : Maybe Bool
            , value : String
            , floatingLabelAlwaysUp : Bool
            }
        styleArgs =
            { label = label
            , value = newArgs.value
            , focused = newArgs.focused
            , disabled = newArgs.disabled
            , requiredLabel = requiredLabel
            , style = newArgs.style
            , palette = newArgs.palette
            , leadingIcon = newArgs.leadingIcon
            , trailingIcon = newArgs.trailingIcon
            , maybeValid = args.maybeValid
            , displayValidation = displayValidation
            , isMouseOver = False
            , floatingLabelAlwaysUp = args.floatingLabelAlwaysUp
            }
    in
    column
        ([ -- This spacing need to be zero because errors need always have to have
           -- a div in the DOM also if there are no errors (for the animation.
           -- If there is spacing and no error, it will appear as a double spacing.
           spacing 0
         , width (fill |> minimum 150)
         ]
            ++ (case args.style of
                    R10.FormComponents.Internal.Style.FixedLabels ->
                        []

                    R10.FormComponents.Internal.Style.FloatingLabels ->
                        [ inFront <| R10.FormComponents.Internal.UI.floatingLabel styleArgs ]
               )
            ++ (if newArgs.disabled then
                    [ alpha 0.6 ]

                else
                    [ alpha 1 ]
               )
            ++ attrs
        )
        ([]
            ++ (case args.style of
                    R10.FormComponents.Internal.Style.FixedLabels ->
                        [ R10.FormComponents.Internal.UI.floatingLabel styleArgs ]

                    R10.FormComponents.Internal.Style.FloatingLabels ->
                        []
               )
            ++ [ viewInput
                    ([ Border.rounded 5
                     , withContextAttribute <|
                        \c ->
                            height <|
                                px <|
                                    case newArgs.textType of
                                        R10.FormTypes.TextMultiline ->
                                            200

                                        R10.FormTypes.TextWithPatternLarge _ ->
                                            c.contextR10.inputFieldWithLargePattern_height

                                        R10.FormTypes.TextWithPatternLargeWithoutLabel _ ->
                                            c.contextR10.inputFieldWithLargePattern_height

                                        -- 70
                                        _ ->
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
                    , paddingEach { top = R10.FormComponents.Internal.UI.genericSpacing, right = 16, bottom = 0, left = 16 }
                    ]
                    newArgs.helperText
               ]
            --
            -- This is an hack due to https://jira.rakuten-it.com/jira/browse/OMN-5336
            -- Instead that make this generic, that requires a lot of code,
            -- we inject this here. This probably is going to be removed in the future
            -- anyway and it is always required for Japanese.
            --
            ++ (if String.contains "フリガナ" args.label then
                    let
                        converted =
                            R10.KatakanaConverter.halfWidthKatakanaAndHiraganaToFullWidthKatakana args.value

                        equal =
                            args.value == converted
                    in
                    if equal then
                        []

                    else
                        [ R10.Paragraph.small [ paddingEach { top = 15, right = 0, bottom = 0, left = 0 } ]
                            [ text "We will convert this to Full-width Katakana: "
                            , el [ Font.bold ] <| text converted
                            , text ". If not correct, use Full-width Katakana directly."
                            ]
                        ]

                else
                    []
               )
        )


viewInput : List (Attribute (R10.Context.ContextInternal z) msg) -> Args z msg -> Element (R10.Context.ContextInternal z) msg
viewInput extraAttr args =
    let
        inputDisabledAttrs : List (Attribute (R10.Context.ContextInternal z) msg)
        inputDisabledAttrs =
            [ htmlAttribute <| Html.Attributes.attribute "disabled" "true" ]

        iconCommonAttrs : List (Attr (R10.Context.ContextInternal z) () msg)
        iconCommonAttrs =
            [ -- in order to icon to be aligned with the input, move icon down
              moveDown 0
            ]

        -- paddingValues : { top : Int, right : Int, bottom : Int, left : Int }
        -- paddingValues =
        --     R10.FormComponents.Internal.UI.getTextfieldPaddingEach args
        _ =
            12

        name =
            case args.textType of
                R10.FormTypes.TextUsername ->
                    "username"

                R10.FormTypes.TextUsernameWithUseEmailCheckbox _ ->
                    "username"

                R10.FormTypes.TextEmail ->
                    "email"

                R10.FormTypes.TextEmailWithSuggestions _ ->
                    "email"

                R10.FormTypes.TextPasswordCurrent _ ->
                    "password"

                R10.FormTypes.TextPasswordNew _ ->
                    "password"

                _ ->
                    ""

        inputAttrs : List (Attribute (R10.Context.ContextInternal z) msg)
        inputAttrs =
            [ -- IOS fix that remove autocorrect, autocapitalize and spellcheck
              htmlAttribute <| Html.Attributes.attribute "spellcheck" "false"
            , htmlAttribute <| Html.Attributes.attribute "autocorrect" "off"
            , htmlAttribute <| Html.Attributes.attribute "autocapitalize" "off"
            , R10.Transition.transition "all 0.15s"
            , htmlAttribute <| Html.Attributes.name name
            , Font.size R10.FormComponents.Internal.UI.Const.inputTextFontSize
            , Font.color <| R10.FormComponents.Internal.UI.Color.font args.palette
            , Border.width 0
            , Background.color <| R10.FormComponents.Internal.UI.Color.transparent
            , Events.onFocus args.msgOnFocus

            -- Adding some padding to have the input field to stay in a good position
            -- This value also influence the light blue area of the Browsers's
            -- autocomplete feature.
            , paddingEach
                { top = 20
                , right = 16
                , bottom = 8
                , left = 16
                }
            ]
                ++ (case args.textType of
                        R10.FormTypes.TextWithPatternLarge _ ->
                            textWithPatternLargeAttrs

                        R10.FormTypes.TextWithPattern _ ->
                            textWithPatternAttrs

                        R10.FormTypes.TextWithPatternLargeWithoutLabel _ ->
                            textWithPatternLargeWithoutLabelAttrs

                        _ ->
                            []
                   )
                ++ (case args.autocomplete of
                        Nothing ->
                            []

                        Just string ->
                            [ htmlAttribute <| Html.Attributes.attribute "autocomplete" string
                            ]
                   )
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
            { label : Input.Label context msg
            , onChange : String -> msg
            , placeholder : Maybe (Input.Placeholder context msg)
            , text : String
            }
        behavioursText =
            { onChange = args.msgOnChange
            , placeholder =
                case ( String.length args.value /= 0, args.placeholder, args.fieldType ) of
                    ( False, Just string, Just (R10.FormTypes.TypeSpecial (R10.FormTypes.SpecialPhone _)) ) ->
                        Just <| Input.placeholder [ alpha 1 ] <| text string

                    ( False, Just string, _ ) ->
                        Just <|
                            Input.placeholder
                                [ alpha <|
                                    if args.focused then
                                        0

                                    else
                                        1
                                ]
                            <|
                                text string

                    _ ->
                        -- Don't use Nothing, the input will lost focus on first change.
                        Just <| Input.placeholder [] none
            , text = args.value
            , label = Input.labelHidden args.label
            }

        behavioursTextOnlyDigitsOrDash :
            { label : Input.Label context msg
            , onChange : String -> msg
            , placeholder : Maybe (Input.Placeholder context msg)
            , text : String
            }
        behavioursTextOnlyDigitsOrDash =
            { behavioursText
                | onChange =
                    \value ->
                        args.msgOnChange <| Regex.replace regexNotDigitOrDash (\_ -> "") value
            }

        behavioursTextEmailWithSuggestions :
            { label : Input.Label context msg
            , onChange : String -> msg
            , placeholder : Maybe (Input.Placeholder context msg)
            , text : String
            }
        behavioursTextEmailWithSuggestions =
            -- ╔══════════════╤═════════════════════════════════════════════════╗
            -- ║ FEATURE_NAME │ Email Input Field with Domain Suggestions       ║
            -- ╚══════════════╧═════════════════════════════════════════════════╝
            -- The "behaviours" (arguments to Input.text) are the same as the
            -- regular input field
            --
            behavioursText

        maybeEmailSuggestion : List String -> Maybe String
        maybeEmailSuggestion listSuggestions =
            if args.focused then
                case args.textType of
                    R10.FormTypes.TextEmailWithSuggestions _ ->
                        R10.FormComponents.Internal.EmailAutoSuggest.emailDomainAutocomplete listSuggestions args.value

                    R10.FormTypes.TextMobileEmail ->
                        R10.FormComponents.Internal.EmailAutoSuggest.emailDomainAutocomplete
                            (List.map
                                (\domain ->
                                    String.replace "@" "" domain
                                )
                                listSuggestions
                            )
                            args.value

                    _ ->
                        Nothing

            else
                Nothing

        rightKeyDownDetection : List String -> List (Attribute (R10.Context.ContextInternal z) msg)
        rightKeyDownDetection listSuggestions =
            case maybeEmailSuggestion listSuggestions of
                Nothing ->
                    []

                Just emailSuggestion ->
                    [ htmlAttribute <|
                        R10.FormComponents.Internal.EmailAutoSuggest.addOnRightKeyDownEvent
                            args.msgOnChange
                            args.value
                            (args.value ++ emailSuggestion)
                    ]

        behavioursTextWithPattern :
            String
            ->
                { label : Input.Label context msg
                , onChange : String -> msg
                , placeholder : Maybe (Input.Placeholder context msg)
                , text : String
                }
        behavioursTextWithPattern pattern =
            { onChange =
                \string ->
                    args.msgOnChange
                        (handleWithPatternChange
                            { pattern = pattern
                            , oldValue = args.value
                            , newValue = string
                            }
                        )
            , placeholder = Nothing
            , text = args.value
            , label = Input.labelHidden args.label
            }

        behavioursPassword :
            Bool
            ->
                { label : Input.Label context msg
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
            { label : Input.Label context msg
            , onChange : String -> msg
            , placeholder : Maybe (Input.Placeholder context msg)
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

        styleArgs :
            { disabled : Bool
            , displayValidation : Bool
            , focused : Bool
            , isMouseOver : Bool
            , label : String
            , palette : R10.Palette.Palette
            , requiredLabel : Maybe String
            , style : R10.FormComponents.Internal.Style.Style
            , leadingIcon : List (Element (R10.Context.ContextInternal z) msg)
            , trailingIcon : List (Element (R10.Context.ContextInternal z) msg)
            , maybeValid : Maybe Bool
            , value : String
            }
        styleArgs =
            { label = args.label
            , value = args.value
            , focused = args.focused
            , disabled = args.disabled
            , requiredLabel = args.requiredLabel
            , style = args.style
            , palette = args.palette
            , leadingIcon = args.leadingIcon
            , trailingIcon = args.trailingIcon
            , maybeValid = args.maybeValid
            , displayValidation = displayValidation
            , isMouseOver = False
            }

        displayValidation : Bool
        displayValidation =
            args.maybeValid /= Nothing

        listenKeyDownAttr : List (Attribute (R10.Context.ContextInternal z) msg)
        listenKeyDownAttr =
            case args.msgOnKeyDown of
                Just onKeyDown ->
                    [ htmlAttribute <| Html.Events.stopPropagationOn "keydown" <| Json.Decode.map (\x -> ( x, True )) (Json.Decode.map onKeyDown Html.Events.keyCode) ]

                Nothing ->
                    []

        topInputWhenSuggestionAttr : List (Attribute (R10.Context.ContextInternal z) msg)
        topInputWhenSuggestionAttr =
            --
            -- https://jira.rakuten-it.com/jira/browse/OMN-4832
            -- Need to upper the zIndex to make the Input at the top of the Label
            -- to display the suggestion value that provide by browser
            -- for UserName and Email fields
            --
            if not args.focused && String.isEmpty args.value then
                [ htmlAttribute <| Html.Attributes.style "z-index" "1" ]

            else
                []
    in
    row
        ([ Border.rounded 5
         , width fill
         , padding 0

         -- Spacing must be 0 here, otherwise the animation of font (from 0px
         -- size to the real size) doesn't work well
         , spacing 0
         ]
            ++ (case args.textType of
                    R10.FormTypes.TextWithPatternLargeWithoutLabel _ ->
                        []

                    _ ->
                        [ getBorder styleArgs
                        , mouseOver [ getBorder { styleArgs | isMouseOver = True } ]
                        ]
               )
        )
    <|
        []
            ++ List.map (\icon -> el iconCommonAttrs icon) args.leadingIcon
            ++ [ case args.textType of
                    R10.FormTypes.TextUsername ->
                        Input.username (inputAttrs ++ topInputWhenSuggestionAttr) behavioursText

                    R10.FormTypes.TextUsernameWithUseEmailCheckbox _ ->
                        Input.username (inputAttrs ++ topInputWhenSuggestionAttr) behavioursText

                    R10.FormTypes.TextEmail ->
                        toEmailInput (inputAttrs ++ topInputWhenSuggestionAttr) behavioursText

                    R10.FormTypes.TextEmailWithSuggestions listSuggestions ->
                        el
                            -- ╔══════════════╤═════════════════════════════════════════════════╗
                            -- ║ FEATURE_NAME │ Email Input Field with Domain Suggestions       ║
                            -- ╚══════════════╧═════════════════════════════════════════════════╝
                            -- Detection of the key "right arrow" need to be
                            -- done on a parent element, otherwise it doesn't
                            -- work. Not sure why. This is why we are
                            -- creating this extra "el" instead attaching it
                            -- to the input field directly
                            --
                            ([ width fill ] ++ rightKeyDownDetection listSuggestions)
                            (withContext <|
                                \c ->
                                    let
                                        autoSuggestionsAttrs : List (Attribute (R10.Context.ContextInternal z) msg)
                                        autoSuggestionsAttrs =
                                            R10.FormComponents.Internal.EmailAutoSuggest.autoSuggestionsAttrs
                                                { device = c.contextR10.device
                                                , style = args.style
                                                , maybeEmailSuggestion = maybeEmailSuggestion c.contextR10.emailDomainList
                                                , msgOnChange = args.msgOnChange
                                                , value = args.value
                                                }
                                    in
                                    toEmailInput (autoSuggestionsAttrs ++ inputAttrs ++ topInputWhenSuggestionAttr) behavioursTextEmailWithSuggestions
                            )

                    R10.FormTypes.TextMobileEmail ->
                        el
                            ([ width fill ] ++ rightKeyDownDetection R10.FormComponents.Internal.EmailAutoSuggest.mobileEmailSupportDomainList)
                            (withContext <|
                                \c ->
                                    let
                                        autoSuggestionsAttrs : List (Attribute (R10.Context.ContextInternal z) msg)
                                        autoSuggestionsAttrs =
                                            R10.FormComponents.Internal.EmailAutoSuggest.autoSuggestionsAttrs
                                                { device = c.contextR10.device
                                                , style = args.style
                                                , maybeEmailSuggestion = maybeEmailSuggestion R10.FormComponents.Internal.EmailAutoSuggest.mobileEmailSupportDomainList
                                                , msgOnChange = args.msgOnChange
                                                , value = args.value
                                                }
                                    in
                                    toEmailInput (autoSuggestionsAttrs ++ inputAttrs) behavioursTextEmailWithSuggestions
                            )

                    R10.FormTypes.TextPasswordCurrent _ ->
                        Input.currentPassword inputAttrs (behavioursPassword args.showPassword)

                    R10.FormTypes.TextPasswordNew _ ->
                        Input.newPassword inputAttrs (behavioursPassword args.showPassword)

                    R10.FormTypes.TextPlain ->
                        Input.text inputAttrs behavioursText

                    R10.FormTypes.TextMultiline ->
                        Input.multiline inputAttrs behavioursMultiline

                    R10.FormTypes.TextWithPattern pattern ->
                        Input.text (inputAttrs ++ listenKeyDownAttr) <| behavioursTextWithPattern pattern

                    R10.FormTypes.TextWithPatternLarge pattern ->
                        Input.text (textWithPatternLargeAttrsExtra ++ inputAttrs ++ listenKeyDownAttr) <| behavioursTextWithPattern pattern

                    R10.FormTypes.TextWithPatternLargeWithoutLabel pattern ->
                        Input.text (textWithPatternLargeWithoutLabelAttrsExtra ++ inputAttrs ++ listenKeyDownAttr) <| behavioursTextWithPattern pattern

                    R10.FormTypes.TextOnlyDigitsOrDash ->
                        Input.text inputAttrs behavioursTextOnlyDigitsOrDash
               ]
            ++ List.map (\icon -> el iconCommonAttrs icon) args.trailingIcon
