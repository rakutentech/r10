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
import R10.Palette
import R10.Table.Internal.Msg
import R10.Table.Internal.Types


{-| There are quite a lot of ways to customize the `<table>` tag. You can add
a `<caption>` which can be styled via CSS. You can do crazy stuff with
`<thead>` to group columns in weird ways. You can have a `<tfoot>` tag for
summaries of various columns. And maybe you want to put attributes on `<tbody>`
or on particular rows in the body. All these customizations are available to you.
-}



--type alias Customizations data msg =
--    { --columnHeaderView : List (HeaderData data msg) -> Element (R10.Context.ContextInternal z) msg
--      --,
--      bodyAttrs : List (Attribute (R10.Context.ContextInternal z) msg)
--    , rowAttrsBuilder : Maybe data -> List (Attribute (R10.Context.ContextInternal z) msg)
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
type alias Config data msg context =
    { toId : data -> String
    , toMsg : R10.Table.Internal.Msg.Msg -> msg
    , columns : List (ColumnConf data msg context)
    , bodyAttrs : List (Attribute (R10.Context.ContextInternal context) msg)
    , rowAttrsBuilder : Maybe data -> List (Attribute (R10.Context.ContextInternal context) msg)
    , maybePaginationConfig : Maybe PaginationConfig
    , maybeFiltersConfig : Maybe FiltersConfig
    }


type alias ColumnConf data msg context =
    { name : String
    , viewCell : R10.Palette.Palette -> Maybe data -> Element (R10.Context.ContextInternal context) msg
    , viewHeader : R10.Palette.Palette -> HeaderInfo msg -> Element (R10.Context.ContextInternal context) msg
    , sorter : R10.Table.Internal.Types.Sorter data
    }


type alias HeaderInfo msg =
    { name : String
    , sortStatus : R10.Table.Internal.Types.Status
    , onSortMsg : msg
    }


type alias ColumnAttrs msg context =
    { header : List (Attribute (R10.Context.ContextInternal context) msg)
    , cell : List (Attribute (R10.Context.ContextInternal context) msg)
    }
