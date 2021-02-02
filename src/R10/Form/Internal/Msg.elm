module R10.Form.Internal.Msg exposing
    ( Msg(..)
    , handleChangesSinceLastSubmissions
    , isChangingValues
    , isSubmitted
    , onLoseFocus
    , onOptionSelect
    , onValueChange
    )

import R10.Form.Internal.Conf
import R10.Form.Internal.FieldConf
import R10.Form.Internal.Key
import R10.FormComponents.Internal.Single.Common


{-| -}
type Msg
    = NoOp
    | GetFocus R10.Form.Internal.Key.Key
    | LoseFocus R10.Form.Internal.Key.Key R10.Form.Internal.FieldConf.FieldConf
    | TogglePasswordShow R10.Form.Internal.Key.Key
    | ChangeValue R10.Form.Internal.Key.Key R10.Form.Internal.FieldConf.FieldConf R10.Form.Internal.Conf.Conf String
    | OnSingleMsg R10.Form.Internal.Key.Key R10.Form.Internal.FieldConf.FieldConf R10.Form.Internal.Conf.Conf R10.FormComponents.Internal.Single.Common.Msg
    | ChangeTab R10.Form.Internal.Key.Key String
    | AddEntity R10.Form.Internal.Key.Key
    | RemoveEntity R10.Form.Internal.Key.Key
    | Submit R10.Form.Internal.Conf.Conf


{-| -}
isSubmitted : Msg -> Bool
isSubmitted msgState =
    case msgState of
        Submit _ ->
            True

        _ ->
            False


{-| -}
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


{-| -}
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


onLoseFocus :
    (R10.Form.Internal.Key.Key
     -> R10.Form.Internal.FieldConf.FieldConf
     -> any
    )
    -> Msg
    -> Maybe any
onLoseFocus func msg_ =
    case msg_ of
        LoseFocus key conf ->
            Just (func key conf)

        _ ->
            Nothing


onValueChange :
    (R10.Form.Internal.Key.Key
     -> R10.Form.Internal.FieldConf.FieldConf
     -> R10.Form.Internal.Conf.Conf
     -> String
     -> any
    )
    -> Msg
    -> Maybe any
onValueChange func msg_ =
    case msg_ of
        ChangeValue key fieldConf formConf value ->
            Just (func key fieldConf formConf value)

        _ ->
            Nothing


onOptionSelect :
    (R10.Form.Internal.Key.Key
     -> R10.Form.Internal.FieldConf.FieldConf
     -> R10.Form.Internal.Conf.Conf
     -> String
     -> any
    )
    -> Msg
    -> Maybe any
onOptionSelect func msg_ =
    case msg_ of
        OnSingleMsg key fieldConf formConf singleMsg ->
            case singleMsg of
                R10.FormComponents.Internal.Single.Common.OnOptionSelect option ->
                    Just (func key fieldConf formConf option)

                _ ->
                    Nothing

        _ ->
            Nothing
