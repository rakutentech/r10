module Form.Helpers exposing
    ( boolToString
    , clearFieldValidation
    , getActiveTab
    , getField
    , getFieldValue
    , getFieldValueAsBool
    , getMultiActiveKeys
    , setActiveTab
    , setFieldDisabled
    , setFieldValidationError
    , setFieldValue
    , setMultiplicableQuantities
    , stringToBool
    )

import Dict
import Form.Dict
import Form.FieldState
import Form.Key
import Form.State
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


getActiveTab : Form.Key.KeyAsString -> Form.State.State -> Maybe String
getActiveTab onId formState =
    Dict.get onId formState.activeTabs


setActiveTab : Form.Key.KeyAsString -> String -> Form.State.State -> Form.State.State
setActiveTab onId newTab formState =
    { formState | activeTabs = Dict.insert onId newTab formState.activeTabs }


getField : Form.Key.KeyAsString -> Form.State.State -> Maybe Form.FieldState.FieldState
getField key formState =
    Dict.get key formState.fieldsState


getFieldValue : Form.Key.KeyAsString -> Form.State.State -> Maybe String
getFieldValue key formState =
    getField key formState
        |> Maybe.map .value


getFieldValueAsBool : Form.Key.KeyAsString -> Form.State.State -> Maybe Bool
getFieldValueAsBool key formState =
    getFieldValue key formState
        |> Maybe.map stringToBool


setFieldDisabled : Form.Key.KeyAsString -> Bool -> Form.State.State -> Form.State.State
setFieldDisabled key isDisabled formState =
    let
        newFieldsState : Form.FieldState.FieldState
        newFieldsState =
            Dict.get key formState.fieldsState
                |> Maybe.withDefault Form.FieldState.init
    in
    { formState
        | fieldsState =
            Dict.insert key { newFieldsState | disabled = isDisabled } formState.fieldsState
    }


setFieldValue : Form.Key.KeyAsString -> String -> Form.State.State -> Form.State.State
setFieldValue key value formState =
    let
        newFieldsState : Form.FieldState.FieldState
        newFieldsState =
            Dict.get key formState.fieldsState
                |> Maybe.withDefault Form.FieldState.init
    in
    { formState
        | fieldsState =
            Dict.insert key { newFieldsState | value = value } formState.fieldsState
    }


setMultiplicableQuantities : Form.Key.KeyAsString -> Int -> Form.State.State -> Form.State.State
setMultiplicableQuantities multiId quantity state =
    { state
        | multiplicableQuantities = Dict.insert multiId quantity state.multiplicableQuantities
    }


setFieldValidationError : Form.Key.KeyAsString -> String -> Form.State.State -> Form.State.State
setFieldValidationError key value formState =
    let
        fieldState : Form.FieldState.FieldState
        fieldState =
            Dict.get key formState.fieldsState
                |> Maybe.withDefault Form.FieldState.init

        newError : Form.FieldState.ValidationOutcome
        newError =
            Form.FieldState.MessageErr value []

        newValidation : Form.FieldState.Validation
        newValidation =
            case fieldState.validation of
                Form.FieldState.NotYetValidated ->
                    Form.FieldState.Validated [ newError ]

                Form.FieldState.Validated listValidationOutcome ->
                    Form.FieldState.Validated <| newError :: listValidationOutcome

        newFieldsState : Dict.Dict String Form.FieldState.FieldState
        newFieldsState =
            Dict.insert key { fieldState | validation = newValidation } formState.fieldsState
    in
    { formState | fieldsState = newFieldsState }


clearFieldValidation : Form.Key.KeyAsString -> Form.State.State -> Form.State.State
clearFieldValidation key formState =
    let
        newFieldsState : Form.FieldState.FieldState
        newFieldsState =
            Dict.get key formState.fieldsState
                |> Maybe.withDefault Form.FieldState.init
    in
    { formState
        | fieldsState =
            Dict.insert key
                { newFieldsState
                    | validation =
                        case newFieldsState.validation of
                            Form.FieldState.NotYetValidated ->
                                Form.FieldState.NotYetValidated

                            Form.FieldState.Validated _ ->
                                Form.FieldState.Validated []
                }
                formState.fieldsState
    }


getMultiActiveKeys : Form.Key.Key -> Form.State.State -> List Form.Key.Key
getMultiActiveKeys key formState =
    let
        quantity : Int
        quantity =
            Maybe.withDefault 1 <| Form.Dict.get key formState.multiplicableQuantities

        notRemoved : Form.Key.Key -> Bool
        notRemoved newKey =
            not <| Set.member (Form.Key.toString newKey) formState.removed
    in
    Form.Key.composeMultiKeys key quantity
        |> List.filter notRemoved
