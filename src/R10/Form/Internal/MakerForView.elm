module R10.Form.Internal.MakerForView exposing
    ( MakerArgs
    , Outcome
    , extraCss
    , maker
    )

import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Events as Events
import Element.WithContext.Font as Font
import Element.WithContext.Input as Input
import Html.Attributes
import R10.Context exposing (..)
import R10.Country
import R10.Device
import R10.Form.Internal.Conf
import R10.Form.Internal.Converter
import R10.Form.Internal.Dict
import R10.Form.Internal.FieldConf
import R10.Form.Internal.FieldState
import R10.Form.Internal.Helpers
import R10.Form.Internal.Key
import R10.Form.Internal.Msg
import R10.Form.Internal.Shared exposing (defaultUsernameFieldKeyString)
import R10.Form.Internal.State
import R10.Form.Internal.Translator
import R10.Form.Internal.Update
import R10.FormComponents.Internal.Binary
import R10.FormComponents.Internal.ExtraCss
import R10.FormComponents.Internal.Phone
import R10.FormComponents.Internal.Phone.Common
import R10.FormComponents.Internal.Single
import R10.FormComponents.Internal.Single.Common
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.Text
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.Validations
import R10.FormTypes
import R10.Palette
import R10.Transition



--  ██████  ██    ██ ████████  ██████  ██████  ███    ███ ███████
-- ██    ██ ██    ██    ██    ██      ██    ██ ████  ████ ██
-- ██    ██ ██    ██    ██    ██      ██    ██ ██ ████ ██ █████
-- ██    ██ ██    ██    ██    ██      ██    ██ ██  ██  ██ ██
--  ██████   ██████     ██     ██████  ██████  ██      ██ ███████


type alias Outcome z =
    Element (R10.Context.ContextInternal z) R10.Form.Internal.Msg.Msg



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


type alias ArgsForFields =
    { fieldConf : R10.Form.Internal.FieldConf.FieldConf
    , fieldState : R10.Form.Internal.FieldState.FieldState
    , focused : Bool
    , active : Bool
    , key : R10.Form.Internal.Key.Key
    , translator : R10.Form.Internal.FieldConf.ValidationCode -> String
    , style : R10.FormComponents.Internal.Style.Style
    , palette : R10.Palette.Palette
    }


paddingGeneric : Attribute (R10.Context.ContextInternal z) msg
paddingGeneric =
    paddingXY 20 25


spacingGeneric : Attribute (R10.Context.ContextInternal z) msg
spacingGeneric =
    spacingXY 15 25


extraCss : Maybe R10.Palette.Palette -> String
extraCss maybePalette =
    let
        palette : R10.Palette.Palette
        palette =
            Maybe.withDefault R10.Palette.light maybePalette
    in
    R10.FormComponents.Internal.ExtraCss.extraCss palette


isFocused : R10.Form.Internal.Key.Key -> Maybe String -> Bool
isFocused key focused =
    case focused of
        Just focused_x ->
            focused_x == R10.Form.Internal.Key.toString key

        Nothing ->
            False


isActive : R10.Form.Internal.Key.Key -> Maybe String -> Bool
isActive key active =
    case active of
        Just active_x ->
            active_x == R10.Form.Internal.Key.toString key

        Nothing ->
            False


getFieldConfig : R10.Form.Internal.Conf.Entity -> R10.Form.Internal.FieldConf.FieldConf
getFieldConfig entity =
    case entity of
        R10.Form.Internal.Conf.EntityField fieldConf ->
            fieldConf

        _ ->
            R10.Form.Internal.FieldConf.init


maybeValid : R10.Form.Internal.FieldState.Validation -> Maybe Bool
maybeValid validation =
    --
    -- Before this function was:
    --
    -- case validation of
    --     R10.Form.Internal.FieldState.NotYetValidated2 ->
    --         Nothing
    --
    --     R10.Form.Internal.FieldState.Valid ->
    --         Just True
    --
    --     R10.Form.Internal.FieldState.NotValid ->
    --         Just False
    --
    case validation of
        R10.Form.Internal.FieldState.NotYetValidated ->
            Nothing

        R10.Form.Internal.FieldState.Validated listValidationMessage ->
            Just (R10.Form.Internal.FieldState.isValid listValidationMessage)



-- ██    ██ ██ ███████ ██     ██     ████████ ███████ ██   ██ ████████
-- ██    ██ ██ ██      ██     ██        ██    ██       ██ ██     ██
-- ██    ██ ██ █████   ██  █  ██        ██    █████     ███      ██
--  ██  ██  ██ ██      ██ ███ ██        ██    ██       ██ ██     ██
--   ████   ██ ███████  ███ ███         ██    ███████ ██   ██    ██


viewText :
    ArgsForFields
    -> R10.FormTypes.TypeText
    -> R10.Form.Internal.Conf.Conf
    -> Element (R10.Context.ContextInternal z) R10.Form.Internal.Msg.Msg
viewText args textType formConf =
    withContext
        (\c ->
            R10.FormComponents.Internal.Text.view
                [ width
                    (fill
                        --
                        -- Min width can be customized in case we need to keep
                        -- two fields in the same row.
                        --
                        -- Before minimum and maximum were set at 300 and 900 (for
                        -- the Self Service Portal). Now they are set in the formConf
                        -- of each field.
                        --
                        |> (case args.fieldConf.minWidth of
                                Just int ->
                                    minimum int

                                Nothing ->
                                    identity
                           )
                        |> (case args.fieldConf.maxWidth of
                                Just int ->
                                    maximum int

                                Nothing ->
                                    identity
                           )
                    )
                ]
                []
                -- Stuff that change
                { value = args.fieldState.value
                , focused = args.focused
                , maybeValid = maybeValid args.fieldState.validation
                , showPassword = args.fieldState.showPassword
                , leadingIcon = []
                , trailingIcon = []

                -- Messages
                , msgOnChange = R10.Form.Internal.Msg.ChangeValue args.key args.fieldConf formConf c.contextR10
                , msgOnFocus = R10.Form.Internal.Msg.GetFocus args.key args.fieldConf
                , msgOnLoseFocus = Just <| R10.Form.Internal.Msg.LoseFocus args.key args.fieldConf
                , msgOnTogglePasswordShow = Just <| R10.Form.Internal.Msg.TogglePasswordShow args.key
                , msgOnEnter =
                    case textType of
                        -- Disabled trigger submit for textarea, because we can not input break line.
                        R10.FormTypes.TextMultiline ->
                            Nothing

                        _ ->
                            Just <| R10.Form.Internal.Msg.Submit formConf
                , msgOnKeyDown = Just R10.Form.Internal.Msg.KeyDown

                -- Stuff that doesn't change
                , label = args.fieldConf.label
                , helperText = args.fieldConf.helperText
                , disabled = args.fieldState.disabled
                , idDom = args.fieldConf.idDom
                , style = args.style
                , requiredLabel = args.fieldConf.requiredLabel
                , palette = args.palette
                , autocomplete = args.fieldConf.autocomplete
                , floatingLabelAlwaysUp =
                    case textType of
                        R10.FormTypes.TextWithPatternLarge _ ->
                            True

                        _ ->
                            False

                -- Specific
                , textType = textType
                , fieldType = Nothing
                , placeholder = args.fieldConf.placeholder
                }
        )


viewUsernameWithUseEmailCheckbox :
    MakerArgs
    -> ArgsForFields
    -> String
    -> R10.Form.Internal.Conf.Conf
    -> R10.Form.Internal.State.State
    -> Element (R10.Context.ContextInternal z) R10.Form.Internal.Msg.Msg
viewUsernameWithUseEmailCheckbox makerArgs args checkboxLabel formConf formState =
    let
        checkboxKey : R10.Form.Internal.Key.Key
        checkboxKey =
            R10.Form.Internal.Shared.copyEmailIntoUsernameCheckboxKey

        checkboxConf : R10.Form.Internal.FieldConf.FieldConf
        checkboxConf =
            { id = R10.Form.Internal.Key.toString checkboxKey
            , idDom = Just <| R10.Form.Internal.Key.toString checkboxKey
            , type_ = R10.FormTypes.TypeText <| R10.FormTypes.TextUsernameWithUseEmailCheckbox checkboxLabel
            , label = checkboxLabel
            , clickableLabel = True
            , helperText = Nothing
            , requiredLabel = Nothing
            , validationSpecs = Nothing
            , minWidth = Nothing
            , maxWidth = Nothing
            , autocomplete = Nothing
            , placeholder = Nothing
            }

        checkboxState : R10.Form.Internal.FieldState.FieldState
        checkboxState =
            Maybe.withDefault
                (R10.Form.Internal.FieldState.init |> (\state -> { state | value = "True" }))
            <|
                R10.Form.Internal.Dict.get checkboxKey formState.fieldsState

        checkboxFocused : Bool
        checkboxFocused =
            isFocused checkboxKey formState.focused

        checkboxActive : Bool
        checkboxActive =
            isActive checkboxKey formState.active

        checkboxArgs : ArgsForFields
        checkboxArgs =
            { fieldConf = checkboxConf
            , fieldState = checkboxState
            , focused = checkboxFocused
            , active = checkboxActive
            , key = checkboxKey
            , translator = makerArgs.translator checkboxKey
            , style = makerArgs.style
            , palette = makerArgs.palette
            }

        textArgs : ArgsForFields
        textArgs =
            let
                oldFieldState : R10.Form.Internal.FieldState.FieldState
                oldFieldState =
                    args.fieldState

                disabled : Bool
                disabled =
                    R10.Form.Internal.Helpers.stringToBool checkboxState.value
            in
            { args | fieldState = { oldFieldState | disabled = disabled } }

        validationIcon : R10.FormTypes.ValidationIcon
        validationIcon =
            args.fieldConf.validationSpecs
                |> Maybe.map .validationIcon
                |> Maybe.withDefault R10.FormTypes.NoIcon
    in
    column
        [ width fill
        , spacingGeneric
        ]
        [ column [ width fill ]
            [ viewText textArgs R10.FormTypes.TextUsername formConf
            , R10.FormComponents.Internal.Validations.viewValidation makerArgs.palette validationIcon <|
                R10.Form.Internal.Converter.fromFieldStateValidationToComponentValidation
                    args.fieldConf.validationSpecs
                    (R10.Form.Internal.Dict.get makerArgs.key formState.fieldsState
                        |> Maybe.withDefault R10.Form.Internal.FieldState.init
                    ).validation
                    (makerArgs.translator makerArgs.key)
            ]
        , viewBinary checkboxArgs R10.FormTypes.BinaryCheckbox formConf
        ]



-- ██    ██ ██ ███████ ██     ██     ██████  ██ ███    ██  █████  ██████  ██    ██
-- ██    ██ ██ ██      ██     ██     ██   ██ ██ ████   ██ ██   ██ ██   ██  ██  ██
-- ██    ██ ██ █████   ██  █  ██     ██████  ██ ██ ██  ██ ███████ ██████    ████
--  ██  ██  ██ ██      ██ ███ ██     ██   ██ ██ ██  ██ ██ ██   ██ ██   ██    ██
--   ████   ██ ███████  ███ ███      ██████  ██ ██   ████ ██   ██ ██   ██    ██


viewBinary :
    ArgsForFields
    -> R10.FormTypes.TypeBinary
    -> R10.Form.Internal.Conf.Conf
    -> Element (R10.Context.ContextInternal z) R10.Form.Internal.Msg.Msg
viewBinary args typeBinary formConf =
    let
        value : Bool
        value =
            R10.Form.Internal.Helpers.stringToBool args.fieldState.value

        msgOnClick : R10.Context.ContextR10 -> R10.Form.Internal.Msg.Msg
        msgOnClick contextR10 =
            R10.Form.Internal.Msg.ChangeValue args.key args.fieldConf formConf contextR10 (R10.Form.Internal.Helpers.boolToString <| not value)
    in
    withContext
        (\c ->
            R10.FormComponents.Internal.Binary.view
                []
                -- Stuff that change
                { value = value
                , focused = args.focused
                , maybeValid = maybeValid args.fieldState.validation
                , fieldConf = args.fieldConf

                -- Messages
                , msgOnChange = \_ -> msgOnClick c.contextR10
                , msgOnFocus = R10.Form.Internal.Msg.GetFocus args.key args.fieldConf
                , msgOnLoseFocus = R10.Form.Internal.Msg.LoseFocus args.key args.fieldConf
                , msgOnClick = msgOnClick c.contextR10
                , msgNoOp = R10.Form.Internal.Msg.NoOp

                -- Stuff that doesn't change
                , label = args.fieldConf.label
                , disabled = args.fieldState.disabled
                , helperText = args.fieldConf.helperText
                , palette = args.palette
                , clickableLabel = args.fieldConf.clickableLabel
                , style = args.style

                -- Specific stuff
                , typeBinary = typeBinary
                }
        )



-- ██    ██ ██ ███████ ██     ██     ███████ ██ ███    ██  ██████  ██      ███████
-- ██    ██ ██ ██      ██     ██     ██      ██ ████   ██ ██       ██      ██
-- ██    ██ ██ █████   ██  █  ██     ███████ ██ ██ ██  ██ ██   ███ ██      █████
--  ██  ██  ██ ██      ██ ███ ██          ██ ██ ██  ██ ██ ██    ██ ██      ██
--   ████   ██ ███████  ███ ███      ███████ ██ ██   ████  ██████  ███████ ███████


viewSingle :
    ArgsForFields
    -> R10.FormTypes.TypeSingle
    -> List R10.FormTypes.FieldOption
    -> R10.Form.Internal.Conf.Conf
    -> Element (R10.Context.ContextInternal z) R10.Form.Internal.Msg.Msg
viewSingle args singleType fieldOptions formConf =
    R10.FormComponents.Internal.Single.view
        []
        -- Stuff that change
        -- R10.FormComponents.Internal.Single.Common.Model
        { value = args.fieldState.value
        , search = args.fieldState.search
        , select = args.fieldState.select
        , scroll = args.fieldState.scroll
        , focused = args.focused
        , opened = args.active
        }
        { maybeValid = maybeValid args.fieldState.validation

        -- Message mapper
        , toMsg = R10.Form.Internal.Msg.OnSingleMsg args.key args.fieldConf formConf

        -- Stuff that doesn't change
        , label = args.fieldConf.label
        , helperText = args.fieldConf.helperText
        , disabled = args.fieldState.disabled
        , requiredLabel = args.fieldConf.requiredLabel
        , style = args.style
        , key = R10.Form.Internal.Key.toString args.key
        , palette = args.palette

        -- Specific
        , singleType = singleType
        , fieldOptions = fieldOptions
        }


viewSpecial :
    ArgsForFields
    -> R10.FormTypes.TypeSpecial
    -> R10.Form.Internal.Conf.Conf
    -> Element (R10.Context.ContextInternal z) R10.Form.Internal.Msg.Msg
viewSpecial args typeSpecial formConf =
    case typeSpecial of
        R10.FormTypes.SpecialPhone disabledChangeCountry ->
            withContext
                (\c ->
                    let
                        model : R10.FormComponents.Internal.Single.Common.Model
                        model =
                            { value = args.fieldState.value
                            , search = args.fieldState.search
                            , select = args.fieldState.select
                            , scroll = args.fieldState.scroll
                            , focused = args.focused
                            , opened = args.active
                            }

                        shouldUseSimpleInput : Bool
                        shouldUseSimpleInput =
                            R10.Device.isMobileOS c.contextR10.userAgent
                                || R10.Device.isInternetExplorer c.contextR10.userAgent
                                || R10.Context.isShouldUseSimplePhoneInputWindowSize c.contextR10.windowSize.width

                        onSimpleInputValueChange : String -> R10.Form.Internal.Msg.Msg
                        onSimpleInputValueChange =
                            R10.Form.Internal.Msg.OnPhoneMsg
                                args.key
                                args.fieldConf
                                formConf
                                << R10.FormComponents.Internal.Phone.Common.OnSimpleValueChange disabledChangeCountry

                        countryTelCode : String
                        countryTelCode =
                            args.fieldState.value
                                |> R10.Country.fromTelephoneAsString
                                |> Maybe.map R10.Country.toCountryTelCode
                                |> Maybe.withDefault ""

                        countryTelCodeViewWidth : Int
                        countryTelCodeViewWidth =
                            -- one char width 10
                            String.length countryTelCode * 10

                        isEmptyExceptCountryTelCode : Bool
                        isEmptyExceptCountryTelCode =
                            String.replace countryTelCode "" args.fieldState.value
                                |> String.isEmpty

                        maybePlaceholderString : Maybe String
                        maybePlaceholderString =
                            if R10.Form.Internal.Key.headId args.key == R10.Form.Internal.Shared.defaultMobilePhoneFieldKeyString then
                                args.fieldState.value
                                    |> R10.Country.fromTelephoneAsString
                                    |> Maybe.map R10.Country.toPhoneTemplate

                            else
                                Nothing
                    in
                    if shouldUseSimpleInput then
                        R10.FormComponents.Internal.Text.view
                            [ width
                                (fill
                                    --
                                    -- Min width can be customized in case we need to keep
                                    -- two fields in the same row.
                                    --
                                    -- Before minimum and maximum were set at 300 and 900 (for
                                    -- the Self Service Portal). Now they are set in the formConf
                                    -- of each field.
                                    --
                                    |> (case args.fieldConf.minWidth of
                                            Just int ->
                                                minimum int

                                            Nothing ->
                                                identity
                                       )
                                    |> (case args.fieldConf.maxWidth of
                                            Just int ->
                                                maximum int

                                            Nothing ->
                                                identity
                                       )
                                )
                            , behindContent <|
                                el
                                    ([ Font.color <| R10.FormComponents.Internal.UI.Color.onSurfaceA 0.6 args.palette
                                     ]
                                        ++ (case args.style of
                                                R10.FormComponents.Internal.Style.Filled ->
                                                    [ moveDown 23
                                                    , moveRight 30
                                                    , moveRight <| toFloat <| countryTelCodeViewWidth
                                                    ]

                                                R10.FormComponents.Internal.Style.Outlined ->
                                                    [ moveDown 20
                                                    , moveRight <| toFloat <| countryTelCodeViewWidth + 16 --padding-left 16
                                                    ]
                                           )
                                    )
                                <|
                                    text
                                        (if isEmptyExceptCountryTelCode then
                                            Maybe.withDefault "" maybePlaceholderString

                                         else
                                            ""
                                        )
                            ]
                            [ htmlAttribute <| Html.Attributes.type_ "tel"
                            , htmlAttribute <| Html.Attributes.attribute "autocomplete" "tel"
                            ]
                            -- Stuff that change
                            { value = args.fieldState.value
                            , focused = args.focused
                            , maybeValid = maybeValid args.fieldState.validation
                            , showPassword = args.fieldState.showPassword
                            , leadingIcon = []
                            , trailingIcon = []

                            -- Messages
                            , msgOnChange = onSimpleInputValueChange
                            , msgOnFocus = R10.Form.Internal.Msg.GetFocus args.key args.fieldConf
                            , msgOnLoseFocus = Just <| R10.Form.Internal.Msg.LoseFocus args.key args.fieldConf
                            , msgOnTogglePasswordShow = Nothing
                            , msgOnEnter = Just <| R10.Form.Internal.Msg.Submit formConf
                            , msgOnKeyDown = Just R10.Form.Internal.Msg.KeyDown

                            -- Stuff that doesn't change
                            , label = args.fieldConf.label
                            , helperText = args.fieldConf.helperText
                            , disabled = args.fieldState.disabled
                            , idDom = args.fieldConf.idDom
                            , style = args.style
                            , requiredLabel = args.fieldConf.requiredLabel
                            , palette = args.palette
                            , autocomplete = args.fieldConf.autocomplete
                            , floatingLabelAlwaysUp = False

                            -- Specific
                            , textType = R10.FormTypes.TextPlain
                            , fieldType = Nothing
                            , placeholder = maybePlaceholderString
                            }

                    else
                        R10.FormComponents.Internal.Phone.view
                            []
                            model
                            { maybeValid = maybeValid args.fieldState.validation
                            , toMsg = R10.Form.Internal.Msg.OnPhoneMsg args.key args.fieldConf formConf
                            , label = args.fieldConf.label
                            , helperText = args.fieldConf.helperText
                            , disabled = args.fieldState.disabled
                            , requiredLabel = args.fieldConf.requiredLabel
                            , style = args.style
                            , key = R10.Form.Internal.Key.toString args.key
                            , palette = args.palette
                            , countryOptions = Nothing
                            , disabledCountryChange = disabledChangeCountry
                            }
                )



-- ██    ██ ██ ███████ ██     ██     ███████ ███    ██ ████████ ██ ████████ ██ ███████ ███████
-- ██    ██ ██ ██      ██     ██     ██      ████   ██    ██    ██    ██    ██ ██      ██
-- ██    ██ ██ █████   ██  █  ██     █████   ██ ██  ██    ██    ██    ██    ██ █████   ███████
--  ██  ██  ██ ██      ██ ███ ██     ██      ██  ██ ██    ██    ██    ██    ██ ██           ██
--   ████   ██ ███████  ███ ███      ███████ ██   ████    ██    ██    ██    ██ ███████ ███████


viewEntityNormal :
    MakerArgs
    -> List R10.Form.Internal.Conf.Entity
    -> R10.Form.Internal.Conf.Conf
    -> List (Outcome z)
viewEntityNormal args entities formConf =
    [ el
        [ alignTop
        , width fill
        , height fill
        , spacingGeneric
        ]
      <|
        column
            -- This padding need to be nested, otherwise the fill doesn't
            -- get 50% of the space
            [ spacingGeneric
            , width fill
            ]
        <|
            maker_ args entities formConf
    ]


viewEntityWrappable :
    MakerArgs
    -> List R10.Form.Internal.Conf.Entity
    -> R10.Form.Internal.Conf.Conf
    -> List (Outcome z)
viewEntityWrappable args entities formConf =
    [ wrappedRow
        [ alignTop
        , width fill
        , height fill
        , spacingGeneric
        ]
      <|
        maker_ args entities formConf
    ]


viewEntityWithBorder :
    MakerArgs
    -> List R10.Form.Internal.Conf.Entity
    -> R10.Form.Internal.Conf.Conf
    -> List (Outcome z)
viewEntityWithBorder args entities formConf =
    [ el
        ([ alignTop
         , width fill
         , height fill
         ]
            ++ R10.FormComponents.Internal.UI.borderEntityWithBorder args.palette
        )
      <|
        column
            -- This padding need to be nested, otherwise the fill doesn't
            -- get 50% of the space
            [ paddingGeneric
            , spacingGeneric
            , width fill
            ]
        <|
            maker_ args entities formConf
    ]


viewTab :
    MakerArgs
    -> R10.Form.Internal.FieldState.FieldState
    ->
        { index : Int
        , selected : Bool
        , label : String
        , entity : R10.Form.Internal.Conf.Entity
        }
    -> Element (R10.Context.ContextInternal z) R10.Form.Internal.Msg.Msg
viewTab args fieldState { index, selected, entity, label } =
    let
        valid : Bool
        valid =
            R10.Form.Internal.Update.isExistingFormFieldsValid { conf = [ entity ], state = args.formState }

        { opacity, clickOverlay } =
            if fieldState.disabled then
                { opacity = 0.5
                , clickOverlay = none
                }

            else
                { opacity = 1
                , clickOverlay =
                    el
                        [ Events.onClick <| R10.Form.Internal.Msg.ChangeTab args.key (R10.Form.Internal.Conf.getId entity)
                        , pointer
                        , width fill
                        , height fill
                        , htmlAttribute <| Html.Attributes.class <| "ripple"
                        , mouseOver [ Background.color <| R10.FormComponents.Internal.UI.Color.mouseOverSurface args.palette ]
                        ]
                        none
                }

        { circleBackground, circleBorder, circleText, labelText } =
            if selected then
                { circleBackground = R10.FormComponents.Internal.UI.Color.surfaceA opacity args.palette
                , circleBorder = R10.FormComponents.Internal.UI.Color.primaryA opacity args.palette
                , circleText = R10.FormComponents.Internal.UI.Color.primaryA opacity args.palette
                , labelText = R10.FormComponents.Internal.UI.Color.primaryA opacity args.palette
                }

            else
                { circleBackground = R10.FormComponents.Internal.UI.Color.surfaceA opacity args.palette
                , circleBorder = R10.FormComponents.Internal.UI.Color.labelA opacity args.palette
                , circleText = R10.FormComponents.Internal.UI.Color.labelA opacity args.palette
                , labelText = R10.FormComponents.Internal.UI.Color.labelA opacity args.palette
                }
    in
    el
        [ paddingXY 8 0
        , inFront <| clickOverlay
        ]
    <|
        row
            [ Background.color <| R10.FormComponents.Internal.UI.Color.surface args.palette
            , paddingXY 8 24
            , spacing 8
            , Font.color <| labelText
            ]
        <|
            [ el
                [ inFront <|
                    el
                        [ height fill
                        , Background.color <| R10.FormComponents.Internal.UI.Color.surface args.palette
                        ]
                    <|
                        R10.FormComponents.Internal.UI.showValidationIcon_
                            { maybeValid = Just valid
                            , displayValidation = True
                            , palette = args.palette
                            , style = args.style
                            }
                , height <| px 24
                , width <| px 24
                , Border.rounded 24
                , Background.color circleBackground
                , Font.color circleText
                , Border.innerShadow
                    { offset = ( 0, 0 )
                    , size = 1
                    , blur = 0
                    , color = circleBorder
                    }
                ]
              <|
                el
                    [ centerY
                    , centerX
                    ]
                <|
                    text <|
                        String.fromInt (index + 1)
            , column [ width shrink ] <|
                [ text label
                , el
                    ([ Font.size 11
                     , clip
                     , Font.color <| R10.FormComponents.Internal.UI.Color.error args.palette
                     , R10.Transition.transition "all 0.15s ease-out"
                     ]
                        ++ (if valid then
                                [ width <| px 0
                                , height <| px 0
                                ]

                            else
                                [ width <| px 80
                                , height <| px 11
                                ]
                           )
                    )
                  <|
                    text "Validation error"
                ]
            ]


viewEntityWithTabs :
    MakerArgs
    -> List ( String, R10.Form.Internal.Conf.Entity )
    -> R10.Form.Internal.Conf.Conf
    -> List (Outcome z)
viewEntityWithTabs args titleEntityList formConf =
    let
        paddingPx : number
        paddingPx =
            8

        firstEntity : Maybe ( String, R10.Form.Internal.Conf.Entity )
        firstEntity =
            List.head titleEntityList

        maybeSelectedEntity : Maybe ( String, R10.Form.Internal.Conf.Entity )
        maybeSelectedEntity =
            case R10.Form.Internal.Dict.get args.key args.formState.activeTabs of
                Just key_ ->
                    case List.head <| List.filter (\( _, entity ) -> R10.Form.Internal.Conf.getId entity == key_) titleEntityList of
                        Just entity_ ->
                            Just entity_

                        Nothing ->
                            firstEntity

                Nothing ->
                    firstEntity

        tabSpacer : Element (R10.Context.ContextInternal z) msg
        tabSpacer =
            el [ width (fill |> maximum 40), height fill ] none

        emptyTab : Element (R10.Context.ContextInternal z) msg
        emptyTab =
            el [ width fill, height fill, moveLeft paddingPx, Background.color <| R10.FormComponents.Internal.UI.Color.surface args.palette ] none
    in
    case maybeSelectedEntity of
        Just ( _, selectedEntity ) ->
            [ el
                [ width fill
                , behindContent <|
                    el [ width fill, centerY, paddingXY paddingPx 0 ] <|
                        el
                            [ width fill
                            , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
                            , Border.color <| R10.FormComponents.Internal.UI.Color.container args.palette
                            ]
                            none
                ]
              <|
                row
                    [ scrollbars
                    , width fill
                    ]
                <|
                    (\items -> items ++ [ emptyTab ]) <|
                        (List.concat <|
                            List.indexedMap
                                (\index ( label, entity ) ->
                                    let
                                        newKey : R10.Form.Internal.Key.Key
                                        newKey =
                                            R10.Form.Internal.Key.composeKey args.key (R10.Form.Internal.Conf.getId entity)

                                        fieldState : R10.Form.Internal.FieldState.FieldState
                                        fieldState =
                                            Maybe.withDefault R10.Form.Internal.FieldState.init <|
                                                R10.Form.Internal.Dict.get newKey args.formState.fieldsState
                                    in
                                    [ viewTab args
                                        fieldState
                                        { index = index
                                        , selected = R10.Form.Internal.Conf.getId selectedEntity == R10.Form.Internal.Conf.getId entity
                                        , label = label
                                        , entity = entity
                                        }
                                    ]
                                        ++ (if index + 1 /= List.length titleEntityList then
                                                [ tabSpacer ]

                                            else
                                                []
                                           )
                                )
                                titleEntityList
                        )
            ]
                ++ maker_ args [ selectedEntity ] formConf

        Nothing ->
            []


viewEntityMultiSingleRow :
    MakerArgs
    -> R10.Form.Internal.Key.Key
    -> List R10.Form.Internal.Conf.Entity
    -> R10.Form.Internal.Conf.Conf
    -> List (Element (R10.Context.ContextInternal z) R10.Form.Internal.Msg.Msg)
viewEntityMultiSingleRow args newKey entities formConf =
    let
        iconSize : Int
        iconSize =
            18

        shadow : Float -> Float -> Attr (R10.Context.ContextInternal z) decorative msg
        shadow size_ a =
            Border.shadow
                { offset = ( 0, 0 )
                , size = size_
                , blur = 0
                , color = R10.FormComponents.Internal.UI.Color.labelA a args.palette
                }

        buttonAttrs : List (Attr (R10.Context.ContextInternal z) () msg)
        buttonAttrs =
            [ Border.width 1
            , Border.rounded 5
            , htmlAttribute <| Html.Attributes.class <| "ripple"
            , R10.Transition.transition "all 0.11s ease-out"
            , padding 8
            , width <| px 28
            , height fill
            , shadow 10 0
            , Border.color <| R10.FormComponents.Internal.UI.Color.containerA 0.5 args.palette
            , mouseOver <| [ Border.color <| R10.FormComponents.Internal.UI.Color.containerA 1 args.palette ]
            , focused <| [ alpha 1, shadow 1 1, Border.color <| R10.FormComponents.Internal.UI.Color.containerA 1 args.palette ]
            ]

        removeColor : Color
        removeColor =
            R10.FormComponents.Internal.UI.Color.label args.palette

        iconCommonAttrs : Int -> Int -> Color -> Float -> List (Attribute (R10.Context.ContextInternal z) msg)
        iconCommonAttrs widthPx heightPx color rotateDeg =
            [ R10.Transition.transition "all 0.2s "
            , Border.rounded 2
            , centerX
            , centerY
            , width <| px widthPx
            , height <| px heightPx
            , Background.color color
            , rotate <| degrees rotateDeg
            ]

        buttonToRemoveEntity : R10.Form.Internal.Key.Key -> Element (R10.Context.ContextInternal z) R10.Form.Internal.Msg.Msg
        buttonToRemoveEntity key_ =
            Input.button buttonAttrs
                { label =
                    el
                        [ width <| px iconSize
                        , height <| px iconSize
                        , R10.Transition.transition "all 0.2s "
                        , inFront <| el (iconCommonAttrs iconSize 2 removeColor 45) none
                        , inFront <| el (iconCommonAttrs 2 iconSize removeColor -135) none
                        ]
                    <|
                        none
                , onPress = Just <| R10.Form.Internal.Msg.RemoveEntity key_
                }
    in
    [ row [ spacing 10, width fill ]
        [ buttonToRemoveEntity newKey
        , column [ width fill, spacingGeneric ] <| maker_ { args | key = newKey } entities formConf
        ]
    ]


viewEntityMultiLastRow : MakerArgs -> Element (R10.Context.ContextInternal z) R10.Form.Internal.Msg.Msg
viewEntityMultiLastRow args =
    let
        iconSize : Int
        iconSize =
            18

        shadow : Float -> Float -> Attr (R10.Context.ContextInternal z) decorative msg
        shadow size_ a =
            Border.shadow
                { offset = ( 0, 0 )
                , size = size_
                , blur = 0
                , color = R10.FormComponents.Internal.UI.Color.labelA a args.palette
                }

        buttonAttrs : List (Attr (R10.Context.ContextInternal z) () msg)
        buttonAttrs =
            [ Border.width 1
            , Border.rounded 5
            , htmlAttribute <| Html.Attributes.class <| "ripple"
            , R10.Transition.transition "all 0.11s ease-out"
            , padding 8
            , width <| px 28
            , height fill
            , shadow 10 0
            , Border.color <| R10.FormComponents.Internal.UI.Color.containerA 0.5 args.palette
            , mouseOver <| [ Border.color <| R10.FormComponents.Internal.UI.Color.containerA 1 args.palette ]
            , focused <| [ alpha 1, shadow 1 1, Border.color <| R10.FormComponents.Internal.UI.Color.containerA 1 args.palette ]
            ]

        plusColor : Color
        plusColor =
            R10.FormComponents.Internal.UI.Color.label args.palette

        iconCommonAttrs : Int -> Int -> Color -> Float -> List (Attribute (R10.Context.ContextInternal z) msg)
        iconCommonAttrs widthPx heightPx color rotateDeg =
            [ R10.Transition.transition "all 0.2s "
            , Border.rounded 2
            , centerX
            , centerY
            , width <| px widthPx
            , height <| px heightPx
            , Background.color color
            , rotate <| degrees rotateDeg
            ]

        buttonToAddEntity : Element (R10.Context.ContextInternal z) R10.Form.Internal.Msg.Msg
        buttonToAddEntity =
            Input.button buttonAttrs
                { label =
                    el
                        [ width <| px iconSize
                        , height <| px iconSize
                        , inFront <| el (iconCommonAttrs iconSize 2 plusColor 0) none
                        , inFront <| el (iconCommonAttrs 2 iconSize plusColor 0) none
                        ]
                    <|
                        none
                , onPress = Just <| R10.Form.Internal.Msg.AddEntity args.key
                }
    in
    row [ spacing 10, width fill ]
        [ buttonToAddEntity
        , el [ width fill, spacingGeneric ] none
        ]


viewEntityMulti :
    MakerArgs
    -> List R10.Form.Internal.Conf.Entity
    -> R10.Form.Internal.Conf.Conf
    -> List (Outcome z)
viewEntityMulti args entities formConf =
    let
        activeKeys : List R10.Form.Internal.Key.Key
        activeKeys =
            R10.Form.Internal.Helpers.getMultiActiveKeys args.key args.formState
    in
    activeKeys
        |> List.map
            (\newKey -> viewEntityMultiSingleRow args newKey entities formConf)
        |> List.concat
        |> (\rows -> rows ++ [ viewEntityMultiLastRow args ])
        |> column [ spacing 10, width fill ]
        |> List.singleton


viewEntityField :
    MakerArgs
    -> R10.Form.Internal.FieldConf.FieldConf
    -> R10.Form.Internal.Conf.Conf
    -> List (Outcome z)
viewEntityField args fieldConf formConf =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            Maybe.withDefault R10.Form.Internal.FieldState.init <|
                R10.Form.Internal.Dict.get args.key args.formState.fieldsState

        focused : Bool
        focused =
            isFocused args.key args.formState.focused

        active : Bool
        active =
            isActive args.key args.formState.active
    in
    --
    -- This is the function that render the "leaf" of the tree, some of
    -- the possible input field (text, password, checkboxes, etc...)
    --
    -- key       = the composed key that describe the position in the tree.
    --             The last section of the key contains the FieldId to lookup
    --             in the configurations.
    -- formState = the state of the entire form
    -- fieldType = type of field, for example: text, email, password, etc.
    --
    let
        args2 : ArgsForFields
        args2 =
            { key = args.key
            , focused = focused
            , active = active
            , fieldState = fieldState
            , fieldConf = fieldConf
            , translator = args.translator args.key
            , style = args.style
            , palette = args.palette
            }

        field : Element (R10.Context.ContextInternal z) R10.Form.Internal.Msg.Msg
        field =
            case fieldConf.type_ of
                R10.FormTypes.TypeText typeText ->
                    case typeText of
                        R10.FormTypes.TextUsernameWithUseEmailCheckbox checkboxLabel ->
                            viewUsernameWithUseEmailCheckbox args args2 checkboxLabel formConf args.formState

                        _ ->
                            viewText args2 typeText formConf

                R10.FormTypes.TypeBinary typeBinary ->
                    viewBinary args2 typeBinary formConf

                R10.FormTypes.TypeSingle typeSingle options ->
                    viewSingle args2 typeSingle options formConf

                R10.FormTypes.TypeMulti _ _ ->
                    text "TODO"

                R10.FormTypes.TypeSpecial typeSpecial ->
                    viewSpecial args2 typeSpecial formConf
    in
    [ field ]


viewEntityTitle :
    R10.Palette.Palette
    -> R10.Form.Internal.Conf.TextConf
    -> List (Outcome z)
viewEntityTitle palette titleConf =
    [ column
        [ spacing 12
        , paddingEach { top = 40, right = 0, bottom = 0, left = 0 }
        , width fill
        ]
        [ paragraph [ R10.FormComponents.Internal.UI.fontSizeTitle ] [ text titleConf.title ]
        , R10.FormComponents.Internal.UI.viewHelperText palette [] titleConf.helperText
        ]
    ]


viewEntitySubTitle :
    R10.Palette.Palette
    -> R10.Form.Internal.Conf.TextConf
    -> List (Outcome z)
viewEntitySubTitle palette titleConf =
    [ column
        [ spacing R10.FormComponents.Internal.UI.genericSpacing
        , width fill
        ]
        [ paragraph [ R10.FormComponents.Internal.UI.fontSizeSubTitle ] [ text titleConf.title ]
        , R10.FormComponents.Internal.UI.viewHelperText palette [ alpha 0.5, Font.size 14, paddingEach { top = R10.FormComponents.Internal.UI.genericSpacing, right = 0, bottom = 0, left = 0 } ] titleConf.helperText
        ]
    ]


addValidationMessagesUnderTheField : MakerArgs -> R10.Form.Internal.Conf.Entity -> List (Element (R10.Context.ContextInternal z) msg) -> List (Element (R10.Context.ContextInternal z) msg)
addValidationMessagesUnderTheField args entity listEl =
    let
        validationIcon : R10.FormTypes.ValidationIcon
        validationIcon =
            getFieldConfig entity
                |> .validationSpecs
                |> Maybe.map .validationIcon
                |> Maybe.withDefault R10.FormTypes.NoIcon

        validationView : List (Element (R10.Context.ContextInternal z) msg)
        validationView =
            [ column [ width fill, height fill ] <|
                listEl
                    ++ [ R10.FormComponents.Internal.Validations.viewValidation args.palette validationIcon <|
                            R10.Form.Internal.Converter.fromFieldStateValidationToComponentValidation
                                (getFieldConfig entity |> .validationSpecs)
                                (R10.Form.Internal.Dict.get args.key args.formState.fieldsState
                                    |> Maybe.withDefault R10.Form.Internal.FieldState.init
                                ).validation
                                (args.translator args.key)
                       ]
            ]
    in
    case entity of
        R10.Form.Internal.Conf.EntityField fieldConf ->
            --
            -- Inside viewUsernameWithUseEmailCheckbox
            --
            if fieldConf.id == defaultUsernameFieldKeyString then
                listEl

            else
                validationView

        _ ->
            validationView



-- ███    ███  █████  ██   ██ ███████ ██████
-- ████  ████ ██   ██ ██  ██  ██      ██   ██
-- ██ ████ ██ ███████ █████   █████   ██████
-- ██  ██  ██ ██   ██ ██  ██  ██      ██   ██
-- ██      ██ ██   ██ ██   ██ ███████ ██   ██


type alias MakerArgs =
    { key : R10.Form.Internal.Key.Key
    , formState : R10.Form.Internal.State.State
    , translator : R10.Form.Internal.Translator.Translator
    , style : R10.FormComponents.Internal.Style.Style
    , palette : R10.Palette.Palette
    }


maker :
    MakerArgs
    -> R10.Form.Internal.Conf.Conf
    -> List (Outcome z)
maker args formConf =
    maker_ args formConf formConf


maker_ :
    MakerArgs
    -> R10.Form.Internal.Conf.Conf
    -> R10.Form.Internal.Conf.Conf
    -> List (Outcome z)
maker_ args branchConf rootFormConf =
    --
    --     This is recursive
    --
    --   ┌─────> maker >─────┐
    --   │                   │
    --   └───────────────────┘
    --
    List.map
        (\entity ->
            (case entity of
                R10.Form.Internal.Conf.EntityWrappable _ entities ->
                    viewEntityWrappable (normalizeKey args entity) entities rootFormConf

                R10.Form.Internal.Conf.EntityWithBorder _ entities ->
                    viewEntityWithBorder (normalizeKey args entity) entities rootFormConf

                R10.Form.Internal.Conf.EntityNormal _ entities ->
                    viewEntityNormal (normalizeKey args entity) entities rootFormConf

                R10.Form.Internal.Conf.EntityWithTabs _ titleEntityList ->
                    viewEntityWithTabs (normalizeKey args entity) titleEntityList rootFormConf

                R10.Form.Internal.Conf.EntityMulti _ entities ->
                    viewEntityMulti (normalizeKey args entity) entities rootFormConf

                R10.Form.Internal.Conf.EntityField fieldConf ->
                    viewEntityField (normalizeKey args entity) fieldConf rootFormConf

                R10.Form.Internal.Conf.EntityTitle _ titleConf ->
                    viewEntityTitle args.palette titleConf

                R10.Form.Internal.Conf.EntitySubTitle _ titleConf ->
                    viewEntitySubTitle args.palette titleConf
            )
                |> addValidationMessagesUnderTheField (normalizeKey args entity) entity
        )
        branchConf
        |> List.concat


normalizeKey : MakerArgs -> R10.Form.Internal.Conf.Entity -> MakerArgs
normalizeKey args entity =
    case entity of
        R10.Form.Internal.Conf.EntityWrappable entityId _ ->
            { args | key = R10.Form.Internal.Key.composeKey args.key entityId }

        R10.Form.Internal.Conf.EntityWithBorder entityId _ ->
            { args | key = R10.Form.Internal.Key.composeKey args.key entityId }

        R10.Form.Internal.Conf.EntityNormal entityId _ ->
            { args | key = R10.Form.Internal.Key.composeKey args.key entityId }

        R10.Form.Internal.Conf.EntityWithTabs entityId _ ->
            { args | key = R10.Form.Internal.Key.composeKey args.key entityId }

        R10.Form.Internal.Conf.EntityMulti entityId _ ->
            { args | key = R10.Form.Internal.Key.composeKey args.key entityId }

        R10.Form.Internal.Conf.EntityField fieldConf ->
            { args | key = R10.Form.Internal.Key.composeKey args.key fieldConf.id }

        R10.Form.Internal.Conf.EntityTitle _ _ ->
            args

        R10.Form.Internal.Conf.EntitySubTitle _ _ ->
            args
