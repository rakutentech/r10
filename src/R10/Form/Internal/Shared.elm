module R10.Form.Internal.Shared exposing (Form)

import R10.Form.Internal.Conf
import R10.Form.Internal.State


{-| Forms are composed of two parts: a configuration and a state.
-}
type alias Form =
    { conf : R10.Form.Internal.Conf.Conf
    , state : R10.Form.Internal.State.State
    }
