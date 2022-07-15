module R10.Form.Internal.Update exposing
    ( allErrorsForView
    , allValidationKeysMaker
    , entitiesWithErrors
    , entitiesWithErrorsForOnlyExistingValidations
    , isEntireFormValid
    , isExistingFormFieldsValid
    , isFormSubmittable
    , isFormSubmittableAndSubmitted
    , runAllValidations
    , runOnlyExistingValidations
    , shouldShowTheValidationOverview
    , submit
    , update
    , validateDirtyFormFields
    , validateEntireForm
    )

import Dict
import R10.Device
import R10.Form.Internal.Conf
import R10.Form.Internal.Dict
import R10.Form.Internal.FieldConf
import R10.Form.Internal.FieldState
import R10.Form.Internal.Helpers
import R10.Form.Internal.Key
import R10.Form.Internal.MakerForValidationKeys
import R10.Form.Internal.Msg
import R10.Form.Internal.QtySubmitAttempted
import R10.Form.Internal.Shared
import R10.Form.Internal.State
import R10.Form.Internal.Validation
import R10.FormComponents.Internal.Phone.Update
import R10.FormComponents.Internal.Single.Common
import R10.FormComponents.Internal.Single.Update
import R10.FormTypes
import R10.KatakanaConverter
import Set
import String.Extra


stateWithDefault : Maybe R10.Form.Internal.FieldState.FieldState -> R10.Form.Internal.FieldState.FieldState
stateWithDefault maybeFieldState =
    Maybe.withDefault R10.Form.Internal.FieldState.init maybeFieldState



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


{-| Is there no validation error inside the form
-}
isEntireFormValid : R10.Form.Internal.Shared.Form -> Bool
isEntireFormValid form =
    let
        allKeys :
            List
                ( R10.Form.Internal.Key.Key
                , R10.FormTypes.FieldType
                , Maybe R10.Form.Internal.FieldConf.ValidationSpecs
                )
        allKeys =
            allValidationKeysMaker form

        fieldsWithErrors_ :
            List
                ( R10.Form.Internal.Key.Key
                , R10.FormTypes.FieldType
                , Maybe R10.Form.Internal.FieldConf.ValidationSpecs
                )
        fieldsWithErrors_ =
            entitiesWithErrors allKeys form.state.fieldsState
    in
    List.head fieldsWithErrors_ == Nothing


{-| Is there no validation error inside the form
-}
isExistingFormFieldsValid : R10.Form.Internal.Shared.Form -> Bool
isExistingFormFieldsValid form =
    let
        allKeys : List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
        allKeys =
            allValidationKeysMaker form

        fieldsWithErrors_ : List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
        fieldsWithErrors_ =
            entitiesWithErrorsForOnlyExistingValidations allKeys form.state.fieldsState
    in
    List.head fieldsWithErrors_ == Nothing


{-| Validate the entire form
-}
validateEntireForm : (String -> String -> String) -> R10.Form.Internal.Shared.Form -> R10.Form.Internal.State.State
validateEntireForm formStateBeforeValidationFixer form =
    let
        allKeys : List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
        allKeys =
            allValidationKeysMaker form

        newFieldsState : Dict.Dict String R10.Form.Internal.FieldState.FieldState
        newFieldsState =
            runAllValidations formStateBeforeValidationFixer allKeys form.state form.state.fieldsState

        state : R10.Form.Internal.State.State
        state =
            form.state
    in
    { state | fieldsState = newFieldsState }


{-| Validate the entire form
-}
validateDirtyFormFields : (String -> String -> String) -> R10.Form.Internal.Shared.Form -> R10.Form.Internal.State.State
validateDirtyFormFields formStateBeforeValidationFixer form =
    let
        allKeys : List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
        allKeys =
            allValidationKeysMaker form

        newFieldsState : Dict.Dict String R10.Form.Internal.FieldState.FieldState
        newFieldsState =
            runOnlyExistingValidations formStateBeforeValidationFixer allKeys form.state form.state.fieldsState

        state : R10.Form.Internal.State.State
        state =
            form.state
    in
    { state | fieldsState = newFieldsState }


helperToggleShowPassword : Maybe R10.Form.Internal.FieldState.FieldState -> Maybe R10.Form.Internal.FieldState.FieldState
helperToggleShowPassword maybeFieldState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | showPassword = not fieldState.showPassword }


helperUpdateValue : R10.Form.Internal.FieldConf.FieldConf -> String -> Maybe R10.Form.Internal.FieldState.FieldState -> Maybe R10.Form.Internal.FieldState.FieldState
helperUpdateValue fieldConf value maybeFieldState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState

        maxLength : Maybe Int
        maxLength =
            fieldConf.validationSpecs
                |> Maybe.map .validation
                |> Maybe.map
                    (List.filterMap
                        (\validation ->
                            case validation of
                                R10.Form.Internal.FieldConf.MaxLength val ->
                                    Just val

                                _ ->
                                    Nothing
                        )
                    )
                |> Maybe.andThen List.head

        newValue : String
        newValue =
            case ( fieldConf.allowOverMaxLength, maxLength ) of
                ( False, Just maxLength_ ) ->
                    String.left maxLength_ value

                _ ->
                    value
    in
    Just { fieldState | value = newValue }


helperCopyEmailIntoUsername :
    R10.Form.Internal.Key.Key
    -> String
    -> Dict.Dict R10.Form.Internal.Key.KeyAsString R10.Form.Internal.FieldState.FieldState
    -> Dict.Dict R10.Form.Internal.Key.KeyAsString R10.Form.Internal.FieldState.FieldState
helperCopyEmailIntoUsername key value fieldsState =
    let
        emailKeyString : String
        emailKeyString =
            R10.Form.Internal.Shared.defaultEmailFieldKeyString

        usernameKeyString : String
        usernameKeyString =
            R10.Form.Internal.Shared.defaultUsernameFieldKeyString

        usernameFieldState : R10.Form.Internal.FieldState.FieldState
        usernameFieldState =
            Dict.get usernameKeyString fieldsState
                |> stateWithDefault

        emailFieldState : R10.Form.Internal.FieldState.FieldState
        emailFieldState =
            Dict.get emailKeyString fieldsState
                |> stateWithDefault

        needCopyIntoUsername : Bool
        needCopyIntoUsername =
            R10.Form.Internal.Dict.get R10.Form.Internal.Shared.copyEmailIntoUsernameCheckboxKey fieldsState
                |> stateWithDefault
                |> .value
                |> R10.Form.Internal.Helpers.stringToBool
    in
    if R10.Form.Internal.Key.toString key == emailKeyString && needCopyIntoUsername then
        fieldsState
            |> Dict.insert usernameKeyString { usernameFieldState | value = R10.Form.Internal.Helpers.punyDecode value, dirty = True }

    else if key == R10.Form.Internal.Shared.copyEmailIntoUsernameCheckboxKey then
        if R10.Form.Internal.Helpers.stringToBool value then
            fieldsState
                |> Dict.insert
                    usernameKeyString
                    { usernameFieldState
                        | value = R10.Form.Internal.Helpers.punyDecode emailFieldState.value
                    }

        else
            fieldsState
                |> Dict.insert usernameKeyString { usernameFieldState | value = "", dirty = True, lostFocusOneOrMoreTime = True }

    else
        fieldsState


helperResetUsernameValidation :
    R10.Form.Internal.Key.Key
    -> String
    -> R10.Form.Internal.Conf.Conf
    -> (String -> String -> String)
    -> R10.Form.Internal.State.State
    -> R10.Form.Internal.State.State
helperResetUsernameValidation key value formConf formStateBeforeValidationFixer formState =
    let
        usernameKeyString : String
        usernameKeyString =
            R10.Form.Internal.Shared.defaultUsernameFieldKeyString

        needCopyIntoUsername : Bool
        needCopyIntoUsername =
            (key == R10.Form.Internal.Shared.copyEmailIntoUsernameCheckboxKey && R10.Form.Internal.Helpers.stringToBool value)
                || (R10.Form.Internal.Helpers.getFieldValue (R10.Form.Internal.Key.toString R10.Form.Internal.Shared.copyEmailIntoUsernameCheckboxKey) formState
                        |> Maybe.map R10.Form.Internal.Helpers.stringToBool
                        |> Maybe.withDefault False
                   )

        usernameFieldConf : R10.Form.Internal.FieldConf.FieldConf
        usernameFieldConf =
            R10.Form.Internal.Conf.getFieldConfByFieldId usernameKeyString formConf
                |> Maybe.withDefault (R10.Form.Internal.FieldConf.init |> (\conf -> { conf | id = usernameKeyString }))
    in
    if needCopyIntoUsername then
        R10.Form.Internal.Helpers.clearFieldValidation usernameKeyString formState

    else
        { formState
            | fieldsState =
                runOnlyExistingValidations
                    formStateBeforeValidationFixer
                    [ ( R10.Form.Internal.Key.fromString usernameKeyString, usernameFieldConf.type_, usernameFieldConf.validationSpecs ) ]
                    formState
                    formState.fieldsState
        }


helperUpdateSearch : String -> Maybe R10.Form.Internal.FieldState.FieldState -> Maybe R10.Form.Internal.FieldState.FieldState
helperUpdateSearch value maybeFieldState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | search = value }


helperUpdateSelect : String -> Maybe R10.Form.Internal.FieldState.FieldState -> Maybe R10.Form.Internal.FieldState.FieldState
helperUpdateSelect value maybeFieldState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | select = value }


helperUpdateOver : Maybe String -> Maybe R10.Form.Internal.FieldState.FieldState -> Maybe R10.Form.Internal.FieldState.FieldState
helperUpdateOver over maybeFieldState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | over = over }


helperUpdateScroll : Float -> Maybe R10.Form.Internal.FieldState.FieldState -> Maybe R10.Form.Internal.FieldState.FieldState
helperUpdateScroll value maybeScroll =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            stateWithDefault maybeScroll
    in
    Just { fieldState | scroll = value }


helperUpdateDirty : Maybe R10.Form.Internal.FieldState.FieldState -> Maybe R10.Form.Internal.FieldState.FieldState
helperUpdateDirty maybeFieldState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | dirty = True }


helperLostFocus : Maybe R10.Form.Internal.FieldState.FieldState -> Maybe R10.Form.Internal.FieldState.FieldState
helperLostFocus maybeFieldState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    if String.isEmpty fieldState.value then
        --
        -- We pretend this field never lost the focus because we want to avoid
        -- fields starting to get validation error if they were just focused
        -- in and out.
        -- https://jira.rakuten-it.com/jira/browse/OMN-5419
        --
        -- This works a bit different for the telephone input box, because the
        -- value is never emoty, as it contains the international prefix
        --
        Just fieldState

    else
        Just { fieldState | lostFocusOneOrMoreTime = True }


validateIfLostFocusAtLeastOnce :
    { formStateBeforeValidationFixer : String -> String -> String
    , showAlsoPassedValidation : Bool
    , key : R10.Form.Internal.Key.Key
    , fieldType : R10.FormTypes.FieldType
    , maybeValidationSpec : Maybe R10.Form.Internal.FieldConf.ValidationSpecs
    , formState : R10.Form.Internal.State.State
    }
    -> Maybe R10.Form.Internal.FieldState.FieldState
    -> Maybe R10.Form.Internal.FieldState.FieldState
validateIfLostFocusAtLeastOnce args maybeFieldState =
    -- https://jira.rakuten-it.com/jira/browse/OMN-5419
    case maybeFieldState of
        Just fieldState ->
            if fieldState.lostFocusOneOrMoreTime then
                helperValidateCreatingFieldsState args maybeFieldState

            else
                maybeFieldState

        Nothing ->
            maybeFieldState


helperValidateCreatingFieldsState :
    { formStateBeforeValidationFixer : String -> String -> String
    , showAlsoPassedValidation : Bool
    , key : R10.Form.Internal.Key.Key
    , fieldType : R10.FormTypes.FieldType
    , maybeValidationSpec : Maybe R10.Form.Internal.FieldConf.ValidationSpecs
    , formState : R10.Form.Internal.State.State
    }
    -> Maybe R10.Form.Internal.FieldState.FieldState
    -> Maybe R10.Form.Internal.FieldState.FieldState
helperValidateCreatingFieldsState args maybeFieldState =
    maybeFieldState
        |> Maybe.withDefault R10.Form.Internal.FieldState.init
        |> R10.Form.Internal.Validation.validate args
        |> Just


helperValidateOnChangeValue :
    { formStateBeforeValidationFixer : String -> String -> String
    , showAlsoPassedValidation : Bool
    , key : R10.Form.Internal.Key.Key
    , fieldType : R10.FormTypes.FieldType
    , maybeValidationSpec : Maybe R10.Form.Internal.FieldConf.ValidationSpecs
    , qtySubmitAttempted : R10.Form.Internal.QtySubmitAttempted.QtySubmitAttempted
    , formState : R10.Form.Internal.State.State
    }
    -> Maybe R10.Form.Internal.FieldState.FieldState
    -> Maybe R10.Form.Internal.FieldState.FieldState
helperValidateOnChangeValue args maybeFieldState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    if shouldValidationBeVisible args.fieldType args.qtySubmitAttempted fieldState then
        helperValidateCreatingFieldsState
            { formStateBeforeValidationFixer = args.formStateBeforeValidationFixer
            , showAlsoPassedValidation = args.showAlsoPassedValidation
            , key = args.key
            , fieldType = args.fieldType
            , maybeValidationSpec = args.maybeValidationSpec
            , formState = args.formState
            }
            maybeFieldState

    else
        maybeFieldState


shouldValidationBeVisible :
    R10.FormTypes.FieldType
    -> R10.Form.Internal.QtySubmitAttempted.QtySubmitAttempted
    -> R10.Form.Internal.FieldState.FieldState
    -> Bool
shouldValidationBeVisible fieldType qtySubmitAttempted fieldState =
    let
        isTypeBinary : Bool
        isTypeBinary =
            case fieldType of
                R10.FormTypes.TypeBinary _ ->
                    True

                _ ->
                    False

        hasError : Bool
        hasError =
            case fieldState.validation of
                R10.Form.Internal.FieldState.Validated validationList ->
                    List.any
                        (\validation ->
                            case validation of
                                R10.Form.Internal.FieldState.MessageErr _ _ ->
                                    True

                                _ ->
                                    False
                        )
                        validationList

                _ ->
                    False
    in
    fieldState.lostFocusOneOrMoreTime
        || (R10.Form.Internal.QtySubmitAttempted.toInt qtySubmitAttempted
                > 0
           )
        || isTypeBinary
        || (not fieldState.lostFocusOneOrMoreTime && hasError)



--
-- OTHER HELPERS
--


allValidationKeysMaker : R10.Form.Internal.Shared.Form -> List R10.Form.Internal.MakerForValidationKeys.Outcome
allValidationKeysMaker form =
    R10.Form.Internal.MakerForValidationKeys.maker R10.Form.Internal.Key.empty form


runAllValidations :
    (String -> String -> String)
    -> List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
    -> R10.Form.Internal.State.State
    -> Dict.Dict String R10.Form.Internal.FieldState.FieldState
    -> Dict.Dict String R10.Form.Internal.FieldState.FieldState
runAllValidations formStateBeforeValidationFixer allKeys formState fieldsState =
    -- Validate the entire form, creating new `fieldState` if necessary,
    -- when such fields were not yet touched, for example.
    -- This is used when the form is submitted, for example.
    List.foldl
        (\( key, fieldType, maybeValidationSpec ) acc ->
            R10.Form.Internal.Dict.update key
                (helperValidateCreatingFieldsState
                    { formStateBeforeValidationFixer = formStateBeforeValidationFixer
                    , showAlsoPassedValidation = isShowAlsoPassedValidation maybeValidationSpec
                    , key = key
                    , fieldType = fieldType
                    , maybeValidationSpec = maybeValidationSpec
                    , formState = formState
                    }
                )
                acc
        )
        fieldsState
        allKeys


runOnlyExistingValidations :
    (String -> String -> String)
    -> List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
    -> R10.Form.Internal.State.State
    -> Dict.Dict String R10.Form.Internal.FieldState.FieldState
    -> Dict.Dict String R10.Form.Internal.FieldState.FieldState
runOnlyExistingValidations formStateBeforeValidationFixer allKeys formState fieldsState =
    -- Validate the entire form, without creating new `fieldState`
    --
    -- Validation should only run for fields that have been focused out or
    -- are special, like password.
    --
    List.foldl
        (\( key, fieldType, maybeValidationSpec ) acc ->
            R10.Form.Internal.Dict.update key
                (\maybeFieldState ->
                    case maybeFieldState of
                        Nothing ->
                            maybeFieldState

                        Just fieldState ->
                            -- ██ ███████     ████████ ██   ██ ██ ███████     ███    ██ ███████ ███████ ██████  ███████ ██████  ██████
                            -- ██ ██             ██    ██   ██ ██ ██          ████   ██ ██      ██      ██   ██ ██      ██   ██      ██
                            -- ██ ███████        ██    ███████ ██ ███████     ██ ██  ██ █████   █████   ██   ██ █████   ██   ██   ▄███
                            -- ██      ██        ██    ██   ██ ██      ██     ██  ██ ██ ██      ██      ██   ██ ██      ██   ██   ▀▀
                            -- ██ ███████        ██    ██   ██ ██ ███████     ██   ████ ███████ ███████ ██████  ███████ ██████    ██
                            -- if fieldState.lostFocusOneOrMoreTime then
                            fieldState
                                |> R10.Form.Internal.Validation.validate
                                    { formStateBeforeValidationFixer = formStateBeforeValidationFixer
                                    , showAlsoPassedValidation = isShowAlsoPassedValidation maybeValidationSpec
                                    , key = key
                                    , fieldType = fieldType
                                    , maybeValidationSpec = maybeValidationSpec
                                    , formState = formState
                                    }
                                |> Just
                 -- else
                 --     maybeFieldState
                )
                acc
        )
        fieldsState
        allKeys


entitiesWithErrors :
    List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
    -> Dict.Dict String R10.Form.Internal.FieldState.FieldState
    -> List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
entitiesWithErrors allKeys fieldsState =
    -- Return the list of field that either didn't pass
    -- the validation or were not validated. Used to understand if a form has been
    -- filled properly and show a comprehensive error at the bottom.
    -- If a field has not yet been validated, it is considered as an error.
    -- So this function require all validations to be run before being called.
    List.filter
        (\( key, _, _ ) ->
            let
                fieldState : R10.Form.Internal.FieldState.FieldState
                fieldState =
                    Maybe.withDefault R10.Form.Internal.FieldState.init <| R10.Form.Internal.Dict.get key fieldsState
            in
            case fieldState.validation of
                R10.Form.Internal.FieldState.NotYetValidated ->
                    True

                R10.Form.Internal.FieldState.Validated listValidationMessage ->
                    not (R10.Form.Internal.FieldState.isValid listValidationMessage)
         --
         -- Before this function was like this:
         --
         --
         -- case R10.Form.Internal.FieldState.isValid fieldState.validation of
         --     R10.Form.Internal.FieldState.NotYetValidated2 ->
         --         True
         --
         --     R10.Form.Internal.FieldState.NotValid ->
         --         True
         --
         --     R10.Form.Internal.FieldState.Valid ->
         --         False
         --
        )
        allKeys


entitiesWithErrorsForOnlyExistingValidations :
    List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
    -> Dict.Dict String R10.Form.Internal.FieldState.FieldState
    -> List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
entitiesWithErrorsForOnlyExistingValidations allKeys fieldsState =
    -- Filter only entities that have been validated and have some error.
    List.filter
        (\( key, _, _ ) ->
            let
                fieldState : R10.Form.Internal.FieldState.FieldState
                fieldState =
                    Maybe.withDefault R10.Form.Internal.FieldState.init <| R10.Form.Internal.Dict.get key fieldsState
            in
            case fieldState.validation of
                R10.Form.Internal.FieldState.NotYetValidated ->
                    False

                R10.Form.Internal.FieldState.Validated listValidationMessage ->
                    not (R10.Form.Internal.FieldState.isValid listValidationMessage)
         --
         -- Before this function was like this:
         --
         -- case R10.Form.Internal.FieldState.isValid fieldState.validation of
         --     R10.Form.Internal.FieldState.NotYetValidated2 ->
         --         False
         --
         --     R10.Form.Internal.FieldState.NotValid ->
         --         True
         --
         --     R10.Form.Internal.FieldState.Valid ->
         --         False
         --
        )
        allKeys


allErrorsForView : R10.Form.Internal.Conf.Conf -> R10.Form.Internal.State.State -> List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
allErrorsForView conf state =
    if shouldShowTheValidationOverview state then
        let
            allKeys :
                List
                    ( R10.Form.Internal.Key.Key
                    , R10.FormTypes.FieldType
                    , Maybe R10.Form.Internal.FieldConf.ValidationSpecs
                    )
            allKeys =
                allValidationKeysMaker { conf = conf, state = state }
        in
        entitiesWithErrors allKeys state.fieldsState

    else
        []


shouldShowTheValidationOverview : R10.Form.Internal.State.State -> Bool
shouldShowTheValidationOverview formState =
    R10.Form.Internal.QtySubmitAttempted.toInt formState.qtySubmitAttempted > 0 && not formState.changesSinceLastSubmissions


isFormSubmittable : R10.Form.Internal.Shared.Form -> Bool
isFormSubmittable form =
    if R10.Form.Internal.QtySubmitAttempted.toInt form.state.qtySubmitAttempted == 0 then
        -- Always submittable if it has never been submitted
        True

    else
        isEntireFormValid form


isFormSubmittableAndSubmitted : R10.Form.Internal.Shared.Form -> R10.Form.Internal.Msg.Msg -> Bool
isFormSubmittableAndSubmitted form formMsg =
    isFormSubmittable form && R10.Form.Internal.Msg.isSubmitted formMsg



-- ███████ ██    ██ ██████  ███    ███ ██ ████████     ███████  ██████  ██████  ███    ███
-- ██      ██    ██ ██   ██ ████  ████ ██    ██        ██      ██    ██ ██   ██ ████  ████
-- ███████ ██    ██ ██████  ██ ████ ██ ██    ██        █████   ██    ██ ██████  ██ ████ ██
--      ██ ██    ██ ██   ██ ██  ██  ██ ██    ██        ██      ██    ██ ██   ██ ██  ██  ██
-- ███████  ██████  ██████  ██      ██ ██    ██        ██       ██████  ██   ██ ██      ██


submit :
    (String -> String -> String)
    -> R10.Form.Internal.Shared.Form
    -> R10.Form.Internal.State.State
submit formStateBeforeValidationFixer form =
    let
        newFieldsState : R10.Form.Internal.State.State
        newFieldsState =
            if isFormSubmittable form then
                -- Why we validating the entire form only if it is submittable?
                validateEntireForm formStateBeforeValidationFixer form

            else
                form.state

        newQtySubmitAttempted : R10.Form.Internal.QtySubmitAttempted.QtySubmitAttempted
        newQtySubmitAttempted =
            R10.Form.Internal.QtySubmitAttempted.increment form.state.qtySubmitAttempted
    in
    { newFieldsState | qtySubmitAttempted = newQtySubmitAttempted }



-- ██    ██ ██████  ██████   █████  ████████ ███████
-- ██    ██ ██   ██ ██   ██ ██   ██    ██    ██
-- ██    ██ ██████  ██   ██ ███████    ██    █████
-- ██    ██ ██      ██   ██ ██   ██    ██    ██
--  ██████  ██      ██████  ██   ██    ██    ███████


onGetFocus :
    (String -> String -> String)
    -> R10.Form.Internal.Key.Key
    -> R10.Form.Internal.FieldConf.FieldConf
    -> R10.Form.Internal.State.State
    -> R10.Form.Internal.State.State
onGetFocus formStateBeforeValidationFixer key fieldConf formState =
    let
        lostFocusOneOrMoreTime : Bool
        lostFocusOneOrMoreTime =
            formState.fieldsState
                |> R10.Form.Internal.Dict.get key
                |> Maybe.map .lostFocusOneOrMoreTime
                |> Maybe.withDefault False
    in
    { formState
        | focused = Just (R10.Form.Internal.Key.toString key)
        , fieldsState =
            formState.fieldsState
                |> R10.Form.Internal.Dict.update key
                    --
                    -- Here we update the value "valueWhenFocused"
                    --
                    (Maybe.map (\v -> { v | valueWhenFocused = v.value }))
                |> (\fieldState ->
                        (--
                         -- VALIDATION
                         --
                         -- 2022.04.27 This is a special case for fields like the password.
                         -- We want the validation to start as soon as the user focus on the
                         -- field because the validations are used as instructions for the user
                         -- about the requirements of the password.
                         --
                         -- But if there are errors from the server, like for example
                         -- PASSWORD_USERUSERNAME_IDENTICAL, these errors will be wrongly removed
                         -- when the user focus the field, when instead they should be removed
                         -- when the user change the value (See this ticket:
                         -- https://jira.rakuten-it.com/jira/browse/OMN-5526)
                         --
                         -- To avoid this condition, I added the "not lostFocusOneOrMoreTime"
                         -- condition so to run the validation on the first focus, and not on
                         -- the following focuses.
                         --
                         if isShowAlsoPassedValidation fieldConf.validationSpecs && not lostFocusOneOrMoreTime then
                            fieldState
                                --
                                -- Removed the next line on 2022.04.26 because it didn't
                                -- make much sense
                                --
                                -- |> R10.Form.Internal.Dict.update key helperLostFocus
                                --
                                |> R10.Form.Internal.Dict.update key
                                    (helperValidateCreatingFieldsState
                                        { formStateBeforeValidationFixer = formStateBeforeValidationFixer
                                        , showAlsoPassedValidation = isShowAlsoPassedValidation fieldConf.validationSpecs
                                        , key = key
                                        , fieldType = fieldConf.type_
                                        , maybeValidationSpec = fieldConf.validationSpecs
                                        , formState = formState
                                        }
                                    )

                         else
                            fieldState
                        )
                   )
    }


onLoseFocus :
    (String -> String -> String)
    -> R10.Form.Internal.Key.Key
    -> R10.Form.Internal.FieldConf.FieldConf
    -> R10.Form.Internal.State.State
    -> R10.Form.Internal.State.State
onLoseFocus formStateBeforeValidationFixer key fieldConf formState =
    let
        valueIsTheSameAsWhenFocusedIn : Bool
        valueIsTheSameAsWhenFocusedIn =
            formState.fieldsState
                |> R10.Form.Internal.Dict.get key
                |> Maybe.map
                    (\fieldState ->
                        (String.Extra.isBlank fieldState.valueWhenFocused && String.Extra.isBlank fieldState.value)
                            || (fieldState.valueWhenFocused == fieldState.value)
                    )
                |> Maybe.withDefault True
    in
    { formState
        | focused = Nothing
        , fieldsState =
            --
            -- We run the validation only if the field has been changed since focusing
            -- in. This is to avoid this issue:
            -- https://jira.rakuten-it.com/jira/browse/OMN-5526
            --
            -- Probably to fix this even better, we should run the validation
            -- also if user edited the field and eventually made it exactly the
            -- same as it was when the field was focused in.
            --
            -- Another solution is to leverage "changesSinceLastSubmissions" but
            -- I could not verify if this value is properly reset upon submission.
            -- It seems that it stays always as True, also when the form is
            -- submitted. Maybe it only happens in localhost. Need more time
            -- to verify that.
            --
            -- So as a temporary solution, I will keep using
            -- "valueIsTheSameAsWhenFocusedIn". In the future we can remove
            -- this flag if not needed anymore.
            --
            if valueIsTheSameAsWhenFocusedIn then
                formState.fieldsState

            else
                formState.fieldsState
                    |> convertToFullwidthKatakanaIfNecessary key
                    |> R10.Form.Internal.Dict.update key helperLostFocus
                    |> R10.Form.Internal.Dict.update key
                        (validateIfLostFocusAtLeastOnce
                            { formStateBeforeValidationFixer = formStateBeforeValidationFixer
                            , showAlsoPassedValidation = isShowAlsoPassedValidation fieldConf.validationSpecs
                            , key = key
                            , fieldType = fieldConf.type_
                            , maybeValidationSpec = fieldConf.validationSpecs
                            , formState = formState
                            }
                        )
    }


convertToFullwidthKatakanaIfNecessary :
    R10.Form.Internal.Key.Key
    -> Dict.Dict String { a | value : String }
    -> Dict.Dict String { a | value : String }
convertToFullwidthKatakanaIfNecessary key fieldsState =
    let
        headId : String
        headId =
            R10.Form.Internal.Key.headId key

        maybeNewKanaValue : Maybe String
        maybeNewKanaValue =
            (-- We convert Hiragana or Half-width katakana to Full-width katakana
             -- https://jira.rakuten-it.com/jira/browse/OMN-5269
             if String.contains "kana" headId then
                fieldsState
                    |> Dict.get (R10.Form.Internal.Key.toString key)
                    |> Maybe.map .value
                    |> Maybe.map R10.KatakanaConverter.halfWidthKatakanaAndHiraganaToFullWidthKatakana

             else if String.contains "nickname" headId || String.contains "last_name" headId || String.contains "first_name" headId then
                fieldsState
                    |> Dict.get (R10.Form.Internal.Key.toString key)
                    |> Maybe.map .value
                    |> Maybe.map R10.KatakanaConverter.halfWidthKatakanaToFullWidthKatakana

             else
                Nothing
            )
    in
    case maybeNewKanaValue of
        Nothing ->
            fieldsState

        Just newKanaValue ->
            Dict.update
                (R10.Form.Internal.Key.toString key)
                (\mv -> Maybe.andThen (\v -> Just { v | value = newKanaValue }) mv)
                fieldsState


onDeactivate : R10.Form.Internal.State.State -> R10.Form.Internal.State.State
onDeactivate formState =
    { formState | active = Nothing }


onActivate : R10.Form.Internal.Key.Key -> R10.Form.Internal.State.State -> R10.Form.Internal.State.State
onActivate key formState =
    { formState
        | active = Just (R10.Form.Internal.Key.toString key)
    }


onScroll : R10.Form.Internal.Key.Key -> Float -> R10.Form.Internal.State.State -> R10.Form.Internal.State.State
onScroll key scroll formState =
    { formState | fieldsState = formState.fieldsState |> R10.Form.Internal.Dict.update key (helperUpdateScroll scroll) }


onChangeValue : (String -> String -> String) -> Bool -> R10.Form.Internal.Key.Key -> R10.Form.Internal.FieldConf.FieldConf -> R10.Form.Internal.Conf.Conf -> String -> R10.Form.Internal.State.State -> R10.Form.Internal.State.State
onChangeValue formStateBeforeValidationFixer showAlsoPassedValidation key fieldConf formConf string formState =
    { formState
        | focused = Just (R10.Form.Internal.Key.toString key)
        , fieldsState =
            formState.fieldsState
                |> R10.Form.Internal.Dict.update key (helperUpdateValue fieldConf string)
                |> R10.Form.Internal.Dict.update key helperUpdateDirty
                |> R10.Form.Internal.Dict.update key
                    (helperValidateOnChangeValue
                        { formStateBeforeValidationFixer = formStateBeforeValidationFixer
                        , showAlsoPassedValidation = showAlsoPassedValidation
                        , key = key
                        , fieldType = fieldConf.type_
                        , maybeValidationSpec = fieldConf.validationSpecs
                        , qtySubmitAttempted = formState.qtySubmitAttempted
                        , formState = formState
                        }
                    )
                |> helperCopyEmailIntoUsername key string
        , lastKeyDownIsProcess = False
    }
        |> helperResetUsernameValidation key string formConf formStateBeforeValidationFixer


onChangeSearch : R10.Form.Internal.Key.Key -> String -> R10.Form.Internal.State.State -> R10.Form.Internal.State.State
onChangeSearch key string formState =
    { formState | fieldsState = formState.fieldsState |> R10.Form.Internal.Dict.update key (helperUpdateSearch string) }


onChangeSelect : R10.Form.Internal.Key.Key -> String -> R10.Form.Internal.State.State -> R10.Form.Internal.State.State
onChangeSelect key string formState =
    { formState | fieldsState = formState.fieldsState |> R10.Form.Internal.Dict.update key (helperUpdateSelect string) }


onChangeOver : R10.Form.Internal.Key.Key -> Maybe String -> R10.Form.Internal.State.State -> R10.Form.Internal.State.State
onChangeOver key string formState =
    { formState | fieldsState = formState.fieldsState |> R10.Form.Internal.Dict.update key (helperUpdateOver string) }


update :
    (String -> String -> String)
    -> R10.Form.Internal.Msg.Msg
    -> R10.Form.Internal.State.State
    -> ( R10.Form.Internal.State.State, Cmd R10.Form.Internal.Msg.Msg )
update formStateBeforeValidationFixer msg formStateBeforeHandleChangesSinceLastSubmissions =
    let
        formState : R10.Form.Internal.State.State
        formState =
            { formStateBeforeHandleChangesSinceLastSubmissions
                | changesSinceLastSubmissions =
                    R10.Form.Internal.Msg.handleChangesSinceLastSubmissions
                        formStateBeforeHandleChangesSinceLastSubmissions.changesSinceLastSubmissions
                        msg
            }
    in
    case msg of
        R10.Form.Internal.Msg.NoOp ->
            ( formState, Cmd.none )

        R10.Form.Internal.Msg.Submit formConf ->
            ( submit formStateBeforeValidationFixer { conf = formConf, state = formState }, Cmd.none )

        R10.Form.Internal.Msg.GetFocus key fieldConf ->
            ( onGetFocus formStateBeforeValidationFixer key fieldConf formState
            , Cmd.none
            )

        R10.Form.Internal.Msg.LoseFocus key fieldConf ->
            ( onLoseFocus formStateBeforeValidationFixer key fieldConf formState
            , Cmd.none
            )

        R10.Form.Internal.Msg.TogglePasswordShow key ->
            ( { formState
                | fieldsState =
                    formState.fieldsState
                        |> R10.Form.Internal.Dict.update key helperToggleShowPassword
              }
            , Cmd.none
            )

        R10.Form.Internal.Msg.ChangeTab key string ->
            ( { formState
                | activeTabs =
                    formState.activeTabs
                        |> R10.Form.Internal.Dict.insert key string
              }
            , Cmd.none
            )

        R10.Form.Internal.Msg.AddEntity key ->
            let
                presentQuantity : Int
                presentQuantity =
                    Maybe.withDefault 1 <| R10.Form.Internal.Dict.get key formState.multiplicableQuantities
            in
            ( { formState
                | multiplicableQuantities =
                    formState.multiplicableQuantities
                        |> R10.Form.Internal.Dict.insert key (presentQuantity + 1)
              }
            , Cmd.none
            )

        R10.Form.Internal.Msg.RemoveEntity key ->
            ( { formState
                | removed =
                    formState.removed
                        |> Set.insert (R10.Form.Internal.Key.toString key)
              }
            , Cmd.none
            )

        R10.Form.Internal.Msg.KeyDown keyCode ->
            ( { formState
                | lastKeyDownIsProcess = keyCode == 229
              }
            , Cmd.none
            )

        R10.Form.Internal.Msg.Hover key over ->
            ( { formState
                | fieldsState =
                    formState.fieldsState
                        |> R10.Form.Internal.Dict.update key (helperUpdateOver over)
              }
            , Cmd.none
            )

        R10.Form.Internal.Msg.ChangeValue key fieldConf formConf contextR10 string ->
            if formState.lastKeyDownIsProcess && R10.Device.isChromeDesktop contextR10.device then
                ( { formState | lastKeyDownIsProcess = False }, Cmd.none )

            else
                ( onChangeValue formStateBeforeValidationFixer (isShowAlsoPassedValidation fieldConf.validationSpecs) key fieldConf formConf string formState, Cmd.none )

        R10.Form.Internal.Msg.OnSingleMsg key fieldConf formConf singleMsg ->
            let
                fieldState : R10.Form.Internal.FieldState.FieldState
                fieldState =
                    R10.Form.Internal.Dict.get key formState.fieldsState
                        |> stateWithDefault

                singleModel : R10.FormComponents.Internal.Single.Common.Model
                singleModel =
                    { value = fieldState.value
                    , search = fieldState.search
                    , select = fieldState.select
                    , scroll = fieldState.scroll
                    , focused = formState.focused == Just (R10.Form.Internal.Key.toString key)
                    , opened = formState.active == Just (R10.Form.Internal.Key.toString key)
                    , over = fieldState.over
                    }

                ( newSingleModel, singleCmd ) =
                    R10.FormComponents.Internal.Single.Update.update singleMsg singleModel

                newFormState : R10.Form.Internal.State.State
                newFormState =
                    copyComponentStateToFormState
                        { formStateBeforeValidationFixer = formStateBeforeValidationFixer
                        , fieldConf = fieldConf
                        , fieldState = fieldState
                        , formConf = formConf
                        , formState = formState
                        , key = key
                        , newSingleModel = newSingleModel
                        , singleModel = singleModel
                        }
            in
            ( newFormState
            , Cmd.map (R10.Form.Internal.Msg.OnSingleMsg key fieldConf formConf) singleCmd
            )

        R10.Form.Internal.Msg.OnPhoneMsg key fieldConf formConf phoneMsg ->
            let
                fieldState : R10.Form.Internal.FieldState.FieldState
                fieldState =
                    R10.Form.Internal.Dict.get key formState.fieldsState
                        |> stateWithDefault

                singleModel : R10.FormComponents.Internal.Single.Common.Model
                singleModel =
                    { value = fieldState.value
                    , search = fieldState.search
                    , select = fieldState.select
                    , scroll = fieldState.scroll
                    , focused = formState.focused == Just (R10.Form.Internal.Key.toString key)
                    , opened = formState.active == Just (R10.Form.Internal.Key.toString key)
                    , over = fieldState.over
                    }

                ( newSingleModel, singleCmd ) =
                    R10.FormComponents.Internal.Phone.Update.update phoneMsg singleModel

                newFormState : R10.Form.Internal.State.State
                newFormState =
                    copyComponentStateToFormState
                        { formStateBeforeValidationFixer = formStateBeforeValidationFixer
                        , fieldConf = fieldConf
                        , fieldState = fieldState
                        , formConf = formConf
                        , formState = formState
                        , key = key
                        , newSingleModel = newSingleModel
                        , singleModel = singleModel
                        }
            in
            ( newFormState
            , Cmd.map (R10.Form.Internal.Msg.OnPhoneMsg key fieldConf formConf) singleCmd
            )


isShowAlsoPassedValidation : Maybe { a | showAlsoPassedValidation : Bool } -> Bool
isShowAlsoPassedValidation maybeValidationSpecs =
    --
    -- In case a field is set to isShowAlsoPassedValidation == True (usually
    -- a password, it also means that
    --
    --    * The validation should start on focus (this is necessary because we use the
    --      validations as instructions for the users)
    --    * The "required" validation is hidden
    --    * Validations are showing also when they are "green"
    --
    case maybeValidationSpecs of
        Just validationSpecs ->
            validationSpecs.showAlsoPassedValidation

        Nothing ->
            False


copyComponentStateToFormState :
    { formStateBeforeValidationFixer : String -> String -> String
    , fieldConf : R10.Form.Internal.FieldConf.FieldConf
    , fieldState : R10.Form.Internal.FieldState.FieldState
    , formConf : R10.Form.Internal.Conf.Conf
    , key : R10.Form.Internal.Key.Key
    , newSingleModel : R10.FormComponents.Internal.Single.Common.Model
    , singleModel : R10.FormComponents.Internal.Single.Common.Model
    , formState : R10.Form.Internal.State.State
    }
    -> R10.Form.Internal.State.State
copyComponentStateToFormState args =
    args.formState
        |> (if args.fieldState.value /= args.newSingleModel.value then
                onChangeValue args.formStateBeforeValidationFixer
                    (isShowAlsoPassedValidation args.fieldConf.validationSpecs)
                    args.key
                    args.fieldConf
                    args.formConf
                    args.newSingleModel.value

            else
                identity
           )
        |> (if args.fieldState.search /= args.newSingleModel.search then
                onChangeSearch args.key args.newSingleModel.search

            else
                identity
           )
        |> (if args.fieldState.select /= args.newSingleModel.select then
                onChangeSelect args.key args.newSingleModel.select

            else
                identity
           )
        |> (if args.fieldState.scroll /= args.newSingleModel.scroll then
                onScroll args.key args.newSingleModel.scroll

            else
                identity
           )
        |> (if args.singleModel.focused /= args.newSingleModel.focused then
                if args.newSingleModel.focused then
                    onGetFocus args.formStateBeforeValidationFixer args.key args.fieldConf

                else
                    onLoseFocus args.formStateBeforeValidationFixer args.key args.fieldConf

            else
                identity
           )
        |> (if args.singleModel.opened /= args.newSingleModel.opened then
                if args.newSingleModel.opened then
                    onActivate args.key

                else
                    onDeactivate

            else
                identity
           )
        |> (if args.singleModel.over /= args.newSingleModel.over then
                onChangeOver args.key args.newSingleModel.over

            else
                identity
           )
