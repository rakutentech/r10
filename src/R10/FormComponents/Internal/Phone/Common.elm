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

import Element exposing (..)
import R10.Country exposing (Country)
import R10.FormComponents.Internal.Style
import R10.FormTypes



-- types


type Msg
    = NoOp
    | OnFocus
    | OnLoseFocus
    | OnScroll Float
    | OnValue String -- newValue, newValue
    | OnSearch String { selectOptionHeight : Int, maxDisplayCount : Int, filteredCountryOptions : List Country } String -- newSearch, newSelect
    | OnOptionSelect Country --newValue
    | OnArrowUp String { selectOptionHeight : Int, maxDisplayCount : Int, filteredCountryOptions : List Country } -- newSelect selectionY
    | OnArrowDown String { selectOptionHeight : Int, maxDisplayCount : Int, filteredCountryOptions : List Country } -- newSelect selectionY
    | OnEsc
    | OnFlagClick String Float -- selectionY


init : Model
init =
    { value = ""
    , countryValue = Nothing
    , search = ""
    , select = Nothing
    , focused = False
    , scroll = 0
    , opened = False
    }


type alias Model =
    { value : String
    , countryValue : Maybe Country
    , search : String
    , select : Maybe Country
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
    { valid : Maybe Bool

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
    , countryOptions : List Country
    , toOptionEl : Country -> Element msg
    , selectOptionHeight : Int
    , maxDisplayCount : Int
    , leadingIcon : Maybe (Element msg)
    , trailingIcon : Maybe (Element msg)
    }


normalizeString : String -> String
normalizeString =
    -- use for filtering, search <-> label comparison
    String.toLower >> String.trim


searchFn : String -> Country -> Bool
searchFn search country =
    String.contains
        (search |> normalizeString)
        (country |> R10.Country.toString |> normalizeString)


filterBySearch : String -> List Country -> List Country
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
