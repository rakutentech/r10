module R10.FormComponents.Internal.Single.Common exposing
    ( Args
    , FieldOption
    , Model
    , Msg(..)
    , dropdownContainerId
    , dropdownContentId
    , filterBySearch
    , getSelectedOrFirst
    , init
    , singleSearchBoxId
    )

import Element.WithContext exposing (..)
import R10.Context exposing (..)
import R10.FormComponents.Internal.Style
import R10.FormTypes
import R10.Palette



-- types


type Msg
    = NoOp
    | Hover (Maybe String)
    | OnFocus
    | OnLoseFocus String
    | OnScroll Float
    | OnEsc
      --
    | OnInputClick { key : String, selectedY : Float }
    | OnOptionSelect String
    | OnSearch { key : String, selectOptionHeight : Int, maxDisplayCount : Int, filteredFieldOption : List FieldOption } String
    | OnArrowUp { key : String, selectOptionHeight : Int, maxDisplayCount : Int, filteredFieldOption : List FieldOption }
    | OnArrowDown { key : String, selectOptionHeight : Int, maxDisplayCount : Int, filteredFieldOption : List FieldOption }
      --
    | OnDelBackspace


init : Model
init =
    { value = ""
    , search = ""
    , focused = False
    , scroll = 0
    , opened = False
    , select = ""
    , over = Nothing
    }


type alias Model =
    { value : String
    , search : String
    , focused : Bool
    , scroll : Float
    , opened : Bool
    , select : String
    , over : Maybe String
    }


type alias FieldOption =
    { value : String
    , label : String
    }


type alias Args z msg =
    { ---- Messages
      toMsg : Msg -> msg

    -- Stuff that doesn't change
    , label : String
    , helperText : Maybe String
    , disabled : Bool
    , maybeValid : Maybe Bool
    , requiredLabel : Maybe String
    , style : R10.FormComponents.Internal.Style.Style
    , key : String
    , palette : R10.Palette.Palette
    , searchable : Bool
    , autocomplete : Maybe String

    -- Specific
    , singleType : R10.FormTypes.TypeSingle
    , fieldOptions : List FieldOption
    , viewOptionEl : FieldOption -> Element (R10.Context.ContextInternal z) msg
    , searchFn : String -> FieldOption -> Bool
    , selectOptionHeight : Int
    , maxDisplayCount : Int
    , leadingIcon : List (Element (R10.Context.ContextInternal z) msg)
    , trailingIcon : List (Element (R10.Context.ContextInternal z) msg)
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


filterBySearch :
    String
    ->
        { a
            | searchFn : String -> FieldOption -> Bool
            , fieldOptions : List FieldOption
        }
    -> List FieldOption
filterBySearch search { searchFn, fieldOptions } =
    if
        String.isEmpty search
            || isAnyOptionLabelMatched { value = search, fieldOptions = fieldOptions }
    then
        fieldOptions

    else
        fieldOptions
            |> List.filter (searchFn search)


dropdownContainerId : String -> String
dropdownContainerId key =
    "single-dropdown-container-" ++ key


dropdownContentId : String -> String
dropdownContentId key =
    "single-dropdown-content-" ++ key


singleSearchBoxId : String -> String
singleSearchBoxId key =
    "single-dropdown-search-" ++ key
