module R10.FormComponents.Single.Common exposing
    ( Args
    , FieldOption
    , Model
    , Msg(..)
    , TypeSingle(..)
    , getSelectedOrFirst
    , init
    , isAnyOptionSelected
    )

import Element exposing (..)
import R10.FormComponents.Style
import R10.FormComponents.UI.Palette
import R10.FormComponents.Validations



-- types


type Msg
    = NoOp
    | OnFocus String
    | OnLoseFocus String
    | OnScroll Float
    | OnSearch String String --newSearch newSearch
    | OnOptionSelect String --newVal
    | OnArrowUp String Float -- newVal selectionY
    | OnArrowDown String Float -- newVal selectionY
    | OnEsc
    | OnInputClick Float -- selectionY


init : Model
init =
    { value = ""
    , search = ""
    , focused = False
    , scroll = 0
    , opened = False
    }


type alias Model =
    { value : String
    , search : String
    , focused : Bool
    , scroll : Float
    , opened : Bool
    }


type TypeSingle
    = SingleRadio
    | SingleCombobox


type alias FieldOption =
    { value : String
    , label : String
    }


type alias Args msg =
    -- Stuff that change
    { value : String
    , search : String
    , focused : Bool
    , scroll : Float
    , active :
        -- TODO indicates is dropdown open or not? named "active" so other elements of R10.FormComponents can
        -- use same naming for component specific state. consider renaming?
        Bool
    , validation : R10.FormComponents.Validations.Validation

    -- Messages
    , msgNoOp : msg
    , msgOnFocus : String -> msg
    , msgOnLoseFocus : String -> msg
    , msgOnScroll : Float -> msg
    , msgOnSearch : String -> String -> msg
    , msgOnOptionSelect : String -> msg
    , msgOnArrowUp : String -> Float -> msg
    , msgOnArrowDown : String -> Float -> msg
    , msgOnEsc : msg
    , msgOnInputClick : Float -> msg

    -- Stuff that doesn't change
    , label : String
    , helperText : Maybe String
    , disabled : Bool
    , requiredLabel : Maybe String
    , style : R10.FormComponents.Style.Style
    , key : String
    , palette : R10.FormComponents.UI.Palette.Palette

    -- Specific
    , singleType : TypeSingle
    , fieldOptions : List FieldOption
    , toOptionEl : FieldOption -> Element msg
    , searchFn : String -> FieldOption -> Bool
    , selectOptionHeight : Int
    , maxDisplayCount : Int
    , leadingIcon : Maybe (Element msg)
    , trailingIcon : Maybe (Element msg)
    }


isAnyOptionSelected : { a | value : String, fieldOptions : List FieldOption } -> Bool
isAnyOptionSelected { value, fieldOptions } =
    List.any (\option -> option.value == value) fieldOptions


getSelectedOrFirst : List FieldOption -> String -> String
getSelectedOrFirst fieldOptions value =
    if isAnyOptionSelected { value = value, fieldOptions = fieldOptions } then
        value

    else
        List.head fieldOptions
            |> Maybe.map .value
            |> Maybe.withDefault ""
