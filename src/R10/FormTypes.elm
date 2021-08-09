module R10.FormTypes exposing
    ( TypeText(..), TypeBinary(..), TypeMulti(..), TypeSingle(..)
    , FieldType(..), FieldOption
    , inputField
    , ValidationIcon(..)
    , Palette
    , TypeSpecial(..)
    )

{-| Types for Forms

@docs TypeText, TypeBinary, TypeMulti, TypeSingle

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
    | TextUsername
    | TextPasswordNew
    | TextPasswordCurrent
    | TextMultiline
    | TextWithPattern String
    | TextWithPatternLarge String


{-| Possible types of **Single** input fields
-}
type TypeSingle
    = SingleRadio
    | SingleRadioRow
    | SingleCombobox
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
    = SpecialPhone -- TODO



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
    , textMultiline : FieldType
    , textPasswordCurrent : FieldType
    , textPasswordNew : FieldType
    , textPlain : FieldType
    , textUsername : FieldType
    , textWithPattern : String -> FieldType
    }
inputField =
    { textPlain = TypeText TextPlain
    , textEmail = TypeText TextEmail
    , textEmailWithSuggestions = \listSuggestions -> TypeText (TextEmailWithSuggestions listSuggestions)
    , textUsername = TypeText TextUsername
    , textPasswordNew = TypeText TextPasswordNew
    , textPasswordCurrent = TypeText TextPasswordCurrent
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
