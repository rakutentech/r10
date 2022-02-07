module R10.Form.Internal.Update exposing
    ( allErrorsForView
    , allValidationKeysMaker
    , entitiesWithErrors
    , entitiesWithErrorsForOnlyExistingValidations
    , isEntireFormValid
    , isExistingFormFieldsValid
    , isFormSubmittableAndSubmitted
    , runAllValidations
    , runOnlyExistingValidations
    , shouldShowTheValidationOverview
    , submit
    , submittable
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
import Set


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
        allKeys : List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
        allKeys =
            allValidationKeysMaker form

        fieldsWithErrors_ : List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
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


helperUpdateValue : String -> Maybe R10.Form.Internal.FieldState.FieldState -> Maybe R10.Form.Internal.FieldState.FieldState
helperUpdateValue value maybeFieldState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | value = value }


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
    Just { fieldState | lostFocusOneOrMoreTime = True }


helperValidateCreatingFieldsState :
    (String -> String -> String)
    -> Bool
    -> R10.Form.Internal.Key.Key
    -> R10.FormTypes.FieldType
    -> Maybe R10.Form.Internal.FieldConf.ValidationSpecs
    -> R10.Form.Internal.State.State
    -> Maybe R10.Form.Internal.FieldState.FieldState
    -> Maybe R10.Form.Internal.FieldState.FieldState
helperValidateCreatingFieldsState formStateBeforeValidationFixer showAlsoPassedValidation key fieldType maybeValidationSpec formState maybeFieldState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    maybeFieldState
        |> Maybe.withDefault R10.Form.Internal.FieldState.init
        |> R10.Form.Internal.Validation.validate formStateBeforeValidationFixer showAlsoPassedValidation key fieldType maybeValidationSpec formState
        |> Just


helperValidateOnChangeValue :
    (String -> String -> String)
    -> Bool
    -> R10.Form.Internal.Key.Key
    -> R10.FormTypes.FieldType
    -> Maybe R10.Form.Internal.FieldConf.ValidationSpecs
    -> R10.Form.Internal.QtySubmitAttempted.QtySubmitAttempted
    -> R10.Form.Internal.State.State
    -> Maybe R10.Form.Internal.FieldState.FieldState
    -> Maybe R10.Form.Internal.FieldState.FieldState
helperValidateOnChangeValue formStateBeforeValidationFixer showAlsoPassedValidation key fieldType maybeValidationSpec qtySubmitAttempted formState maybeFieldState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    if shouldValidationBeVisible fieldType qtySubmitAttempted fieldState then
        helperValidateCreatingFieldsState formStateBeforeValidationFixer showAlsoPassedValidation key fieldType maybeValidationSpec formState maybeFieldState

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
                (helperValidateCreatingFieldsState formStateBeforeValidationFixer
                    (isShowAlsoPassedValidation maybeValidationSpec)
                    key
                    fieldType
                    maybeValidationSpec
                    formState
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
                                |> R10.Form.Internal.Validation.validate formStateBeforeValidationFixer
                                    (isShowAlsoPassedValidation maybeValidationSpec)
                                    key
                                    fieldType
                                    maybeValidationSpec
                                    formState
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
            allKeys : List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
            allKeys =
                allValidationKeysMaker { conf = conf, state = state }
        in
        entitiesWithErrors allKeys state.fieldsState

    else
        []


shouldShowTheValidationOverview : R10.Form.Internal.State.State -> Bool
shouldShowTheValidationOverview formState =
    R10.Form.Internal.QtySubmitAttempted.toInt formState.qtySubmitAttempted > 0 && not formState.changesSinceLastSubmissions


submittable : R10.Form.Internal.Shared.Form -> Bool
submittable form =
    if R10.Form.Internal.QtySubmitAttempted.toInt form.state.qtySubmitAttempted == 0 then
        -- Always submittable if it has never been submitted
        True

    else
        isEntireFormValid form


isFormSubmittableAndSubmitted : R10.Form.Internal.Shared.Form -> R10.Form.Internal.Msg.Msg -> Bool
isFormSubmittableAndSubmitted form formMsg =
    submittable form && R10.Form.Internal.Msg.isSubmitted formMsg



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
            validateEntireForm formStateBeforeValidationFixer form

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
    { formState
        | focused = Just (R10.Form.Internal.Key.toString key)
        , fieldsState =
            if isShowAlsoPassedValidation fieldConf.validationSpecs then
                formState.fieldsState
                    |> R10.Form.Internal.Dict.update key helperLostFocus
                    |> R10.Form.Internal.Dict.update key
                        (helperValidateCreatingFieldsState
                            formStateBeforeValidationFixer
                            (isShowAlsoPassedValidation fieldConf.validationSpecs)
                            key
                            fieldConf.type_
                            fieldConf.validationSpecs
                            formState
                        )

            else
                formState.fieldsState
    }


onLoseFocus :
    (String -> String -> String)
    -> R10.Form.Internal.Key.Key
    -> R10.Form.Internal.FieldConf.FieldConf
    -> R10.Form.Internal.State.State
    -> R10.Form.Internal.State.State
onLoseFocus formStateBeforeValidationFixer key fieldConf formState =
    { formState
        | focused = Nothing
        , fieldsState =
            formState.fieldsState
                |> R10.Form.Internal.Dict.update key helperLostFocus
                |> R10.Form.Internal.Dict.update
                    key
                    (helperValidateCreatingFieldsState
                        formStateBeforeValidationFixer
                        (isShowAlsoPassedValidation fieldConf.validationSpecs)
                        key
                        fieldConf.type_
                        fieldConf.validationSpecs
                        formState
                    )
    }


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
                |> R10.Form.Internal.Dict.update key (helperUpdateValue string)
                |> R10.Form.Internal.Dict.update key helperUpdateDirty
                |> R10.Form.Internal.Dict.update key (helperValidateOnChangeValue formStateBeforeValidationFixer showAlsoPassedValidation key fieldConf.type_ fieldConf.validationSpecs formState.qtySubmitAttempted formState)
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


update : (String -> String -> String) -> R10.Form.Internal.Msg.Msg -> R10.Form.Internal.State.State -> ( R10.Form.Internal.State.State, Cmd R10.Form.Internal.Msg.Msg )
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

        R10.Form.Internal.Msg.ChangeValue key fieldConf formConf contextR10 string ->
            if formState.lastKeyDownIsProcess && R10.Device.isChromeDesktop contextR10.userAgent then
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
    --    * the validation should start on focus
    --    * the "required" validation is hidden
    --    * also green validations are showing
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
    , formState : R10.Form.Internal.State.State
    , key : R10.Form.Internal.Key.Key
    , newSingleModel : R10.FormComponents.Internal.Single.Common.Model
    , singleModel : R10.FormComponents.Internal.Single.Common.Model
    }
    -> R10.Form.Internal.State.State
copyComponentStateToFormState { formStateBeforeValidationFixer, formState, key, fieldConf, formConf, fieldState, singleModel, newSingleModel } =
    formState
        |> (if fieldState.value /= newSingleModel.value then
                onChangeValue formStateBeforeValidationFixer
                    (isShowAlsoPassedValidation fieldConf.validationSpecs)
                    key
                    fieldConf
                    formConf
                    newSingleModel.value

            else
                identity
           )
        |> (if fieldState.search /= newSingleModel.search then
                onChangeSearch key newSingleModel.search

            else
                identity
           )
        |> (if fieldState.select /= newSingleModel.select then
                onChangeSelect key newSingleModel.select

            else
                identity
           )
        |> (if fieldState.scroll /= newSingleModel.scroll then
                onScroll key newSingleModel.scroll

            else
                identity
           )
        |> (if singleModel.focused /= newSingleModel.focused then
                if newSingleModel.focused then
                    onGetFocus formStateBeforeValidationFixer key fieldConf

                else
                    onLoseFocus formStateBeforeValidationFixer key fieldConf

            else
                identity
           )
        |> (if singleModel.opened /= newSingleModel.opened then
                if newSingleModel.opened then
                    onActivate key

                else
                    onDeactivate

            else
                identity
           )
