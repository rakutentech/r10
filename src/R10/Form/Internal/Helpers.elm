module R10.Form.Internal.Helpers exposing
    ( boolToString
    , clearFieldValidation
    , getActiveTab
    , getField
    , getFieldIgnoringPath
    , getFieldValue
    , getFieldValueAsBool
    , getFieldValueIgnoringPath
    , getMultiActiveKeys
    , setActiveTab
    , setFieldDisabled
    , setFieldValidationError
    , setFieldValue
    , setMultiplicableQuantities
    , stringToBool
    , updateField
    )

import Dict
import R10.Form.Internal.Dict
import R10.Form.Internal.FieldState
import R10.Form.Internal.Key
import R10.Form.Internal.State
import Set


stringToBool : String -> Bool
stringToBool string =
    String.toLower string == "true"


boolToString : Bool -> String
boolToString bool =
    if bool then
        "True"

    else
        "False"


getActiveTab : R10.Form.Internal.Key.KeyAsString -> R10.Form.Internal.State.State -> Maybe String
getActiveTab onId formState =
    Dict.get onId formState.activeTabs


setActiveTab : R10.Form.Internal.Key.KeyAsString -> String -> R10.Form.Internal.State.State -> R10.Form.Internal.State.State
setActiveTab onId newTab formState =
    { formState | activeTabs = Dict.insert onId newTab formState.activeTabs }


getField : R10.Form.Internal.Key.KeyAsString -> R10.Form.Internal.State.State -> Maybe R10.Form.Internal.FieldState.FieldState
getField key formState =
    Dict.get key formState.fieldsState


getFieldIgnoringPath : String -> R10.Form.Internal.State.State -> Maybe R10.Form.Internal.FieldState.FieldState
getFieldIgnoringPath id formState =
    --
    -- This is to facilitate the retrivial of a field even if the path is not know.
    --
    -- For example:
    --
    -- aaa/bbb/ccc/id
    --
    -- It return the first field with such id even in case of multiple field
    -- exsist with the same id, for example:
    --
    -- aaa/bbb/ccc/id
    -- aaa/id
    -- id
    --
    -- It is useful when we are sure that only one unique id exsists but we
    -- don't know the path.
    --
    List.head <|
        Dict.foldl
            (\k v acc ->
                let
                    lastIdIgnoringPath =
                        k
                            |> String.split R10.Form.Internal.Key.separator
                            |> List.reverse
                            |> List.head
                            |> Maybe.withDefault ""
                in
                if id == lastIdIgnoringPath then
                    v :: acc

                else
                    acc
            )
            []
            formState.fieldsState


getFieldValue : R10.Form.Internal.Key.KeyAsString -> R10.Form.Internal.State.State -> Maybe String
getFieldValue key formState =
    getField key formState
        |> Maybe.map .value


getFieldValueIgnoringPath : String -> R10.Form.Internal.State.State -> Maybe String
getFieldValueIgnoringPath id formState =
    getFieldIgnoringPath id formState
        |> Maybe.map .value


getFieldValueAsBool : R10.Form.Internal.Key.KeyAsString -> R10.Form.Internal.State.State -> Maybe Bool
getFieldValueAsBool key formState =
    getFieldValue key formState
        |> Maybe.map stringToBool


updateField :
    R10.Form.Internal.Key.KeyAsString
    -> (R10.Form.Internal.FieldState.FieldState -> R10.Form.Internal.FieldState.FieldState)
    -> R10.Form.Internal.State.State
    -> R10.Form.Internal.State.State
updateField key mapper formState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            getField key formState
                |> Maybe.withDefault R10.Form.Internal.FieldState.init
    in
    { formState
        | fieldsState =
            Dict.insert key (mapper fieldState) formState.fieldsState
    }


setFieldDisabled : R10.Form.Internal.Key.KeyAsString -> Bool -> R10.Form.Internal.State.State -> R10.Form.Internal.State.State
setFieldDisabled key disabled formState =
    updateField key (\fieldState -> { fieldState | disabled = disabled }) formState


setFieldValue : R10.Form.Internal.Key.KeyAsString -> String -> R10.Form.Internal.State.State -> R10.Form.Internal.State.State
setFieldValue key value formState =
    updateField key (\fieldState -> { fieldState | value = value }) formState


setMultiplicableQuantities : R10.Form.Internal.Key.KeyAsString -> Int -> R10.Form.Internal.State.State -> R10.Form.Internal.State.State
setMultiplicableQuantities multiId quantity state =
    { state
        | multiplicableQuantities = Dict.insert multiId quantity state.multiplicableQuantities
    }


setFieldValidationError : R10.Form.Internal.Key.KeyAsString -> String -> R10.Form.Internal.State.State -> R10.Form.Internal.State.State
setFieldValidationError key value formState =
    let
        fieldState : R10.Form.Internal.FieldState.FieldState
        fieldState =
            Dict.get key formState.fieldsState
                |> Maybe.withDefault R10.Form.Internal.FieldState.init

        newError : R10.Form.Internal.FieldState.ValidationOutcome
        newError =
            R10.Form.Internal.FieldState.MessageErr value []

        newValidation : R10.Form.Internal.FieldState.Validation
        newValidation =
            case fieldState.validation of
                R10.Form.Internal.FieldState.NotYetValidated ->
                    R10.Form.Internal.FieldState.Validated [ newError ]

                R10.Form.Internal.FieldState.Validated listValidationOutcome ->
                    R10.Form.Internal.FieldState.Validated <| newError :: listValidationOutcome

        newFieldsState : Dict.Dict String R10.Form.Internal.FieldState.FieldState
        newFieldsState =
            Dict.insert key { fieldState | validation = newValidation } formState.fieldsState
    in
    { formState | fieldsState = newFieldsState }


clearFieldValidation : R10.Form.Internal.Key.KeyAsString -> R10.Form.Internal.State.State -> R10.Form.Internal.State.State
clearFieldValidation key formState =
    let
        newFieldsState : R10.Form.Internal.FieldState.FieldState
        newFieldsState =
            Dict.get key formState.fieldsState
                |> Maybe.withDefault R10.Form.Internal.FieldState.init
    in
    { formState
        | fieldsState =
            Dict.insert key
                { newFieldsState
                    | validation =
                        case newFieldsState.validation of
                            R10.Form.Internal.FieldState.NotYetValidated ->
                                R10.Form.Internal.FieldState.NotYetValidated

                            R10.Form.Internal.FieldState.Validated _ ->
                                R10.Form.Internal.FieldState.Validated []
                }
                formState.fieldsState
    }


getMultiActiveKeys : R10.Form.Internal.Key.Key -> R10.Form.Internal.State.State -> List R10.Form.Internal.Key.Key
getMultiActiveKeys key formState =
    let
        quantity : Int
        quantity =
            Maybe.withDefault 1 <| R10.Form.Internal.Dict.get key formState.multiplicableQuantities

        notRemoved : R10.Form.Internal.Key.Key -> Bool
        notRemoved newKey =
            not <| Set.member (R10.Form.Internal.Key.toString newKey) formState.removed
    in
    R10.Form.Internal.Key.composeMultiKeys key quantity
        |> List.filter notRemoved
