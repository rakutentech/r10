module R10.Form.Converter exposing
    ( binaryTypeFromFieldConfToComponent
    , fromFieldStateValidationToComponentValidation
    , fromFormValidationIconToComponentValidationIcon
    , singleTypeFromFieldConfToComponent
    , textTypeFromFieldConfToComponent
    )

import R10.Form.FieldConf
import R10.Form.FieldState
import R10.Form.ValidationCode
import R10.FormComponents.Binary
import R10.FormComponents.Single.Common
import R10.FormComponents.Text
import R10.FormComponents.Validations



--
--  ██████  ██████  ███    ██ ██    ██ ███████ ██████  ████████ ███████ ██████
-- ██      ██    ██ ████   ██ ██    ██ ██      ██   ██    ██    ██      ██   ██
-- ██      ██    ██ ██ ██  ██ ██    ██ █████   ██████     ██    █████   ██████
-- ██      ██    ██ ██  ██ ██  ██  ██  ██      ██   ██    ██    ██      ██   ██
--  ██████  ██████  ██   ████   ████   ███████ ██   ██    ██    ███████ ██   ██
--
--  This module R10.helps to convert stuff from form-recursive to form-components
--


binaryTypeFromFieldConfToComponent : R10.Form.FieldConf.TypeBinary -> R10.FormComponents.Binary.TypeBinary
binaryTypeFromFieldConfToComponent typeText =
    case typeText of
        R10.Form.FieldConf.BinaryCheckbox ->
            R10.FormComponents.Binary.BinaryCheckbox

        R10.Form.FieldConf.BinarySwitch ->
            R10.FormComponents.Binary.BinarySwitch


singleTypeFromFieldConfToComponent : R10.Form.FieldConf.TypeSingle -> R10.FormComponents.Single.Common.TypeSingle
singleTypeFromFieldConfToComponent typeText =
    case typeText of
        R10.Form.FieldConf.SingleRadio ->
            R10.FormComponents.Single.Common.SingleRadio

        R10.Form.FieldConf.SingleCombobox ->
            R10.FormComponents.Single.Common.SingleCombobox


textTypeFromFieldConfToComponent : R10.Form.FieldConf.TypeText -> R10.FormComponents.Text.TextType
textTypeFromFieldConfToComponent typeText =
    case typeText of
        R10.Form.FieldConf.TextPlain ->
            R10.FormComponents.Text.TextPlain

        R10.Form.FieldConf.TextUsername ->
            R10.FormComponents.Text.TextUsername

        R10.Form.FieldConf.TextEmail ->
            R10.FormComponents.Text.TextEmail

        R10.Form.FieldConf.TextPasswordCurrent ->
            R10.FormComponents.Text.TextPasswordCurrent

        R10.Form.FieldConf.TextPasswordNew ->
            R10.FormComponents.Text.TextPasswordNew

        R10.Form.FieldConf.TextMultiline ->
            R10.FormComponents.Text.TextMultiline

        R10.Form.FieldConf.TextWithPattern pattern ->
            R10.FormComponents.Text.TextWithPattern pattern


fromFormValidationIconToComponentValidationIcon : R10.Form.FieldConf.ValidationIcon -> R10.FormComponents.Validations.ValidationIcon
fromFormValidationIconToComponentValidationIcon formIcon =
    case formIcon of
        R10.Form.FieldConf.NoIcon ->
            R10.FormComponents.Validations.NoIcon

        R10.Form.FieldConf.ClearOrCheck ->
            R10.FormComponents.Validations.ClearOrCheck

        R10.Form.FieldConf.ErrorOrCheck ->
            R10.FormComponents.Validations.ErrorOrCheck


fromFieldStateValidationToComponentValidation :
    Maybe R10.Form.FieldConf.ValidationSpecs
    -> R10.Form.FieldState.Validation
    -> (R10.Form.FieldConf.ValidationCode -> String)
    -> R10.FormComponents.Validations.Validation
fromFieldStateValidationToComponentValidation maybeValidationSpecs validation translator =
    case validation of
        R10.Form.FieldState.NotYetValidated ->
            R10.FormComponents.Validations.NotYetValidated

        R10.Form.FieldState.Validated listValidationOutcome ->
            let
                listErrValidationOutcome : List R10.Form.FieldState.ValidationOutcome
                listErrValidationOutcome =
                    List.filter
                        (\validationOutcome ->
                            case validationOutcome of
                                R10.Form.FieldState.MessageOk _ _ ->
                                    False

                                R10.Form.FieldState.MessageErr _ _ ->
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
                R10.FormComponents.Validations.Validated <|
                    List.map
                        (\a -> fromValidationOutcomeToValidationMessage a translator)
                        listValidationOutcome

            else if hidePassedValidationStyle && List.length listErrValidationOutcome == 0 then
                R10.FormComponents.Validations.NotYetValidated

            else
                R10.FormComponents.Validations.Validated <|
                    List.map
                        (\err -> fromValidationOutcomeToValidationMessage err translator)
                        listErrValidationOutcome


fromValidationOutcomeToValidationMessage :
    R10.Form.FieldState.ValidationOutcome
    -> (R10.Form.FieldConf.ValidationCode -> String)
    -> R10.FormComponents.Validations.ValidationMessage
fromValidationOutcomeToValidationMessage validationOutcome translator =
    case validationOutcome of
        R10.Form.FieldState.MessageOk validationCode validationPayload ->
            R10.FormComponents.Validations.MessageOk <|
                R10.Form.ValidationCode.fromValidationCodeToMessageWithReplacedValues
                    validationCode
                    validationPayload
                    translator

        R10.Form.FieldState.MessageErr validationCode validationPayload ->
            R10.FormComponents.Validations.MessageErr <|
                R10.Form.ValidationCode.fromValidationCodeToMessageWithReplacedValues
                    validationCode
                    validationPayload
                    translator
