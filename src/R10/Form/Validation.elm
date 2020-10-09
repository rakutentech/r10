module R10.Form.Validation exposing
    ( commonValidation
    , validate
    )

import Dict
import R10.Form.FieldConf exposing (Validation(..))
import R10.Form.FieldState exposing (ValidationOutcome(..))
import R10.Form.Key
import R10.Form.State
import R10.Form.ValidationCode exposing (validationCodes)
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


isValid : R10.Form.FieldState.ValidationOutcome -> Bool
isValid outcome =
    case outcome of
        MessageOk _ _ ->
            True

        MessageErr _ _ ->
            False


toMessageOk : R10.Form.FieldState.ValidationOutcome -> R10.Form.FieldState.ValidationOutcome
toMessageOk outcome =
    case outcome of
        MessageOk _ _ ->
            outcome

        MessageErr msg payload ->
            MessageOk msg payload


toMessageErr : R10.Form.FieldState.ValidationOutcome -> R10.Form.FieldState.ValidationOutcome
toMessageErr outcome =
    case outcome of
        MessageOk msg payload ->
            MessageErr msg payload

        MessageErr _ _ ->
            outcome


validateDependant : String -> R10.Form.Key.KeyAsString -> R10.Form.State.State -> Validation -> List R10.Form.FieldState.ValidationOutcome
validateDependant value key formState validation =
    let
        newContextValue : String
        newContextValue =
            Dict.get key formState.fieldsState
                |> Maybe.map .value
                |> Maybe.withDefault ""
    in
    case validation of
        Equal ->
            validateEqual value newContextValue

        _ ->
            validateValidationSpecs newContextValue formState validation


validateAllOf : String -> R10.Form.State.State -> List Validation -> List R10.Form.FieldState.ValidationOutcome
validateAllOf value formState validations =
    List.map (validateValidationSpecs value formState) validations
        |> List.concat


validateOneOf : String -> R10.Form.State.State -> List Validation -> List R10.Form.FieldState.ValidationOutcome
validateOneOf value formState validations =
    let
        messages : List R10.Form.FieldState.ValidationOutcome
        messages =
            List.map (validateValidationSpecs value formState) validations
                |> List.concat
    in
    if List.isEmpty messages then
        []

    else if List.any isValid messages then
        List.map toMessageOk messages

    else
        List.map toMessageErr messages


validateWithMsg : String -> R10.Form.FieldConf.ValidationMessage -> R10.Form.State.State -> Validation -> List R10.Form.FieldState.ValidationOutcome
validateWithMsg value msg formState validation =
    let
        messages : List R10.Form.FieldState.ValidationOutcome
        messages =
            validateValidationSpecs value formState validation
    in
    if List.isEmpty messages then
        []

    else if List.all isValid messages then
        [ MessageOk msg.ok [] ]

    else
        [ MessageErr msg.err [] ]


validateRequired : String -> List R10.Form.FieldState.ValidationOutcome
validateRequired value =
    if String.isEmpty value then
        [ R10.Form.FieldState.MessageErr validationCodes.required [] ]

    else
        [ R10.Form.FieldState.MessageOk validationCodes.required [] ]


validateEqual : String -> String -> List R10.Form.FieldState.ValidationOutcome
validateEqual a b =
    if a == b then
        [ R10.Form.FieldState.MessageOk validationCodes.equalInvalid [] ]

    else
        [ R10.Form.FieldState.MessageErr validationCodes.equalInvalid [] ]


validateMinLength : String -> Int -> List R10.Form.FieldState.ValidationOutcome
validateMinLength value length =
    if String.length value < length then
        [ R10.Form.FieldState.MessageErr validationCodes.lengthTooSmallInvalid [ String.fromInt length ] ]

    else
        [ R10.Form.FieldState.MessageOk validationCodes.lengthTooSmallInvalid [ String.fromInt length ] ]


validateMaxLength : String -> Int -> List R10.Form.FieldState.ValidationOutcome
validateMaxLength value length =
    if String.length value > length then
        [ R10.Form.FieldState.MessageErr validationCodes.lengthTooLargeInvalid [ String.fromInt length ] ]

    else
        [ R10.Form.FieldState.MessageOk validationCodes.lengthTooLargeInvalid [ String.fromInt length ] ]


validateRegex : String -> String -> List R10.Form.FieldState.ValidationOutcome
validateRegex value regex =
    case runRegex regex value of
        Valid ->
            [ R10.Form.FieldState.MessageOk validationCodes.formatInvalid [] ]

        NotValid ->
            [ R10.Form.FieldState.MessageErr validationCodes.formatInvalid [] ]


skipValidationIfEmpty : String -> List R10.Form.FieldState.ValidationOutcome -> List R10.Form.FieldState.ValidationOutcome
skipValidationIfEmpty value validationOutcomes =
    if String.isEmpty value then
        []

    else
        validationOutcomes


validateValidationSpecs : String -> R10.Form.State.State -> Validation -> List R10.Form.FieldState.ValidationOutcome
validateValidationSpecs value formState validation =
    case validation of
        WithMsg msg validation_ ->
            validateWithMsg value msg formState validation_

        Dependant key validation_ ->
            validateDependant value key formState validation_

        OneOf validations ->
            validateOneOf value formState validations

        AllOf validations ->
            validateAllOf value formState validations

        Required ->
            validateRequired value

        Regex regex ->
            skipValidationIfEmpty value <|
                validateRegex value regex

        MinLength length ->
            skipValidationIfEmpty value <|
                validateMinLength value length

        MaxLength length ->
            skipValidationIfEmpty value <|
                validateMaxLength value length

        Equal ->
            []

        NoValidation ->
            []


validate : Maybe R10.Form.FieldConf.ValidationSpecs -> R10.Form.State.State -> R10.Form.FieldState.FieldState -> R10.Form.FieldState.FieldState
validate maybeValidationSpec formState state =
    { state
        | validation =
            R10.Form.FieldState.Validated <|
                validateValidationSpecs state.value
                    formState
                    (maybeValidationSpec |> Maybe.map .validation |> Maybe.withDefault NoValidation)
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
    , url = "^https?:\\/\\/\\w+(\\.\\w+)*(:[0-9]+)?[\\w\\-\\._~:/?#[\\]@!\\$&'\\(\\)\\*\\+,;=.]+$"
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
    }
commonValidation =
    { phoneNumber =
        R10.Form.FieldConf.WithMsg { ok = validationCodes.formatValid, err = validationCodes.formatInvalid } <|
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
    }
