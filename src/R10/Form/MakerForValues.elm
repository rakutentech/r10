module Form.MakerForValues exposing
    ( Outcome
    , maker
    , viewEntityMulti
    )

import Form.Conf
import Form.Dict
import Form.FieldState
import Form.Key
import Form.State
import Form.StateForValues
import Set



--  ██████  ██    ██ ████████  ██████  ██████  ███    ███ ███████
-- ██    ██ ██    ██    ██    ██      ██    ██ ████  ████ ██
-- ██    ██ ██    ██    ██    ██      ██    ██ ██ ████ ██ █████
-- ██    ██ ██    ██    ██    ██      ██    ██ ██  ██  ██ ██
--  ██████   ██████     ██     ██████  ██████  ██      ██ ███████


type alias Outcome =
    Form.StateForValues.Entity



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
                    [ Form.StateForValues.EntityIndex index <| maker newKey formState entities ]
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
                    Form.Conf.EntityWrappable _ entities ->
                        maker key formState entities

                    Form.Conf.EntityWithBorder _ entities ->
                        maker key formState entities

                    Form.Conf.EntityNormal _ entities ->
                        maker key formState entities

                    Form.Conf.EntityWithTabs _ titleEntityList ->
                        maker key formState (titleEntityList |> List.map Tuple.second)

                    Form.Conf.EntityMulti key_ entities ->
                        [ Form.StateForValues.EntityMulti key_ <| viewEntityMulti key formState entities ]

                    Form.Conf.EntityField fieldConf ->
                        let
                            newKey : Form.Key.Key
                            newKey =
                                Form.Key.composeKey key fieldConf.id

                            fieldState : Form.FieldState.FieldState
                            fieldState =
                                Maybe.withDefault Form.FieldState.init <| Form.Dict.get newKey formState.fieldsState
                        in
                        [ Form.StateForValues.EntityField fieldConf.id fieldState.value ]

                    Form.Conf.EntityTitle _ _ ->
                        []

                    Form.Conf.EntitySubTitle _ _ ->
                        []
            )
            formConf
