module R10.FormTypes exposing
    ( TypeText(..), TypeBinary(..), TypeMulti(..), TypeSingle(..)
    , FieldType(..), FieldOption
    , inputField
    , ValidationIcon(..)
    , Palette
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
    | TextUsername
    | TextPasswordNew
    | TextPasswordCurrent
    | TextMultiline
    | TextWithPattern String


{-| Possible types of **Single** input fields
-}
type TypeSingle
    = SingleRadio
    | SingleCombobox


{-| Possible types of **Binarye** input fields
-}
type TypeBinary
    = BinaryCheckbox
    | BinarySwitch


{-| Possible types of **Multy** input fields
-}
type TypeMulti
    = MultiCombobox -- TODO



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
    , singleRadio : List FieldOption -> FieldType
    , textEmail : FieldType
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
    , textUsername = TypeText TextUsername
    , textPasswordNew = TypeText TextPasswordNew
    , textPasswordCurrent = TypeText TextPasswordCurrent
    , textMultiline = TypeText TextMultiline
    , textWithPattern = \string -> TypeText (TextWithPattern string)

    --
    , singleRadio = TypeSingle SingleRadio
    , singleCombobox = TypeSingle SingleCombobox

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
    | ClearOrCheck -- clear aka cross
    | ErrorOrCheck -- "!" in circle, just like Google's



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

Note that these are `Element.Color` from `elm-ui`.

See <https://material.io/design/color/dark-theme.html#properties> for more details.

If you want to use the default palette, just pass `Nothing`

-}
type alias Palette =
    { -- Colors
      primary : Color.Color
    , primaryVariant : Color.Color
    , success : Color.Color
    , error : Color.Color

    -- Text Colors
    , onSurface : Color.Color
    , onPrimary : Color.Color

    -- Background Colors
    , surface : Color.Color -- Card, List background color https://material.io/design/color/dark-theme.html#properties
    , background : Color.Color
    }
