module R10.Form.Internal.Validation exposing
    ( commonValidation
    , validate
    )

import Dict
import R10.Form.Internal.FieldConf exposing (Validation(..))
import R10.Form.Internal.FieldState exposing (ValidationOutcome(..))
import R10.Form.Internal.Key
import R10.Form.Internal.State
import R10.Form.Internal.ValidationCode exposing (validationCodes)
import Regex


type ValidationOutcome
    = Valid
    | NotValid


runRegex : String -> String -> ValidationOutcome
runRegex pattern value =
    case Regex.fromString pattern of
        Just regex ->
            if Regex.contains regex value then
                Valid

            else
                NotValid

        Nothing ->
            -- Regex Not Valid
            NotValid


isValid : R10.Form.Internal.FieldState.ValidationOutcome -> Bool
isValid outcome =
    case outcome of
        MessageOk _ _ ->
            True

        MessageErr _ _ ->
            False


toMessageOk : R10.Form.Internal.FieldState.ValidationOutcome -> R10.Form.Internal.FieldState.ValidationOutcome
toMessageOk outcome =
    case outcome of
        MessageOk _ _ ->
            outcome

        MessageErr msg payload ->
            MessageOk msg payload


toMessageErr : R10.Form.Internal.FieldState.ValidationOutcome -> R10.Form.Internal.FieldState.ValidationOutcome
toMessageErr outcome =
    case outcome of
        MessageOk msg payload ->
            MessageErr msg payload

        MessageErr _ _ ->
            outcome


validateDependant : String -> R10.Form.Internal.Key.KeyAsString -> R10.Form.Internal.State.State -> Validation -> Maybe R10.Form.Internal.FieldState.ValidationOutcome
validateDependant value dependantKey formState validation =
    let
        newKey : R10.Form.Internal.Key.Key
        newKey =
            dependantKey |> R10.Form.Internal.Key.fromString

        newContextValue : String
        newContextValue =
            Dict.get dependantKey formState.fieldsState
                |> Maybe.map .value
                |> Maybe.withDefault ""
    in
    validateValidationSpecs newKey newContextValue formState validation


validateEqual : String -> R10.Form.Internal.Key.KeyAsString -> R10.Form.Internal.State.State -> R10.Form.Internal.FieldState.ValidationOutcome
validateEqual value dependantKey formState =
    let
        dependantValue : String
        dependantValue =
            Dict.get dependantKey formState.fieldsState
                |> Maybe.map .value
                |> Maybe.withDefault ""
    in
    if value == dependantValue then
        R10.Form.Internal.FieldState.MessageOk validationCodes.equalInvalid []

    else
        R10.Form.Internal.FieldState.MessageErr validationCodes.equalInvalid []


validateNot : R10.Form.Internal.Key.Key -> String -> R10.Form.Internal.State.State -> Validation -> Maybe R10.Form.Internal.FieldState.ValidationOutcome
validateNot key value formState validation =
    let
        outcome : Maybe R10.Form.Internal.FieldState.ValidationOutcome
        outcome =
            validateValidationSpecs key value formState validation
    in
    case outcome of
        Just (R10.Form.Internal.FieldState.MessageOk a b) ->
            Just <| R10.Form.Internal.FieldState.MessageErr a b

        Just (R10.Form.Internal.FieldState.MessageErr a b) ->
            Just <| R10.Form.Internal.FieldState.MessageOk a b

        Nothing ->
            Nothing


validateAllOf : R10.Form.Internal.Key.Key -> String -> R10.Form.Internal.State.State -> List Validation -> R10.Form.Internal.FieldState.ValidationOutcome
validateAllOf key value formState validations =
    let
        messages : List R10.Form.Internal.FieldState.ValidationOutcome
        messages =
            List.map (validateValidationSpecs key value formState) validations
                |> List.filterMap identity
    in
    if List.isEmpty messages then
        R10.Form.Internal.FieldState.MessageOk validationCodes.allOf []

    else if List.all isValid messages then
        R10.Form.Internal.FieldState.MessageOk validationCodes.allOf []

    else
        R10.Form.Internal.FieldState.MessageErr validationCodes.allOf []


validateOneOf : R10.Form.Internal.Key.Key -> String -> R10.Form.Internal.State.State -> List Validation -> R10.Form.Internal.FieldState.ValidationOutcome
validateOneOf key value formState validations =
    let
        messages : List R10.Form.Internal.FieldState.ValidationOutcome
        messages =
            List.map (validateValidationSpecs key value formState) validations
                |> List.filterMap identity
    in
    if List.isEmpty messages then
        R10.Form.Internal.FieldState.MessageOk validationCodes.oneOf []

    else if List.any isValid messages then
        R10.Form.Internal.FieldState.MessageOk validationCodes.oneOf []

    else
        R10.Form.Internal.FieldState.MessageErr validationCodes.oneOf []


validateWithMsg : R10.Form.Internal.Key.Key -> String -> R10.Form.Internal.FieldConf.ValidationMessage -> R10.Form.Internal.State.State -> Validation -> Maybe R10.Form.Internal.FieldState.ValidationOutcome
validateWithMsg key value msg formState validation =
    let
        maybeMessage : Maybe R10.Form.Internal.FieldState.ValidationOutcome
        maybeMessage =
            validateValidationSpecs key value formState validation
    in
    case maybeMessage of
        Nothing ->
            Nothing

        Just message ->
            if isValid message then
                Just <| MessageOk msg.ok []

            else
                Just <| MessageErr msg.err []


validateRequired : String -> R10.Form.Internal.FieldState.ValidationOutcome
validateRequired value =
    if String.isEmpty value then
        R10.Form.Internal.FieldState.MessageErr validationCodes.required []

    else
        R10.Form.Internal.FieldState.MessageOk validationCodes.required []


validateEmpty : String -> R10.Form.Internal.FieldState.ValidationOutcome
validateEmpty value =
    if String.isEmpty value then
        R10.Form.Internal.FieldState.MessageOk validationCodes.empty []

    else
        R10.Form.Internal.FieldState.MessageErr validationCodes.empty []


validateMinLength : String -> Int -> R10.Form.Internal.FieldState.ValidationOutcome
validateMinLength value length =
    if String.length value < length then
        R10.Form.Internal.FieldState.MessageErr validationCodes.lengthTooSmallInvalid [ String.fromInt length ]

    else
        R10.Form.Internal.FieldState.MessageOk validationCodes.lengthTooSmallInvalid [ String.fromInt length ]


validateMaxLength : String -> Int -> R10.Form.Internal.FieldState.ValidationOutcome
validateMaxLength value length =
    if String.length value > length then
        R10.Form.Internal.FieldState.MessageErr validationCodes.lengthTooLargeInvalid [ String.fromInt length ]

    else
        R10.Form.Internal.FieldState.MessageOk validationCodes.lengthTooLargeInvalid [ String.fromInt length ]


validateRegex : String -> String -> R10.Form.Internal.FieldState.ValidationOutcome
validateRegex value regex =
    case runRegex regex value of
        Valid ->
            R10.Form.Internal.FieldState.MessageOk validationCodes.formatInvalid []

        NotValid ->
            R10.Form.Internal.FieldState.MessageErr validationCodes.formatInvalid []


skipValidationIfEmpty : String -> R10.Form.Internal.FieldState.ValidationOutcome -> Maybe R10.Form.Internal.FieldState.ValidationOutcome
skipValidationIfEmpty value validationOutcome =
    if String.isEmpty value then
        Nothing

    else
        Just validationOutcome


validateValidationSpecs : R10.Form.Internal.Key.Key -> String -> R10.Form.Internal.State.State -> Validation -> Maybe R10.Form.Internal.FieldState.ValidationOutcome
validateValidationSpecs key value formState validation =
    case validation of
        WithMsg msg validation_ ->
            validateWithMsg key value msg formState validation_

        Dependant dependantKey validation_ ->
            validateDependant value dependantKey formState validation_

        OneOf validations ->
            Just <| validateOneOf key value formState validations

        AllOf validations ->
            Just <| validateAllOf key value formState validations

        Required ->
            Just <| validateRequired value

        Empty ->
            Just <| validateEmpty value

        Regex regex ->
            skipValidationIfEmpty value <|
                validateRegex value regex

        MinLength length ->
            skipValidationIfEmpty value <|
                validateMinLength value length

        MaxLength length ->
            skipValidationIfEmpty value <|
                validateMaxLength value length

        Equal dependantKey ->
            skipValidationIfEmpty value <|
                validateEqual value dependantKey formState

        Not validation_ ->
            validateNot key value formState validation_

        NoValidation ->
            Nothing


validate : R10.Form.Internal.Key.Key -> Maybe R10.Form.Internal.FieldConf.ValidationSpecs -> R10.Form.Internal.State.State -> R10.Form.Internal.FieldState.FieldState -> R10.Form.Internal.FieldState.FieldState
validate key maybeValidationSpec formState state =
    { state
        | validation =
            (maybeValidationSpec |> Maybe.map .validation |> Maybe.withDefault [ NoValidation ])
                |> List.map (validateValidationSpecs key state.value formState)
                |> List.filterMap identity
                |> R10.Form.Internal.FieldState.Validated
    }



-- ██████  ██    ██ ██      ███████ ███████
-- ██   ██ ██    ██ ██      ██      ██
-- ██████  ██    ██ ██      █████   ███████
-- ██   ██ ██    ██ ██      ██           ██
-- ██   ██  ██████  ███████ ███████ ███████


commonRegularExpression :
    { alpha : String
    , alphaNumeric : String
    , alphaNumericDash : String
    , alphaNumericDashSpace : String
    , phoneNumber : String
    , email : String
    , numeric : String
    , integer : String
    , decimal : String
    , url : String
    , hexColor : String
    }
commonRegularExpression =
    { alpha = "^[a-zA-Z]*$"
    , alphaNumeric = "^[a-zA-Z0-9]*$"
    , alphaNumericDash = "^[A-Za-z0-9_.-]*$"
    , alphaNumericDashSpace = "^[A-Za-z0-9_.-\\s]*$"
    , phoneNumber = "^\\+?[1-9]\\d+$"
    , email = "^[\\u0021\\u0023-\\u0027\\u002B\\u002D-\\u0039\\u003D\\u003F\\u0041-\\u005A\\u005E-\\u007E]+@[\\u002D\\u0030-\\u0039\\u0041-\\u005A\\u0061-\\u007A]+(\\.[\\u002D\\u0030-\\u0039\\u0041-\\u005A\\u0061-\\u007A]+)+$"
    , numeric = "^([0-9]+)$"
    , integer = "^\\d+$"
    , decimal = "^-?\\d*(\\.\\d+)?$"
    , url = "^[\\.\\-\\+\\w]*?:\\/\\/\\w+(\\.\\w+)*(:[0-9]+)?[\\w\\-\\._~:\\/?#[\\]@!\\$&'\\(\\)\\*\\+,;=.]+$"
    , hexColor = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
    }


commonValidation :
    { alphaNumericDash : Validation
    , alphaNumericDashSpace : Validation
    , email : Validation
    , hexColor : Validation
    , password : Validation
    , phoneNumber : Validation
    , url : Validation
    , numeric : Validation
    }
commonValidation =
    { phoneNumber =
        R10.Form.Internal.FieldConf.WithMsg { ok = validationCodes.formatValid, err = validationCodes.formatInvalid } <|
            Regex commonRegularExpression.phoneNumber
    , email =
        WithMsg { ok = validationCodes.emailFormatInvalid, err = validationCodes.emailFormatInvalid } <|
            Regex commonRegularExpression.email
    , password =
        AllOf
            [ WithMsg { ok = validationCodes.formatNoUppercaseInvalid, err = validationCodes.formatNoUppercaseInvalid } <|
                Regex "[A-Z]"
            , WithMsg { ok = validationCodes.formatNoNumberInvalid, err = validationCodes.formatNoNumberInvalid } <|
                Regex "[0-9]"
            , WithMsg { ok = validationCodes.formatNoSpecialCharactersInvalid, err = validationCodes.formatNoSpecialCharactersInvalid } <|
                Regex "[~!@#$%^&*()_+|}{\\[\\]|\\><?:\\\";',./=-]"
            ]
    , alphaNumericDash =
        WithMsg { ok = validationCodes.formatValid, err = validationCodes.formatInvalid } <|
            Regex commonRegularExpression.alphaNumericDash
    , alphaNumericDashSpace =
        WithMsg { ok = validationCodes.formatValid, err = validationCodes.formatInvalid } <|
            Regex commonRegularExpression.alphaNumericDashSpace
    , url =
        WithMsg { ok = validationCodes.formatValid, err = validationCodes.formatInvalid } <|
            Regex commonRegularExpression.url
    , hexColor =
        WithMsg { ok = validationCodes.hexColorFormatInvalid, err = validationCodes.hexColorFormatInvalid } <|
            Regex commonRegularExpression.hexColor
    , numeric =
        WithMsg { ok = validationCodes.formatValid, err = validationCodes.formatInvalid } <|
            Regex commonRegularExpression.numeric
    }
