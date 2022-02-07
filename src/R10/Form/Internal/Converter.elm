module R10.Form.Internal.Converter exposing (fromFieldStateValidationToComponentValidation)

import R10.Form.Internal.FieldConf
import R10.Form.Internal.FieldState
import R10.Form.Internal.Translator
import R10.Form.Internal.ValidationCode
import R10.FormComponents.Internal.Validations



--
--  ██████  ██████  ███    ██ ██    ██ ███████ ██████  ████████ ███████ ██████
-- ██      ██    ██ ████   ██ ██    ██ ██      ██   ██    ██    ██      ██   ██
-- ██      ██    ██ ██ ██  ██ ██    ██ █████   ██████     ██    █████   ██████
-- ██      ██    ██ ██  ██ ██  ██  ██  ██      ██   ██    ██    ██      ██   ██
--  ██████  ██████  ██   ████   ████   ███████ ██   ██    ██    ███████ ██   ██
--
--  This module helps to convert stuff from form-recursive to form-components
--
-- TODO - Remove this function and make the two "Validations"
-- (R10.Form.Internal.FieldState.Validation and R10.FormComponents.Internal.Validations.Validation)
-- to be only one


fromFieldStateValidationToComponentValidation :
    Maybe R10.Form.Internal.FieldConf.ValidationSpecs
    -> R10.Form.Internal.FieldState.Validation
    -> (R10.Form.Internal.FieldConf.ValidationCode -> String)
    -> R10.FormComponents.Internal.Validations.ValidationForView
fromFieldStateValidationToComponentValidation maybeValidationSpecs validation translator =
    case validation of
        R10.Form.Internal.FieldState.NotYetValidated ->
            R10.FormComponents.Internal.Validations.PretendIsNotYetValidated

        R10.Form.Internal.FieldState.Validated listValidationOutcome_ ->
            let
                lengthValidationOk : Bool
                lengthValidationOk =
                    List.any
                        (\validationOutcome ->
                            case validationOutcome of
                                R10.Form.Internal.FieldState.MessageOk validationCode _ ->
                                    case validationCode of
                                        "INVALID_LENGTH_TOO_SMALL" ->
                                            True

                                        _ ->
                                            False

                                R10.Form.Internal.FieldState.MessageErr _ _ ->
                                    False
                        )
                        listValidationOutcome_
                        && List.any
                            (\validationOutcome ->
                                case validationOutcome of
                                    R10.Form.Internal.FieldState.MessageOk validationCode _ ->
                                        case validationCode of
                                            "INVALID_LENGTH_TOO_LARGE" ->
                                                True

                                            _ ->
                                                False

                                    R10.Form.Internal.FieldState.MessageErr _ _ ->
                                        False
                            )
                            listValidationOutcome_

                replaceLengthValidation : List R10.Form.Internal.FieldState.ValidationOutcome
                replaceLengthValidation =
                    if lengthValidationOk then
                        List.map
                            (\validationOutcome ->
                                case validationOutcome of
                                    R10.Form.Internal.FieldState.MessageOk validationCode a ->
                                        case validationCode of
                                            "INVALID_LENGTH_TOO_SMALL" ->
                                                R10.Form.Internal.FieldState.MessageOk "CORRECT_LENGTH" a

                                            _ ->
                                                validationOutcome

                                    R10.Form.Internal.FieldState.MessageErr _ _ ->
                                        validationOutcome
                            )
                            listValidationOutcome_

                    else
                        listValidationOutcome_

                listAllButTwoOkMessages : List R10.Form.Internal.FieldState.ValidationOutcome
                listAllButTwoOkMessages =
                    -- 2021.04.04
                    -- Hacky solution here because we need to hide certain validation
                    -- if succesefull also if `showAlsoPassedValidation` is
                    -- set to true. For example "Cannot be blank" and
                    -- "Maximum allowed length is 128 characters"
                    List.filter
                        (\validationOutcome ->
                            case validationOutcome of
                                R10.Form.Internal.FieldState.MessageOk validationCode _ ->
                                    case validationCode of
                                        --
                                        -- Hiding two OK messages:
                                        --
                                        -- * Good, your data is short enough
                                        -- * Good, you typed something that was required
                                        --
                                        "INVALID_LENGTH_TOO_SMALL" ->
                                            False

                                        "INVALID_LENGTH_TOO_LARGE" ->
                                            False

                                        "REQUIRED" ->
                                            False

                                        _ ->
                                            True

                                R10.Form.Internal.FieldState.MessageErr _ _ ->
                                    True
                        )
                        replaceLengthValidation

                listOnlyErrors : List R10.Form.Internal.FieldState.ValidationOutcome
                listOnlyErrors =
                    List.filter
                        (\validationOutcome ->
                            case validationOutcome of
                                R10.Form.Internal.FieldState.MessageOk _ _ ->
                                    False

                                R10.Form.Internal.FieldState.MessageErr _ _ ->
                                    True
                        )
                        listAllButTwoOkMessages

                showAlsoPassedValidation : Bool
                showAlsoPassedValidation =
                    maybeValidationSpecs
                        |> Maybe.map .showAlsoPassedValidation
                        |> Maybe.withDefault False

                pretendIsNotValidatedIfValid : Bool
                pretendIsNotValidatedIfValid =
                    maybeValidationSpecs
                        |> Maybe.map .pretendIsNotValidatedIfValid
                        |> Maybe.withDefault False
            in
            if showAlsoPassedValidation then
                R10.FormComponents.Internal.Validations.Validated <|
                    List.map
                        (\err -> fromValidationOutcomeToValidationMessage err translator)
                        listAllButTwoOkMessages

            else if pretendIsNotValidatedIfValid && List.length listOnlyErrors == 0 then
                R10.FormComponents.Internal.Validations.PretendIsNotYetValidated

            else
                R10.FormComponents.Internal.Validations.Validated <|
                    List.map
                        (\err -> fromValidationOutcomeToValidationMessage err translator)
                        listOnlyErrors


fromValidationOutcomeToValidationMessage :
    R10.Form.Internal.FieldState.ValidationOutcome
    -> (R10.Form.Internal.FieldConf.ValidationCode -> String)
    -> R10.FormComponents.Internal.Validations.ValidationMessage
fromValidationOutcomeToValidationMessage validationOutcome translator =
    case validationOutcome of
        R10.Form.Internal.FieldState.MessageOk validationCode validationPayload ->
            R10.FormComponents.Internal.Validations.MessageOk <|
                R10.Form.Internal.ValidationCode.fromValidationCodeToMessageWithReplacedValues
                    validationCode
                    validationPayload
                    translator

        R10.Form.Internal.FieldState.MessageErr validationCode validationPayload ->
            R10.FormComponents.Internal.Validations.MessageErr <|
                R10.Form.Internal.ValidationCode.fromValidationCodeToMessageWithReplacedValues
                    validationCode
                    validationPayload
                    translator
