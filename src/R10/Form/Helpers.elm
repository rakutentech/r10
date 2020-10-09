module R10.Form.Helpers exposing
    ( RecordFieldSet
    , boolToString
    , clearFieldValidation
    , getField
    , getFieldValue
    , getFieldValueAsBool
    , getMultiActiveKeys
    , setFieldDisabled
    , setFieldValidationError
    , setFieldValue
    , setMultiFieldValue
    , stringToBool
    )

import Dict
import R10.Form.Dict
import R10.Form.FieldState
import R10.Form.Key
import R10.Form.State
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


getField : R10.Form.Key.KeyAsString -> R10.Form.State.State -> Maybe R10.Form.FieldState.FieldState
getField key formState =
    Dict.get key formState.fieldsState


getFieldValue : R10.Form.Key.KeyAsString -> R10.Form.State.State -> Maybe String
getFieldValue key formState =
    getField key formState
        |> Maybe.map .value


getFieldValueAsBool : R10.Form.Key.KeyAsString -> R10.Form.State.State -> Maybe Bool
getFieldValueAsBool key formState =
    getFieldValue key formState
        |> Maybe.map stringToBool


setFieldDisabled : R10.Form.Key.KeyAsString -> Bool -> R10.Form.State.State -> R10.Form.State.State
setFieldDisabled key isDisabled formState =
    let
        newFieldsState : R10.Form.FieldState.FieldState
        newFieldsState =
            Dict.get key formState.fieldsState
                |> Maybe.withDefault R10.Form.FieldState.init
    in
    { formState
        | fieldsState =
            Dict.insert key { newFieldsState | disabled = isDisabled } formState.fieldsState
    }


setFieldValue : R10.Form.Key.KeyAsString -> String -> R10.Form.State.State -> R10.Form.State.State
setFieldValue key value formState =
    let
        newFieldsState : R10.Form.FieldState.FieldState
        newFieldsState =
            Dict.get key formState.fieldsState
                |> Maybe.withDefault R10.Form.FieldState.init
    in
    { formState
        | fieldsState =
            Dict.insert key { newFieldsState | value = value } formState.fieldsState
    }


setFieldValidationError : R10.Form.Key.KeyAsString -> String -> R10.Form.State.State -> R10.Form.State.State
setFieldValidationError key value formState =
    let
        fieldState : R10.Form.FieldState.FieldState
        fieldState =
            Dict.get key formState.fieldsState
                |> Maybe.withDefault R10.Form.FieldState.init

        newError : R10.Form.FieldState.ValidationOutcome
        newError =
            R10.Form.FieldState.MessageErr value []

        newValidation : R10.Form.FieldState.Validation
        newValidation =
            case fieldState.validation of
                R10.Form.FieldState.NotYetValidated ->
                    R10.Form.FieldState.Validated [ newError ]

                R10.Form.FieldState.Validated listValidationOutcome ->
                    R10.Form.FieldState.Validated <| newError :: listValidationOutcome

        newFieldsState :
            Dict.Dict String
                { dirty : Bool
                , disabled : Bool
                , lostFocusOneOrMoreTime : Bool
                , scroll : Float
                , search : String
                , showPassword : Bool
                , validation : R10.Form.FieldState.Validation
                , value : String
                }
        newFieldsState =
            Dict.insert key { fieldState | validation = newValidation } formState.fieldsState
    in
    { formState | fieldsState = newFieldsState }


clearFieldValidation : R10.Form.Key.KeyAsString -> R10.Form.State.State -> R10.Form.State.State
clearFieldValidation key formState =
    let
        newFieldsState : R10.Form.FieldState.FieldState
        newFieldsState =
            Dict.get key formState.fieldsState
                |> Maybe.withDefault R10.Form.FieldState.init
    in
    { formState
        | fieldsState =
            Dict.insert key
                { newFieldsState
                    | validation =
                        case newFieldsState.validation of
                            R10.Form.FieldState.NotYetValidated ->
                                R10.Form.FieldState.NotYetValidated

                            R10.Form.FieldState.Validated _ ->
                                R10.Form.FieldState.Validated []
                }
                formState.fieldsState
    }


type alias RecordFieldSet =
    List ( R10.Form.Key.KeyAsString, String )


setMultiFieldValue :
    R10.Form.Key.KeyAsString
    -> List RecordFieldSet
    -> R10.Form.State.State
    -> R10.Form.State.State
setMultiFieldValue multiId recordsList formState =
    let
        quantity : Int
        quantity =
            List.length recordsList

        multiKeys : List R10.Form.Key.Key
        multiKeys =
            R10.Form.Key.composeMultiKeys (R10.Form.Key.fromString multiId) quantity

        keyRecordPairs : List ( R10.Form.Key.Key, List ( R10.Form.Key.KeyAsString, String ) )
        keyRecordPairs =
            List.map2 Tuple.pair multiKeys recordsList

        keyValuePairs : List ( R10.Form.Key.Key, String )
        keyValuePairs =
            keyRecordPairs
                |> List.map
                    (\( key, list ) ->
                        List.map
                            (\( k, v ) -> ( R10.Form.Key.composeKey key k, v ))
                            list
                    )
                |> List.concat

        newState : R10.Form.State.State
        newState =
            List.foldl
                (\( key, v ) ->
                    setFieldValue (R10.Form.Key.toString key) v
                )
                formState
                keyValuePairs
    in
    { newState
        | multiplicableQuantities = Dict.insert multiId quantity newState.multiplicableQuantities
    }


getMultiActiveKeys : R10.Form.Key.Key -> R10.Form.State.State -> List R10.Form.Key.Key
getMultiActiveKeys key formState =
    let
        quantity : Int
        quantity =
            Maybe.withDefault 1 <| R10.Form.Dict.get key formState.multiplicableQuantities

        notRemoved : R10.Form.Key.Key -> Bool
        notRemoved newKey =
            not <| Set.member (R10.Form.Key.toString newKey) formState.removed
    in
    R10.Form.Key.composeMultiKeys key quantity
        |> List.filter notRemoved
