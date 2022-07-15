module R10.Form.Internal.Validation exposing
    ( commonRegularExpression
    , commonValidation
    , validate
    )

import Dict
import R10.Country
import R10.Form.Internal.Dict
import R10.Form.Internal.FieldConf
import R10.Form.Internal.FieldState
import R10.Form.Internal.Helpers
import R10.Form.Internal.Key
import R10.Form.Internal.Shared
import R10.Form.Internal.State
import R10.Form.Internal.Translator
import R10.FormTypes
import R10.ValidationDate
import Regex


type ValidationOutcome
    = Valid
    | NotValid


runRegex : String -> String -> ValidationOutcome
runRegex pattern value =
    let
        regex =
            Maybe.withDefault Regex.never <| Regex.fromString pattern
    in
    if Regex.contains regex value then
        Valid

    else
        NotValid


isValid : R10.Form.Internal.FieldState.ValidationOutcome -> Bool
isValid outcome =
    case outcome of
        R10.Form.Internal.FieldState.MessageOk _ _ ->
            True

        R10.Form.Internal.FieldState.MessageErr _ _ ->
            False


validateDependant :
    Bool
    -> R10.Form.Internal.Key.Key
    -> R10.Form.Internal.Key.KeyAsString
    -> R10.Form.Internal.State.State
    -> R10.Form.Internal.FieldConf.Validation
    -> Maybe R10.Form.Internal.FieldState.ValidationOutcome
validateDependant showAlsoPassedValidation key dependantKey formState validation =
    let
        newLeafKey : R10.Form.Internal.Key.Key
        newLeafKey =
            R10.Form.Internal.Key.replaceLeaf dependantKey key

        newFullKey : R10.Form.Internal.Key.Key
        newFullKey =
            dependantKey |> R10.Form.Internal.Key.fromString

        -- newContextValue : String
        -- newContextValue =
        --     Dict.get dependantKey formState.fieldsState
        --         |> Maybe.map .value
        --         |> Maybe.withDefault ""
        newLeafContextValue : Maybe ( String, R10.Form.Internal.Key.Key )
        newLeafContextValue =
            formState.fieldsState
                |> Dict.get (newLeafKey |> R10.Form.Internal.Key.toString)
                |> Maybe.map (\rec -> ( rec.value, newLeafKey ))

        newFullContextValue : Maybe ( String, R10.Form.Internal.Key.Key )
        newFullContextValue =
            formState.fieldsState
                |> Dict.get (newFullKey |> R10.Form.Internal.Key.toString)
                |> Maybe.map (\rec -> ( rec.value, newFullKey ))

        defaultContextValue : ( String, R10.Form.Internal.Key.Key )
        defaultContextValue =
            ( "", newFullKey )

        result =
            newLeafContextValue
                |> Maybe.withDefault
                    (newFullContextValue
                        |> Maybe.withDefault defaultContextValue
                    )
    in
    result
        |> (\( newContextValue, newKey ) ->
                validateValidationSpecs "validateDependant" showAlsoPassedValidation newKey newContextValue formState validation
           )


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
        R10.Form.Internal.FieldState.MessageOk R10.Form.Internal.Translator.validationCodes.equalInvalid []

    else
        R10.Form.Internal.FieldState.MessageErr R10.Form.Internal.Translator.validationCodes.equalInvalid []


validateNot : Bool -> R10.Form.Internal.Key.Key -> String -> R10.Form.Internal.State.State -> R10.Form.Internal.FieldConf.Validation -> Maybe R10.Form.Internal.FieldState.ValidationOutcome
validateNot showAlsoPassedValidation key value formState validation =
    let
        outcome : Maybe R10.Form.Internal.FieldState.ValidationOutcome
        outcome =
            validateValidationSpecs "validateNot" showAlsoPassedValidation key value formState validation
    in
    case outcome of
        Just (R10.Form.Internal.FieldState.MessageOk a b) ->
            Just <| R10.Form.Internal.FieldState.MessageErr a b

        Just (R10.Form.Internal.FieldState.MessageErr a b) ->
            Just <| R10.Form.Internal.FieldState.MessageOk a b

        Nothing ->
            Nothing


validateAllOf : Bool -> R10.Form.Internal.Key.Key -> String -> R10.Form.Internal.State.State -> List R10.Form.Internal.FieldConf.Validation -> R10.Form.Internal.FieldState.ValidationOutcome
validateAllOf showAlsoPassedValidation key value formState validations =
    let
        messages : List R10.Form.Internal.FieldState.ValidationOutcome
        messages =
            List.map (validateValidationSpecs "validateAllOf" showAlsoPassedValidation key value formState) validations
                |> List.filterMap identity
    in
    if List.isEmpty messages then
        R10.Form.Internal.FieldState.MessageOk R10.Form.Internal.Translator.validationCodes.allOf []

    else if List.all isValid messages then
        R10.Form.Internal.FieldState.MessageOk R10.Form.Internal.Translator.validationCodes.allOf []

    else
        R10.Form.Internal.FieldState.MessageErr R10.Form.Internal.Translator.validationCodes.allOf []


validateOneOf : Bool -> R10.Form.Internal.Key.Key -> String -> R10.Form.Internal.State.State -> List R10.Form.Internal.FieldConf.Validation -> R10.Form.Internal.FieldState.ValidationOutcome
validateOneOf showAlsoPassedValidation key value formState validations =
    let
        messages : List R10.Form.Internal.FieldState.ValidationOutcome
        messages =
            List.map (validateValidationSpecs "validateOneOf" showAlsoPassedValidation key value formState) validations
                |> List.filterMap identity
    in
    if List.isEmpty messages then
        R10.Form.Internal.FieldState.MessageOk R10.Form.Internal.Translator.validationCodes.oneOf []

    else if List.any isValid messages then
        R10.Form.Internal.FieldState.MessageOk R10.Form.Internal.Translator.validationCodes.oneOf []

    else
        R10.Form.Internal.FieldState.MessageErr R10.Form.Internal.Translator.validationCodes.oneOf []


validateWithMsg : Bool -> R10.Form.Internal.Key.Key -> String -> R10.Form.Internal.FieldConf.ValidationMessage -> R10.Form.Internal.State.State -> R10.Form.Internal.FieldConf.Validation -> Maybe R10.Form.Internal.FieldState.ValidationOutcome
validateWithMsg showAlsoPassedValidation key value msg formState validation =
    let
        maybeMessage : Maybe R10.Form.Internal.FieldState.ValidationOutcome
        maybeMessage =
            validateValidationSpecs "validateWithMsg" showAlsoPassedValidation key value formState validation
    in
    case maybeMessage of
        Nothing ->
            Nothing

        Just message ->
            if isValid message then
                Just <| R10.Form.Internal.FieldState.MessageOk msg.ok []

            else
                Just <| R10.Form.Internal.FieldState.MessageErr msg.err []


validateRequired : String -> R10.Form.Internal.FieldState.ValidationOutcome
validateRequired value =
    if String.isEmpty value then
        R10.Form.Internal.FieldState.MessageErr R10.Form.Internal.Translator.validationCodes.required []

    else
        R10.Form.Internal.FieldState.MessageOk R10.Form.Internal.Translator.validationCodes.required []


validateEmpty : String -> R10.Form.Internal.FieldState.ValidationOutcome
validateEmpty value =
    if String.isEmpty value then
        R10.Form.Internal.FieldState.MessageOk R10.Form.Internal.Translator.validationCodes.empty []

    else
        R10.Form.Internal.FieldState.MessageErr R10.Form.Internal.Translator.validationCodes.empty []


validateMinLength : String -> Int -> R10.Form.Internal.FieldState.ValidationOutcome
validateMinLength value length =
    if String.length value < length then
        R10.Form.Internal.FieldState.MessageErr R10.Form.Internal.Translator.validationCodes.lengthTooSmallInvalid [ String.fromInt length ]

    else
        R10.Form.Internal.FieldState.MessageOk R10.Form.Internal.Translator.validationCodes.lengthTooSmallInvalid [ String.fromInt length ]


validateMaxLength : String -> Int -> R10.Form.Internal.FieldState.ValidationOutcome
validateMaxLength value length =
    if String.length value > length then
        R10.Form.Internal.FieldState.MessageErr R10.Form.Internal.Translator.validationCodes.lengthTooLargeInvalid [ String.fromInt length ]

    else
        R10.Form.Internal.FieldState.MessageOk R10.Form.Internal.Translator.validationCodes.lengthTooLargeInvalid [ String.fromInt length ]


validateRegex : String -> String -> R10.Form.Internal.FieldState.ValidationOutcome
validateRegex value regex =
    case runRegex regex value of
        Valid ->
            R10.Form.Internal.FieldState.MessageOk R10.Form.Internal.Translator.validationCodes.formatInvalid []

        NotValid ->
            R10.Form.Internal.FieldState.MessageErr R10.Form.Internal.Translator.validationCodes.formatInvalid []


skipValidationIfEmpty :
    String
    -> Bool
    -> R10.Form.Internal.FieldState.ValidationOutcome
    -> Maybe R10.Form.Internal.FieldState.ValidationOutcome
skipValidationIfEmpty value showAlsoPassedValidation validationOutcome =
    if showAlsoPassedValidation then
        -- Password field is probably the only field that have
        -- showAlsoPassedValidation set to True.
        -- In this case we don't hide the validations also if the value
        -- is empty
        Just validationOutcome

    else if String.isEmpty value then
        Nothing

    else
        Just validationOutcome


validateDateRange :
    R10.ValidationDate.Range
    -> String
    -> Maybe R10.Form.Internal.FieldState.ValidationOutcome
validateDateRange range value =
    let
        v : Result R10.ValidationDate.RangeResult Int
        v =
            R10.ValidationDate.range range value
    in
    if String.isEmpty value then
        Nothing

    else
        case v of
            Ok _ ->
                Just <| R10.Form.Internal.FieldState.MessageOk R10.Form.Internal.Translator.validationCodes.formatInvalid []

            Err err ->
                let
                    invalid : Maybe R10.Form.Internal.FieldState.ValidationOutcome
                    invalid =
                        Just <| R10.Form.Internal.FieldState.MessageErr R10.Form.Internal.Translator.validationCodes.formatInvalid []
                in
                case err of
                    R10.ValidationDate.TooOld ->
                        -- Out of range
                        invalid

                    R10.ValidationDate.TooNew ->
                        -- Out of range
                        invalid

                    R10.ValidationDate.MinRangeNotValid ->
                        -- Should never happen
                        invalid

                    R10.ValidationDate.MaxRangeNotValid ->
                        -- Should never happen
                        invalid

                    R10.ValidationDate.InvertedMinMax ->
                        -- Should never happen
                        invalid

                    R10.ValidationDate.Need8Digits ->
                        -- Not 8 digits
                        invalid

                    R10.ValidationDate.ParsingError _ ->
                        -- Invalid
                        invalid


validateValidationSpecs :
    String
    -> Bool
    -> R10.Form.Internal.Key.Key
    -> String
    -> R10.Form.Internal.State.State
    -> R10.Form.Internal.FieldConf.Validation
    -> Maybe R10.Form.Internal.FieldState.ValidationOutcome
validateValidationSpecs _ showAlsoPassedValidation key value_ formState validation =
    let
        value =
            -- Temporary fix for https://jira.rakuten-it.com/jira/browse/OMN-3277
            -- Chrome is trimming this field in the browser, bot other
            -- browsers don't do this
            if R10.Form.Internal.Key.toString key == "email" then
                String.trim value_

            else
                value_
    in
    case validation of
        R10.Form.Internal.FieldConf.WithMsg msg validation_ ->
            validateWithMsg showAlsoPassedValidation key value msg formState validation_

        R10.Form.Internal.FieldConf.Dependant dependantKey validation_ ->
            validateDependant showAlsoPassedValidation key dependantKey formState validation_

        R10.Form.Internal.FieldConf.OneOf validations ->
            Just <| validateOneOf showAlsoPassedValidation key value formState validations

        R10.Form.Internal.FieldConf.AllOf validations ->
            Just <| validateAllOf showAlsoPassedValidation key value formState validations

        R10.Form.Internal.FieldConf.Required ->
            if showAlsoPassedValidation then
                -- Hiding the "Required" validation in case it is a password
                -- field
                Nothing

            else
                Just <| validateRequired value

        R10.Form.Internal.FieldConf.Empty ->
            Just <| validateEmpty value

        R10.Form.Internal.FieldConf.Regex regex ->
            skipValidationIfEmpty value showAlsoPassedValidation <|
                validateRegex value regex

        R10.Form.Internal.FieldConf.MinLength length ->
            skipValidationIfEmpty value showAlsoPassedValidation <|
                validateMinLength value length

        R10.Form.Internal.FieldConf.MaxLength length ->
            skipValidationIfEmpty value showAlsoPassedValidation <|
                validateMaxLength value length

        R10.Form.Internal.FieldConf.Equal dependantKey ->
            skipValidationIfEmpty value showAlsoPassedValidation <|
                validateEqual value dependantKey formState

        R10.Form.Internal.FieldConf.Not validation_ ->
            validateNot showAlsoPassedValidation key value formState validation_

        R10.Form.Internal.FieldConf.NoValidation ->
            Nothing

        R10.Form.Internal.FieldConf.DateRange range ->
            validateDateRange range value


punydecodeIfEmail : R10.FormTypes.FieldType -> String -> String
punydecodeIfEmail fieldType value =
    case fieldType of
        R10.FormTypes.TypeText R10.FormTypes.TextEmail ->
            R10.Form.Internal.Helpers.punyDecode value

        R10.FormTypes.TypeText R10.FormTypes.TextMobileEmail ->
            R10.Form.Internal.Helpers.punyDecode value

        R10.FormTypes.TypeText (R10.FormTypes.TextEmailWithSuggestions _) ->
            R10.Form.Internal.Helpers.punyDecode value

        _ ->
            value


cleanPhoneNumber : R10.FormTypes.FieldType -> String -> String
cleanPhoneNumber fieldType value =
    case fieldType of
        R10.FormTypes.TypeSpecial (R10.FormTypes.SpecialPhone _) ->
            R10.Form.Internal.Helpers.cleanPhoneNumber value

        _ ->
            value


validate :
    { formStateBeforeValidationFixer : String -> String -> String
    , showAlsoPassedValidation : Bool
    , key : R10.Form.Internal.Key.Key
    , fieldType : R10.FormTypes.FieldType
    , maybeValidationSpec : Maybe R10.Form.Internal.FieldConf.ValidationSpecs
    , formState : R10.Form.Internal.State.State
    }
    -> R10.Form.Internal.FieldState.FieldState
    -> R10.Form.Internal.FieldState.FieldState
validate args fieldState =
    --
    -- "formStateBeforeValidationFixer" is a function used to fix the values of
    -- fields before the validation is applied, but those values should be then
    -- discarded. For example keeping only the numeric digits of a field before
    -- a validation that require only digits.
    --
    -- This trick is necessary because the validation from the back-end is too
    -- strict and doesn't allow the user to freely type stuff.
    --
    -- Ideally these hacks should be done in the validation from the server and
    -- this function should became unnecessary.
    --
    -- This same function is used to change the values before submission.
    --
    -- QUESTION - Why do we have both formState and fieldState here?
    --
    -- QUESTION - Do we need to fix also fieldState?
    --
    -- TODO - Before running the validation, we should change the values (formState?)
    -- Should it be part of the formConf? But it cannot be serialized
    --
    -- Flow.formStateBeforeValidationFixer.fix : { fieldIdAsString : String, value : String } -> String
    --
    let
        newFormState : R10.Form.Internal.State.State
        newFormState =
            --
            -- I am not sure if this part is needed?
            -- Maybe only for validation of fields based on other fields
            -- like "Confirm your password"
            --
            -- let
            --     fieldsState =
            --         formState.fieldsState
            --             |> Dict.toList
            --             |> List.map (f formStateBeforeValidationFixer)
            --             |> Dict.fromList
            -- in
            -- { formState | fieldsState = fieldsState }
            --
            args.formState

        newValue : String
        newValue =
            fieldState.value
                |> punydecodeIfEmail args.fieldType
                |> cleanPhoneNumber args.fieldType
                |> args.formStateBeforeValidationFixer (R10.Form.Internal.Key.headId args.key)

        isDisabled : Bool
        isDisabled =
            R10.Form.Internal.Dict.get args.key newFormState.fieldsState
                |> Maybe.map .disabled
                |> Maybe.withDefault False

        skipValidateForUsername : Bool
        skipValidateForUsername =
            R10.Form.Internal.Key.toString args.key
                == R10.Form.Internal.Shared.defaultUsernameFieldKeyString
                && (R10.Form.Internal.Dict.get R10.Form.Internal.Shared.copyEmailIntoUsernameCheckboxKey newFormState.fieldsState
                        |> Maybe.map (\fs -> R10.Form.Internal.Helpers.stringToBool fs.value)
                        |> Maybe.withDefault False
                   )

        -- skipValidateIfFieldIsOptionalAndEmpty : Bool
        -- skipValidateIfFieldIsOptionalAndEmpty =
        --     let
        --         _ =
        --             Debug.log "xxx23" ( skip, args.key )
        --
        --         skip =
        --             not (isRequired args.maybeValidationSpec) && String.isEmpty fieldState.value
        --     in
        --     skip
        --
        validationSpec : List R10.Form.Internal.FieldConf.Validation
        validationSpec =
            if
                isDisabled
                    || skipValidateForUsername
                -- || skipValidateIfFieldIsOptionalAndEmpty
            then
                [ R10.Form.Internal.FieldConf.NoValidation ]

            else
                args.maybeValidationSpec
                    |> Maybe.map .validation
                    |> Maybe.withDefault [ R10.Form.Internal.FieldConf.NoValidation ]

        isJapanTelCode : Bool
        isJapanTelCode =
            newValue
                |> R10.Country.fromTelephoneAsString
                |> Maybe.map R10.Country.toCountryTelCode
                |> Maybe.andThen R10.Country.fromCountryTelCode
                |> Maybe.map (\country -> country == R10.Country.Japan)
                |> Maybe.withDefault False

        changeValidationSpecIfJapanPohone : List R10.Form.Internal.FieldConf.Validation -> List R10.Form.Internal.FieldConf.Validation
        changeValidationSpecIfJapanPohone =
            -- https://jira.rakuten-it.com/jira/browse/OMN-5708
            -- use this to change fields minLength when selected Japan
            case ( args.fieldType, isJapanTelCode ) of
                ( R10.FormTypes.TypeSpecial (R10.FormTypes.SpecialPhone specialPhone), True ) ->
                    -- https://jira.rakuten-it.com/jira/browse/OMN-5904
                    -- change validation rule only for JapanService
                    if specialPhone.isJapanService then
                        List.map
                            (\vi ->
                                case vi of
                                    R10.Form.Internal.FieldConf.MinLength _ ->
                                        R10.Form.Internal.FieldConf.MinLength 13

                                    _ ->
                                        vi
                            )

                    else
                        identity

                _ ->
                    identity
    in
    { fieldState
        | validation =
            validationSpec
                |> changeValidationSpecIfJapanPohone
                |> List.map
                    (validateValidationSpecs
                        "validate"
                        args.showAlsoPassedValidation
                        args.key
                        newValue
                        newFormState
                    )
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

    -- https://jira.rakuten-it.com/jira/browse/OMN-5432
    -- https://jira.rakuten-it.com/jira/browse/OMN-5456
    , email = "^(?!\\.)(?!.*\\.\\.)[~!#-&+\\--9=?A-Z^-z|]*(?!\\.)[~!#-&+\\--9=?A-Z^-z|]@[-0-9A-Za-z]+(\\.[-0-9A-Za-z]+)*(\\.[-0-9A-Za-z]{2,})$"
    , numeric = "^([0-9]+)$"
    , integer = "^\\d+$"
    , decimal = "^-?\\d*(\\.\\d+)?$"
    , url = "^[\\.\\-\\+\\w]*?:\\/\\/\\w+(\\.\\w+)*(:[0-9]+)?[\\w\\-\\._~:\\/?#[\\]@!\\$&'\\(\\)\\*\\+,;=.]+$"
    , hexColor = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
    }


commonValidation :
    { alphaNumericDash : R10.Form.Internal.FieldConf.Validation
    , alphaNumericDashSpace : R10.Form.Internal.FieldConf.Validation
    , email : R10.Form.Internal.FieldConf.Validation
    , hexColor : R10.Form.Internal.FieldConf.Validation
    , password : R10.Form.Internal.FieldConf.Validation
    , phoneNumber : R10.Form.Internal.FieldConf.Validation
    , url : R10.Form.Internal.FieldConf.Validation
    , numeric : R10.Form.Internal.FieldConf.Validation
    }
commonValidation =
    { phoneNumber =
        R10.Form.Internal.FieldConf.WithMsg { ok = R10.Form.Internal.Translator.validationCodes.formatValid, err = R10.Form.Internal.Translator.validationCodes.formatInvalid } <|
            R10.Form.Internal.FieldConf.Regex commonRegularExpression.phoneNumber
    , email =
        R10.Form.Internal.FieldConf.WithMsg { ok = R10.Form.Internal.Translator.validationCodes.emailFormatInvalid, err = R10.Form.Internal.Translator.validationCodes.emailFormatInvalid } <|
            R10.Form.Internal.FieldConf.Regex commonRegularExpression.email
    , password =
        R10.Form.Internal.FieldConf.AllOf
            [ R10.Form.Internal.FieldConf.WithMsg { ok = R10.Form.Internal.Translator.validationCodes.formatNoUppercaseInvalid, err = R10.Form.Internal.Translator.validationCodes.formatNoUppercaseInvalid } <|
                R10.Form.Internal.FieldConf.Regex "[A-Z]"
            , R10.Form.Internal.FieldConf.WithMsg { ok = R10.Form.Internal.Translator.validationCodes.formatNoNumberInvalid, err = R10.Form.Internal.Translator.validationCodes.formatNoNumberInvalid } <|
                R10.Form.Internal.FieldConf.Regex "[0-9]"
            , R10.Form.Internal.FieldConf.WithMsg { ok = R10.Form.Internal.Translator.validationCodes.formatNoSpecialCharactersInvalid, err = R10.Form.Internal.Translator.validationCodes.formatNoSpecialCharactersInvalid } <|
                R10.Form.Internal.FieldConf.Regex "[~!@#$%^&*()_+|}{\\[\\]|\\><?:\\\";',./=-]"
            ]
    , alphaNumericDash =
        R10.Form.Internal.FieldConf.WithMsg { ok = R10.Form.Internal.Translator.validationCodes.formatValid, err = R10.Form.Internal.Translator.validationCodes.formatInvalid } <|
            R10.Form.Internal.FieldConf.Regex commonRegularExpression.alphaNumericDash
    , alphaNumericDashSpace =
        R10.Form.Internal.FieldConf.WithMsg { ok = R10.Form.Internal.Translator.validationCodes.formatValid, err = R10.Form.Internal.Translator.validationCodes.formatInvalid } <|
            R10.Form.Internal.FieldConf.Regex commonRegularExpression.alphaNumericDashSpace
    , url =
        R10.Form.Internal.FieldConf.WithMsg { ok = R10.Form.Internal.Translator.validationCodes.formatValid, err = R10.Form.Internal.Translator.validationCodes.formatInvalid } <|
            R10.Form.Internal.FieldConf.Regex commonRegularExpression.url
    , hexColor =
        R10.Form.Internal.FieldConf.WithMsg { ok = R10.Form.Internal.Translator.validationCodes.hexColorFormatInvalid, err = R10.Form.Internal.Translator.validationCodes.hexColorFormatInvalid } <|
            R10.Form.Internal.FieldConf.Regex commonRegularExpression.hexColor
    , numeric =
        R10.Form.Internal.FieldConf.WithMsg { ok = R10.Form.Internal.Translator.validationCodes.formatValid, err = R10.Form.Internal.Translator.validationCodes.formatInvalid } <|
            R10.Form.Internal.FieldConf.Regex commonRegularExpression.numeric
    }
