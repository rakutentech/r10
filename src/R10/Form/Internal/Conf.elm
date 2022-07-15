module R10.Form.Internal.Conf exposing
    ( Conf
    , Entity(..)
    , EntityId
    , TextConf
    , changeFieldConf
    , fieldConfigConcatMap
    , fieldConfigMap
    , filter
    , fromString
    , getFieldConfByFieldId
    , getId
    , init
    , toString
    )

import Json.Decode as D
import Json.Encode as E
import Json.Encode.Extra
import List.Extra
import R10.Form.Internal.FieldConf


type alias EntityId =
    String


type alias TextConf =
    { title : String
    , helperText : Maybe String
    , validationSpecs : Maybe R10.Form.Internal.FieldConf.ValidationSpecs
    }


type Entity
    = EntityNormal EntityId (List Entity)
    | EntityWrappable EntityId (List Entity)
    | EntityWithBorder EntityId (List Entity)
    | EntityWithTabs EntityId (List ( String, Entity ))
    | EntityMulti EntityId (List Entity)
    | EntityField R10.Form.Internal.FieldConf.FieldConf
    | EntityTitle EntityId TextConf
    | EntitySubTitle EntityId TextConf


type alias Conf =
    List Entity



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


changeFieldConf : (R10.Form.Internal.FieldConf.FieldConf -> R10.Form.Internal.FieldConf.FieldConf) -> Entity -> Entity
changeFieldConf mapper entity =
    case entity of
        EntityNormal entityId entityList ->
            EntityNormal entityId (List.map (changeFieldConf mapper) entityList)

        EntityWrappable entityId entityList ->
            EntityWrappable entityId (List.map (changeFieldConf mapper) entityList)

        EntityWithBorder entityId entityList ->
            EntityWithBorder entityId (List.map (changeFieldConf mapper) entityList)

        EntityWithTabs entityId entityStringList ->
            EntityWithTabs entityId (List.map (\( string, entity_ ) -> ( string, changeFieldConf mapper entity_ )) entityStringList)

        EntityMulti entityId entityList ->
            EntityMulti entityId (List.map (changeFieldConf mapper) entityList)

        EntityField fieldConf ->
            EntityField (mapper fieldConf)

        EntityTitle _ _ ->
            entity

        EntitySubTitle _ _ ->
            entity


init : List Entity
init =
    []


getId : Entity -> EntityId
getId entity =
    case entity of
        EntityNormal entityId _ ->
            entityId

        EntityWrappable entityId _ ->
            entityId

        EntityWithBorder entityId _ ->
            entityId

        EntityWithTabs entityId _ ->
            entityId

        EntityMulti entityId _ ->
            entityId

        EntityField fieldConf ->
            fieldConf.id

        EntityTitle _ titleConf ->
            titleConf.title

        EntitySubTitle _ titleConf ->
            titleConf.title


filter : EntityId -> List Entity -> List Entity
filter entityId listEntities =
    List.filter (\entity -> entityId == getId entity) listEntities


getFieldConfByFieldId : String -> Conf -> Maybe R10.Form.Internal.FieldConf.FieldConf
getFieldConfByFieldId fieldId formConf =
    List.Extra.findMap
        (\entity ->
            case entity of
                EntityField fieldConf ->
                    if fieldConf.id == fieldId then
                        Just fieldConf

                    else
                        Nothing

                _ ->
                    Nothing
        )
        formConf



-- ███████ ███    ██ ████████ ██ ████████ ██    ██
-- ██      ████   ██    ██    ██    ██     ██  ██
-- █████   ██ ██  ██    ██    ██    ██      ████
-- ██      ██  ██ ██    ██    ██    ██       ██
-- ███████ ██   ████    ██    ██    ██       ██
--
-- ███████ ███    ██  ██████  ██████  ██████  ███████ ██████
-- ██      ████   ██ ██      ██    ██ ██   ██ ██      ██   ██
-- █████   ██ ██  ██ ██      ██    ██ ██   ██ █████   ██████
-- ██      ██  ██ ██ ██      ██    ██ ██   ██ ██      ██   ██
-- ███████ ██   ████  ██████  ██████  ██████  ███████ ██   ██


encoderGenericEntity : String -> List Entity -> String -> E.Value
encoderGenericEntity entityId listEntity string =
    E.object
        [ ( "EntityId", E.string entityId )
        , ( string, E.list encoderEntity listEntity )
        ]


encoderEntityWithTabs : String -> List ( String, Entity ) -> String -> E.Value
encoderEntityWithTabs entityId listEntityName string =
    E.object
        [ ( "EntityId", E.string entityId )
        , ( string, E.list (\( a, b ) -> E.list identity [ E.string a, encoderEntity b ]) listEntityName )
        ]


decoderGenericEntity : (EntityId -> List Entity -> Entity) -> String -> D.Decoder Entity
decoderGenericEntity typeConstructor string =
    D.map2
        typeConstructor
        (D.field "EntityId" D.string)
        (D.field string <| D.list <| D.lazy <| \_ -> decoderEntity)


decoderEntityWithTabs : (EntityId -> List ( String, Entity ) -> Entity) -> String -> D.Decoder Entity
decoderEntityWithTabs typeConstructor string =
    D.map2
        typeConstructor
        (D.field "EntityId" D.string)
        (D.field string <| D.list <| D.lazy <| \_ -> D.map2 Tuple.pair (D.index 0 D.string) (D.index 1 decoderEntity))


encoderGenericTitle : String -> TextConf -> String -> E.Value
encoderGenericTitle entityId titleConf string =
    E.object
        [ ( "EntityId", E.string entityId )
        , ( string
          , E.object
                [ ( "Title", E.string titleConf.title )
                , ( "HelperText", Json.Encode.Extra.maybe E.string titleConf.helperText )
                , ( "ValidationSpecs", Json.Encode.Extra.maybe R10.Form.Internal.FieldConf.encodeValidationSpecs titleConf.validationSpecs )
                ]
          )
        ]


decoderGenericTitle : (EntityId -> TextConf -> Entity) -> String -> D.Decoder Entity
decoderGenericTitle typeConstructor string =
    D.map2
        typeConstructor
        (D.field "EntityId" D.string)
        (D.field string <|
            D.map3
                TextConf
                (D.field "Title" D.string)
                (D.field "HelperText" (D.maybe D.string))
                (D.field "ValidationSpecs" (D.maybe R10.Form.Internal.FieldConf.decoderValidationSpecs))
        )


encoderEntity : Entity -> E.Value
encoderEntity entity2 =
    case entity2 of
        EntityNormal entityId listEntity ->
            encoderGenericEntity entityId listEntity "EntityNormal"

        EntityWrappable entityId listEntity ->
            encoderGenericEntity entityId listEntity "EntityWrappable"

        EntityWithBorder entityId listEntity ->
            encoderGenericEntity entityId listEntity "EntityWithBorder"

        EntityWithTabs entityId listNameEntity ->
            encoderEntityWithTabs entityId listNameEntity "EntityWithTabs"

        EntityMulti entityId listEntity ->
            encoderGenericEntity entityId listEntity "EntityMulti"

        EntityTitle entityId titleConf ->
            encoderGenericTitle entityId titleConf "EntityTitle"

        EntitySubTitle entityId titleConf ->
            encoderGenericTitle entityId titleConf "EntitySubTitle"

        EntityField fieldConf ->
            R10.Form.Internal.FieldConf.encoderFieldConf fieldConf


decoderEntity : D.Decoder Entity
decoderEntity =
    D.oneOf
        [ decoderGenericEntity EntityNormal "EntityNormal"
        , decoderGenericEntity EntityWrappable "EntityWrappable"
        , decoderGenericEntity EntityWithBorder "EntityWithBorder"
        , decoderEntityWithTabs EntityWithTabs "EntityWithTabs"
        , decoderGenericEntity EntityMulti "EntityMulti"
        , decoderGenericTitle EntityTitle "EntityTitle"
        , decoderGenericTitle EntitySubTitle "EntitySubTitle"
        , D.map EntityField R10.Form.Internal.FieldConf.decoderFieldConf
        ]


toString : Conf -> String
toString v =
    E.encode 4 <| E.list encoderEntity v


fromString : String -> Result D.Error Conf
fromString string =
    D.decodeString (D.list decoderEntity) string


fieldConfigMap : (R10.Form.Internal.FieldConf.FieldConf -> a) -> Conf -> List a
fieldConfigMap func1 =
    let
        func2 : Entity -> List a
        func2 entity_ =
            case entity_ of
                EntityNormal _ entities ->
                    List.concatMap func2 entities

                EntityWrappable _ entities ->
                    List.concatMap func2 entities

                EntityWithBorder _ entities ->
                    List.concatMap func2 entities

                EntityWithTabs _ entities ->
                    entities
                        |> List.concatMap (\( _, ent ) -> func2 ent)

                EntityMulti _ entities ->
                    List.concatMap func2 entities

                EntityField config ->
                    [ func1 config ]

                EntityTitle _ _ ->
                    []

                EntitySubTitle _ _ ->
                    []
    in
    List.concatMap func2


fieldConfigConcatMap : (R10.Form.Internal.FieldConf.FieldConf -> List R10.Form.Internal.FieldConf.FieldConf) -> Conf -> Conf
fieldConfigConcatMap func1 =
    let
        fMap : (Conf -> a) -> Conf -> List a
        fMap func2 =
            List.map groupBy
                >> List.concat
                >> (\entities -> entities |> List.head |> Maybe.map (always [ func2 entities ]) |> Maybe.withDefault [])

        groupBy : Entity -> List Entity
        groupBy entity_ =
            case entity_ of
                EntityNormal entityId entities ->
                    fMap (EntityNormal entityId) entities

                EntityWrappable entityId entities ->
                    fMap (EntityWrappable entityId) entities

                EntityWithBorder entityId entities ->
                    fMap (EntityNormal entityId) entities

                EntityWithTabs entityId entities ->
                    entities
                        |> List.map (\( str, ent ) -> groupBy ent |> List.map (Tuple.pair str))
                        |> List.concat
                        |> (\entities_ -> entities_ |> List.head |> Maybe.map (always [ EntityWithTabs entityId entities_ ]) |> Maybe.withDefault [])

                EntityMulti entityId entities ->
                    fMap (EntityNormal entityId) entities

                EntityField config ->
                    config |> func1 |> List.map EntityField

                EntityTitle _ _ ->
                    [ entity_ ]

                EntitySubTitle _ _ ->
                    [ entity_ ]
    in
    List.concatMap groupBy
