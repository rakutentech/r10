module R10.Form.Internal.MakerForValidationKeys exposing (Outcome, maker)

import R10.Form.Internal.Conf
import R10.Form.Internal.Dict
import R10.Form.Internal.FieldConf
import R10.Form.Internal.Key
import R10.Form.Internal.Shared
import R10.FormTypes
import Set



--  ██████  ██    ██ ████████  ██████  ██████  ███    ███ ███████
-- ██    ██ ██    ██    ██    ██      ██    ██ ████  ████ ██
-- ██    ██ ██    ██    ██    ██      ██    ██ ██ ████ ██ █████
-- ██    ██ ██    ██    ██    ██      ██    ██ ██  ██  ██ ██
--  ██████   ██████     ██     ██████  ██████  ██      ██ ███████


type alias Outcome =
    ( R10.Form.Internal.Key.Key, R10.FormTypes.FieldType, Maybe R10.Form.Internal.FieldConf.ValidationSpecs )



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


viewEntityMulti :
    R10.Form.Internal.Key.Key
    -> R10.Form.Internal.Shared.Form
    -> List Outcome
viewEntityMulti key form =
    let
        quantity : Int
        quantity =
            Maybe.withDefault 1 <| R10.Form.Internal.Dict.get key form.state.multiplicableQuantities
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
                        Set.member (R10.Form.Internal.Key.toString newKey) form.state.removed
                in
                if removed then
                    []

                else
                    maker newKey form
            )
            (List.repeat quantity ())



-- ███    ███  █████  ██   ██ ███████ ██████
-- ████  ████ ██   ██ ██  ██  ██      ██   ██
-- ██ ████ ██ ███████ █████   █████   ██████
-- ██  ██  ██ ██   ██ ██  ██  ██      ██   ██
-- ██      ██ ██   ██ ██   ██ ███████ ██   ██


maker :
    R10.Form.Internal.Key.Key
    -> R10.Form.Internal.Shared.Form
    -> List Outcome
maker key form =
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
                    R10.Form.Internal.Conf.EntityWrappable id entities ->
                        maker (R10.Form.Internal.Key.composeKey key id) { conf = entities, state = form.state }

                    R10.Form.Internal.Conf.EntityWithBorder id entities ->
                        maker (R10.Form.Internal.Key.composeKey key id) { conf = entities, state = form.state }

                    R10.Form.Internal.Conf.EntityNormal id entities ->
                        maker (R10.Form.Internal.Key.composeKey key id) { conf = entities, state = form.state }

                    R10.Form.Internal.Conf.EntityWithTabs id titleEntityList ->
                        maker (R10.Form.Internal.Key.composeKey key id) { conf = titleEntityList |> List.map Tuple.second, state = form.state }

                    R10.Form.Internal.Conf.EntityMulti entityId entities ->
                        viewEntityMulti (R10.Form.Internal.Key.composeKey key entityId) { conf = entities, state = form.state }

                    R10.Form.Internal.Conf.EntityField fieldConf ->
                        [ ( R10.Form.Internal.Key.composeKey key fieldConf.id, fieldConf.type_, fieldConf.validationSpecs ) ]

                    R10.Form.Internal.Conf.EntityTitle entityId textConf ->
                        [ ( R10.Form.Internal.Key.composeKey key entityId, R10.FormTypes.TypeText R10.FormTypes.TextPlain, textConf.validationSpecs ) ]

                    R10.Form.Internal.Conf.EntitySubTitle entityId textConf ->
                        [ ( R10.Form.Internal.Key.composeKey key entityId, R10.FormTypes.TypeText R10.FormTypes.TextPlain, textConf.validationSpecs ) ]
            )
            form.conf
