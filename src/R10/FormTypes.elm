module R10.FormTypes exposing
    ( TypeText(..), TypeBinary(..), TypeMulti(..), TypeSingle(..), TypeSpecial(..)
    , FieldType(..), FieldOption
    , inputField
    , ValidationIcon(..)
    , Palette
    )

{-| Types for Forms

@docs TypeText, TypeBinary, TypeMulti, TypeSingle, TypeSpecial

@docs FieldType, FieldOption

@docs inputField

@docs ValidationIcon

@docs Palette

-}

import Color


{-| Possible types of **Text** input fields
-}
type TypeText
    = TextPlain
    | TextEmail
    | TextEmailWithSuggestions (List String)
    | TextMobileEmail
    | TextUsername
    | TextUsernameWithUseEmailCheckbox String
    | TextPasswordNew String
    | TextPasswordCurrent String
    | TextMultiline
    | TextWithPattern String
    | TextWithPatternLarge String
    | TextWithPatternLargeWithoutLabel String -- Only used for IdlitePhoneVerification, has specific styles.
    | TextOnlyDigitsOrDash -- Only input digits and the dash, similar input:tel


{-| Possible types of **Single** input fields
-}
type TypeSingle
    = SingleRadio
    | SingleRadioRow
    | SingleCombobox
    | SingleComboboxForCountry
    | SingleSelect


{-| Possible types of **Binary** input fields
-}
type TypeBinary
    = BinaryCheckbox
    | BinarySwitch


{-| Possible types of **Multi** input fields
-}
type TypeMulti
    = MultiCombobox -- TODO


{-| Possible types of **Special** input fields
-}
type TypeSpecial
    = SpecialPhone { disableInternationalPrefixPhoneChange : Bool, isJapanService : Bool }



-- disableInternationalPrefixPhoneChange: Disabled country change. isJapanService: OMN-5904 Disable valiadion change
--
--
--
--
--
--


{-| -}
type alias FieldOption =
    { value : String
    , label : String
    }


{-| -}
type FieldType
    = TypeText TypeText
    | TypeSingle TypeSingle (List FieldOption)
    | TypeMulti TypeMulti (List FieldOption)
    | TypeBinary TypeBinary
    | TypeSpecial TypeSpecial



--
--
--
--
--
--
--
--


{-| -}
inputField :
    { binaryCheckbox : FieldType
    , binarySwitch : FieldType
    , multiCombobox : List FieldOption -> FieldType
    , singleCombobox : List FieldOption -> FieldType
    , singleSelect : List FieldOption -> FieldType
    , singleRadio : List FieldOption -> FieldType
    , singleRadioRow : List FieldOption -> FieldType
    , textEmail : FieldType
    , textEmailWithSuggestions : List String -> FieldType
    , textMobileEmail : FieldType
    , textMultiline : FieldType
    , textPasswordCurrent : String -> FieldType
    , textPasswordNew : String -> FieldType
    , textPlain : FieldType
    , textUsername : FieldType
    , textUsernameWithUseEmailCheckbox : String -> FieldType
    , textWithPattern : String -> FieldType
    }
inputField =
    { textPlain = TypeText TextPlain
    , textEmail = TypeText TextEmail
    , textEmailWithSuggestions = \listSuggestions -> TypeText (TextEmailWithSuggestions listSuggestions)
    , textMobileEmail = TypeText TextMobileEmail
    , textUsername = TypeText TextUsername
    , textUsernameWithUseEmailCheckbox = \checkboxLabel -> TypeText (TextUsernameWithUseEmailCheckbox checkboxLabel)
    , textPasswordNew = \checkboxLabel -> TypeText (TextPasswordNew checkboxLabel)
    , textPasswordCurrent = \checkboxLabel -> TypeText (TextPasswordCurrent checkboxLabel)
    , textMultiline = TypeText TextMultiline
    , textWithPattern = \string -> TypeText (TextWithPattern string)

    --
    , singleRadio = TypeSingle SingleRadio
    , singleRadioRow = TypeSingle SingleRadioRow
    , singleCombobox = TypeSingle SingleCombobox -- searchable select
    , singleSelect = TypeSingle SingleSelect

    --
    , binaryCheckbox = TypeBinary BinaryCheckbox
    , binarySwitch = TypeBinary BinarySwitch

    --
    , multiCombobox = TypeMulti MultiCombobox
    }



--
--
--
--
--
--


{-| -}
type ValidationIcon
    = NoIcon
    | ClearOrCheck -- Error = "batsu"
    | ErrorOrCheck -- Error = "!" in a triangle



--
--
--
--
--
--


{-|

    type alias Palette =
        { primary : Color
        , primaryVariant : Color
        , success : Color
        , error : Color

        -- Text Colors
        --
        , onSurface : Color
        , onPrimary : Color

        -- Background Colors
        --
        , surface : Color
        , background : Color
        }

Note that these are `Color` from `elm-ui`.

See <https://material.io/design/color/dark-theme.html#properties> for more details.

If you want to use the default palette, just pass `Nothing`

-}
type alias Palette =
    { -- Colors
      primary : Color.Color
    , primaryVariant : Color.Color
    , success : Color.Color
    , error : Color.Color
    , border : Color.Color

    -- Text Colors
    , onSurface : Color.Color
    , onPrimary : Color.Color

    -- Background Colors
    , surface : Color.Color -- Card, List background color https://material.io/design/color/dark-theme.html#properties
    , background : Color.Color
    }
