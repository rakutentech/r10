module R10.Table.Internal.Msg exposing (Msg(..))

import R10.Form
import R10.Table.Internal.Types


type Msg
    = Sort String Bool
    | PaginatorNextPage
    | PaginatorPrevPage
    | PaginatorLengthOption Int
    | FiltersTogglePopup R10.Table.Internal.Types.Filter
    | FilterClear String
    | FiltersPopupFormMsg R10.Form.Msg
