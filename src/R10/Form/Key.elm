module R10.Form.Key exposing
    ( Key
    , KeyAsString
    , composeKey
    , composeMultiKeys
    , empty
    , fromList
    , fromString
    , headId
    , replaceLeaf
    , toQuantity
    , toString
    )


type Key
    = Key (List String)


type alias KeyAsString =
    String


fromList : List String -> Key
fromList list =
    Key (list |> List.filter (not << String.isEmpty))


empty : Key
empty =
    fromList []


composeKey : Key -> String -> Key
composeKey (Key keys) extraKey =
    if String.isEmpty extraKey then
        Key keys

    else
        Key (extraKey :: keys)


composeMultiKeys : Key -> Int -> List Key
composeMultiKeys key quantity =
    List.indexedMap
        (\index _ ->
            composeKey key (String.fromInt index)
        )
        (List.repeat quantity ())


headId : Key -> Maybe String
headId (Key list) =
    List.head <| list


separator : String
separator =
    "/"


toString : Key -> KeyAsString
toString (Key keys) =
    String.join separator (List.reverse keys)


fromString : KeyAsString -> Key
fromString keyAsString =
    Key <| List.reverse <| String.split separator keyAsString


toQuantity : Key -> Int
toQuantity (Key keys) =
    List.length keys


replaceLeaf : String -> Key -> Key
replaceLeaf newLeaf (Key keyList) =
    if List.isEmpty keyList then
        fromList keyList

    else
        newLeaf :: List.drop 1 keyList |> fromList
