module R10.FormComponents.Internal.Utils exposing
    ( entitiesValidationOutcomes
    , entitiesWithErrors
    , errorsList
    , listSlice
    , stringInsertAtMulti
    )

{-| same as String.Extra.insertAt but allows to input at several positions at once
-}

import R10.Form.Internal.Converter
import R10.Form.Internal.Dict
import R10.Form.Internal.FieldConf
import R10.Form.Internal.FieldState
import R10.Form.Internal.Key
import R10.Form.Internal.Shared
import R10.Form.Internal.Translator
import R10.Form.Internal.Update
import R10.FormComponents.Internal.Validations
import String.Extra


stringInsertAtMulti : String -> List Int -> String -> String
stringInsertAtMulti insert positions string =
    let
        insertLen : Int
        insertLen =
            String.length insert

        insertAtOffset : Int -> { c | offset : Int, str : String } -> { offset : Int, str : String }
        insertAtOffset pos { str, offset } =
            { str = String.Extra.insertAt insert (pos + offset) str
            , offset = offset + insertLen
            }
    in
    List.foldl insertAtOffset { str = string, offset = 0 } positions
        |> .str


listSlice : Int -> Int -> List b -> List b
listSlice from to list =
    if from >= to then
        []

    else
        List.drop from list
            |> List.indexedMap
                (\idx opt ->
                    if idx < (to - from) then
                        Just opt

                    else
                        Nothing
                )
            |> List.filterMap identity


errorsList :
    R10.Form.Internal.Shared.Form
    -> List ( R10.Form.Internal.Key.Key, spec )
    -> List ( R10.Form.Internal.Key.Key, spec, R10.Form.Internal.FieldState.FieldState )
errorsList form entitiesWithErrors_ =
    entitiesWithErrors_
        |> List.map (\( key, spec ) -> ( key, spec, R10.Form.Internal.Dict.get key form.state.fieldsState ))
        |> List.filterMap
            (\( key, spec, maybeFieldState ) ->
                case maybeFieldState of
                    Nothing ->
                        Nothing

                    Just fieldState ->
                        Just ( key, spec, fieldState )
            )


entitiesWithErrors :
    R10.Form.Internal.Shared.Form
    -> List ( R10.Form.Internal.Key.Key, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
entitiesWithErrors form =
    let
        allKeys : List ( R10.Form.Internal.Key.Key, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
        allKeys =
            R10.Form.Internal.Update.allValidationKeysMaker form

        fieldsWithErrors_ : List ( R10.Form.Internal.Key.Key, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
        fieldsWithErrors_ =
            R10.Form.Internal.Update.entitiesWithErrors allKeys form.state.fieldsState
    in
    fieldsWithErrors_


entitiesValidationOutcomes :
    R10.Form.Internal.Shared.Form
    -> Maybe R10.Form.Internal.Translator.Translator
    -> List ( R10.Form.Internal.Key.Key, R10.FormComponents.Internal.Validations.ValidationForView )
entitiesValidationOutcomes form maybeTranslator =
    let
        translator : R10.Form.Internal.Translator.Translator
        translator =
            Maybe.withDefault R10.Form.Internal.Translator.translator maybeTranslator

        keys : List ( R10.Form.Internal.Key.Key, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
        keys =
            R10.Form.Internal.Update.allValidationKeysMaker form
    in
    form.state.fieldsState
        |> R10.Form.Internal.Update.entitiesWithErrors keys
        |> errorsList form
        |> List.map
            (\( key, validationSpec, fieldState ) ->
                ( key
                , R10.Form.Internal.Converter.fromFieldStateValidationToComponentValidation
                    validationSpec
                    fieldState.validation
                    (translator key)
                )
            )
