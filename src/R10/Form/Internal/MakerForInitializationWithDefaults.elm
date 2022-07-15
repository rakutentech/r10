module R10.Form.Internal.MakerForInitializationWithDefaults exposing (initWithDefaults)

import Dict
import R10.Country
import R10.Form.Internal.Conf
import R10.Form.Internal.Dict
import R10.Form.Internal.FieldConf
import R10.Form.Internal.FieldState
import R10.Form.Internal.Key
import R10.Form.Internal.Shared
import R10.Form.Internal.State
import R10.FormTypes
import Set


fieldConfToMaybeFieldState :
    Maybe R10.Country.Country
    -> R10.Form.Internal.FieldConf.FieldConf
    -> Maybe R10.Form.Internal.FieldState.FieldState
fieldConfToMaybeFieldState maybeCountry fieldConf =
    case fieldConf.type_ of
        R10.FormTypes.TypeSpecial typeSpecial ->
            case typeSpecial of
                R10.FormTypes.SpecialPhone _ ->
                    let
                        initState =
                            R10.Form.Internal.FieldState.init
                    in
                    Just <|
                        { initState
                            | value =
                                maybeCountry
                                    |> Maybe.map (\country -> R10.Country.toCountryTelCode country ++ " ")
                                    |> Maybe.withDefault "+"
                        }

        _ ->
            Nothing


initWithDefaults :
    R10.Form.Internal.Conf.Conf
    -> Maybe R10.Country.Country
    -> R10.Form.Internal.State.State
initWithDefaults formConf maybeCountry =
    let
        init =
            R10.Form.Internal.State.init

        fieldsState =
            maker { maybeCountry = maybeCountry } R10.Form.Internal.Key.empty { conf = formConf, state = init }
                |> List.filter (\( _, maybeFieldState ) -> maybeFieldState /= Nothing)
                |> List.map
                    (\( key_, maybeFieldState ) ->
                        ( R10.Form.Internal.Key.toString key_, Maybe.withDefault R10.Form.Internal.FieldState.init maybeFieldState )
                    )
                |> Dict.fromList
                |> withCopyEmailIntoUsernameField

        hasUsernameAndEmailField : Bool
        hasUsernameAndEmailField =
            case
                ( R10.Form.Internal.Conf.getFieldConfByFieldId R10.Form.Internal.Shared.defaultUsernameFieldKeyString formConf
                , R10.Form.Internal.Conf.getFieldConfByFieldId R10.Form.Internal.Shared.defaultEmailFieldKeyString formConf
                )
            of
                ( Just _, Just _ ) ->
                    True

                _ ->
                    False

        defaultCopyEmailIntoUsernameCheckboxFieldState : R10.Form.Internal.FieldState.FieldState
        defaultCopyEmailIntoUsernameCheckboxFieldState =
            R10.Form.Internal.FieldState.init
                |> (\fieldState -> { fieldState | value = "True" })

        withCopyEmailIntoUsernameField : Dict.Dict String R10.Form.Internal.FieldState.FieldState -> Dict.Dict String R10.Form.Internal.FieldState.FieldState
        withCopyEmailIntoUsernameField fieldsState_ =
            if hasUsernameAndEmailField then
                fieldsState_
                    |> Dict.insert (R10.Form.Internal.Key.toString R10.Form.Internal.Shared.copyEmailIntoUsernameCheckboxKey) defaultCopyEmailIntoUsernameCheckboxFieldState

            else
                fieldsState_
    in
    { init | fieldsState = fieldsState }



--  ██████  ██    ██ ████████  ██████  ██████  ███    ███ ███████
-- ██    ██ ██    ██    ██    ██      ██    ██ ████  ████ ██
-- ██    ██ ██    ██    ██    ██      ██    ██ ██ ████ ██ █████
-- ██    ██ ██    ██    ██    ██      ██    ██ ██  ██  ██ ██
--  ██████   ██████     ██     ██████  ██████  ██      ██ ███████


type alias Outcome =
    ( R10.Form.Internal.Key.Key, Maybe R10.Form.Internal.FieldState.FieldState )



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


viewEntityMulti :
    Args
    -> R10.Form.Internal.Key.Key
    -> R10.Form.Internal.Shared.Form
    -> List Outcome
viewEntityMulti args key form =
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
                    maker args newKey form
            )
            (List.repeat quantity ())



-- ███    ███  █████  ██   ██ ███████ ██████
-- ████  ████ ██   ██ ██  ██  ██      ██   ██
-- ██ ████ ██ ███████ █████   █████   ██████
-- ██  ██  ██ ██   ██ ██  ██  ██      ██   ██
-- ██      ██ ██   ██ ██   ██ ███████ ██   ██


type alias Args =
    { maybeCountry : Maybe R10.Country.Country }


maker :
    Args
    -> R10.Form.Internal.Key.Key
    -> R10.Form.Internal.Shared.Form
    -> List Outcome
maker args key form =
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
                        maker args (R10.Form.Internal.Key.composeKey key id) { conf = entities, state = form.state }

                    R10.Form.Internal.Conf.EntityWithBorder id entities ->
                        maker args (R10.Form.Internal.Key.composeKey key id) { conf = entities, state = form.state }

                    R10.Form.Internal.Conf.EntityNormal id entities ->
                        maker args (R10.Form.Internal.Key.composeKey key id) { conf = entities, state = form.state }

                    R10.Form.Internal.Conf.EntityWithTabs id titleEntityList ->
                        maker args (R10.Form.Internal.Key.composeKey key id) { conf = titleEntityList |> List.map Tuple.second, state = form.state }

                    R10.Form.Internal.Conf.EntityMulti entityId entities ->
                        viewEntityMulti args (R10.Form.Internal.Key.composeKey key entityId) { conf = entities, state = form.state }

                    R10.Form.Internal.Conf.EntityField fieldConf ->
                        [ ( R10.Form.Internal.Key.composeKey key fieldConf.id, fieldConfToMaybeFieldState args.maybeCountry fieldConf ) ]

                    R10.Form.Internal.Conf.EntityTitle entityId _ ->
                        [ ( R10.Form.Internal.Key.composeKey key entityId, Nothing ) ]

                    R10.Form.Internal.Conf.EntitySubTitle entityId _ ->
                        [ ( R10.Form.Internal.Key.composeKey key entityId, Nothing ) ]
            )
            form.conf
