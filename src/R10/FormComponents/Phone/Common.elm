module FormComponents.Phone.Common exposing
    ( Args
    , FieldOption
    , Model
    , Msg(..)
    , dropdownContentId
    , init
    , selectId
    )

import Element exposing (..)
import FormComponents.Phone.Country exposing (Country)
import FormComponents.Style
import FormComponents.UI.Palette
import FormComponents.Validations
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
    { validation : FormComponents.Validations.Validation

    ---- Messages
    , toMsg : Msg -> msg

    -- Stuff that doesn't change
    , label : String
    , helperText : Maybe String
    , disabled : Bool
    , requiredLabel : Maybe String
    , style : FormComponents.Style.Style
    , key : String
    , palette : FormComponents.UI.Palette.Palette

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
