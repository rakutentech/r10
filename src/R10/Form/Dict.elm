module Form.Dict exposing
    ( get
    , insert
    , update
    )

import Dict
import Form.Key


get : Form.Key.Key -> Dict.Dict String v -> Maybe v
get key =
    Dict.get (Form.Key.toString key)


update : Form.Key.Key -> (Maybe v -> Maybe v) -> Dict.Dict String v -> Dict.Dict String v
update key =
    Dict.update (Form.Key.toString key)


insert : Form.Key.Key -> v -> Dict.Dict String v -> Dict.Dict String v
insert key =
    Dict.insert (Form.Key.toString key)
