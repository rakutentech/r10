module R10.Form.Internal.FieldConf exposing
    ( FieldConf
    , FieldId
    , Range
    , Validation(..)
    , ValidationCode
    , ValidationMessage
    , ValidationPayload
    , ValidationSpecs
    , decoderFieldConf
    , decoderValidationSpecs
    , encodeValidationSpecs
    , encoderFieldConf
    , init
    , initValidationSpecs
    )

import Json.Decode as D
import Json.Encode as E
import Json.Encode.Extra
import R10.Form.Internal.Key
import R10.FormTypes


type alias ValidationMessage =
    { ok : String
    , err : String
    }


type Validation
    = NoValidation
      -- Modifications validations
    | WithMsg ValidationMessage Validation -- MsgOk MsgErr validation; changes message of the validation
    | Dependant R10.Form.Internal.Key.KeyAsString Validation -- changes context of the validation
    | OneOf (List Validation) -- Sees set of underlying validation like one rule. Makes all rules valid if ANY of the rules is valid, otherwise make them invalid.
    | AllOf (List Validation) -- Sees set of underlying validation like one rule. Makes all rules valid if ALL of the rules is valid, otherwise make them invalid.
    | Not Validation -- Inverts result of the validation
      -- Current field validations
    | Equal R10.Form.Internal.Key.KeyAsString -- Pass if the value is equal to the value
    | Required
    | Empty -- can be used in combined validations to create rules like "if field X is not empty, then Required" ( OneOf [ Required, Dependant "X"  ] )
    | MinLength Int
    | MaxLength Int
    | Regex String
    | DateRange Range


type alias Range =
    { max : Int
    , min : Int
    }



-- ████████ ██    ██ ██████  ███████ ███████
--    ██     ██  ██  ██   ██ ██      ██
--    ██      ████   ██████  █████   ███████
--    ██       ██    ██      ██           ██
--    ██       ██    ██      ███████ ███████


type alias ValidationCode =
    String


type alias ValidationPayload =
    -- bracket args
    List String


type alias FieldId =
    String


type alias FieldConf =
    { id : FieldId
    , idDom : Maybe String
    , type_ : R10.FormTypes.FieldType
    , label : String
    , clickableLabel : Bool
    , helperText : Maybe String
    , requiredLabel : Maybe String
    , validationSpecs : Maybe ValidationSpecs
    , minWidth : Maybe Int
    , maxWidth : Maybe Int
    , allowOverMaxLength : Bool

    -- If autocomplete is Nothing, we just use the default value, set by elm-ui
    , autocomplete : Maybe String
    , placeholder : Maybe String
    }



-- ██ ███    ██ ██ ████████
-- ██ ████   ██ ██    ██
-- ██ ██ ██  ██ ██    ██
-- ██ ██  ██ ██ ██    ██
-- ██ ██   ████ ██    ██


type alias ValidationSpecs =
    { showAlsoPassedValidation : Bool
    , pretendIsNotValidatedIfValid : Bool
    , validation : List Validation
    , validationIcon : R10.FormTypes.ValidationIcon
    }


init : FieldConf
init =
    { id = ""
    , idDom = Nothing
    , type_ = R10.FormTypes.TypeText R10.FormTypes.TextPlain
    , label = ""
    , clickableLabel = True
    , placeholder = Nothing
    , helperText = Nothing
    , requiredLabel = Nothing
    , validationSpecs = Just initValidationSpecs
    , minWidth = Nothing
    , maxWidth = Nothing
    , allowOverMaxLength = True
    , autocomplete = Nothing
    }


initValidationSpecs : ValidationSpecs
initValidationSpecs =
    { showAlsoPassedValidation = False
    , pretendIsNotValidatedIfValid = False
    , validation = [ NoValidation ]
    , validationIcon = R10.FormTypes.NoIcon
    }



--
-- ███████ ███    ██  ██████  ██████  ██████  ███████ ██████
-- ██      ████   ██ ██      ██    ██ ██   ██ ██      ██   ██
-- █████   ██ ██  ██ ██      ██    ██ ██   ██ █████   ██████
-- ██      ██  ██ ██ ██      ██    ██ ██   ██ ██      ██   ██
-- ███████ ██   ████  ██████  ██████  ██████  ███████ ██   ██
--
-- ██████  ███████  ██████  ██████  ██████  ███████ ██████
-- ██   ██ ██      ██      ██    ██ ██   ██ ██      ██   ██
-- ██   ██ █████   ██      ██    ██ ██   ██ █████   ██████
-- ██   ██ ██      ██      ██    ██ ██   ██ ██      ██   ██
-- ██████  ███████  ██████  ██████  ██████  ███████ ██   ██


jsonSeparator : String
jsonSeparator =
    ":'_':"


encoderFieldConf : FieldConf -> E.Value
encoderFieldConf fieldConf =
    E.object
        [ ( "id", E.string fieldConf.id )
        , ( "idDom", Json.Encode.Extra.maybe E.string fieldConf.idDom )
        , ( "type", encoderFieldType fieldConf.type_ )
        , ( "label", E.string fieldConf.label )
        , ( "clickableLabel", E.bool fieldConf.clickableLabel )
        , ( "helperText", Json.Encode.Extra.maybe E.string fieldConf.helperText )
        , ( "requiredLabel", Json.Encode.Extra.maybe E.string fieldConf.requiredLabel )
        , ( "validationSpecs", Json.Encode.Extra.maybe encodeValidationSpecs fieldConf.validationSpecs )
        , ( "minWidth", Json.Encode.Extra.maybe E.int fieldConf.minWidth )
        , ( "maxWidth", Json.Encode.Extra.maybe E.int fieldConf.maxWidth )
        , ( "autocomplete", Json.Encode.Extra.maybe E.string fieldConf.autocomplete )
        ]



--
-- map9 :
--     (a -> b -> c -> d -> e -> f -> g -> h -> i -> value)
--     -> D.Decoder a
--     -> D.Decoder b
--     -> D.Decoder c
--     -> D.Decoder d
--     -> D.Decoder e
--     -> D.Decoder f
--     -> D.Decoder g
--     -> D.Decoder h
--     -> D.Decoder i
--     -> D.Decoder value
-- map9 a b c d e f g h i =
--     D.map2 (D.map8 (\a b c d e f g h -> v) a b c d e f g h) i
--


decoderFieldConf : D.Decoder FieldConf
decoderFieldConf =
    -- From https://korban.net/posts/elm/2018-06-22-json-decode-tricks/
    let
        mainFields =
            D.map8 FieldConf
                (D.field "id" D.string)
                (D.field "idDom" (D.maybe D.string))
                (D.field "type" decoderFieldType)
                (D.field "label" D.string)
                (D.field "clickableLabel" D.bool)
                (D.field "helperText" (D.maybe D.string))
                (D.field "requiredLabel" (D.maybe D.string))
                (D.field "validationSpecs" (D.maybe decoderValidationSpecs))
    in
    D.map6
        (<|)
        mainFields
        (D.field "minWidth" (D.maybe D.int))
        (D.field "maxWidth" (D.maybe D.int))
        (D.field "allowOverMaxLength" D.bool)
        (D.field "autocomplete" (D.maybe D.string))
        (D.field "placeholder" (D.maybe D.string))


encoderFieldType : R10.FormTypes.FieldType -> E.Value
encoderFieldType fieldType =
    case fieldType of
        R10.FormTypes.TypeText typeText ->
            case typeText of
                R10.FormTypes.TextPlain ->
                    E.string "TypeTextPlain"

                R10.FormTypes.TextEmail ->
                    E.string "TypeTextEmail"

                R10.FormTypes.TextEmailWithSuggestions listSuggestions ->
                    E.string <| "TextEmailWithSuggestions" ++ jsonSeparator ++ String.join "," listSuggestions

                R10.FormTypes.TextMobileEmail ->
                    E.string "TypeTextMobileEmail"

                R10.FormTypes.TextUsername ->
                    E.string "TypeTextUsername"

                R10.FormTypes.TextUsernameWithUseEmailCheckbox checkboxLabel ->
                    E.string <| "TextUsernameWithUseEmailCheckbox" ++ jsonSeparator ++ checkboxLabel

                R10.FormTypes.TextPasswordNew checkboxLabel ->
                    E.string <| "TypeTextPasswordNew" ++ jsonSeparator ++ checkboxLabel

                R10.FormTypes.TextPasswordCurrent checkboxLabel ->
                    E.string <| "TypeTextPasswordCurrent" ++ jsonSeparator ++ checkboxLabel

                R10.FormTypes.TextMultiline ->
                    E.string "TypeTextMultiline"

                R10.FormTypes.TextWithPattern pattern ->
                    E.string <| "TextWithPattern" ++ jsonSeparator ++ pattern

                R10.FormTypes.TextWithPatternLarge pattern ->
                    E.string <| "TextWithPatternLarge" ++ jsonSeparator ++ pattern

                R10.FormTypes.TextWithPatternLargeWithoutLabel pattern ->
                    E.string <| "TextWithPatternLargeWithoutLabel" ++ jsonSeparator ++ pattern

                R10.FormTypes.TextOnlyDigitsOrDash ->
                    E.string <| "TextOnlyDigitsOrDash"

        R10.FormTypes.TypeBinary typeBinary ->
            case typeBinary of
                R10.FormTypes.BinaryCheckbox ->
                    E.string "TypeBinaryCheckbox"

                R10.FormTypes.BinarySwitch ->
                    E.string "TypeBinarySwitch"

        R10.FormTypes.TypeSingle singleType _ ->
            case singleType of
                R10.FormTypes.SingleRadio ->
                    E.string "TypeSingleRadio"

                R10.FormTypes.SingleRadioRow ->
                    E.string "TypeSingleRadioRow"

                R10.FormTypes.SingleCombobox ->
                    E.string "TypeSingleCombobox"

                R10.FormTypes.SingleComboboxForCountry ->
                    E.string "SingleComboboxForCountry"

                R10.FormTypes.SingleSelect ->
                    E.string "TypeSingleSelect"

        R10.FormTypes.TypeMulti typeMulti _ ->
            case typeMulti of
                R10.FormTypes.MultiCombobox ->
                    E.string "TypeMultiCombobox"

        R10.FormTypes.TypeSpecial typeSpecial ->
            case typeSpecial of
                R10.FormTypes.SpecialPhone _ ->
                    E.string "TypeSpecialPhone"


decoderFieldType : D.Decoder R10.FormTypes.FieldType
decoderFieldType =
    D.string
        |> D.andThen
            (\str ->
                case String.split jsonSeparator str of
                    [ "TypeTextPlain" ] ->
                        D.succeed (R10.FormTypes.TypeText R10.FormTypes.TextPlain)

                    [ "TypeTextEmail" ] ->
                        D.succeed (R10.FormTypes.TypeText R10.FormTypes.TextEmail)

                    [ "TextEmailWithSuggestions", listSuggestions ] ->
                        D.succeed (R10.FormTypes.TypeText <| R10.FormTypes.TextEmailWithSuggestions (String.split "," listSuggestions))

                    [ "TypeTextMobileEmail" ] ->
                        D.succeed (R10.FormTypes.TypeText R10.FormTypes.TextMobileEmail)

                    [ "TypeTextUsername" ] ->
                        D.succeed (R10.FormTypes.TypeText R10.FormTypes.TextUsername)

                    [ "TypeTextPasswordNew" ] ->
                        D.succeed (R10.FormTypes.TypeText <| R10.FormTypes.TextPasswordNew str)

                    [ "TypeTextPasswordCurrent" ] ->
                        D.succeed (R10.FormTypes.TypeText <| R10.FormTypes.TextPasswordCurrent str)

                    [ "TypeTextMultiline" ] ->
                        D.succeed (R10.FormTypes.TypeText R10.FormTypes.TextMultiline)

                    [ "TextWithPattern", pattern ] ->
                        D.succeed (R10.FormTypes.TypeText <| R10.FormTypes.TextWithPattern pattern)

                    [ "TextWithPatternLarge", pattern ] ->
                        D.succeed (R10.FormTypes.TypeText <| R10.FormTypes.TextWithPatternLarge pattern)

                    [ "TextWithPatternLargeWithoutLabel", pattern ] ->
                        D.succeed (R10.FormTypes.TypeText <| R10.FormTypes.TextWithPatternLargeWithoutLabel pattern)

                    [ "TypeBinaryCheckbox" ] ->
                        D.succeed (R10.FormTypes.TypeBinary R10.FormTypes.BinaryCheckbox)

                    [ "TypeBinarySwitch" ] ->
                        D.succeed (R10.FormTypes.TypeBinary R10.FormTypes.BinarySwitch)

                    [ "TypeSingleRadio" ] ->
                        D.succeed (R10.FormTypes.TypeSingle R10.FormTypes.SingleRadio [])

                    [ "TypeSingleRadioRow" ] ->
                        D.succeed (R10.FormTypes.TypeSingle R10.FormTypes.SingleRadioRow [])

                    [ "TypeSingleCombobox" ] ->
                        D.succeed (R10.FormTypes.TypeSingle R10.FormTypes.SingleCombobox [])

                    [ "TypeSingleSelect" ] ->
                        D.succeed (R10.FormTypes.TypeSingle R10.FormTypes.SingleSelect [])

                    [ "TypeMultiCombobox" ] ->
                        D.succeed (R10.FormTypes.TypeMulti R10.FormTypes.MultiCombobox [])

                    [ "TypeSpecial" ] ->
                        D.succeed (R10.FormTypes.TypeSpecial (R10.FormTypes.SpecialPhone { disableInternationalPrefixPhoneChange = False, isJapanService = False }))

                    somethingElse ->
                        D.fail <| "Unknown FieldType: " ++ List.foldl (++) "" somethingElse ++ ". It should be something like TypeTextPlain, TypeTextEmail, TypeTextUsername, TypeTextPasswordNew, TypeTextPasswordCurrent, TypeCheckbox, TypeRadio, TypeDate, TypePhoneNumber, TypeBirthday or TypeCombobox."
            )



--ValidationSpecs


encodeValidationSpecs : ValidationSpecs -> E.Value
encodeValidationSpecs validationSpecs =
    E.object
        [ ( "showAlsoPassedValidation", E.bool validationSpecs.showAlsoPassedValidation )
        , ( "hideCheckmark", E.bool validationSpecs.pretendIsNotValidatedIfValid )
        , ( "validation", E.list encodeValidation validationSpecs.validation )
        , ( "validationIcon", encodeValidationIcon validationSpecs.validationIcon )
        ]


decoderValidationSpecs : D.Decoder ValidationSpecs
decoderValidationSpecs =
    D.map4 ValidationSpecs
        (D.field "showAlsoPassedValidation" D.bool)
        (D.field "hideCheckmark" D.bool)
        (D.field "validation" (D.list decoderValidation))
        (D.field "validationIcon" decoderValidationIcon)



--Validation


encodeValidation : Validation -> E.Value
encodeValidation validation =
    case validation of
        AllOf validations ->
            encodeAllOf validations

        OneOf validations ->
            encodeOneOf validations

        WithMsg msg validation_ ->
            encodeWithMsg msg validation_

        Dependant key validation_ ->
            encodeDependant key validation_

        MinLength length ->
            encodeMinLength length

        MaxLength length ->
            encodeMaxLength length

        Regex regex ->
            encodeRegex regex

        NoValidation ->
            E.string "no_validation"

        Equal key ->
            encodeEqual key

        Not validation_ ->
            encodeNot validation_

        Required ->
            E.string "required"

        Empty ->
            E.string "empty"

        DateRange range ->
            encodeDateRange range


encodeValidationIcon : R10.FormTypes.ValidationIcon -> E.Value
encodeValidationIcon validationIcon =
    case validationIcon of
        R10.FormTypes.NoIcon ->
            E.string "no_icon"

        R10.FormTypes.ClearOrCheck ->
            E.string "clear_or_check"

        R10.FormTypes.ErrorOrCheck ->
            E.string "error_or_check"


decoderValidation : D.Decoder Validation
decoderValidation =
    D.oneOf
        [ D.lazy (\_ -> decoderAllOf)
        , D.lazy (\_ -> decoderOneOf)
        , D.lazy (\_ -> decoderWithMsg)
        , D.lazy (\_ -> decoderDependant)
        , D.lazy (\_ -> decoderNot)
        , decoderMinLength
        , decoderMaxLength
        , decoderRegex
        , decoderEqual
        , decoderSimpleValidation
        , decoderDateRange
        ]


decoderValidationIcon : D.Decoder R10.FormTypes.ValidationIcon
decoderValidationIcon =
    D.string
        |> D.andThen
            (\str ->
                case str of
                    "no_icon" ->
                        D.succeed R10.FormTypes.NoIcon

                    "clear_or_check" ->
                        D.succeed R10.FormTypes.ClearOrCheck

                    "error_or_check" ->
                        D.succeed R10.FormTypes.ErrorOrCheck

                    somethingElse ->
                        D.fail <| "Unknown ValidationIcon: " ++ somethingElse ++ ". It should be something like NoValidation."
            )



--AllOf


encodeAllOf : List Validation -> E.Value
encodeAllOf validations =
    E.object
        [ ( "validation", E.list encodeValidation validations ) ]


decoderAllOf : D.Decoder Validation
decoderAllOf =
    D.map AllOf
        (D.field "validations" (D.list decoderValidation))



--OneOf


encodeOneOf : List Validation -> E.Value
encodeOneOf validations =
    E.object
        [ ( "validation", E.list encodeValidation validations ) ]


decoderOneOf : D.Decoder Validation
decoderOneOf =
    D.map OneOf
        (D.field "validations" (D.list decoderValidation))



--WithMsg


encodeWithMsg : ValidationMessage -> Validation -> E.Value
encodeWithMsg msg validation =
    E.object
        [ ( "msg", encodeValidationMessage msg )
        , ( "validation", encodeValidation validation )
        ]


decoderWithMsg : D.Decoder Validation
decoderWithMsg =
    D.map2 WithMsg
        (D.field "msg" decoderValidationMessage)
        (D.field "validation" decoderValidation)



--ValidationMessage


encodeValidationMessage : ValidationMessage -> E.Value
encodeValidationMessage validationMessage =
    E.object
        [ ( "ok", E.string validationMessage.ok )
        , ( "err", E.string validationMessage.err )
        ]


decoderValidationMessage : D.Decoder ValidationMessage
decoderValidationMessage =
    D.map2 ValidationMessage
        (D.field "ok" D.string)
        (D.field "err" D.string)



--Dependant


encodeDependant : String -> Validation -> E.Value
encodeDependant dependant_on validation =
    E.object
        [ ( "dependant_on", E.string dependant_on )
        , ( "validation", encodeValidation validation )
        ]


decoderDependant : D.Decoder Validation
decoderDependant =
    D.map2 Dependant
        (D.field "dependant_on" D.string)
        (D.field "validation" decoderValidation)



--MinLength


encodeMinLength : Int -> E.Value
encodeMinLength minLength =
    E.object [ ( "min_length", E.int minLength ) ]


decoderMinLength : D.Decoder Validation
decoderMinLength =
    D.map MinLength
        (D.field "min_length" D.int)



--MaxLength


encodeMaxLength : Int -> E.Value
encodeMaxLength maxLength =
    E.object [ ( "max_length", E.int maxLength ) ]


decoderMaxLength : D.Decoder Validation
decoderMaxLength =
    D.map MaxLength
        (D.field "max_length" D.int)



--Regex


encodeRegex : String -> E.Value
encodeRegex regex =
    E.object [ ( "regex", E.string regex ) ]


decoderRegex : D.Decoder Validation
decoderRegex =
    D.map Regex
        (D.field "regex" D.string)



-- Equal


encodeEqual : String -> E.Value
encodeEqual key =
    E.object [ ( "equal", E.string key ) ]


decoderEqual : D.Decoder Validation
decoderEqual =
    D.map Equal
        (D.field "equal" D.string)



-- Not


encodeNot : Validation -> E.Value
encodeNot validation =
    E.object [ ( "not", encodeValidation validation ) ]


decoderNot : D.Decoder Validation
decoderNot =
    D.map Not
        (D.field "not" decoderValidation)



--SimpleValidation


decoderSimpleValidation : D.Decoder Validation
decoderSimpleValidation =
    D.string
        |> D.andThen
            (\str ->
                case str of
                    "no_validation" ->
                        D.succeed NoValidation

                    "required" ->
                        D.succeed Required

                    "empty" ->
                        D.succeed Empty

                    somethingElse ->
                        D.fail <| "Unknown Validation: " ++ somethingElse ++ ". It should be something like NoValidation."
            )



-- DateRange


encodeDateRange : Range -> E.Value
encodeDateRange range =
    E.object [ ( "date_range", encodeRange range ) ]


encodeRange : Range -> E.Value
encodeRange range =
    E.object
        [ ( "max", E.int range.max )
        , ( "min", E.int range.min )
        ]


decoderDateRange : D.Decoder Validation
decoderDateRange =
    D.map DateRange
        (D.field "date_range" decoderRange)


decoderRange : D.Decoder Range
decoderRange =
    D.map2 Range
        (D.field "max" D.int)
        (D.field "min" D.int)
