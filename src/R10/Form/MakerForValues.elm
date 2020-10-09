module R10.Form.MakerForValues exposing
    ( Outcome
    , maker
    , viewEntityMulti
    )

import R10.Form.Conf
import R10.Form.Dict
import R10.Form.FieldState
import R10.Form.Key
import R10.Form.State
import R10.Form.StateForValues
import Set



--  ██████  ██    ██ ████████  ██████  ██████  ███    ███ ███████
-- ██    ██ ██    ██    ██    ██      ██    ██ ████  ████ ██
-- ██    ██ ██    ██    ██    ██      ██    ██ ██ ████ ██ █████
-- ██    ██ ██    ██    ██    ██      ██    ██ ██  ██  ██ ██
--  ██████   ██████     ██     ██████  ██████  ██      ██ ███████


type alias Outcome =
    R10.Form.StateForValues.Entity



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
                    [ R10.Form.StateForValues.EntityIndex index <| maker newKey formState entities ]
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
                    R10.Form.Conf.EntityWrappable _ entities ->
                        maker key formState entities

                    R10.Form.Conf.EntityWithBorder _ entities ->
                        maker key formState entities

                    R10.Form.Conf.EntityNormal _ entities ->
                        maker key formState entities

                    R10.Form.Conf.EntityWithTabs _ entities ->
                        maker key formState entities

                    R10.Form.Conf.EntityMulti key_ entities ->
                        [ R10.Form.StateForValues.EntityMulti key_ <| viewEntityMulti key formState entities ]

                    R10.Form.Conf.EntityField fieldConf ->
                        let
                            newKey : R10.Form.Key.Key
                            newKey =
                                R10.Form.Key.composeKey key fieldConf.id

                            fieldState : R10.Form.FieldState.FieldState
                            fieldState =
                                Maybe.withDefault R10.Form.FieldState.init <| R10.Form.Dict.get newKey formState.fieldsState
                        in
                        [ R10.Form.StateForValues.EntityField fieldConf.id fieldState.value ]

                    R10.Form.Conf.EntityTitle _ _ ->
                        []

                    R10.Form.Conf.EntitySubTitle _ _ ->
                        []
            )
            formConf
