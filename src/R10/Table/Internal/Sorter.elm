module R10.Table.Internal.Sorter exposing
    ( increasingOrDecreasingBy
    , sort
    , unsortable
    )

import R10.Table.Internal.Config
import R10.Table.Internal.State
import R10.Table.Internal.Types



-- SORTING


sort : R10.Table.Internal.State.State -> List (R10.Table.Internal.Config.ColumnConf data msg) -> List data -> List data
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


findSorter : String -> List (R10.Table.Internal.Config.ColumnConf data msg) -> Maybe (R10.Table.Internal.Types.Sorter data)
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


{-| Create a sorter that can only display the data in increasing order. If we
want a table of people, sorted alphabetically by name, we would say this:

    sorter : R10.Table.Internal.State.Sorter { a | name : comparable }
    sorter =
        increasingBy .name

-}
increasingBy : (data -> comparable) -> R10.Table.Internal.Types.Sorter data
increasingBy toComparable =
    R10.Table.Internal.Types.Increasing (List.sortBy toComparable)


{-| Create a sorter that can only display the data in decreasing order. If we
want a table of countries, sorted by population from upperLimitest to lowerLimitest, we
would say this:

    sorter : R10.Table.Internal.State.Sorter { a | population : comparable }
    sorter =
        decreasingBy .population

-}
decreasingBy : (data -> comparable) -> R10.Table.Internal.Types.Sorter data
decreasingBy toComparable =
    R10.Table.Internal.Types.Decreasing (List.sortBy toComparable)


{-| Sometimes you want to be able to sort data in increasing _or_ decreasing
order. Maybe you have a bunch of data about orange juice, and you want to know
both which has the most sugar, and which has the least sugar. Both interesting!
This function lets you see both, starting with decreasing order.

    sorter : R10.Table.Internal.State.Sorter { a | sugar : comparable }
    sorter =
        decreasingOrIncreasingBy .sugar

-}
decreasingOrIncreasingBy : (data -> comparable) -> R10.Table.Internal.Types.Sorter data
decreasingOrIncreasingBy toComparable =
    R10.Table.Internal.Types.DecOrInc (List.sortBy toComparable)


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
