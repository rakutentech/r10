module R10.Form.Internal.Translator exposing
    ( Translator
    , translator
    , validationCodes
    )

import Dict
import R10.Form.Internal.FieldConf
import R10.Form.Internal.Key


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
    , lengthExactInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , lengthValid : R10.Form.Internal.FieldConf.ValidationCode
    , required : R10.Form.Internal.FieldConf.ValidationCode
    , empty : R10.Form.Internal.FieldConf.ValidationCode
    , requiredField : R10.Form.Internal.FieldConf.ValidationCode
    , somethingWrong : R10.Form.Internal.FieldConf.ValidationCode
    , valueInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , allOf : R10.Form.Internal.FieldConf.ValidationCode
    , oneOf : R10.Form.Internal.FieldConf.ValidationCode
    , mobileEmailFormatInvalid : R10.Form.Internal.FieldConf.ValidationCode
    , mobileEmailDomainInvalid : R10.Form.Internal.FieldConf.ValidationCode
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
    , lengthExactInvalid = "INVALID_LENGTH_EXACT"
    , lengthValid = "CORRECT_LENGTH"
    , required = "REQUIRED"
    , empty = "EMPTY"
    , requiredField = "REQUIRED_FIELD"
    , somethingWrong = "SOMETHING_WENT_WRONG_DURING_VALIDATION"
    , valueInvalid = "INVALID_VALUE"
    , allOf = "ALL_OF"
    , oneOf = "ONE_OF"
    , mobileEmailFormatInvalid = "MOBILE_EMAIL_INVALID_FORMAT"
    , mobileEmailDomainInvalid = "MOBILE_EMAIL_INVALID_DOMAIN"
    }


type alias Translator =
    R10.Form.Internal.Key.Key -> R10.Form.Internal.FieldConf.ValidationCode -> String


translator : Translator
translator _ validationCode =
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
        , ( validationCodes.lengthValid
          , "Correct length"
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
          , "All of the validations have failed"
          )
        , ( validationCodes.mobileEmailFormatInvalid
          , "Incorrect email address format"
          )
        , ( validationCodes.mobileEmailDomainInvalid
          , "This domain name cannot be used"
          )
        ]
        |> Dict.get validationCode
        |> Maybe.withDefault validationCode
