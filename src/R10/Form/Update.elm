module Form.Update exposing
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
import Form.Conf
import Form.Dict
import Form.FieldConf
import Form.FieldState
import Form.Key
import Form.MakerForValidationKeys
import Form.Msg
import Form.QtySubmitAttempted as QtySubmitAttempted exposing (QtySubmitAttempted)
import Form.State
import Form.Validation
import FormComponents.Single.Common
import FormComponents.Single.Update
import Set


stateWithDefault : Maybe Form.FieldState.FieldState -> Form.FieldState.FieldState
stateWithDefault maybeFieldState =
    Maybe.withDefault Form.FieldState.init maybeFieldState



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


{-| Is there no validation error inside the form
-}
isEntireFormValid : Form.Conf.Conf -> Form.State.State -> Bool
isEntireFormValid conf state =
    let
        allKeys : List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
        allKeys =
            allValidationKeysMaker conf state

        fieldsWithErrors_ : List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
        fieldsWithErrors_ =
            entitiesWithErrors allKeys state.fieldsState
    in
    List.head fieldsWithErrors_ == Nothing


{-| Is there no validation error inside the form
-}
isExistingFormFieldsValid : Form.Conf.Conf -> Form.State.State -> Bool
isExistingFormFieldsValid conf state =
    let
        allKeys : List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
        allKeys =
            allValidationKeysMaker conf state

        fieldsWithErrors_ : List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
        fieldsWithErrors_ =
            entitiesWithErrorsForOnlyExistingValidations allKeys state.fieldsState
    in
    List.head fieldsWithErrors_ == Nothing


{-| Validate the entire form
-}
validateEntireForm : Form.Conf.Conf -> Form.State.State -> Form.State.State
validateEntireForm conf state =
    let
        allKeys : List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
        allKeys =
            allValidationKeysMaker conf state

        newFieldsState : Dict.Dict String Form.FieldState.FieldState
        newFieldsState =
            runAllValidations allKeys state state.fieldsState
    in
    { state | fieldsState = newFieldsState }


{-| Validate the entire form
-}
validateDirtyFormFields : Form.Conf.Conf -> Form.State.State -> Form.State.State
validateDirtyFormFields conf state =
    let
        allKeys : List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
        allKeys =
            allValidationKeysMaker conf state

        newFieldsState : Dict.Dict String Form.FieldState.FieldState
        newFieldsState =
            runOnlyExistingValidations allKeys state state.fieldsState
    in
    { state | fieldsState = newFieldsState }


helperToggleShowPassword : Maybe Form.FieldState.FieldState -> Maybe Form.FieldState.FieldState
helperToggleShowPassword maybeFieldState =
    let
        fieldState : Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | showPassword = not fieldState.showPassword }


helperUpdateValue : String -> Maybe Form.FieldState.FieldState -> Maybe Form.FieldState.FieldState
helperUpdateValue value maybeFieldState =
    let
        fieldState : Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | value = value }


helperUpdateSearch : String -> Maybe Form.FieldState.FieldState -> Maybe Form.FieldState.FieldState
helperUpdateSearch value maybeFieldState =
    let
        fieldState : Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | search = value }


helperUpdateSelect : String -> Maybe Form.FieldState.FieldState -> Maybe Form.FieldState.FieldState
helperUpdateSelect value maybeFieldState =
    let
        fieldState : Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | select = value }


helperUpdateScroll : Float -> Maybe Form.FieldState.FieldState -> Maybe Form.FieldState.FieldState
helperUpdateScroll value maybeScroll =
    let
        fieldState : Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeScroll
    in
    Just { fieldState | scroll = value }


helperUpdateDirty : Maybe Form.FieldState.FieldState -> Maybe Form.FieldState.FieldState
helperUpdateDirty maybeFieldState =
    let
        fieldState : Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | dirty = True }


helperLostFocus : Maybe Form.FieldState.FieldState -> Maybe Form.FieldState.FieldState
helperLostFocus maybeFieldState =
    let
        fieldState : Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | lostFocusOneOrMoreTime = True }


helperValidateCreatingFieldsState : Form.Key.Key -> Maybe Form.FieldConf.ValidationSpecs -> Form.State.State -> Maybe Form.FieldState.FieldState -> Maybe Form.FieldState.FieldState
helperValidateCreatingFieldsState key maybeValidationSpec formState maybeFieldState =
    let
        fieldState : Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just <| Form.Validation.validate key maybeValidationSpec formState fieldState


helperValidateWithoutCreatingFieldsState : Maybe Form.FieldConf.ValidationSpecs -> Form.State.State -> Form.Key.Key -> Maybe Form.FieldState.FieldState -> Maybe Form.FieldState.FieldState
helperValidateWithoutCreatingFieldsState maybeValidationSpec formState key maybeFieldState =
    Maybe.map (Form.Validation.validate key maybeValidationSpec formState) maybeFieldState


helperValidateOnChangeValue : Form.Key.Key -> Maybe Form.FieldConf.ValidationSpecs -> QtySubmitAttempted -> Form.State.State -> Maybe Form.FieldState.FieldState -> Maybe Form.FieldState.FieldState
helperValidateOnChangeValue key maybeValidationSpec qtySubmitAttempted formState maybeFieldState =
    let
        fieldState : Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    if fieldState.lostFocusOneOrMoreTime || QtySubmitAttempted.toInt qtySubmitAttempted > 0 then
        helperValidateCreatingFieldsState key maybeValidationSpec formState maybeFieldState

    else
        maybeFieldState



--
-- OTHER HELPERS
--


allValidationKeysMaker : Form.Conf.Conf -> Form.State.State -> List Form.MakerForValidationKeys.Outcome
allValidationKeysMaker conf state =
    Form.MakerForValidationKeys.maker Form.Key.empty state conf


runAllValidations :
    List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
    -> Form.State.State
    -> Dict.Dict String Form.FieldState.FieldState
    -> Dict.Dict String Form.FieldState.FieldState
runAllValidations allKeys formState fieldsState =
    -- Validate the entire form, creating new `fieldState` if necessary,
    -- when such fields were not yet touched, for example
    List.foldl
        (\( key, validationSpec ) acc ->
            Form.Dict.update key (helperValidateCreatingFieldsState key validationSpec formState) acc
        )
        fieldsState
        allKeys


runOnlyExistingValidations :
    List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
    -> Form.State.State
    -> Dict.Dict String Form.FieldState.FieldState
    -> Dict.Dict String Form.FieldState.FieldState
runOnlyExistingValidations allKeys formState fieldsState =
    -- Validate the entire form, without creating new `fieldState`
    List.foldl
        (\( key, fieldConf ) acc ->
            Form.Dict.update key (helperValidateWithoutCreatingFieldsState fieldConf formState key) acc
        )
        fieldsState
        allKeys


entitiesWithErrors :
    List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
    -> Dict.Dict String Form.FieldState.FieldState
    -> List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
entitiesWithErrors allKeys fieldsState =
    -- Return the list of field that either didn't pass
    -- the validation or were not validated. Used to understand if a form has been
    -- filled properly and show a comprehensive error at the bottom.
    -- If a field has not yet been validated, it is considered as an error.
    -- So this function require all validations to be run before being called.
    List.filter
        (\( key, _ ) ->
            let
                fieldState : Form.FieldState.FieldState
                fieldState =
                    Maybe.withDefault Form.FieldState.init <| Form.Dict.get key fieldsState
            in
            case Form.FieldState.isValid fieldState.validation of
                Form.FieldState.NotYetValidated2 ->
                    True

                Form.FieldState.NotValid ->
                    True

                Form.FieldState.Valid ->
                    False
        )
        allKeys


entitiesWithErrorsForOnlyExistingValidations :
    List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
    -> Dict.Dict String Form.FieldState.FieldState
    -> List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
entitiesWithErrorsForOnlyExistingValidations allKeys fieldsState =
    List.filter
        (\( key, _ ) ->
            let
                fieldState : Form.FieldState.FieldState
                fieldState =
                    Maybe.withDefault Form.FieldState.init <| Form.Dict.get key fieldsState
            in
            case Form.FieldState.isValid fieldState.validation of
                Form.FieldState.NotYetValidated2 ->
                    False

                Form.FieldState.NotValid ->
                    True

                Form.FieldState.Valid ->
                    False
        )
        allKeys


allErrorsForView : Form.Conf.Conf -> Form.State.State -> List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
allErrorsForView conf state =
    if shouldShowTheValidationOverview state then
        let
            allKeys : List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
            allKeys =
                allValidationKeysMaker conf state
        in
        entitiesWithErrors allKeys state.fieldsState

    else
        []


shouldShowTheValidationOverview : Form.State.State -> Bool
shouldShowTheValidationOverview formState =
    QtySubmitAttempted.toInt formState.qtySubmitAttempted > 0 && not formState.changesSinceLastSubmissions


submittable : Form.Conf.Conf -> Form.State.State -> Bool
submittable conf state =
    if QtySubmitAttempted.toInt state.qtySubmitAttempted == 0 then
        -- Always submittable if it has never been submitted
        True

    else
        isEntireFormValid conf state


isFormSubmittableAndSubmitted : Form.Conf.Conf -> Form.State.State -> Form.Msg.Msg -> Bool
isFormSubmittableAndSubmitted conf state formMsg =
    submittable conf state && Form.Msg.isSubmitted formMsg



-- ███████ ██    ██ ██████  ███    ███ ██ ████████     ███████  ██████  ██████  ███    ███
-- ██      ██    ██ ██   ██ ████  ████ ██    ██        ██      ██    ██ ██   ██ ████  ████
-- ███████ ██    ██ ██████  ██ ████ ██ ██    ██        █████   ██    ██ ██████  ██ ████ ██
--      ██ ██    ██ ██   ██ ██  ██  ██ ██    ██        ██      ██    ██ ██   ██ ██  ██  ██
-- ███████  ██████  ██████  ██      ██ ██    ██        ██       ██████  ██   ██ ██      ██


submit :
    Form.Conf.Conf
    -> Form.State.State
    -> Form.State.State
submit conf state =
    let
        newFieldsState : Form.State.State
        newFieldsState =
            validateEntireForm conf state

        newQtySubmitAttempted : QtySubmitAttempted
        newQtySubmitAttempted =
            QtySubmitAttempted.increment state.qtySubmitAttempted
    in
    { newFieldsState | qtySubmitAttempted = newQtySubmitAttempted }



-- ██    ██ ██████  ██████   █████  ████████ ███████
-- ██    ██ ██   ██ ██   ██ ██   ██    ██    ██
-- ██    ██ ██████  ██   ██ ███████    ██    █████
-- ██    ██ ██      ██   ██ ██   ██    ██    ██
--  ██████  ██      ██████  ██   ██    ██    ███████


onGetFocus : Form.Key.Key -> Form.State.State -> Form.State.State
onGetFocus key formState =
    { formState
        | focused = Just (Form.Key.toString key)
    }


onLoseFocus : Form.Key.Key -> Form.FieldConf.FieldConf -> Form.State.State -> Form.State.State
onLoseFocus key fieldConf formState =
    { formState
        | focused = Nothing
        , fieldsState =
            formState.fieldsState
                |> Form.Dict.update key helperLostFocus
                |> Form.Dict.update key (helperValidateCreatingFieldsState key fieldConf.validationSpecs formState)
    }


onDeactivate : Form.State.State -> Form.State.State
onDeactivate formState =
    { formState | active = Nothing }


onActivate : Form.Key.Key -> Form.State.State -> Form.State.State
onActivate key formState =
    { formState
        | active = Just (Form.Key.toString key)
    }


onScroll : Form.Key.Key -> Float -> Form.State.State -> Form.State.State
onScroll key scroll formState =
    { formState | fieldsState = formState.fieldsState |> Form.Dict.update key (helperUpdateScroll scroll) }


onChangeValue : Form.Key.Key -> Form.FieldConf.FieldConf -> Form.Conf.Conf -> String -> Form.State.State -> Form.State.State
onChangeValue key fieldConf formConf string formState =
    let
        newState : Form.State.State
        newState =
            { formState
                | focused = Just (Form.Key.toString key)
                , fieldsState =
                    formState.fieldsState
                        |> Form.Dict.update key (helperUpdateValue string)
                        |> Form.Dict.update key helperUpdateDirty
                        |> Form.Dict.update key (helperValidateOnChangeValue key fieldConf.validationSpecs formState.qtySubmitAttempted formState)
            }

        allKeys : List ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )
        allKeys =
            allValidationKeysMaker formConf newState
    in
    { newState
        | fieldsState =
            runOnlyExistingValidations allKeys newState newState.fieldsState
    }


onChangeSearch : Form.Key.Key -> String -> Form.State.State -> Form.State.State
onChangeSearch key string formState =
    { formState | fieldsState = formState.fieldsState |> Form.Dict.update key (helperUpdateSearch string) }


onChangeSelect : Form.Key.Key -> String -> Form.State.State -> Form.State.State
onChangeSelect key string formState =
    { formState | fieldsState = formState.fieldsState |> Form.Dict.update key (helperUpdateSelect string) }


update : Form.Msg.Msg -> Form.State.State -> ( Form.State.State, Cmd Form.Msg.Msg )
update msg formStateBeforeHandleChangesSinceLastSubmissions =
    let
        formState : Form.State.State
        formState =
            { formStateBeforeHandleChangesSinceLastSubmissions
                | changesSinceLastSubmissions =
                    Form.Msg.handleChangesSinceLastSubmissions
                        formStateBeforeHandleChangesSinceLastSubmissions.changesSinceLastSubmissions
                        msg
            }
    in
    case msg of
        Form.Msg.NoOp ->
            ( formState, Cmd.none )

        Form.Msg.Submit formConf ->
            ( submit formConf formState, Cmd.none )

        Form.Msg.GetFocus key ->
            ( onGetFocus key formState
            , Cmd.none
            )

        Form.Msg.LoseFocus key fieldConf ->
            ( onLoseFocus key fieldConf formState
            , Cmd.none
            )

        Form.Msg.TogglePasswordShow key ->
            ( { formState
                | fieldsState =
                    formState.fieldsState
                        |> Form.Dict.update key helperToggleShowPassword
              }
            , Cmd.none
            )

        Form.Msg.ChangeTab key string ->
            ( { formState
                | activeTabs =
                    formState.activeTabs
                        |> Form.Dict.insert key string
              }
            , Cmd.none
            )

        Form.Msg.AddEntity key ->
            let
                presentQuantity : Int
                presentQuantity =
                    Maybe.withDefault 1 <| Form.Dict.get key formState.multiplicableQuantities
            in
            ( { formState
                | multiplicableQuantities =
                    formState.multiplicableQuantities
                        |> Form.Dict.insert key (presentQuantity + 1)
              }
            , Cmd.none
            )

        Form.Msg.RemoveEntity key ->
            ( { formState
                | removed =
                    formState.removed
                        |> Set.insert (Form.Key.toString key)
              }
            , Cmd.none
            )

        Form.Msg.ChangeValue key fieldConf formConf string ->
            ( onChangeValue key fieldConf formConf string formState, Cmd.none )

        Form.Msg.OnSingleMsg key fieldConf formConf singleMsg ->
            let
                fieldState : Form.FieldState.FieldState
                fieldState =
                    Form.Dict.get key formState.fieldsState
                        |> stateWithDefault

                singleModel : FormComponents.Single.Common.Model
                singleModel =
                    { value = fieldState.value
                    , search = fieldState.search
                    , select = fieldState.select
                    , scroll = fieldState.scroll
                    , focused = formState.focused == Just (Form.Key.toString key)
                    , opened = formState.active == Just (Form.Key.toString key)
                    }

                ( newSingleModel, singleCmd ) =
                    FormComponents.Single.Update.update singleMsg singleModel

                newFormState : Form.State.State
                newFormState =
                    formState
                        |> (if fieldState.value /= newSingleModel.value then
                                onChangeValue key fieldConf formConf newSingleModel.value

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
                                    onGetFocus key

                                else
                                    onLoseFocus key fieldConf

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
            in
            ( newFormState
            , Cmd.map (Form.Msg.OnSingleMsg key fieldConf formConf) singleCmd
            )
