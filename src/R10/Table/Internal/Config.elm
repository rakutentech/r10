module R10.Table.Internal.Config exposing
    ( ColumnAttrs
    , ColumnConf
    , Config
    , FiltersConfig
    , HeaderInfo
    , PaginationConfig
    )

import Element.WithContext exposing (..)
import R10.Context exposing (..)
import R10.FormTypes
import R10.Table.Internal.Msg
import R10.Table.Internal.Types


{-| There are quite a lot of ways to customize the `<table>` tag. You can add
a `<caption>` which can be styled via CSS. You can do crazy stuff with
`<thead>` to group columns in weird ways. You can have a `<tfoot>` tag for
summaries of various columns. And maybe you want to put attributes on `<tbody>`
or on particular rows in the body. All these customizations are available to you.
-}



--type alias Customizations data msg =
--    { --columnHeaderView : List (HeaderData data msg) -> ElementC msg
--      --,
--      bodyAttrs : List (AttributeC msg)
--    , rowAttrsBuilder : Maybe data -> List (AttributeC msg)
--    }


type alias PaginationConfig =
    { lengthOptions : List Int }


type alias FiltersConfig =
    { filterFields : List R10.Table.Internal.Types.Filter
    }



-- CONFIG


{-| Configuration for your table, describing your columns.

**Note:** Your `Config` should _never_ be held in your model.
It should only appear in `view` code.

-- todo exposing `Config(..)` would be the same as using `type alias`?

-}
type alias Config data msg =
    { toId : data -> String
    , toMsg : R10.Table.Internal.Msg.Msg -> msg
    , columns : List (ColumnConf data msg)
    , bodyAttrs : List (AttributeC msg)
    , rowAttrsBuilder : Maybe data -> List (AttributeC msg)
    , maybePaginationConfig : Maybe PaginationConfig
    , maybeFiltersConfig : Maybe FiltersConfig
    }


type alias ColumnConf data msg =
    { name : String
    , viewCell : R10.FormTypes.Palette -> Maybe data -> ElementC msg
    , viewHeader : R10.FormTypes.Palette -> HeaderInfo msg -> ElementC msg
    , sorter : R10.Table.Internal.Types.Sorter data
    }


type alias HeaderInfo msg =
    { name : String
    , sortStatus : R10.Table.Internal.Types.Status
    , onSortMsg : msg
    }


type alias ColumnAttrs msg =
    { header : List (AttributeC msg)
    , cell : List (AttributeC msg)
    }
