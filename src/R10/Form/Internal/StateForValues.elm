module R10.Form.Internal.StateForValues exposing
    ( Entity(..)
    , EntityId
    , FieldId
    , Index
    , Value
    , encoderEntity
    , toString
    )

import Json.Encode as E


type alias FieldId =
    String


type alias EntityId =
    String


type alias Value =
    String


type alias Index =
    Int


type Entity
    = EntityField FieldId Value
    | EntityMulti EntityId (List Entity)
    | EntityIndex Index (List Entity)


encoderEntity : Entity -> E.Value
encoderEntity entity =
    case entity of
        EntityField fieldId value ->
            -- E.string <| fieldId ++ ":: " ++ value
            E.object
                [ ( "id", E.string fieldId )
                , ( "string", E.string value )
                ]

        EntityMulti entityId listEntity ->
            E.object
                [ ( "id", E.string entityId )
                , ( "list", E.list encoderEntity listEntity )
                ]

        EntityIndex _ listEntity ->
            -- E.object
            --     [ ( "index", E.int index )
            --     , ( "list", E.list encoderEntity listEntity )
            --     ]
            E.list encoderEntity listEntity


toString : List Entity -> String
toString entities =
    E.encode 4 <| E.list encoderEntity entities



--
-- Study on Firebase data structure
--
-- https://firebase.google.com/docs/firestore/data-model#hierarchical-data
--
-- type alias DocId =
--     String
--
--
-- type alias CollectionId =
--     String
--
--
-- type alias DocValue =
--     String
--
--
-- type Doc
--     = Doc DocId DocValue (List Collection)
--
--
-- type Collection
--     = Collection CollectionId (List Doc)
--
--
-- example : Collection
-- example =
--     Collection "rooms"
--         [ Doc "roomA"
--             "name: my chat room"
--             [ Collection "messages"
--                 [ Doc "message1" "from: alex, msg: Hello world!" []
--                 , Doc "message2" "..." []
--                 ]
--             ]
--         , Doc "roomB" "..." []
--         ]
--
