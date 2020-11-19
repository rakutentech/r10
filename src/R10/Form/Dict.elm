module R10.Form.Dict exposing
    ( get
    , insert
    , update
    )

import Dict
import R10.Form.Key


get : R10.Form.Key.Key -> Dict.Dict String v -> Maybe v
get key =
    Dict.get (R10.Form.Key.toString key)


update : R10.Form.Key.Key -> (Maybe v -> Maybe v) -> Dict.Dict String v -> Dict.Dict String v
update key =
    Dict.update (R10.Form.Key.toString key)


insert : R10.Form.Key.Key -> v -> Dict.Dict String v -> Dict.Dict String v
insert key =
    Dict.insert (R10.Form.Key.toString key)
