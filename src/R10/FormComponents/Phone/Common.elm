module R10.FormComponents.Phone.Common exposing
    ( Args
    , FieldOption
    , Model
    , Msg(..)
    , dropdownContentId
    , init
    , selectId
    )

import Element exposing (..)
import R10.FormComponents.Phone.Country exposing (Country)
import R10.FormComponents.Style
import R10.FormComponents.Validations
import R10.FormTypes
import Time



-- types


type Msg
    = NoOp
    | OnFocus
    | OnLoseFocus
    | OnScroll Float
    | OnSearch String { selectOptionHeight : Int, maxDisplayCount : Int, countryOptions : List Country } String -- newSearch, newSelect
    | OnSearchTime String { selectOptionHeight : Int, maxDisplayCount : Int, countryOptions : List Country } String Time.Posix -- newSearch, newSelect
    | OnOptionSelect Country --newValue
    | OnArrowUp String { selectOptionHeight : Int, maxDisplayCount : Int, countryOptions : List Country } -- newSelect selectionY
    | OnArrowDown String { selectOptionHeight : Int, maxDisplayCount : Int, countryOptions : List Country } -- newSelect selectionY
    | OnEsc
    | OnFlagClick String Float -- selectionY


init : Model
init =
    { value = ""
    , search = ""
    , select = Nothing
    , focused = False
    , scroll = 0
    , opened = False
    }


type alias Model =
    { value : String
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
    { validation : R10.FormComponents.Validations.Validation

    ---- Messages
    , toMsg : Msg -> msg

    -- Stuff that doesn't change
    , label : String
    , helperText : Maybe String
    , disabled : Bool
    , requiredLabel : Maybe String
    , style : R10.FormComponents.Style.Style
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


dropdownContentId : String -> String
dropdownContentId key =
    "dropdown-content-" ++ key


selectId : String -> String
selectId key =
    "dropdown-" ++ key
