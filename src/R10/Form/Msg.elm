module R10.Form.Msg exposing
    ( Msg(..)
    , handleChangesSinceLastSubmissions
    , isChangingValues
    , isSubmitted
    )

import R10.Form.Conf
import R10.Form.FieldConf
import R10.Form.Key
import R10.FormComponents.Single.Common



-- ███    ███ ███████  ██████
-- ████  ████ ██      ██
-- ██ ████ ██ ███████ ██   ███
-- ██  ██  ██      ██ ██    ██
-- ██      ██ ███████  ██████


type Msg
    = NoOp
    | GetFocus R10.Form.Key.Key
      --| GetFocusWithValue R10.Form.Key.Key R10.Form.FieldConf.FieldConf R10.Form.Conf.Conf String
      --| Activate R10.Form.Key.Key R10.Form.FieldConf.FieldConf R10.Form.Conf.Conf String
      --| Deactivate R10.Form.Key.Key R10.Form.FieldConf.FieldConf R10.Form.Conf.Conf String
      --| DropdownOpen R10.Form.Key.Key R10.Form.FieldConf.FieldConf R10.Form.Conf.Conf String Float
      --| ValueSelect R10.Form.Key.Key R10.Form.FieldConf.FieldConf R10.Form.Conf.Conf String
      --| Scroll R10.Form.Key.Key Float
      --| ChangeSearch R10.Form.Key.Key R10.Form.FieldConf.FieldConf R10.Form.Conf.Conf String String
      --| LoseFocusSingle R10.Form.Key.Key R10.Form.FieldConf.FieldConf R10.Form.Conf.Conf String
    | LoseFocus R10.Form.Key.Key R10.Form.FieldConf.FieldConf
    | TogglePasswordShow R10.Form.Key.Key
    | ChangeValue R10.Form.Key.Key R10.Form.FieldConf.FieldConf R10.Form.Conf.Conf String
    | ChangeSelection R10.Form.Key.Key R10.Form.FieldConf.FieldConf R10.Form.Conf.Conf String Float
    | OnSingleMsg R10.Form.Key.Key R10.Form.FieldConf.FieldConf R10.Form.Conf.Conf R10.FormComponents.Single.Common.Msg
    | ChangeTab R10.Form.Key.Key String
    | AddEntity R10.Form.Key.Key
    | RemoveEntity R10.Form.Key.Key
    | Submit R10.Form.Conf.Conf


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
