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
    , inputPhoneElementId
    , normalizeString
    )

import Element.WithContext exposing (..)
import R10.Context exposing (..)
import R10.Country
import R10.FormComponents.Internal.Single.Common
import R10.FormComponents.Internal.Style
import R10.Palette



-- types


type Msg
    = NoOp
    | OnFocus String
    | OnLoseFocus String
    | OnScroll Float
    | OnEsc String Bool
      --
    | OnInputClick { key : String, selectedY : Float }
    | OnOptionSelect String R10.Country.Country
    | OnSearch { key : String, selectOptionHeight : Int, maxDisplayCount : Int, filteredFieldOption : List R10.Country.Country } String
    | OnArrowUp { key : String, selectOptionHeight : Int, maxDisplayCount : Int, filteredFieldOption : List R10.Country.Country }
    | OnArrowDown { key : String, selectOptionHeight : Int, maxDisplayCount : Int, filteredFieldOption : List R10.Country.Country }
      --
    | OnValueChange String { selectOptionHeight : Int, maxDisplayCount : Int, filteredFieldOption : List R10.Country.Country } String
    | OnSimpleValueChange Bool String


init : Model
init =
    R10.FormComponents.Internal.Single.Common.init


type alias Model =
    R10.FormComponents.Internal.Single.Common.Model


type alias FieldOption =
    R10.FormComponents.Internal.Single.Common.FieldOption


type alias Args z msg =
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
    , palette : R10.Palette.Palette
    , disabledCountryChange : Bool

    -- Specific
    , countryOptions : List R10.Country.Country
    , toOptionEl : R10.Country.Country -> Element (R10.Context.ContextInternal z) msg
    , selectOptionHeight : Int
    , maxDisplayCount : Int
    , leadingIcon : List (Element (R10.Context.ContextInternal z) msg)
    , trailingIcon : List (Element (R10.Context.ContextInternal z) msg)
    }


normalizeString : String -> String
normalizeString =
    -- use for filtering, search <-> label comparison
    String.toLower >> String.trim


searchFn : String -> R10.Country.Country -> Bool
searchFn search country =
    String.contains
        (search |> normalizeString)
        (country |> R10.Country.toCountryNameWithAlias |> normalizeString)


filterBySearch : String -> List R10.Country.Country -> List R10.Country.Country
filterBySearch search fieldOptions =
    if String.isEmpty search then
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


inputPhoneElementId : String -> String
inputPhoneElementId key =
    "input-phone-" ++ key
