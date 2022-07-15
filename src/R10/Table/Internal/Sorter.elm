module R10.Table.Internal.Sorter exposing
    ( increasingOrDecreasingBy
    , sort
    , unsortable
    )

import R10.Table.Internal.Config
import R10.Table.Internal.State
import R10.Table.Internal.Types



-- SORTING


sort :
    R10.Table.Internal.State.State
    -> List (R10.Table.Internal.Config.ColumnConf data msg context)
    -> List data
    -> List data
sort state columnData data =
    case findSorter state.sort.name columnData of
        Nothing ->
            data

        Just sorter ->
            applySorter state.sort.isReversed sorter data


applySorter : Bool -> R10.Table.Internal.Types.Sorter data -> List data -> List data
applySorter isReversed sorter data =
    case sorter of
        R10.Table.Internal.Types.None ->
            data

        R10.Table.Internal.Types.Increasing sort_ ->
            sort_ data

        R10.Table.Internal.Types.Decreasing sort_ ->
            List.reverse (sort_ data)

        R10.Table.Internal.Types.IncOrDec sort_ ->
            if isReversed then
                List.reverse (sort_ data)

            else
                sort_ data

        R10.Table.Internal.Types.DecOrInc sort_ ->
            if isReversed then
                sort_ data

            else
                List.reverse (sort_ data)


findSorter :
    String
    -> List (R10.Table.Internal.Config.ColumnConf data msg context)
    -> Maybe (R10.Table.Internal.Types.Sorter data)
findSorter selectedColumn columnData =
    case columnData of
        [] ->
            Nothing

        { name, sorter } :: remainingColumnData ->
            if name == selectedColumn then
                Just sorter

            else
                findSorter selectedColumn remainingColumnData



-- SORTERS


{-| A sorter for columns that are unsortable. Maybe you have a column in your
table for delete buttons that delete the row. It would not make any sense to
sort based on that column.
-}
unsortable : R10.Table.Internal.Types.Sorter data
unsortable =
    R10.Table.Internal.Types.None


{-| Sometimes you want to be able to sort data in increasing _or_ decreasing
order. Maybe you have race times for the 100 meter sprint. This function lets
sort by best time by default, but also see the other order.

    sorter : R10.Table.Internal.State.Sorter { a | time : comparable }
    sorter =
        increasingOrDecreasingBy .time

-}
increasingOrDecreasingBy : (data -> comparable) -> R10.Table.Internal.Types.Sorter data
increasingOrDecreasingBy toComparable =
    R10.Table.Internal.Types.IncOrDec (List.sortBy toComparable)
