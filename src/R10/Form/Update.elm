module R10.Form.Update exposing
    ( allErrorsForView
    , allValidationKeysMaker
    , entitiesWithErrors
    , isFormSubmittableAndSubmitted
    , runOnlyExistingValidations
    , shouldShowTheValidationOverview
    , submit
    , submittable
    , update
    )

import Browser.Dom
import Dict
import R10.Form.Conf
import R10.Form.Dict
import R10.Form.FieldConf
import R10.Form.FieldState
import R10.Form.Key
import R10.Form.MakerForValidationKeys
import R10.Form.Msg
import R10.Form.QtySubmitAttempted as QtySubmitAttempted exposing (QtySubmitAttempted)
import R10.Form.Shared
import R10.Form.State
import R10.Form.Validation
import R10.FormComponents.Single
import Set
import Task


stateWithDefault : Maybe R10.Form.FieldState.FieldState -> R10.Form.FieldState.FieldState
stateWithDefault maybeFieldState =
    Maybe.withDefault R10.Form.FieldState.init maybeFieldState



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


helperToggleShowPassword : Maybe R10.Form.FieldState.FieldState -> Maybe R10.Form.FieldState.FieldState
helperToggleShowPassword maybeFieldState =
    let
        fieldState : R10.Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | showPassword = not fieldState.showPassword }


helperUpdateValue : String -> Maybe R10.Form.FieldState.FieldState -> Maybe R10.Form.FieldState.FieldState
helperUpdateValue value maybeFieldState =
    let
        fieldState : R10.Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | value = value }


helperUpdateSearch : String -> Maybe R10.Form.FieldState.FieldState -> Maybe R10.Form.FieldState.FieldState
helperUpdateSearch value maybeFieldState =
    let
        fieldState : R10.Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | search = value }


helperUpdateScroll : Float -> Maybe R10.Form.FieldState.FieldState -> Maybe R10.Form.FieldState.FieldState
helperUpdateScroll value maybeScroll =
    let
        fieldState : R10.Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeScroll
    in
    Just { fieldState | scroll = value }


helperUpdateDirty : Maybe R10.Form.FieldState.FieldState -> Maybe R10.Form.FieldState.FieldState
helperUpdateDirty maybeFieldState =
    let
        fieldState : R10.Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | dirty = True }


helperLostFocus : Maybe R10.Form.FieldState.FieldState -> Maybe R10.Form.FieldState.FieldState
helperLostFocus maybeFieldState =
    let
        fieldState : R10.Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just { fieldState | lostFocusOneOrMoreTime = True }


helperValidateCreatingFieldsState : Maybe R10.Form.FieldConf.ValidationSpecs -> R10.Form.State.State -> Maybe R10.Form.FieldState.FieldState -> Maybe R10.Form.FieldState.FieldState
helperValidateCreatingFieldsState maybeValidationSpec formState maybeFieldState =
    let
        fieldState : R10.Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    Just <| R10.Form.Validation.validate maybeValidationSpec formState fieldState


helperValidateWithoutCreatingFieldsState : Maybe R10.Form.FieldConf.ValidationSpecs -> R10.Form.State.State -> Maybe R10.Form.FieldState.FieldState -> Maybe R10.Form.FieldState.FieldState
helperValidateWithoutCreatingFieldsState maybeValidationSpec formState maybeFieldState =
    Maybe.map (R10.Form.Validation.validate maybeValidationSpec formState) maybeFieldState


helperValidateOnChangeValue : Maybe R10.Form.FieldConf.ValidationSpecs -> QtySubmitAttempted -> R10.Form.State.State -> Maybe R10.Form.FieldState.FieldState -> Maybe R10.Form.FieldState.FieldState
helperValidateOnChangeValue maybeValidationSpec qtySubmitAttempted formState maybeFieldState =
    let
        fieldState : R10.Form.FieldState.FieldState
        fieldState =
            stateWithDefault maybeFieldState
    in
    if fieldState.lostFocusOneOrMoreTime || QtySubmitAttempted.toInt qtySubmitAttempted > 0 then
        helperValidateCreatingFieldsState maybeValidationSpec formState maybeFieldState

    else
        maybeFieldState



--
-- OTHER HELPERS
--


allValidationKeysMaker : R10.Form.Shared.Model -> List R10.Form.MakerForValidationKeys.Outcome
allValidationKeysMaker form =
    R10.Form.MakerForValidationKeys.maker R10.Form.Key.empty form.state form.conf


runAllValidations :
    List ( R10.Form.Key.Key, Maybe R10.Form.FieldConf.ValidationSpecs )
    -> R10.Form.State.State
    -> Dict.Dict String R10.Form.FieldState.FieldState
    -> Dict.Dict String R10.Form.FieldState.FieldState
runAllValidations allKeys formState fieldsState =
    -- Validate the entire form, creating new `fieldState` if necessary,
    -- when such fields were not yet touched, for example
    List.foldl
        (\( key, validationSpec ) acc ->
            R10.Form.Dict.update key (helperValidateCreatingFieldsState validationSpec formState) acc
        )
        fieldsState
        allKeys


runOnlyExistingValidations :
    List ( R10.Form.Key.Key, Maybe R10.Form.FieldConf.ValidationSpecs )
    -> R10.Form.State.State
    -> Dict.Dict String R10.Form.FieldState.FieldState
    -> Dict.Dict String R10.Form.FieldState.FieldState
runOnlyExistingValidations allKeys formState fieldsState =
    -- Validate the entire form, without creating new `fieldState`
    List.foldl
        (\( key, fieldConf ) acc ->
            R10.Form.Dict.update key (helperValidateWithoutCreatingFieldsState fieldConf formState) acc
        )
        fieldsState
        allKeys


entitiesWithErrors :
    List ( R10.Form.Key.Key, Maybe R10.Form.FieldConf.ValidationSpecs )
    -> Dict.Dict String R10.Form.FieldState.FieldState
    -> List ( R10.Form.Key.Key, Maybe R10.Form.FieldConf.ValidationSpecs )
entitiesWithErrors allKeys fieldsState =
    -- Return the list of field that either didn't pass
    -- the validation or were not validated. Used to understand if a form has been
    -- filled properly and show a comprehensive error at the bottom.
    -- If a field has not yet been validated, it is considered as an error.
    -- So this function require all validations to be run before being called.
    List.filter
        (\( key, _ ) ->
            let
                fieldState : R10.Form.FieldState.FieldState
                fieldState =
                    Maybe.withDefault R10.Form.FieldState.init <| R10.Form.Dict.get key fieldsState
            in
            case R10.Form.FieldState.isValid fieldState.validation of
                R10.Form.FieldState.NotYetValidated2 ->
                    True

                R10.Form.FieldState.NotValid ->
                    True

                R10.Form.FieldState.Valid ->
                    False
        )
        allKeys


allErrorsForView : R10.Form.Shared.Model -> List ( R10.Form.Key.Key, Maybe R10.Form.FieldConf.ValidationSpecs )
allErrorsForView form =
    if shouldShowTheValidationOverview form.state then
        let
            allKeys : List ( R10.Form.Key.Key, Maybe R10.Form.FieldConf.ValidationSpecs )
            allKeys =
                allValidationKeysMaker form
        in
        entitiesWithErrors allKeys form.state.fieldsState

    else
        []


shouldShowTheValidationOverview : R10.Form.State.State -> Bool
shouldShowTheValidationOverview formState =
    QtySubmitAttempted.toInt formState.qtySubmitAttempted > 0 && not formState.changesSinceLastSubmissions


submittable : R10.Form.Shared.Model -> Bool
submittable form =
    if QtySubmitAttempted.toInt form.state.qtySubmitAttempted == 0 then
        -- Always submittable if it has never been submitted
        True

    else
        let
            allKeys : List ( R10.Form.Key.Key, Maybe R10.Form.FieldConf.ValidationSpecs )
            allKeys =
                allValidationKeysMaker form

            fieldsWithErrors_ : List ( R10.Form.Key.Key, Maybe R10.Form.FieldConf.ValidationSpecs )
            fieldsWithErrors_ =
                entitiesWithErrors allKeys form.state.fieldsState
        in
        List.length fieldsWithErrors_ == 0


isFormSubmittableAndSubmitted : R10.Form.Shared.Model -> R10.Form.Msg.Msg -> Bool
isFormSubmittableAndSubmitted form formMsg =
    submittable form && R10.Form.Msg.isSubmitted formMsg



-- ███████ ██    ██ ██████  ███    ███ ██ ████████     ███████  ██████  ██████  ███    ███
-- ██      ██    ██ ██   ██ ████  ████ ██    ██        ██      ██    ██ ██   ██ ████  ████
-- ███████ ██    ██ ██████  ██ ████ ██ ██    ██        █████   ██    ██ ██████  ██ ████ ██
--      ██ ██    ██ ██   ██ ██  ██  ██ ██    ██        ██      ██    ██ ██   ██ ██  ██  ██
-- ███████  ██████  ██████  ██      ██ ██    ██        ██       ██████  ██   ██ ██      ██


submit :
    R10.Form.Conf.Conf
    -> R10.Form.State.State
    -> R10.Form.State.State
submit conf state =
    let
        allKeys : List ( R10.Form.Key.Key, Maybe R10.Form.FieldConf.ValidationSpecs )
        allKeys =
            allValidationKeysMaker { conf = conf, state = state }

        newFieldsState : Dict.Dict String R10.Form.FieldState.FieldState
        newFieldsState =
            runAllValidations allKeys state state.fieldsState

        newQtysubmitAttempted : QtySubmitAttempted
        newQtysubmitAttempted =
            QtySubmitAttempted.increment state.qtySubmitAttempted

        fieldsWithErrors_ : List ( R10.Form.Key.Key, Maybe R10.Form.FieldConf.ValidationSpecs )
        fieldsWithErrors_ =
            entitiesWithErrors allKeys newFieldsState

        cachedSubmitMe : Bool
        cachedSubmitMe =
            List.length fieldsWithErrors_ == 0
    in
    { state
        | fieldsState = newFieldsState
        , qtySubmitAttempted = newQtysubmitAttempted
    }



-- ██    ██ ██████  ██████   █████  ████████ ███████
-- ██    ██ ██   ██ ██   ██ ██   ██    ██    ██
-- ██    ██ ██████  ██   ██ ███████    ██    █████
-- ██    ██ ██      ██   ██ ██   ██    ██    ██
--  ██████  ██      ██████  ██   ██    ██    ███████


onGetFocus : R10.Form.Key.Key -> R10.Form.State.State -> R10.Form.State.State
onGetFocus key formState =
    { formState
        | focused = Just (R10.Form.Key.toString key)
    }


onLoseFocus : R10.Form.Key.Key -> R10.Form.FieldConf.FieldConf -> R10.Form.State.State -> R10.Form.State.State
onLoseFocus key fieldConf formState =
    { formState
        | focused = Nothing
        , fieldsState =
            formState.fieldsState
                |> R10.Form.Dict.update key helperLostFocus
                |> R10.Form.Dict.update key (helperValidateCreatingFieldsState fieldConf.validationSpecs formState)
    }


onDeactivate : R10.Form.State.State -> R10.Form.State.State
onDeactivate formState =
    { formState | active = Nothing }


onActivate : R10.Form.Key.Key -> R10.Form.State.State -> R10.Form.State.State
onActivate key formState =
    { formState
        | active = Just (R10.Form.Key.toString key)
    }


onScroll : R10.Form.Key.Key -> Float -> R10.Form.State.State -> R10.Form.State.State
onScroll key scroll formState =
    { formState | fieldsState = formState.fieldsState |> R10.Form.Dict.update key (helperUpdateScroll scroll) }


onChangeValue : R10.Form.Key.Key -> R10.Form.FieldConf.FieldConf -> R10.Form.Conf.Conf -> String -> R10.Form.State.State -> R10.Form.State.State
onChangeValue key fieldConf formConf string formState =
    let
        newState :
            { active : Maybe R10.Form.Key.KeyAsString
            , activeTabs : Dict.Dict R10.Form.Key.KeyAsString String
            , changesSinceLastSubmissions : Bool
            , fieldsState : Dict.Dict R10.Form.Key.KeyAsString R10.Form.FieldState.FieldState
            , focused : Maybe R10.Form.Key.KeyAsString
            , multiplicableQuantities : Dict.Dict R10.Form.Key.KeyAsString Int
            , qtySubmitAttempted : QtySubmitAttempted
            , removed : Set.Set R10.Form.Key.KeyAsString
            }
        newState =
            { formState
                | focused = Just (R10.Form.Key.toString key)
                , fieldsState =
                    formState.fieldsState
                        |> R10.Form.Dict.update key (helperUpdateValue string)
                        |> R10.Form.Dict.update key helperUpdateDirty
                        |> R10.Form.Dict.update key (helperValidateOnChangeValue fieldConf.validationSpecs formState.qtySubmitAttempted formState)
            }

        allKeys : List ( R10.Form.Key.Key, Maybe R10.Form.FieldConf.ValidationSpecs )
        allKeys =
            allValidationKeysMaker { conf = formConf, state = newState }
    in
    { newState
        | fieldsState = runOnlyExistingValidations allKeys newState newState.fieldsState
    }


onChangeSearch : R10.Form.Key.Key -> String -> R10.Form.State.State -> R10.Form.State.State
onChangeSearch key string formState =
    { formState | fieldsState = formState.fieldsState |> R10.Form.Dict.update key (helperUpdateSearch string) }


update : R10.Form.Msg.Msg -> R10.Form.State.State -> ( R10.Form.State.State, Cmd R10.Form.Msg.Msg )
update msg formStateBeforeHandleChangesSinceLastSubmissions =
    let
        formState : R10.Form.State.State
        formState =
            { formStateBeforeHandleChangesSinceLastSubmissions
                | changesSinceLastSubmissions =
                    R10.Form.Msg.handleChangesSinceLastSubmissions
                        formStateBeforeHandleChangesSinceLastSubmissions.changesSinceLastSubmissions
                        msg
            }
    in
    case msg of
        R10.Form.Msg.NoOp ->
            ( formState, Cmd.none )

        R10.Form.Msg.Submit formConf ->
            ( submit formConf formState, Cmd.none )

        R10.Form.Msg.GetFocus key ->
            ( onGetFocus key formState
            , Cmd.none
            )

        R10.Form.Msg.TogglePasswordShow key ->
            ( { formState
                | fieldsState =
                    formState.fieldsState
                        |> R10.Form.Dict.update key helperToggleShowPassword
              }
            , Cmd.none
            )

        R10.Form.Msg.ChangeTab key string ->
            ( { formState
                | activeTabs =
                    formState.activeTabs
                        |> R10.Form.Dict.insert key string
              }
            , Cmd.none
            )

        R10.Form.Msg.AddEntity key ->
            let
                presentQuantity : Int
                presentQuantity =
                    Maybe.withDefault 1 <| R10.Form.Dict.get key formState.multiplicableQuantities
            in
            ( { formState
                | multiplicableQuantities =
                    formState.multiplicableQuantities
                        |> R10.Form.Dict.insert key (presentQuantity + 1)
              }
            , Cmd.none
            )

        R10.Form.Msg.RemoveEntity key ->
            ( { formState
                | removed =
                    formState.removed
                        |> Set.insert (R10.Form.Key.toString key)
              }
            , Cmd.none
            )

        R10.Form.Msg.LoseFocus key fieldConf ->
            ( onLoseFocus key fieldConf formState
            , Cmd.none
            )

        R10.Form.Msg.ChangeValue key fieldConf formConf string ->
            ( onChangeValue key fieldConf formConf string formState, Cmd.none )

        R10.Form.Msg.ChangeSelection key fieldConf formConf string newY ->
            ( onChangeValue key fieldConf formConf string formState
            , Task.attempt
                (always R10.Form.Msg.NoOp)
                (Browser.Dom.setViewportOf
                    (R10.FormComponents.Single.dropdownContentId <| R10.Form.Key.toString key)
                    0
                    newY
                )
            )

        R10.Form.Msg.OnSingleMsg key fieldConf formConf singleMsg ->
            let
                fieldState : R10.Form.FieldState.FieldState
                fieldState =
                    R10.Form.Dict.get key formState.fieldsState
                        |> stateWithDefault

                singleModel :
                    { focused : Bool
                    , opened : Bool
                    , scroll : Float
                    , search : String
                    , value : String
                    }
                singleModel =
                    { value = fieldState.value
                    , search = fieldState.search
                    , scroll = fieldState.scroll
                    , focused = formState.focused == Just (R10.Form.Key.toString key)
                    , opened = formState.active == Just (R10.Form.Key.toString key)
                    }

                ( newSingleModel, singleCmd ) =
                    R10.FormComponents.Single.update singleMsg singleModel

                newFormState : R10.Form.State.State
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
            , Cmd.map (R10.Form.Msg.OnSingleMsg key fieldConf formConf) singleCmd
            )
