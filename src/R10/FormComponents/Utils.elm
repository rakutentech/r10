module FormComponents.Utils exposing
    ( listSlice
    , stringInsertAtMulti
    )

{-| same as String.Extra.insertAt but allows to input at several positions at once
-}

import String.Extra


stringInsertAtMulti : String -> List Int -> String -> String
stringInsertAtMulti insert positions string =
    let
        insertLen : Int
        insertLen =
            String.length insert

        insertAtOffset : Int -> { c | offset : Int, str : String } -> { offset : Int, str : String }
        insertAtOffset pos { str, offset } =
            { str = String.Extra.insertAt insert (pos + offset) str
            , offset = offset + insertLen
            }
    in
    List.foldl insertAtOffset { str = string, offset = 0 } positions
        |> .str


listSlice : Int -> Int -> List b -> List b
listSlice from to list =
    if from >= to then
        []

    else
        List.drop from list
            |> List.indexedMap
                (\idx opt ->
                    if idx < (to - from) then
                        Just opt

                    else
                        Nothing
                )
            |> List.filterMap identity
