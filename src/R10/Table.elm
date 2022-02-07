module R10.Table exposing (Column, columnCustom, columnSimple, columnWithAttrs, columnWithViews, config, configWithAccordionRow, customConfig, getActiveFilters, getPaginationStateRecord, initialStateFilters, initialStatePagination, initialStateSort, isLoading, isLoadingByPagination, paginationButtonDisableAll, paginationButtonEnableAll, paginationButtonEnableOther, paginationButtonNextFetch, paginationButtonPrevFetch, setLoading, updatePaginationState, view, viewHeaderRowHelp, State)

{-|

@docs Column, columnCustom, columnSimple, columnWithAttrs, columnWithViews, config, configWithAccordionRow, customConfig, getActiveFilters, getPaginationStateRecord, initialStateFilters, initialStatePagination, initialStateSort, isLoading, isLoadingByPagination, paginationButtonDisableAll, paginationButtonEnableAll, paginationButtonEnableOther, paginationButtonNextFetch, paginationButtonPrevFetch, setLoading, updatePaginationState, view, viewHeaderRowHelp, State

-}

-- Elm-UI adapted version of <https://github.com/NoRedInk/elm-sortable-table>

import Dict exposing (Dict)
import Element.WithContext exposing (..)
import Element.WithContext.Keyed as Keyed
import R10.Context exposing (..)
import R10.Palette
import R10.Table.Internal.Accordion
import R10.Table.Internal.Cell
import R10.Table.Internal.Config
import R10.Table.Internal.Filters
import R10.Table.Internal.Header
import R10.Table.Internal.Msg
import R10.Table.Internal.Paginator
import R10.Table.Internal.Sorter
import R10.Table.Internal.State
import R10.Table.Internal.Style
import R10.Table.Internal.Types


{-| Create a table state. By providing a column name, you determine which
column should be used for sorting by default. So if you want your table of
yachts to be sorted by length by default, you might say:

    import Table

    R10.Table.initialSort "Length"

-}
initialStateSort : { name : String, isReversed : Bool } -> R10.Table.Internal.State.State
initialStateSort { name, isReversed } =
    { sort = { name = name, isReversed = isReversed }
    , pagination = R10.Table.Internal.State.NoPagination
    , filters = R10.Table.Internal.State.NoFilters
    , loading = False
    }


{-| -}
initialStatePagination : { length : Int } -> R10.Table.Internal.State.State -> R10.Table.Internal.State.State
initialStatePagination { length } state =
    { state
        | pagination =
            R10.Table.Internal.State.Pagination
                { length = length
                , nextButtonState = R10.Table.Internal.State.PaginationButtonDisabled
                , prevButtonState = R10.Table.Internal.State.PaginationButtonDisabled
                }
    }


{-| -}
initialStateFilters : { filterValues : Dict String String } -> R10.Table.Internal.State.State -> R10.Table.Internal.State.State
initialStateFilters { filterValues } state =
    { state
        | filters =
            R10.Table.Internal.State.Filters
                { filterEditor = Nothing
                , filterValues = filterValues
                }
    }


{-| -}
updatePaginationState : R10.Table.Internal.State.PaginationStateRecord -> R10.Table.Internal.State.State -> R10.Table.Internal.State.State
updatePaginationState paginationStateRecord state =
    R10.Table.Internal.Paginator.updatePaginationState_ paginationStateRecord state


{-| -}
paginationButtonNextFetch : R10.Table.Internal.State.State -> R10.Table.Internal.State.State
paginationButtonNextFetch state =
    R10.Table.Internal.Paginator.paginationButtonNextFetch_ state


{-| -}
paginationButtonPrevFetch : R10.Table.Internal.State.State -> R10.Table.Internal.State.State
paginationButtonPrevFetch state =
    R10.Table.Internal.Paginator.paginationButtonPrevFetch_ state


{-| -}
paginationButtonEnableAll : R10.Table.Internal.State.State -> R10.Table.Internal.State.State
paginationButtonEnableAll state =
    R10.Table.Internal.Paginator.paginationButtonEnableAll_ state


{-| -}
paginationButtonDisableAll : R10.Table.Internal.State.State -> R10.Table.Internal.State.State
paginationButtonDisableAll state =
    R10.Table.Internal.Paginator.paginationButtonDisableAll_ state


{-| -}
paginationButtonEnableOther : R10.Table.Internal.State.State -> R10.Table.Internal.State.State
paginationButtonEnableOther state =
    R10.Table.Internal.Paginator.paginationButtonEnableOther_ state


{-| -}
getPaginationStateRecord : R10.Table.Internal.State.State -> Maybe R10.Table.Internal.State.PaginationStateRecord
getPaginationStateRecord state =
    R10.Table.Internal.Paginator.getPaginationStateRecord_ state


{-| -}
getActiveFilters : R10.Table.Internal.State.State -> Dict String String
getActiveFilters state =
    case state.filters of
        R10.Table.Internal.State.Filters { filterValues } ->
            filterValues

        R10.Table.Internal.State.NoFilters ->
            Dict.empty


{-| -}
setLoading : Bool -> R10.Table.Internal.State.State -> R10.Table.Internal.State.State
setLoading isLoading_ state =
    { state | loading = isLoading_ }


{-| -}
isLoading : R10.Table.Internal.State.State -> Bool
isLoading state =
    state.loading


{-| -}
isLoadingByPagination : R10.Table.Internal.State.State -> Bool
isLoadingByPagination state =
    case state.pagination of
        R10.Table.Internal.State.Pagination { nextButtonState, prevButtonState } ->
            (nextButtonState == R10.Table.Internal.State.PaginationButtonLoading)
                || (prevButtonState == R10.Table.Internal.State.PaginationButtonLoading)

        R10.Table.Internal.State.NoPagination ->
            False


{-| Create the `Config` for your `view` function. Everything you need to
render your columns efficiently and handle selection of columns.

Say we have a `List Person` that we want to show as a table. The table should
have a column for name and age. We would create a `Config` like this:

    import Table

    type Msg = NewTableTable.Model.State R10.Table.Internal.State.State | ...

    config : R10.Table.Internal.Config Person Msg
    config =
      R10.Table.config
        { toId = .name
        , toMsg = NewTableTable.Model.State
        , columns =
            [ R10.Table.stringColumn "Name" .name
            , R10.Table.intColumn "Age" .age
            ]
        }

You provide the followerLimiting information in your table configuration:

  - `toId` &mdash; turn a `Person` into a unique ID. This lets us use
    [`Html.Keyed`][keyed] under the hood to make resorts faster.
  - `columns` &mdash; specify some columns to show.
  - `toMsg` &mdash; a way to send new table states to your app as messages.

See the [examples] to get a better feel for this!

[keyed]: http://package.elm-lang.org/packages/elm-lang/html/latest/Html-Keyed
[examples]: https://github.com/evancz/elm-sortable-table/tree/master/examples

-}
config :
    { toId : data -> String
    , toMsg : R10.Table.Internal.Msg.Msg -> msg
    , columns : List (Column data msg context)
    }
    -> R10.Table.Internal.Config.Config data msg context
config { toId, toMsg, columns } =
    --Table.Config.Config
    { toId = toId
    , toMsg = toMsg
    , columns = List.map (\(Column cData) -> cData) columns
    , bodyAttrs = [ width fill, height fill ]
    , rowAttrsBuilder = always R10.Table.Internal.Style.defaultRowAttrs
    , maybePaginationConfig = Nothing
    , maybeFiltersConfig = Nothing
    }


{-| Just like `config` but you can specify a bunch of table customizations.
-}
customConfig :
    { toId : data -> String
    , toMsg : R10.Table.Internal.Msg.Msg -> msg
    , columns : List (Column data msg context)
    , bodyAttrs : List (Attribute (R10.Context.ContextInternal context) msg)
    , rowAttrsBuilder : Maybe data -> List (Attribute (R10.Context.ContextInternal context) msg)
    , pagination : Maybe R10.Table.Internal.Config.PaginationConfig
    , filters : Maybe R10.Table.Internal.Config.FiltersConfig
    }
    -> R10.Table.Internal.Config.Config data msg context
customConfig { toId, toMsg, columns, bodyAttrs, rowAttrsBuilder, pagination, filters } =
    --Table.Config.Config
    { toId = toId
    , toMsg = toMsg
    , columns = List.map (\(Column cData) -> cData) columns
    , bodyAttrs = bodyAttrs
    , rowAttrsBuilder = rowAttrsBuilder
    , maybePaginationConfig = pagination
    , maybeFiltersConfig = filters
    }


{-| -}
configWithAccordionRow :
    (Maybe data -> Element (R10.Context.ContextInternal context) msg)
    -> Int
    -> (Maybe data -> Bool)
    -> (Maybe data -> Bool)
    -> R10.Table.Internal.Config.Config data msg context
    -> R10.Table.Internal.Config.Config data msg context
configWithAccordionRow viewContent expandedHeight getIsExpanded getIsLoading conf =
    { conf
        | rowAttrsBuilder =
            R10.Table.Internal.Accordion.getAttrs viewContent expandedHeight getIsExpanded getIsLoading
    }



-- COLUMNS


{-| Describes how to turn `data` into a column in your table.
-}
type Column data msg context
    = Column (R10.Table.Internal.Config.ColumnConf data msg context)


{-| -}
columnSimple : { name : String, toStr : data -> String } -> Column data msg context
columnSimple { name, toStr } =
    Column
        { name = name
        , viewCell = R10.Table.Internal.Cell.simpleCell [] (Maybe.map toStr)
        , viewHeader = R10.Table.Internal.Header.simpleHeader []
        , sorter = R10.Table.Internal.Sorter.increasingOrDecreasingBy toStr
        }


{-| -}
columnWithAttrs :
    { name : String
    , toStr : data -> String
    , maybeToCmp : Maybe (data -> comparable)
    , maybeAttrs :
        Maybe
            { header : List (Attribute (R10.Context.ContextInternal context) msg)
            , cell : List (Attribute (R10.Context.ContextInternal context) msg)
            }
    }
    -> Column data msg context
columnWithAttrs { name, toStr, maybeToCmp, maybeAttrs } =
    let
        attrs :
            { header : List (Attribute (R10.Context.ContextInternal context) msg)
            , cell : List (Attribute (R10.Context.ContextInternal context) msg)
            }
        attrs =
            maybeAttrs |> Maybe.withDefault { header = [], cell = [] }
    in
    Column
        { name = name
        , viewCell = R10.Table.Internal.Cell.simpleCell attrs.cell (Maybe.map toStr)
        , viewHeader = R10.Table.Internal.Header.simpleHeader attrs.header
        , sorter =
            case maybeToCmp of
                Just toCmp ->
                    R10.Table.Internal.Sorter.increasingOrDecreasingBy toCmp

                Nothing ->
                    R10.Table.Internal.Sorter.unsortable
        }


{-| -}
columnWithViews :
    { name : String
    , viewCell :
        R10.Palette.Palette
        -> Maybe data
        -> Element (R10.Context.ContextInternal context) msg
    , viewHeader :
        R10.Palette.Palette
        -> R10.Table.Internal.Config.HeaderInfo msg
        -> Element (R10.Context.ContextInternal context) msg
    , maybeToCmp : Maybe (data -> comparable)
    }
    -> Column data msg context
columnWithViews { name, viewCell, viewHeader, maybeToCmp } =
    Column
        { name = name
        , viewCell = viewCell
        , viewHeader = viewHeader
        , sorter =
            case maybeToCmp of
                Just toCmp ->
                    R10.Table.Internal.Sorter.increasingOrDecreasingBy toCmp

                Nothing ->
                    R10.Table.Internal.Sorter.unsortable
        }


{-| -}
columnCustom :
    { name : String
    , viewCell : R10.Palette.Palette -> Maybe data -> Element (R10.Context.ContextInternal context) msg
    , viewHeader : R10.Palette.Palette -> R10.Table.Internal.Config.HeaderInfo msg -> Element (R10.Context.ContextInternal context) msg
    , sorter : R10.Table.Internal.Types.Sorter data
    }
    -> Column data msg context
columnCustom { name, viewCell, viewHeader, sorter } =
    Column
        { name = name
        , viewCell = viewCell
        , viewHeader = viewHeader
        , sorter = sorter
        }


{-| -}
viewHeaderRowHelp :
    R10.Palette.Palette
    -> R10.Table.Internal.State.State
    -> List (R10.Table.Internal.Config.ColumnConf data msg context)
    -> (String -> Bool -> msg)
    -> Element (R10.Context.ContextInternal context) msg
viewHeaderRowHelp palette state columns sortMsg =
    row [ width fill ] (List.map (viewHeaderRow_ palette state sortMsg) columns)


viewHeaderRow_ :
    R10.Palette.Palette
    -> R10.Table.Internal.State.State
    -> (String -> Bool -> msg)
    -> R10.Table.Internal.Config.ColumnConf data msg context
    -> Element (R10.Context.ContextInternal context) msg
viewHeaderRow_ palette state sortMsg column =
    column.viewHeader palette (R10.Table.Internal.Header.toHeaderInfo state column sortMsg)


viewRowHelp :
    R10.Palette.Palette
    -> List (R10.Table.Internal.Config.ColumnConf data msg context)
    -> (Maybe data -> List (Attribute (R10.Context.ContextInternal context) msg))
    -> Maybe data
    -> Element (R10.Context.ContextInternal context) msg
viewRowHelp palette columns toRowAttrs maybeData =
    row
        (toRowAttrs maybeData)
        (List.map (\col -> col.viewCell palette maybeData) columns)


viewBody :
    R10.Palette.Palette
    -> R10.Table.Internal.Config.Config data msg context
    -> R10.Table.Internal.State.State
    -> List data
    -> Element (R10.Context.ContextInternal context) msg
viewBody palette { toId, columns, bodyAttrs, rowAttrsBuilder } state data =
    let
        countTODO : number
        countTODO =
            3

        sortedData : List (Maybe data)
        sortedData =
            if isLoading state then
                List.range 0 (countTODO - 1)
                    |> List.map (always Nothing)

            else
                R10.Table.Internal.Sorter.sort state columns data
                    |> List.map Just
    in
    Keyed.column (width fill :: bodyAttrs) <|
        List.indexedMap
            (\idx maybeRowData ->
                let
                    key : String
                    key =
                        case maybeRowData of
                            Just rowData ->
                                toId rowData

                            Nothing ->
                                String.fromInt idx

                    el_ : Element (R10.Context.ContextInternal context) msg
                    el_ =
                        viewRowHelp palette columns rowAttrsBuilder maybeRowData
                in
                ( key, el_ )
            )
            sortedData



-- VIEW


{-| Take a list of data and turn it into a table. The `Config` argument is the
configuration for the table. It describes the columns that we want to show. The
`Table.State.State` argument describes which column we are sorting by at the moment.

**Note:** The `Table.State.State` and `List data` should live in your `Model`. The `Config`
for the table belongs in your `view` code. I very strongly recommend against
putting `Config` in your model. Describe any potential table configurations
statically, and look for a different library if you need something crazier than
that.

-}
view :
    R10.Palette.Palette
    -> R10.Table.Internal.Config.Config data msg context
    -> R10.Table.Internal.State.State
    -> List data
    -> Element (R10.Context.ContextInternal context) msg
view palette conf state data =
    let
        filters : Element (ContextInternal context) R10.Table.Internal.Msg.Msg
        filters =
            case conf.maybeFiltersConfig of
                Just filtersConfig ->
                    R10.Table.Internal.Filters.view palette filtersConfig state

                Nothing ->
                    none

        paginator : Element (ContextInternal context) R10.Table.Internal.Msg.Msg
        paginator =
            case ( conf.maybePaginationConfig, state ) of
                ( Just paginationConfig, { pagination } ) ->
                    R10.Table.Internal.Paginator.view palette paginationConfig pagination

                ( Nothing, _ ) ->
                    none

        sortMsg : String -> Bool -> msg
        sortMsg a b =
            R10.Table.Internal.Msg.Sort a b |> conf.toMsg
    in
    column
        [ width fill, height fill ]
        [ Element.WithContext.map conf.toMsg filters
        , viewHeaderRowHelp palette state conf.columns sortMsg
        , viewBody palette conf state data
        , Element.WithContext.map conf.toMsg paginator
        ]


{-| -}
type alias State =
    R10.Table.Internal.State.State
