module R10.Form.Internal.Converter exposing
    ( binaryTypeFromFieldConfToComponent
    , fromFieldStateValidationToComponentValidation
    , fromFormValidationIconToComponentValidationIcon
    , singleTypeFromFieldConfToComponent
    , textTypeFromFieldConfToComponent
    )

import R10.Form.Internal.FieldConf
import R10.Form.Internal.FieldState
import R10.Form.Internal.ValidationCode
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
--  This module helps to convert stuff from form-recursive to form-components
--


binaryTypeFromFieldConfToComponent : R10.Form.Internal.FieldConf.TypeBinary -> R10.FormComponents.Binary.TypeBinary
binaryTypeFromFieldConfToComponent typeText =
    case typeText of
        R10.Form.Internal.FieldConf.BinaryCheckbox ->
            R10.FormComponents.Binary.BinaryCheckbox

        R10.Form.Internal.FieldConf.BinarySwitch ->
            R10.FormComponents.Binary.BinarySwitch


singleTypeFromFieldConfToComponent : R10.Form.Internal.FieldConf.TypeSingle -> R10.FormComponents.Single.Common.TypeSingle
singleTypeFromFieldConfToComponent typeText =
    case typeText of
        R10.Form.Internal.FieldConf.SingleRadio ->
            R10.FormComponents.Single.Common.SingleRadio

        R10.Form.Internal.FieldConf.SingleCombobox ->
            R10.FormComponents.Single.Common.SingleCombobox


textTypeFromFieldConfToComponent : R10.Form.Internal.FieldConf.TypeText -> R10.FormComponents.Text.TextType
textTypeFromFieldConfToComponent typeText =
    case typeText of
        R10.Form.Internal.FieldConf.TextPlain ->
            R10.FormComponents.Text.TextPlain

        R10.Form.Internal.FieldConf.TextUsername ->
            R10.FormComponents.Text.TextUsername

        R10.Form.Internal.FieldConf.TextEmail ->
            R10.FormComponents.Text.TextEmail

        R10.Form.Internal.FieldConf.TextPasswordCurrent ->
            R10.FormComponents.Text.TextPasswordCurrent

        R10.Form.Internal.FieldConf.TextPasswordNew ->
            R10.FormComponents.Text.TextPasswordNew

        R10.Form.Internal.FieldConf.TextMultiline ->
            R10.FormComponents.Text.TextMultiline

        R10.Form.Internal.FieldConf.TextWithPattern pattern ->
            R10.FormComponents.Text.TextWithPattern pattern


fromFormValidationIconToComponentValidationIcon : R10.Form.Internal.FieldConf.ValidationIcon -> R10.FormComponents.Validations.ValidationIcon
fromFormValidationIconToComponentValidationIcon formIcon =
    case formIcon of
        R10.Form.Internal.FieldConf.NoIcon ->
            R10.FormComponents.Validations.NoIcon

        R10.Form.Internal.FieldConf.ClearOrCheck ->
            R10.FormComponents.Validations.ClearOrCheck

        R10.Form.Internal.FieldConf.ErrorOrCheck ->
            R10.FormComponents.Validations.ErrorOrCheck


fromFieldStateValidationToComponentValidation :
    Maybe R10.Form.Internal.FieldConf.ValidationSpecs
    -> R10.Form.Internal.FieldState.Validation
    -> (R10.Form.Internal.FieldConf.ValidationCode -> String)
    -> R10.FormComponents.Validations.Validation
fromFieldStateValidationToComponentValidation maybeValidationSpecs validation translator =
    case validation of
        R10.Form.Internal.FieldState.NotYetValidated ->
            R10.FormComponents.Validations.NotYetValidated

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
    R10.Form.Internal.FieldState.ValidationOutcome
    -> (R10.Form.Internal.FieldConf.ValidationCode -> String)
    -> R10.FormComponents.Validations.ValidationMessage
fromValidationOutcomeToValidationMessage validationOutcome translator =
    case validationOutcome of
        R10.Form.Internal.FieldState.MessageOk validationCode validationPayload ->
            R10.FormComponents.Validations.MessageOk <|
                R10.Form.Internal.ValidationCode.fromValidationCodeToMessageWithReplacedValues
                    validationCode
                    validationPayload
                    translator

        R10.Form.Internal.FieldState.MessageErr validationCode validationPayload ->
            R10.FormComponents.Validations.MessageErr <|
                R10.Form.Internal.ValidationCode.fromValidationCodeToMessageWithReplacedValues
                    validationCode
                    validationPayload
                    translator
