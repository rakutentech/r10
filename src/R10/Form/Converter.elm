module Form.Converter exposing
    ( binaryTypeFromFieldConfToComponent
    , fromFieldStateValidationToComponentValidation
    , fromFormValidationIconToComponentValidationIcon
    , singleTypeFromFieldConfToComponent
    , textTypeFromFieldConfToComponent
    )

import Form.FieldConf
import Form.FieldState
import Form.ValidationCode
import FormComponents.Binary
import FormComponents.Single.Common
import FormComponents.Text
import FormComponents.Validations



--
--  ██████  ██████  ███    ██ ██    ██ ███████ ██████  ████████ ███████ ██████
-- ██      ██    ██ ████   ██ ██    ██ ██      ██   ██    ██    ██      ██   ██
-- ██      ██    ██ ██ ██  ██ ██    ██ █████   ██████     ██    █████   ██████
-- ██      ██    ██ ██  ██ ██  ██  ██  ██      ██   ██    ██    ██      ██   ██
--  ██████  ██████  ██   ████   ████   ███████ ██   ██    ██    ███████ ██   ██
--
--  This module helps to convert stuff from form-recursive to form-components
--


binaryTypeFromFieldConfToComponent : Form.FieldConf.TypeBinary -> FormComponents.Binary.TypeBinary
binaryTypeFromFieldConfToComponent typeText =
    case typeText of
        Form.FieldConf.BinaryCheckbox ->
            FormComponents.Binary.BinaryCheckbox

        Form.FieldConf.BinarySwitch ->
            FormComponents.Binary.BinarySwitch


singleTypeFromFieldConfToComponent : Form.FieldConf.TypeSingle -> FormComponents.Single.Common.TypeSingle
singleTypeFromFieldConfToComponent typeText =
    case typeText of
        Form.FieldConf.SingleRadio ->
            FormComponents.Single.Common.SingleRadio

        Form.FieldConf.SingleCombobox ->
            FormComponents.Single.Common.SingleCombobox


textTypeFromFieldConfToComponent : Form.FieldConf.TypeText -> FormComponents.Text.TextType
textTypeFromFieldConfToComponent typeText =
    case typeText of
        Form.FieldConf.TextPlain ->
            FormComponents.Text.TextPlain

        Form.FieldConf.TextUsername ->
            FormComponents.Text.TextUsername

        Form.FieldConf.TextEmail ->
            FormComponents.Text.TextEmail

        Form.FieldConf.TextPasswordCurrent ->
            FormComponents.Text.TextPasswordCurrent

        Form.FieldConf.TextPasswordNew ->
            FormComponents.Text.TextPasswordNew

        Form.FieldConf.TextMultiline ->
            FormComponents.Text.TextMultiline

        Form.FieldConf.TextWithPattern pattern ->
            FormComponents.Text.TextWithPattern pattern


fromFormValidationIconToComponentValidationIcon : Form.FieldConf.ValidationIcon -> FormComponents.Validations.ValidationIcon
fromFormValidationIconToComponentValidationIcon formIcon =
    case formIcon of
        Form.FieldConf.NoIcon ->
            FormComponents.Validations.NoIcon

        Form.FieldConf.ClearOrCheck ->
            FormComponents.Validations.ClearOrCheck

        Form.FieldConf.ErrorOrCheck ->
            FormComponents.Validations.ErrorOrCheck


fromFieldStateValidationToComponentValidation :
    Maybe Form.FieldConf.ValidationSpecs
    -> Form.FieldState.Validation
    -> (Form.FieldConf.ValidationCode -> String)
    -> FormComponents.Validations.Validation
fromFieldStateValidationToComponentValidation maybeValidationSpecs validation translator =
    case validation of
        Form.FieldState.NotYetValidated ->
            FormComponents.Validations.NotYetValidated

        Form.FieldState.Validated listValidationOutcome ->
            let
                listErrValidationOutcome : List Form.FieldState.ValidationOutcome
                listErrValidationOutcome =
                    List.filter
                        (\validationOutcome ->
                            case validationOutcome of
                                Form.FieldState.MessageOk _ _ ->
                                    False

                                Form.FieldState.MessageErr _ _ ->
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
                FormComponents.Validations.Validated <|
                    List.map
                        (\a -> fromValidationOutcomeToValidationMessage a translator)
                        listValidationOutcome

            else if hidePassedValidationStyle && List.length listErrValidationOutcome == 0 then
                FormComponents.Validations.NotYetValidated

            else
                FormComponents.Validations.Validated <|
                    List.map
                        (\err -> fromValidationOutcomeToValidationMessage err translator)
                        listErrValidationOutcome


fromValidationOutcomeToValidationMessage :
    Form.FieldState.ValidationOutcome
    -> (Form.FieldConf.ValidationCode -> String)
    -> FormComponents.Validations.ValidationMessage
fromValidationOutcomeToValidationMessage validationOutcome translator =
    case validationOutcome of
        Form.FieldState.MessageOk validationCode validationPayload ->
            FormComponents.Validations.MessageOk <|
                Form.ValidationCode.fromValidationCodeToMessageWithReplacedValues
                    validationCode
                    validationPayload
                    translator

        Form.FieldState.MessageErr validationCode validationPayload ->
            FormComponents.Validations.MessageErr <|
                Form.ValidationCode.fromValidationCodeToMessageWithReplacedValues
                    validationCode
                    validationPayload
                    translator
