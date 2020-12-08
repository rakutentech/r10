module R10.FormComponents.Internal.Single.Common exposing
    ( Args
    , FieldOption
    , Model
    , Msg(..)
    , dropdownContentId
    , getSelectedOrFirst
    , init
    , isAnyOptionLabelMatched
    , isAnyOptionValueMatched
    , selectId
    )

import Element exposing (..)
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.Validations
import R10.FormTypes



-- types


type Msg
    = NoOp
    | OnFocus String
    | OnLoseFocus String
    | OnScroll Float
    | OnSearch { key : String, fieldOptions : List FieldOption } String
    | OnOptionSelect String --newValue
    | OnArrowUp { key : String, selectOptionHeight : Int, maxDisplayCount : Int, fieldOptions : List FieldOption } -- newSelect selectionY
    | OnArrowDown { key : String, selectOptionHeight : Int, maxDisplayCount : Int, fieldOptions : List FieldOption } -- newSelect selectionY
    | OnEsc
    | OnInputClick { key : String, selectedY : Float }


init : Model
init =
    { value = ""
    , search = ""
    , select = ""
    , focused = False
    , scroll = 0
    , opened = False
    }


type alias Model =
    { value : String
    , search : String
    , select : String
    , focused : Bool
    , scroll : Float
    , opened : Bool
    }


type alias FieldOption =
    { value : String
    , label : String
    }


type alias Args msg =
    -- Stuff that change
    { validation : R10.FormComponents.Internal.Validations.Validation

    ---- Messages
    , toMsg : Msg -> msg

    -- Stuff that doesn't change
    , label : String
    , helperText : Maybe String
    , disabled : Bool
    , requiredLabel : Maybe String
    , style : R10.FormComponents.Internal.Style.Style
    , key : String
    , palette : R10.FormTypes.Palette

    -- Specific
    , singleType : R10.FormTypes.TypeSingle
    , fieldOptions : List FieldOption
    , toOptionEl : FieldOption -> Element msg
    , searchFn : String -> FieldOption -> Bool
    , selectOptionHeight : Int
    , maxDisplayCount : Int
    , leadingIcon : Maybe (Element msg)
    , trailingIcon : Maybe (Element msg)
    }


isAnyOptionValueMatched : { a | value : String, fieldOptions : List FieldOption } -> Bool
isAnyOptionValueMatched { value, fieldOptions } =
    List.any (\option -> option.value == value) fieldOptions


isAnyOptionLabelMatched : { a | value : String, fieldOptions : List FieldOption } -> Bool
isAnyOptionLabelMatched { value, fieldOptions } =
    List.any (\option -> option.label == value) fieldOptions


getSelectedOrFirst : List FieldOption -> String -> String -> String
getSelectedOrFirst fieldOptions value select =
    if not <| String.isEmpty select then
        select

    else if isAnyOptionValueMatched { value = value, fieldOptions = fieldOptions } then
        value

    else
        List.head fieldOptions
            |> Maybe.map .value
            |> Maybe.withDefault ""


dropdownContentId : String -> String
dropdownContentId key =
    "dropdown-content-" ++ key


selectId : String -> String
selectId key =
    "dropdown-" ++ key
