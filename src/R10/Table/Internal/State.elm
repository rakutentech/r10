module R10.Table.Internal.State exposing
    ( FiltersState(..)
    , FiltersStateRecord
    , PaginationButtonState(..)
    , PaginationState(..)
    , PaginationStateRecord
    , State
    )

import Dict
import R10.Form


type PaginationButtonState
    = PaginationButtonDisabled
    | PaginationButtonOtherLoading
    | PaginationButtonLoading
    | PaginationButtonEnabled


type alias PaginationStateRecord =
    -- TODO there is too many combinations of nextButtonState + prevButtonState
    { length : Int
    , nextButtonState : PaginationButtonState
    , prevButtonState : PaginationButtonState

    -- todo replace button states with Edge+Loading states? Same number of combinations but likely clearer idea
    }


type PaginationState
    = Pagination PaginationStateRecord
    | NoPagination


type alias SortState =
    { name : String
    , isReversed : Bool
    }


type alias FiltersStateRecord =
    { filterEditor : Maybe ( String, R10.Form.Form ) -- ( open on filter with key, popup inner form model)
    , filterValues : Dict.Dict String String
    }


type FiltersState
    = Filters FiltersStateRecord
    | NoFilters


type alias State =
    { sort : SortState
    , pagination : PaginationState
    , filters : FiltersState
    , loading : Bool
    }
