module R10.Form.Internal.ValidationCode exposing
    ( fromValidationCodeToMessageWithReplacedValues
    , translator
    , validationCodes
    )

import Dict
import R10.Form.Internal.FieldConf
import Regex


validationCodes :
    { emailFormatInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , emailFormatValid : R10.Form.Internal.FieldConf.ValidationCode
    , equalInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , formatInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , formatInvalidCharactersInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , formatNoNumberInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , formatNoSpecialCharactersInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , formatNoUppercaseInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , formatValid : R10.Form.Internal.FieldConf.ValidationCode
    , hexColorFormatInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , jsonFormatInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , lengthTooLargeInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , lengthTooSmallInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , required : R10.Form.Internal.FieldConf.ValidationCode
    , empty : R10.Form.Internal.FieldConf.ValidationCode
    , requiredField : R10.Form.Internal.FieldConf.ValidationCode
    , somethingWrong : R10.Form.Internal.FieldConf.ValidationCode
    , valueInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , allOf : R10.Form.Internal.FieldConf.ValidationCode
    , oneOf : R10.Form.Internal.FieldConf.ValidationCode
    }
validationCodes =
    { emailFormatInvalid = "INVALID_EMAIL_FORMAT"
    , emailFormatValid = "VALID_EMAIL_FORMAT"
    , equalInvalid = "INVALID_EQUAL"
    , formatInvalid = "INVALID_FORMAT"
    , formatInvalidCharactersInvalid = "INVALID_FORMAT_INVALID_CHARACTERS"
    , formatNoNumberInvalid = "INVALID_FORMAT_NO_NUMBER"
    , formatNoSpecialCharactersInvalid = "INVALID_FORMAT_NO_SPECIAL_CHARACTERS"
    , formatNoUppercaseInvalid = "INVALID_FORMAT_NO_UPPERCASE"
    , formatValid = "VALID_FORMAT"
    , hexColorFormatInvalid = "INVALID_HEX_COLOR_FORMAT"
    , jsonFormatInvalid = "INVALID_JSON_FORMAT"
    , lengthTooLargeInvalid = "INVALID_LENGTH_TOO_LARGE"
    , lengthTooSmallInvalid = "INVALID_LENGTH_TOO_SMALL"
    , required = "REQUIRED"
    , empty = "EMPTY"
    , requiredField = "REQUIRED_FIELD"
    , somethingWrong = "SOMETHING_WENT_WRONG_DURING_VALIDATION"
    , valueInvalid = "INVALID_VALUE"
    , allOf = "ALL_OF"
    , oneOf = "ONE_OF"
    }


translator : R10.Form.Internal.FieldConf.ValidationCode -> String
translator validationCode =
    Dict.fromList
        [ ( validationCodes.emailFormatInvalid
          , "Invalid email format"
          )
        , ( validationCodes.emailFormatValid
          , "Valid email format"
          )
        , ( validationCodes.formatInvalid
          , "Invalid format"
          )
        , ( validationCodes.formatValid
          , "Valid format"
          )
        , ( validationCodes.formatInvalidCharactersInvalid
          , "Cannot contain spaces or special language characters"
          )
        , ( validationCodes.formatNoNumberInvalid
          , "Must contain a digit (ex: 1, 2, etc.)"
          )
        , ( validationCodes.formatNoSpecialCharactersInvalid
          , "Must contain a special character (ex: !, @, #, etc.)"
          )
        , ( validationCodes.formatNoUppercaseInvalid
          , "Must contain a capital letter (ex: A, B, etc.)"
          )
        , ( validationCodes.hexColorFormatInvalid
          , "Invalid hex color"
          )
        , ( validationCodes.jsonFormatInvalid
          , "Invalid json format"
          )
        , ( validationCodes.lengthTooLargeInvalid
          , "Maximum allowed length is {0} characters"
          )
        , ( validationCodes.lengthTooSmallInvalid
          , "Minimum allowed length is {0} characters"
          )
        , ( validationCodes.required
          , "Required"
          )
        , ( validationCodes.empty
          , "Empty"
          )
        , ( validationCodes.requiredField
          , "(Required)"
          )
        , ( validationCodes.somethingWrong
          , "Something wrong"
          )
        , ( validationCodes.equalInvalid
          , "Value should be equal"
          )
        , ( validationCodes.valueInvalid
          , "This is not a valid selection"
          )
        , ( validationCodes.allOf
          , "One of the validations have failed"
          )
        , ( validationCodes.oneOf
          , "All the validations have failed"
          )
        ]
        |> Dict.get validationCode
        |> Maybe.withDefault validationCode


fromValidationCodeToMessageWithReplacedValues :
    R10.Form.Internal.FieldConf.ValidationCode
    -> R10.Form.Internal.FieldConf.ValidationPayload
    -> (R10.Form.Internal.FieldConf.ValidationCode -> String)
    -> String
fromValidationCodeToMessageWithReplacedValues validationCode bracketsArgs translator_ =
    let
        translated : String
        translated =
            translator_ validationCode
    in
    if List.isEmpty bracketsArgs then
        translated

    else
        replaceBrackets bracketsArgs translated


replacer : ( Int, String ) -> String -> String
replacer ( index, value ) acc =
    Regex.replace (regexBracket index) (\_ -> value) acc


replaceBrackets : List String -> String -> String
replaceBrackets values target =
    values
        |> List.indexedMap Tuple.pair
        |> List.foldl replacer target


regexBracket : Int -> Regex.Regex
regexBracket index =
    -- Removing all pairs of square brackets that just contain comments
    Regex.fromStringWith { caseInsensitive = True, multiline = True } ("\\{" ++ String.fromInt index ++ "\\}")
        |> Maybe.withDefault Regex.never
