module R10.Form.Internal.MakerForValues exposing
    ( Outcome
    , maker
    , viewEntityMulti
    )

import R10.Form.Internal.Conf
import R10.Form.Internal.Dict
import R10.Form.Internal.FieldState
import R10.Form.Internal.Key
import R10.Form.Internal.Shared
import R10.Form.Internal.State
import R10.Form.Internal.StateForValues
import Set



--  ██████  ██    ██ ████████  ██████  ██████  ███    ███ ███████
-- ██    ██ ██    ██    ██    ██      ██    ██ ████  ████ ██
-- ██    ██ ██    ██    ██    ██      ██    ██ ██ ████ ██ █████
-- ██    ██ ██    ██    ██    ██      ██    ██ ██  ██  ██ ██
--  ██████   ██████     ██     ██████  ██████  ██      ██ ███████


type alias Outcome =
    R10.Form.Internal.StateForValues.Entity



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


viewEntityMulti :
    R10.Form.Internal.Key.Key
    -> R10.Form.Internal.State.State
    -> List R10.Form.Internal.Conf.Entity
    -> List Outcome
viewEntityMulti key formState entities =
    let
        quantity : Int
        quantity =
            Maybe.withDefault 1 <| R10.Form.Internal.Dict.get key formState.multiplicableQuantities
    in
    List.concat <|
        List.indexedMap
            (\index _ ->
                let
                    newKey : R10.Form.Internal.Key.Key
                    newKey =
                        R10.Form.Internal.Key.composeKey key (String.fromInt index)

                    removed : Bool
                    removed =
                        Set.member (R10.Form.Internal.Key.toString newKey) formState.removed
                in
                if removed then
                    []

                else
                    [ R10.Form.Internal.StateForValues.EntityIndex index <| maker { state = formState, conf = entities } newKey ]
            )
            (List.repeat quantity ())



-- ███    ███  █████  ██   ██ ███████ ██████
-- ████  ████ ██   ██ ██  ██  ██      ██   ██
-- ██ ████ ██ ███████ █████   █████   ██████
-- ██  ██  ██ ██   ██ ██  ██  ██      ██   ██
-- ██      ██ ██   ██ ██   ██ ███████ ██   ██


maker :
    R10.Form.Internal.Shared.Form
    -> R10.Form.Internal.Key.Key
    -> List Outcome
maker form key =
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
                    R10.Form.Internal.Conf.EntityWrappable _ entities ->
                        maker { form | conf = entities } key

                    R10.Form.Internal.Conf.EntityWithBorder _ entities ->
                        maker { form | conf = entities } key

                    R10.Form.Internal.Conf.EntityNormal _ entities ->
                        maker { form | conf = entities } key

                    R10.Form.Internal.Conf.EntityWithTabs _ titleEntityList ->
                        maker { form | conf = titleEntityList |> List.map Tuple.second } key

                    R10.Form.Internal.Conf.EntityMulti key_ entities ->
                        [ R10.Form.Internal.StateForValues.EntityMulti key_ <| viewEntityMulti key form.state entities ]

                    R10.Form.Internal.Conf.EntityField fieldConf ->
                        let
                            newKey : R10.Form.Internal.Key.Key
                            newKey =
                                R10.Form.Internal.Key.composeKey key fieldConf.id

                            fieldState : R10.Form.Internal.FieldState.FieldState
                            fieldState =
                                Maybe.withDefault R10.Form.Internal.FieldState.init <| R10.Form.Internal.Dict.get newKey form.state.fieldsState
                        in
                        [ R10.Form.Internal.StateForValues.EntityField fieldConf.id fieldState.value ]

                    R10.Form.Internal.Conf.EntityTitle _ _ ->
                        []

                    R10.Form.Internal.Conf.EntitySubTitle _ _ ->
                        []
            )
            form.conf
