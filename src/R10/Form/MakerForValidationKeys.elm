module R10.Form.MakerForValidationKeys exposing (Outcome, maker)

import R10.Form.Conf
import R10.Form.Dict
import R10.Form.FieldConf
import R10.Form.Key
import R10.Form.State
import Set



--  ██████  ██    ██ ████████  ██████  ██████  ███    ███ ███████
-- ██    ██ ██    ██    ██    ██      ██    ██ ████  ████ ██
-- ██    ██ ██    ██    ██    ██      ██    ██ ██ ████ ██ █████
-- ██    ██ ██    ██    ██    ██      ██    ██ ██  ██  ██ ██
--  ██████   ██████     ██     ██████  ██████  ██      ██ ███████


type alias Outcome =
    ( R10.Form.Key.Key, Maybe R10.Form.FieldConf.ValidationSpecs )



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


viewEntityMulti :
    R10.Form.Key.Key
    -> R10.Form.State.State
    -> List R10.Form.Conf.Entity
    -> List Outcome
viewEntityMulti key formState entities =
    let
        quantity : Int
        quantity =
            Maybe.withDefault 1 <| R10.Form.Dict.get key formState.multiplicableQuantities
    in
    List.concat <|
        List.indexedMap
            (\index _ ->
                let
                    newKey : R10.Form.Key.Key
                    newKey =
                        R10.Form.Key.composeKey key (String.fromInt index)

                    removed : Bool
                    removed =
                        Set.member (R10.Form.Key.toString newKey) formState.removed
                in
                if removed then
                    []

                else
                    maker newKey formState entities
            )
            (List.repeat quantity ())



-- ███    ███  █████  ██   ██ ███████ ██████
-- ████  ████ ██   ██ ██  ██  ██      ██   ██
-- ██ ████ ██ ███████ █████   █████   ██████
-- ██  ██  ██ ██   ██ ██  ██  ██      ██   ██
-- ██      ██ ██   ██ ██   ██ ███████ ██   ██


maker :
    R10.Form.Key.Key
    -> R10.Form.State.State
    -> R10.Form.Conf.Conf
    -> List Outcome
maker key formState formConf =
    --
    --     This is recursive
    --
    --   ┌─────> maker >─────┐
    --   │                   │
    --   └───────────────────┘
    --
    List.concat <|
        List.map
            (\entity ->
                case entity of
                    R10.Form.Conf.EntityWrappable id entities ->
                        maker (R10.Form.Key.composeKey key id) formState entities

                    R10.Form.Conf.EntityWithBorder id entities ->
                        maker (R10.Form.Key.composeKey key id) formState entities

                    R10.Form.Conf.EntityNormal id entities ->
                        maker (R10.Form.Key.composeKey key id) formState entities

                    R10.Form.Conf.EntityWithTabs id titleEntityList ->
                        maker (R10.Form.Key.composeKey key id) formState (titleEntityList |> List.map Tuple.second)

                    R10.Form.Conf.EntityMulti entityId entities ->
                        viewEntityMulti (R10.Form.Key.composeKey key entityId) formState entities

                    R10.Form.Conf.EntityField fieldConf ->
                        [ ( R10.Form.Key.composeKey key fieldConf.id, fieldConf.validationSpecs ) ]

                    R10.Form.Conf.EntityTitle entityId textConf ->
                        [ ( R10.Form.Key.composeKey key entityId, textConf.validationSpecs ) ]

                    R10.Form.Conf.EntitySubTitle entityId textConf ->
                        [ ( R10.Form.Key.composeKey key entityId, textConf.validationSpecs ) ]
            )
            formConf
