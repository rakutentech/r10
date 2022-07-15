module R10.Form.Internal.Converter exposing (fromFieldStateValidationToComponentValidation)

import List.Extra
import R10.Country
import R10.Form.Internal.FieldConf
import R10.Form.Internal.FieldState
import R10.Form.Internal.Translator
import R10.Form.Internal.ValidationCode
import R10.FormComponents.Internal.Validations
import R10.FormTypes



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
    -> R10.Form.Internal.FieldState.FieldState
    -> (R10.Form.Internal.FieldConf.ValidationCode -> String)
    -> R10.FormTypes.FieldType
    -> R10.FormComponents.Internal.Validations.ValidationForView
fromFieldStateValidationToComponentValidation maybeValidationSpecs fieldState translator fieldType =
    let
        validation : R10.Form.Internal.FieldState.Validation
        validation =
            fieldState.validation
    in
    case validation of
        R10.Form.Internal.FieldState.NotYetValidated ->
            R10.FormComponents.Internal.Validations.PretendIsNotYetValidated

        R10.Form.Internal.FieldState.Validated listValidationOutcome_ ->
            let
                allLengthValidationOk : Bool
                allLengthValidationOk =
                    List.any
                        (\validationOutcome ->
                            case validationOutcome of
                                R10.Form.Internal.FieldState.MessageOk validationCode _ ->
                                    validationCode == R10.Form.Internal.Translator.validationCodes.lengthTooSmallInvalid

                                R10.Form.Internal.FieldState.MessageErr _ _ ->
                                    False
                        )
                        listValidationOutcome_
                        && List.any
                            (\validationOutcome ->
                                case validationOutcome of
                                    R10.Form.Internal.FieldState.MessageOk validationCode _ ->
                                        validationCode == R10.Form.Internal.Translator.validationCodes.lengthTooLargeInvalid

                                    R10.Form.Internal.FieldState.MessageErr _ _ ->
                                        False
                            )
                            listValidationOutcome_

                hasLengthValidationErr : Bool
                hasLengthValidationErr =
                    List.any
                        (\validationOutcome ->
                            case validationOutcome of
                                R10.Form.Internal.FieldState.MessageErr validationCode _ ->
                                    validationCode
                                        == R10.Form.Internal.Translator.validationCodes.lengthTooLargeInvalid
                                        || validationCode
                                        == R10.Form.Internal.Translator.validationCodes.lengthTooSmallInvalid

                                R10.Form.Internal.FieldState.MessageOk _ _ ->
                                    False
                        )
                        listValidationOutcome_

                ifIsSameMinLenthAndMaxLength : Bool
                ifIsSameMinLenthAndMaxLength =
                    let
                        getLengthNumber : String -> Maybe Int
                        getLengthNumber validationCode =
                            List.Extra.findMap
                                (\validationOutcome ->
                                    case validationOutcome of
                                        R10.Form.Internal.FieldState.MessageOk validationCode_ payload ->
                                            if validationCode_ == validationCode then
                                                List.head payload
                                                    |> Maybe.andThen String.toInt

                                            else
                                                Nothing

                                        R10.Form.Internal.FieldState.MessageErr validationCode_ payload ->
                                            if validationCode_ == validationCode then
                                                List.head payload
                                                    |> Maybe.andThen String.toInt

                                            else
                                                Nothing
                                )
                                listValidationOutcome_
                    in
                    case ( getLengthNumber R10.Form.Internal.Translator.validationCodes.lengthTooSmallInvalid, getLengthNumber R10.Form.Internal.Translator.validationCodes.lengthTooLargeInvalid ) of
                        ( Just min, Just max ) ->
                            min == max

                        _ ->
                            False

                replaceLengthValidation : List R10.Form.Internal.FieldState.ValidationOutcome
                replaceLengthValidation =
                    if allLengthValidationOk then
                        List.map
                            (\validationOutcome ->
                                case validationOutcome of
                                    R10.Form.Internal.FieldState.MessageOk validationCode a ->
                                        if validationCode == R10.Form.Internal.Translator.validationCodes.lengthTooSmallInvalid then
                                            R10.Form.Internal.FieldState.MessageOk R10.Form.Internal.Translator.validationCodes.lengthValid a

                                        else
                                            validationOutcome

                                    R10.Form.Internal.FieldState.MessageErr _ _ ->
                                        validationOutcome
                            )
                            listValidationOutcome_

                    else if hasLengthValidationErr && ifIsSameMinLenthAndMaxLength then
                        List.map
                            (\validationOutcome ->
                                case validationOutcome of
                                    R10.Form.Internal.FieldState.MessageErr validationCode a ->
                                        if validationCode == R10.Form.Internal.Translator.validationCodes.lengthTooSmallInvalid then
                                            R10.Form.Internal.FieldState.MessageErr R10.Form.Internal.Translator.validationCodes.lengthExactInvalid a

                                        else
                                            validationOutcome

                                    R10.Form.Internal.FieldState.MessageOk _ _ ->
                                        validationOutcome
                            )
                            listValidationOutcome_

                    else
                        listValidationOutcome_

                isJapanTelCode : Bool
                isJapanTelCode =
                    fieldState.value
                        |> R10.Country.fromTelephoneAsString
                        |> Maybe.map R10.Country.toCountryTelCode
                        |> Maybe.andThen R10.Country.fromCountryTelCode
                        |> Maybe.map (\country -> country == R10.Country.Japan)
                        |> Maybe.withDefault False

                replaceInvalidValieValidationIfJapanPhone : List R10.Form.Internal.FieldState.ValidationOutcome -> List R10.Form.Internal.FieldState.ValidationOutcome
                replaceInvalidValieValidationIfJapanPhone =
                    -- https://jira.rakuten-it.com/jira/browse/OMN-5708
                    -- Special error message for Phone field with Japan phone value
                    case ( fieldType, isJapanTelCode ) of
                        -- https://jira.rakuten-it.com/jira/browse/OMN-5904
                        -- Special error message only for JapanService
                        ( R10.FormTypes.TypeSpecial (R10.FormTypes.SpecialPhone specialPhone), True ) ->
                            if specialPhone.isJapanService then
                                List.map
                                    (\item ->
                                        case item of
                                            R10.Form.Internal.FieldState.MessageErr code payload ->
                                                if
                                                    code
                                                        == R10.Form.Internal.Translator.validationCodes.lengthTooSmallInvalid
                                                        || code
                                                        == R10.Form.Internal.Translator.validationCodes.lengthTooLargeInvalid
                                                        || code
                                                        -- https://jira.rakuten-it.com/jira/browse/OMN-5819
                                                        -- The INVALID_VALUE was comes from backend, use the same message with the INVALID_FORMAT if it is Japan phone
                                                        == R10.Form.Internal.Translator.validationCodes.valueInvalid
                                                then
                                                    R10.Form.Internal.FieldState.MessageErr
                                                        R10.Form.Internal.Translator.validationCodes.formatInvalid
                                                        payload

                                                else
                                                    item

                                            _ ->
                                                item
                                    )

                            else
                                identity

                        _ ->
                            identity

                listAllButTwoOkMessages : List R10.Form.Internal.FieldState.ValidationOutcome
                listAllButTwoOkMessages =
                    -- 2021.04.04
                    -- Hacky solution here because we need to hide certain validation
                    -- if succesefull also if `showAlsoPassedValidation` is
                    -- set to true. For example "Cannot be blank" and
                    -- "Maximum allowed length is 128 characters"
                    replaceLengthValidation
                        |> List.filter
                            (\validationOutcome ->
                                case validationOutcome of
                                    R10.Form.Internal.FieldState.MessageOk validationCode _ ->
                                        --
                                        -- Hiding two OK messages:
                                        --
                                        -- * Good, your data is short enough
                                        -- * Good, you typed something that was required
                                        --
                                        not <|
                                            List.member
                                                validationCode
                                                [ R10.Form.Internal.Translator.validationCodes.lengthTooSmallInvalid
                                                , R10.Form.Internal.Translator.validationCodes.lengthTooLargeInvalid
                                                , R10.Form.Internal.Translator.validationCodes.required
                                                ]

                                    R10.Form.Internal.FieldState.MessageErr validationCode _ ->
                                        case fieldType of
                                            R10.FormTypes.TypeText R10.FormTypes.TextOnlyDigitsOrDash ->
                                                -- For this field type, if has the length validation error, hide the invalid format error.
                                                (hasLengthValidationErr && validationCode == R10.Form.Internal.Translator.validationCodes.formatInvalid)
                                                    |> not

                                            _ ->
                                                True
                            )

                listOnlyErrors : List R10.Form.Internal.FieldState.ValidationOutcome
                listOnlyErrors =
                    listAllButTwoOkMessages
                        |> List.filter
                            (\validationOutcome ->
                                case validationOutcome of
                                    R10.Form.Internal.FieldState.MessageOk _ _ ->
                                        False

                                    R10.Form.Internal.FieldState.MessageErr _ _ ->
                                        True
                            )
                        |> replaceInvalidValieValidationIfJapanPhone
                        |> List.Extra.uniqueBy
                            -- Should call after others replaces
                            -- https://jira.rakuten-it.com/jira/browse/OMN-5708
                            -- help to remove same error message
                            (\validationOutcome ->
                                case validationOutcome of
                                    R10.Form.Internal.FieldState.MessageErr errorMessage _ ->
                                        errorMessage

                                    R10.Form.Internal.FieldState.MessageOk errorMessage _ ->
                                        errorMessage
                            )

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
