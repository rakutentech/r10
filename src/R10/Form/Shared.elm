module R10.Form.Shared exposing (Model)

import R10.Form.Conf
import R10.Form.State


{-| Forms are composed of two parts: a configuration and a state.
-}
type alias Model =
    { conf : R10.Form.Conf.Conf
    , state : R10.Form.State.State
    }
