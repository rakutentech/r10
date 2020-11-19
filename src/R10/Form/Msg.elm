module Form.Msg exposing
    ( Msg(..)
    , handleChangesSinceLastSubmissions
    , isChangingValues
    , isSubmitted
    )

import Form.Conf
import Form.FieldConf
import Form.Key
import FormComponents.Single.Common



-- ███    ███ ███████  ██████
-- ████  ████ ██      ██
-- ██ ████ ██ ███████ ██   ███
-- ██  ██  ██      ██ ██    ██
-- ██      ██ ███████  ██████


type Msg
    = NoOp
    | GetFocus Form.Key.Key
    | LoseFocus Form.Key.Key Form.FieldConf.FieldConf
    | TogglePasswordShow Form.Key.Key
    | ChangeValue Form.Key.Key Form.FieldConf.FieldConf Form.Conf.Conf String
    | OnSingleMsg Form.Key.Key Form.FieldConf.FieldConf Form.Conf.Conf FormComponents.Single.Common.Msg
    | ChangeTab Form.Key.Key String
    | AddEntity Form.Key.Key
    | RemoveEntity Form.Key.Key
    | Submit Form.Conf.Conf


isSubmitted : Msg -> Bool
isSubmitted msgState =
    case msgState of
        Submit _ ->
            True

        _ ->
            False


handleChangesSinceLastSubmissions : Bool -> Msg -> Bool
handleChangesSinceLastSubmissions changesSinceLastSubmissions msg =
    case msg of
        Submit _ ->
            -- We reset the value
            False

        _ ->
            if isChangingValues msg then
                True

            else
                changesSinceLastSubmissions


isChangingValues : Msg -> Bool
isChangingValues msg =
    -- This is a list of messages that potentially can change values
    case msg of
        ChangeValue _ _ _ _ ->
            True

        AddEntity _ ->
            True

        RemoveEntity _ ->
            True

        _ ->
            False
