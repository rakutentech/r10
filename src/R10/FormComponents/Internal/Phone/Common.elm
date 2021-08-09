module R10.FormComponents.Internal.Phone.Common exposing
    ( Args
    , FieldOption
    , Model
    , Msg(..)
    , dropdownContainerId
    , dropdownContentId
    , dropdownSearchBoxId
    , filterBySearch
    , init
    , normalizeString
    )

import Element.WithContext exposing (..)
import R10.Country
import R10.FormComponents.Internal.Single.Common
import R10.FormComponents.Internal.Style
import R10.FormTypes
import R10.Context exposing (..)



-- types


type Msg
    = NoOp
    | OnFocus String
    | OnLoseFocus String
    | OnScroll Float
    | OnEsc
      --
    | OnInputClick { key : String, selectedY : Float }
    | OnOptionSelect R10.Country.Country
    | OnSearch { key : String, selectOptionHeight : Int, maxDisplayCount : Int, filteredFieldOption : List R10.Country.Country } String
    | OnArrowUp { key : String, selectOptionHeight : Int, maxDisplayCount : Int, filteredFieldOption : List R10.Country.Country }
    | OnArrowDown { key : String, selectOptionHeight : Int, maxDisplayCount : Int, filteredFieldOption : List R10.Country.Country }
      --
    | OnValueChange String { selectOptionHeight : Int, maxDisplayCount : Int, filteredFieldOption : List R10.Country.Country } String


init : Model
init =
    R10.FormComponents.Internal.Single.Common.init


type alias Model =
    R10.FormComponents.Internal.Single.Common.Model


type alias FieldOption =
    R10.FormComponents.Internal.Single.Common.FieldOption


type alias Args msg =
    -- Stuff that change
    { maybeValid : Maybe Bool

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
    , countryOptions : List R10.Country.Country
    , toOptionEl : R10.Country.Country -> ElementC msg
    , selectOptionHeight : Int
    , maxDisplayCount : Int
    , leadingIcon : List (ElementC msg)
    , trailingIcon : List (ElementC msg)
    }


normalizeString : String -> String
normalizeString =
    -- use for filtering, search <-> label comparison
    String.toLower >> String.trim


searchFn : String -> R10.Country.Country -> Bool
searchFn search country =
    String.contains
        (search |> normalizeString)
        (country |> R10.Country.toString |> normalizeString)


filterBySearch : String -> List R10.Country.Country -> List R10.Country.Country
filterBySearch search fieldOptions =
    if
        String.isEmpty search
            --|| isAnyOptionLabelMatched { value = search, fieldOptions = fieldOptions }
            || (fieldOptions |> List.map R10.Country.toString |> List.any ((==) search))
    then
        fieldOptions

    else
        fieldOptions
            |> List.filter (searchFn search)


dropdownContainerId : String -> String
dropdownContainerId key =
    "dropdown-container-" ++ key


dropdownContentId : String -> String
dropdownContentId key =
    "dropdown-content-" ++ key


dropdownSearchBoxId : String -> String
dropdownSearchBoxId key =
    "dropdown-search-" ++ key
