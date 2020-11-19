module Form.FieldConf exposing
    ( FieldConf
    , FieldOption
    , FieldType(..)
    , TypeBinary(..)
    , TypeMulti
    , TypeSingle(..)
    , TypeText(..)
    , Validation(..)
    , ValidationCode
    , ValidationIcon(..)
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

import Form.Key
import Json.Decode as D
import Json.Encode as E
import Json.Encode.Extra as E


type alias ValidationMessage =
    { ok : String
    , err : String
    }


type Validation
    = NoValidation
      -- Modifications validations
    | WithMsg ValidationMessage Validation -- MsgOk MsgErr validation; changes message of the validation
    | Dependant Form.Key.KeyAsString Validation -- changes context of the validation
    | OneOf (List Validation) -- Sees set of underlying validation like one rule. Makes all rules valid if ANY of the rules is valid, otherwise make them invalid.
    | AllOf (List Validation) -- Sees set of underlying validation like one rule. Makes all rules valid if ALL of the rules is valid, otherwise make them invalid.
    | Not Validation -- Inverts result of the validation
      -- Current field validations
    | Equal Form.Key.KeyAsString -- Pass if the value is equal to the value
    | Required
    | Empty -- can be used in combined validations to create rules like "if field X is not empty, then Required" ( OneOf [ Required, Dependant "X"  ] )
    | MinLength Int
    | MaxLength Int
    | Regex String


type ValidationIcon
    = NoIcon
    | ClearOrCheck -- clear aka cross
    | ErrorOrCheck -- "!" in circle, just like Google's



-- ████████ ██    ██ ██████  ███████ ███████
--    ██     ██  ██  ██   ██ ██      ██
--    ██      ████   ██████  █████   ███████
--    ██       ██    ██      ██           ██
--    ██       ██    ██      ███████ ███████


type alias FieldOption =
    { value : String
    , label : String
    }


type TypeText
    = TextPlain
    | TextEmail
    | TextUsername
    | TextPasswordNew
    | TextPasswordCurrent
    | TextMultiline
    | TextWithPattern String


type TypeSingle
    = SingleRadio
    | SingleCombobox


type TypeBinary
    = BinaryCheckbox
    | BinarySwitch


type TypeMulti
    = MultiCombobox -- TODO


type FieldType
    = TypeText TypeText
    | TypeSingle TypeSingle (List FieldOption)
    | TypeMulti TypeMulti (List FieldOption)
    | TypeBinary TypeBinary


type alias ValidationCode =
    String


type alias ValidationPayload =
    -- bracket args
    List String


type alias FieldConf =
    { id : String
    , idDom : Maybe String
    , type_ : FieldType
    , label : String
    , helperText : Maybe String
    , requiredLabel : Maybe String
    , validationSpecs : Maybe ValidationSpecs
    }



-- ██ ███    ██ ██ ████████
-- ██ ████   ██ ██    ██
-- ██ ██ ██  ██ ██    ██
-- ██ ██  ██ ██ ██    ██
-- ██ ██   ████ ██    ██


type alias ValidationSpecs =
    { showPassedValidationMessages : Bool
    , hidePassedValidationStyle : Bool
    , validation : List Validation
    , validationIcon : ValidationIcon
    }


init : FieldConf
init =
    { id = ""
    , idDom = Nothing
    , type_ = TypeText TextPlain
    , label = ""
    , helperText = Nothing
    , requiredLabel = Nothing
    , validationSpecs = Just initValidationSpecs
    }


initValidationSpecs : ValidationSpecs
initValidationSpecs =
    { showPassedValidationMessages = False
    , hidePassedValidationStyle = False
    , validation = [ NoValidation ]
    , validationIcon = NoIcon
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
        , ( "idDom", E.maybe E.string fieldConf.idDom )
        , ( "type", encoderFieldType fieldConf.type_ )
        , ( "Label", E.string fieldConf.label )
        , ( "helperText", E.maybe E.string fieldConf.helperText )
        , ( "requiredLabel", E.maybe E.string fieldConf.requiredLabel )
        , ( "validationSpecs", E.maybe encodeValidationSpecs fieldConf.validationSpecs )
        ]


decoderFieldConf : D.Decoder FieldConf
decoderFieldConf =
    D.map7 FieldConf
        (D.field "id" D.string)
        (D.field "idDom" (D.maybe D.string))
        (D.field "type" decoderFieldType)
        (D.field "Label" D.string)
        (D.field "helperText" (D.maybe D.string))
        (D.field "requiredLabel" (D.maybe D.string))
        (D.field "validationSpecs" (D.maybe decoderValidationSpecs))


encoderFieldType : FieldType -> E.Value
encoderFieldType fieldType =
    case fieldType of
        TypeText testType ->
            case testType of
                TextPlain ->
                    E.string "TypeTextPlain"

                TextEmail ->
                    E.string "TypeTextEmail"

                TextUsername ->
                    E.string "TypeTextUsername"

                TextPasswordNew ->
                    E.string "TypeTextPasswordNew"

                TextPasswordCurrent ->
                    E.string "TypeTextPasswordCurrent"

                TextMultiline ->
                    E.string "TypeTextMultiline"

                TextWithPattern pattern ->
                    E.string <| "TextWithPattern" ++ jsonSeparator ++ pattern

        TypeBinary typeBinary ->
            case typeBinary of
                BinaryCheckbox ->
                    E.string "TypeBinaryCheckbox"

                BinarySwitch ->
                    E.string "TypeBinarySwitch"

        TypeSingle singleType _ ->
            case singleType of
                SingleRadio ->
                    E.string "TypeSingleRadio"

                SingleCombobox ->
                    E.string "TypeSingleCombobox"

        TypeMulti typeMulti _ ->
            case typeMulti of
                MultiCombobox ->
                    E.string "TypeMultiCombobox"


decoderFieldType : D.Decoder FieldType
decoderFieldType =
    D.string
        |> D.andThen
            (\str ->
                case String.split jsonSeparator str of
                    [ "TypeTextPlain" ] ->
                        D.succeed (TypeText TextPlain)

                    [ "TypeTextEmail" ] ->
                        D.succeed (TypeText TextEmail)

                    [ "TypeTextUsername" ] ->
                        D.succeed (TypeText TextUsername)

                    [ "TypeTextPasswordNew" ] ->
                        D.succeed (TypeText TextPasswordNew)

                    [ "TypeTextPasswordCurrent" ] ->
                        D.succeed (TypeText TextPasswordCurrent)

                    [ "TypeTextMultiline" ] ->
                        D.succeed (TypeText TextMultiline)

                    [ "TextWithPattern", pattern ] ->
                        D.succeed (TypeText <| TextWithPattern pattern)

                    [ "TypeSingleRadio" ] ->
                        D.succeed (TypeSingle SingleRadio [])

                    [ "TypeSingleCombobox" ] ->
                        D.succeed (TypeSingle SingleCombobox [])

                    [ "TypeBinaryCheckbox" ] ->
                        D.succeed (TypeBinary BinaryCheckbox)

                    somethingElse ->
                        D.fail <| "Unknown FieldType: " ++ List.foldl (++) "" somethingElse ++ ". It should be something like TypeTextPlain, TypeTextEmail, TypeTextUsername, TypeTextPasswordNew, TypeTextPasswordCurrent, TypeCheckbox, TypeRadio, TypeDate, TypePhoneNumber, TypeBirthday or TypeCombobox."
            )



--ValidationSpecs


encodeValidationSpecs : ValidationSpecs -> E.Value
encodeValidationSpecs validationSpecs =
    E.object
        [ ( "showPassedValidationMessages", E.bool validationSpecs.showPassedValidationMessages )
        , ( "hideCheckmark", E.bool validationSpecs.hidePassedValidationStyle )
        , ( "validation", E.list encodeValidation validationSpecs.validation )
        , ( "validationIcon", encodeValidationIcon validationSpecs.validationIcon )
        ]


decoderValidationSpecs : D.Decoder ValidationSpecs
decoderValidationSpecs =
    D.map4 ValidationSpecs
        (D.field "showPassedValidationMessages" D.bool)
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


encodeValidationIcon : ValidationIcon -> E.Value
encodeValidationIcon validationIcon =
    case validationIcon of
        NoIcon ->
            E.string "no_icon"

        ClearOrCheck ->
            E.string "clear_or_check"

        ErrorOrCheck ->
            E.string "error_or_check"


decoderValidation : D.Decoder Validation
decoderValidation =
    D.oneOf
        [ D.lazy (\_ -> decoderAllOf)
        , D.lazy (\_ -> decoderOneOf)
        , D.lazy (\_ -> decoderWithMsg)
        , D.lazy (\_ -> decoderDependant)
        , decoderMinLength
        , decoderMaxLength
        , decoderRegex
        , decodeSimpleValidation
        ]


decoderValidationIcon : D.Decoder ValidationIcon
decoderValidationIcon =
    D.string
        |> D.andThen
            (\str ->
                case str of
                    "no_icon" ->
                        D.succeed NoIcon

                    "clear_or_check" ->
                        D.succeed ClearOrCheck

                    "error_or_check" ->
                        D.succeed ErrorOrCheck

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


decodeEqual : D.Decoder Validation
decodeEqual =
    D.map Equal
        (D.field "equal" D.string)



-- Not


encodeNot : Validation -> E.Value
encodeNot validation =
    E.object [ ( "not", encodeValidation validation ) ]


decodeNot : D.Decoder Validation
decodeNot =
    D.map Not
        (D.field "validation" decoderValidation)



--SimpleValidation


decodeSimpleValidation : D.Decoder Validation
decodeSimpleValidation =
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
