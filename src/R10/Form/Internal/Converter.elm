module R10.Form.Internal.Converter exposing (fromFieldStateValidationToComponentValidation)

import R10.Form.Internal.FieldConf
import R10.Form.Internal.FieldState
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
    -> R10.FormComponents.Internal.Validations.Validation
fromFieldStateValidationToComponentValidation maybeValidationSpecs validation translator =
    case validation of
        R10.Form.Internal.FieldState.NotYetValidated ->
            R10.FormComponents.Internal.Validations.NotYetValidated

        R10.Form.Internal.FieldState.Validated listValidationOutcome ->
            let
                listErrValidationOutcome : List R10.Form.Internal.FieldState.ValidationOutcome
                listErrValidationOutcome =
                    List.filter
                        (\validationOutcome ->
                            case validationOutcome of
                                R10.Form.Internal.FieldState.MessageOk _ _ ->
                                    False

                                R10.Form.Internal.FieldState.MessageErr _ _ ->
                                    True
                        )
                        listValidationOutcome

                showPassedValidationMessages : Bool
                showPassedValidationMessages =
                    maybeValidationSpecs
                        |> Maybe.map .showPassedValidationMessages
                        |> Maybe.withDefault False

                hidePassedValidationStyle : Bool
                hidePassedValidationStyle =
                    maybeValidationSpecs
                        |> Maybe.map .hidePassedValidationStyle
                        |> Maybe.withDefault False
            in
            if showPassedValidationMessages then
                R10.FormComponents.Internal.Validations.Validated <|
                    List.map
                        (\err -> fromValidationOutcomeToValidationMessage err translator)
                        listValidationOutcome

            else if hidePassedValidationStyle && List.length listErrValidationOutcome == 0 then
                R10.FormComponents.Internal.Validations.NotYetValidated

            else
                R10.FormComponents.Internal.Validations.Validated <|
                    List.map
                        (\err -> fromValidationOutcomeToValidationMessage err translator)
                        listErrValidationOutcome


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
