module R10.Table exposing
    ( Column
    , columnCustom
    , columnSimple
    , columnWithAttrs
    , columnWithViews
    , config
    , configWithAccordionRow
    , customConfig
    , getActiveFilters
    , getPaginationStateRecord
    , initialStateFilters
    , initialStatePagination
    , initialStateSort
    , isLoading
    , isLoadingByPagination
    , paginationButtonDisableAll
    , paginationButtonEnableAll
    , paginationButtonEnableOther
    , paginationButtonNextFetch
    , paginationButtonPrevFetch
    , setLoading
    , updatePaginationState
    , view
    , viewHeaderRowHelp
    )

{-| Elm-UI adapted version of
<https://github.com/NoRedInk/elm-sortable-table>
-}

import Dict exposing (Dict)
import Element exposing (..)
import Element.Keyed as Keyed
import R10.Form
import R10.Table.Accordion
import R10.Table.Cell
import R10.Table.Config
import R10.Table.Filters
import R10.Table.Header
import R10.Table.Msg
import R10.Table.Paginator
import R10.Table.Sorter
import R10.Table.State
import R10.Table.Style
import R10.Table.Types


{-| Create a table state. By providing a column name, you determine which
column should be used for sorting by default. So if you want your table of
yachts to be sorted by length by default, you might say:

    import Table

    R10.Table.initialSort "Length"

-}
initialStateSort : { name : String, isReversed : Bool } -> R10.Table.State.State
initialStateSort { name, isReversed } =
    { sort = { name = name, isReversed = isReversed }
    , pagination = R10.Table.State.NoPagination
    , filters = R10.Table.State.NoFilters
    , loading = False
    }


initialStatePagination : { length : Int } -> R10.Table.State.State -> R10.Table.State.State
initialStatePagination { length } state =
    { state
        | pagination =
            R10.Table.State.Pagination
                { length = length
                , nextButtonState = R10.Table.State.PaginationButtonDisabled
                , prevButtonState = R10.Table.State.PaginationButtonDisabled
                }
    }


initialStateFilters : { filterValues : Dict String String } -> R10.Table.State.State -> R10.Table.State.State
initialStateFilters { filterValues } state =
    { state
        | filters =
            R10.Table.State.Filters
                { filterEditor = Nothing
                , filterValues = filterValues
                }
    }


updatePaginationState : R10.Table.State.PaginationStateRecord -> R10.Table.State.State -> R10.Table.State.State
updatePaginationState paginationStateRecord state =
    R10.Table.Paginator.updatePaginationState_ paginationStateRecord state


paginationButtonNextFetch : R10.Table.State.State -> R10.Table.State.State
paginationButtonNextFetch state =
    R10.Table.Paginator.paginationButtonNextFetch_ state


paginationButtonPrevFetch : R10.Table.State.State -> R10.Table.State.State
paginationButtonPrevFetch state =
    R10.Table.Paginator.paginationButtonPrevFetch_ state


paginationButtonEnableAll : R10.Table.State.State -> R10.Table.State.State
paginationButtonEnableAll state =
    R10.Table.Paginator.paginationButtonEnableAll_ state


paginationButtonDisableAll : R10.Table.State.State -> R10.Table.State.State
paginationButtonDisableAll state =
    R10.Table.Paginator.paginationButtonDisableAll_ state


paginationButtonEnableOther : R10.Table.State.State -> R10.Table.State.State
paginationButtonEnableOther state =
    R10.Table.Paginator.paginationButtonEnableOther_ state


getPaginationStateRecord : R10.Table.State.State -> Maybe R10.Table.State.PaginationStateRecord
getPaginationStateRecord state =
    R10.Table.Paginator.getPaginationStateRecord_ state


getActiveFilters : R10.Table.State.State -> Dict String String
getActiveFilters state =
    case state.filters of
        R10.Table.State.Filters { filterValues } ->
            filterValues

        R10.Table.State.NoFilters ->
            Dict.empty


setLoading : Bool -> R10.Table.State.State -> R10.Table.State.State
setLoading isLoading_ state =
    { state | loading = isLoading_ }


isLoading : R10.Table.State.State -> Bool
isLoading state =
    state.loading


isLoadingByPagination : R10.Table.State.State -> Bool
isLoadingByPagination state =
    case state.pagination of
        R10.Table.State.Pagination { nextButtonState, prevButtonState } ->
            (nextButtonState == R10.Table.State.PaginationButtonLoading)
                || (prevButtonState == R10.Table.State.PaginationButtonLoading)

        R10.Table.State.NoPagination ->
            False


{-| Create the `Config` for your `view` function. Everything you need to
render your columns efficiently and handle selection of columns.

Say we have a `List Person` that we want to show as a table. The table should
have a column for name and age. We would create a `Config` like this:

    import Table

    type Msg = NewTableTable.Model.State R10.Table.State.State | ...

    config : R10.Table.Config Person Msg
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
    , toMsg : R10.Table.Msg.Msg -> msg
    , columns : List (Column data msg)
    }
    -> R10.Table.Config.Config data msg
config { toId, toMsg, columns } =
    --Table.Config.Config
    { toId = toId
    , toMsg = toMsg
    , columns = List.map (\(Column cData) -> cData) columns
    , bodyAttrs = [ width fill, height fill ]
    , rowAttrsBuilder = always R10.Table.Style.defaultRowAttrs
    , maybePaginationConfig = Nothing
    , maybeFiltersConfig = Nothing
    }


{-| Just like `config` but you can specify a bunch of table customizations.
-}
customConfig :
    { toId : data -> String
    , toMsg : R10.Table.Msg.Msg -> msg
    , columns : List (Column data msg)
    , bodyAttrs : List (Attribute msg)
    , rowAttrsBuilder : Maybe data -> List (Attribute msg)
    , pagination : Maybe R10.Table.Config.PaginationConfig
    , filters : Maybe R10.Table.Config.FiltersConfig
    }
    -> R10.Table.Config.Config data msg
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


configWithAccordionRow :
    (Maybe data -> Element msg)
    -> Int
    -> (Maybe data -> Bool)
    -> (Maybe data -> Bool)
    -> R10.Table.Config.Config data msg
    -> R10.Table.Config.Config data msg
configWithAccordionRow viewContent expandedHeight getIsExpanded getIsLoading conf =
    { conf
        | rowAttrsBuilder =
            R10.Table.Accordion.getAttrs viewContent expandedHeight getIsExpanded getIsLoading
    }



-- COLUMNS


{-| Describes how to turn `data` into a column in your table.
-}
type Column data msg
    = Column (R10.Table.Config.ColumnConf data msg)


{-| -}
columnSimple : { name : String, toStr : data -> String } -> Column data msg
columnSimple { name, toStr } =
    Column
        { name = name
        , viewCell = R10.Table.Cell.simpleCell [] (Maybe.map toStr)
        , viewHeader = R10.Table.Header.simpleHeader []
        , sorter = R10.Table.Sorter.increasingOrDecreasingBy toStr
        }


{-| -}
columnWithAttrs :
    { name : String
    , toStr : data -> String
    , maybeToCmp : Maybe (data -> comparable)
    , maybeAttrs : Maybe { header : List (Attribute msg), cell : List (Attribute msg) }
    }
    -> Column data msg
columnWithAttrs { name, toStr, maybeToCmp, maybeAttrs } =
    let
        attrs : { header : List (Attribute msg), cell : List (Attribute msg) }
        attrs =
            maybeAttrs |> Maybe.withDefault { header = [], cell = [] }
    in
    Column
        { name = name
        , viewCell = R10.Table.Cell.simpleCell attrs.cell (Maybe.map toStr)
        , viewHeader = R10.Table.Header.simpleHeader attrs.header
        , sorter =
            case maybeToCmp of
                Just toCmp ->
                    R10.Table.Sorter.increasingOrDecreasingBy toCmp

                Nothing ->
                    R10.Table.Sorter.unsortable
        }


{-| -}
columnWithViews :
    { name : String
    , viewCell : R10.Form.Palette -> Maybe data -> Element msg
    , viewHeader : R10.Form.Palette -> R10.Table.Config.HeaderInfo msg -> Element msg
    , maybeToCmp : Maybe (data -> comparable)
    }
    -> Column data msg
columnWithViews { name, viewCell, viewHeader, maybeToCmp } =
    Column
        { name = name
        , viewCell = viewCell
        , viewHeader = viewHeader
        , sorter =
            case maybeToCmp of
                Just toCmp ->
                    R10.Table.Sorter.increasingOrDecreasingBy toCmp

                Nothing ->
                    R10.Table.Sorter.unsortable
        }


{-| -}
columnCustom :
    { name : String
    , viewCell : R10.Form.Palette -> Maybe data -> Element msg
    , viewHeader : R10.Form.Palette -> R10.Table.Config.HeaderInfo msg -> Element msg
    , sorter : R10.Table.Types.Sorter data
    }
    -> Column data msg
columnCustom { name, viewCell, viewHeader, sorter } =
    Column
        { name = name
        , viewCell = viewCell
        , viewHeader = viewHeader
        , sorter = sorter
        }


viewHeaderRowHelp : R10.Form.Palette -> R10.Table.State.State -> List (R10.Table.Config.ColumnConf data msg) -> (String -> Bool -> msg) -> Element msg
viewHeaderRowHelp palette state columns sortMsg =
    row [ width fill ] (List.map (viewHeaderRow_ palette state sortMsg) columns)


viewHeaderRow_ : R10.Form.Palette -> R10.Table.State.State -> (String -> Bool -> msg) -> R10.Table.Config.ColumnConf data msg -> Element msg
viewHeaderRow_ palette state sortMsg column =
    column.viewHeader palette (R10.Table.Header.toHeaderInfo state column sortMsg)


viewRowHelp : R10.Form.Palette -> List (R10.Table.Config.ColumnConf data msg) -> (Maybe data -> List (Attribute msg)) -> Maybe data -> Element msg
viewRowHelp palette columns toRowAttrs maybeData =
    row
        (toRowAttrs maybeData)
        (List.map (\col -> col.viewCell palette maybeData) columns)


viewBody :
    R10.Form.Palette
    -> R10.Table.Config.Config data msg
    -> R10.Table.State.State
    -> List data
    -> Element msg
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
                R10.Table.Sorter.sort state columns data
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

                    el_ : Element msg
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
view : R10.Form.Palette -> R10.Table.Config.Config data msg -> R10.Table.State.State -> List data -> Element msg
view palette conf state data =
    let
        filters : Element R10.Table.Msg.Msg
        filters =
            case conf.maybeFiltersConfig of
                Just filtersConfig ->
                    R10.Table.Filters.view palette filtersConfig state

                Nothing ->
                    none

        paginator : Element R10.Table.Msg.Msg
        paginator =
            case ( conf.maybePaginationConfig, state ) of
                ( Just paginationConfig, { pagination } ) ->
                    R10.Table.Paginator.view palette paginationConfig pagination

                ( Nothing, _ ) ->
                    none

        sortMsg : String -> Bool -> msg
        sortMsg a b =
            R10.Table.Msg.Sort a b |> conf.toMsg
    in
    column
        [ width fill, height fill ]
        [ Element.map conf.toMsg filters
        , viewHeaderRowHelp palette state conf.columns sortMsg
        , viewBody palette conf state data
        , Element.map conf.toMsg paginator
        ]
