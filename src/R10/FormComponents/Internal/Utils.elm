module R10.FormComponents.Internal.Utils exposing
    ( entitiesValidationOutcomes
    , entitiesWithErrors
    , errorsList
    , getFlagIcon
    , listSlice
    , maybeCountryCodeToString
    , stringInsertAtMulti
    )

{-| same as String.Extra.insertAt but allows to input at several positions at once
-}

import Dict
import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Html.Attributes
import R10.Context
import R10.Country
import R10.Form.Internal.Converter
import R10.Form.Internal.Dict
import R10.Form.Internal.FieldConf
import R10.Form.Internal.FieldState
import R10.Form.Internal.Key
import R10.Form.Internal.Shared
import R10.Form.Internal.Translator
import R10.Form.Internal.Update
import R10.FormComponents.Internal.Validations
import R10.FormTypes
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
    -> List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, spec )
    -> List ( ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, spec ), R10.Form.Internal.FieldState.FieldState )
errorsList form entitiesWithErrors_ =
    entitiesWithErrors_
        |> List.map (\( key, fieldType, spec ) -> ( ( key, fieldType, spec ), R10.Form.Internal.Dict.get key form.state.fieldsState ))
        |> List.filterMap
            (\( ( key, fieldType, spec ), maybeFieldState ) ->
                case maybeFieldState of
                    Nothing ->
                        Nothing

                    Just fieldState ->
                        Just ( ( key, fieldType, spec ), fieldState )
            )


entitiesWithErrors :
    R10.Form.Internal.Shared.Form
    -> List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
entitiesWithErrors form =
    let
        allKeys : List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
        allKeys =
            R10.Form.Internal.Update.allValidationKeysMaker form

        fieldsWithErrors_ : List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
        fieldsWithErrors_ =
            R10.Form.Internal.Update.entitiesWithErrors allKeys form.state.fieldsState
    in
    fieldsWithErrors_


entitiesValidationOutcomes :
    R10.Form.Internal.Shared.Form
    -> Maybe R10.Form.Internal.Translator.Translator
    -> List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, R10.FormComponents.Internal.Validations.ValidationForView )
entitiesValidationOutcomes form maybeTranslator =
    let
        translator : R10.Form.Internal.Translator.Translator
        translator =
            Maybe.withDefault R10.Form.Internal.Translator.translator maybeTranslator

        keys : List ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )
        keys =
            R10.Form.Internal.Update.allValidationKeysMaker form
    in
    form.state.fieldsState
        |> R10.Form.Internal.Update.entitiesWithErrors keys
        |> errorsList form
        |> List.map
            (\( ( key, fieldType, validationSpec ), fieldState ) ->
                ( key
                , fieldType
                , R10.Form.Internal.Converter.fromFieldStateValidationToComponentValidation
                    validationSpec
                    fieldState
                    (translator key)
                    fieldType
                )
            )


countryCodeToFlag : String -> List (Attribute context msg)
countryCodeToFlag countryCode =
    let
        newCountryCode : String
        newCountryCode =
            --
            -- https://jira.rakuten-it.com/jira/browse/OMN-5571
            --
            -- Several phone international prefixes are not countries so a flag is not
            -- available. As temporary fix I used the flag of the related country.
            --
            -- In the future we should have an official Rakuten's list of international
            -- prefixes,  and associated flags.
            --
            -- * AQ Antarctica -> AU
            -- * IO BritishIndianOceanTerritory -> GB
            -- * CX ChristmasIsland -> AU
            -- * CC CocosIslands -> AU
            -- * XK Kosovo -> Serbia (RS)
            -- * PM SaintPierreandMiquelon -> FR
            --   SX SintMaarten -> Netherlands (NL)
            --   SJ SvalbardandJanMayen -> Norway (NO)
            --
            if countryCode == "AQ" then
                "AU"

            else if countryCode == "IO" then
                "GB"

            else if countryCode == "CX" then
                "AU"

            else if countryCode == "CC" then
                "AU"

            else if countryCode == "XK" then
                "RS"

            else if countryCode == "PM" then
                "FR"

            else if countryCode == "SX" then
                "NL"

            else if countryCode == "SJ" then
                "NO"

            else
                countryCode
    in
    case Dict.get newCountryCode R10.Form.Internal.Shared.flagIconPositions of
        Just ( x, y ) ->
            [ htmlAttribute <| Html.Attributes.style "background-position" (String.fromFloat (x - 1) ++ "px " ++ String.fromFloat (y - 2) ++ "px")
            , htmlAttribute <| Html.Attributes.style "background-size" "auto"
            ]

        Nothing ->
            [ htmlAttribute <| Html.Attributes.style "background-size" "cover" ]


maybeCountryCodeToString : Maybe R10.Country.Country -> String
maybeCountryCodeToString maybeCountry_ =
    Maybe.map R10.Country.toCountryCode maybeCountry_
        |> Maybe.withDefault ""


getFlagIcon : String -> Element (R10.Context.ContextInternal z) msg
getFlagIcon countryCode =
    withContext
        (\c ->
            el
                ([ width <| px 14
                 , height <| px 11
                 , Border.shadow { offset = ( 0, 0 ), size = 1, blur = 1, color = rgba 0 0 0 0.2 }
                 , moveDown 1
                 , Background.image c.contextR10.urlImageFlags
                 ]
                    ++ countryCodeToFlag countryCode
                )
            <|
                none
        )
