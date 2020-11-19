module Form.MakerForValidationKeys exposing (Outcome, maker)

import Form.Conf
import Form.Dict
import Form.FieldConf
import Form.Key
import Form.State
import Set



--  ██████  ██    ██ ████████  ██████  ██████  ███    ███ ███████
-- ██    ██ ██    ██    ██    ██      ██    ██ ████  ████ ██
-- ██    ██ ██    ██    ██    ██      ██    ██ ██ ████ ██ █████
-- ██    ██ ██    ██    ██    ██      ██    ██ ██  ██  ██ ██
--  ██████   ██████     ██     ██████  ██████  ██      ██ ███████


type alias Outcome =
    ( Form.Key.Key, Maybe Form.FieldConf.ValidationSpecs )



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


viewEntityMulti :
    Form.Key.Key
    -> Form.State.State
    -> List Form.Conf.Entity
    -> List Outcome
viewEntityMulti key formState entities =
    let
        quantity : Int
        quantity =
            Maybe.withDefault 1 <| Form.Dict.get key formState.multiplicableQuantities
    in
    List.concat <|
        List.indexedMap
            (\index _ ->
                let
                    newKey : Form.Key.Key
                    newKey =
                        Form.Key.composeKey key (String.fromInt index)

                    removed : Bool
                    removed =
                        Set.member (Form.Key.toString newKey) formState.removed
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
    Form.Key.Key
    -> Form.State.State
    -> Form.Conf.Conf
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
                    Form.Conf.EntityWrappable id entities ->
                        maker (Form.Key.composeKey key id) formState entities

                    Form.Conf.EntityWithBorder id entities ->
                        maker (Form.Key.composeKey key id) formState entities

                    Form.Conf.EntityNormal id entities ->
                        maker (Form.Key.composeKey key id) formState entities

                    Form.Conf.EntityWithTabs id titleEntityList ->
                        maker (Form.Key.composeKey key id) formState (titleEntityList |> List.map Tuple.second)

                    Form.Conf.EntityMulti entityId entities ->
                        viewEntityMulti (Form.Key.composeKey key entityId) formState entities

                    Form.Conf.EntityField fieldConf ->
                        [ ( Form.Key.composeKey key fieldConf.id, fieldConf.validationSpecs ) ]

                    Form.Conf.EntityTitle entityId textConf ->
                        [ ( Form.Key.composeKey key entityId, textConf.validationSpecs ) ]

                    Form.Conf.EntitySubTitle entityId textConf ->
                        [ ( Form.Key.composeKey key entityId, textConf.validationSpecs ) ]
            )
            formConf
