module R10.Form.Internal.Msg exposing
    ( Msg(..)
    , handleChangesSinceLastSubmissions
    , isChangingValues
    , isSubmitted
    , onLoseFocus
    , onOptionSelect
    , onValueChange
    , toValue
    )

import R10.Context
import R10.Form.Internal.Conf
import R10.Form.Internal.FieldConf
import R10.Form.Internal.Key
import R10.FormComponents.Internal.Phone.Common
import R10.FormComponents.Internal.Single.Common


toValue : Msg -> Maybe String
toValue msg =
    case msg of
        ChangeValue _ _ _ _ string ->
            Just string

        _ ->
            Nothing


{-| -}
type Msg
    = NoOp
    | GetFocus R10.Form.Internal.Key.Key R10.Form.Internal.FieldConf.FieldConf
    | LoseFocus R10.Form.Internal.Key.Key R10.Form.Internal.FieldConf.FieldConf
    | Hover R10.Form.Internal.Key.Key (Maybe String)
    | TogglePasswordShow R10.Form.Internal.Key.Key
    | KeyDown Int
    | ChangeValue R10.Form.Internal.Key.Key R10.Form.Internal.FieldConf.FieldConf R10.Form.Internal.Conf.Conf R10.Context.ContextR10 String
    | ChangeTab R10.Form.Internal.Key.Key String
    | AddEntity R10.Form.Internal.Key.Key
    | RemoveEntity R10.Form.Internal.Key.Key
    | Submit R10.Form.Internal.Conf.Conf
      -- SUB COMPONENTS
    | OnSingleMsg R10.Form.Internal.Key.Key R10.Form.Internal.FieldConf.FieldConf R10.Form.Internal.Conf.Conf R10.FormComponents.Internal.Single.Common.Msg
    | OnPhoneMsg R10.Form.Internal.Key.Key R10.Form.Internal.FieldConf.FieldConf R10.Form.Internal.Conf.Conf R10.FormComponents.Internal.Phone.Common.Msg


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


{-| Return true if the message can potentially change some value
-}
isChangingValues : Msg -> Bool
isChangingValues msg =
    case msg of
        ChangeValue _ _ _ _ _ ->
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
        ChangeValue key fieldConf formConf _ value ->
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
