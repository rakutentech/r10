module R10.Form.Internal.Dict exposing
    ( get
    , insert
    , update
    )

import Dict
import R10.Form.Internal.Key


get : R10.Form.Internal.Key.Key -> Dict.Dict String v -> Maybe v
get key =
    Dict.get (R10.Form.Internal.Key.toString key)


update : R10.Form.Internal.Key.Key -> (Maybe v -> Maybe v) -> Dict.Dict String v -> Dict.Dict String v
update key =
    Dict.update (R10.Form.Internal.Key.toString key)


insert : R10.Form.Internal.Key.Key -> v -> Dict.Dict String v -> Dict.Dict String v
insert key =
    Dict.insert (R10.Form.Internal.Key.toString key)
