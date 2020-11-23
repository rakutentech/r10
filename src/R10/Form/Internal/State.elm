module R10.Form.Internal.State exposing
    ( State
    , fromString
    , init
    , toString
    )

import Dict
import Json.Decode as D
import Json.Decode.Extra as D
import Json.Decode.Pipeline as D
import Json.Encode as E
import Json.Encode.Extra as E
import R10.Form.Internal.FieldState
import R10.Form.Internal.Key
import R10.Form.Internal.QtySubmitAttempted as QtySubmitAttempted exposing (QtySubmitAttempted)
import Set



-- ████████ ██    ██ ██████  ███████ ███████
--    ██     ██  ██  ██   ██ ██      ██
--    ██      ████   ██████  █████   ███████
--    ██       ██    ██      ██           ██
--    ██       ██    ██      ███████ ███████
--


type alias State =
    { fieldsState : Dict.Dict R10.Form.Internal.Key.KeyAsString R10.Form.Internal.FieldState.FieldState
    , multiplicableQuantities : Dict.Dict R10.Form.Internal.Key.KeyAsString Int
    , activeTabs : Dict.Dict R10.Form.Internal.Key.KeyAsString String
    , focused : Maybe R10.Form.Internal.Key.KeyAsString
    , active : Maybe R10.Form.Internal.Key.KeyAsString
    , removed : Set.Set R10.Form.Internal.Key.KeyAsString
    , qtySubmitAttempted : QtySubmitAttempted
    , changesSinceLastSubmissions : Bool
    }



-- ██ ███    ██ ██ ████████
-- ██ ████   ██ ██    ██
-- ██ ██ ██  ██ ██    ██
-- ██ ██  ██ ██ ██    ██
-- ██ ██   ████ ██    ██


init : State
init =
    { fieldsState = Dict.empty
    , multiplicableQuantities = Dict.empty
    , activeTabs = Dict.empty
    , focused = Nothing
    , active = Nothing
    , removed = Set.empty
    , qtySubmitAttempted = QtySubmitAttempted.fromInt 0
    , changesSinceLastSubmissions = False
    }



--
-- ███████ ███    ██  ██████  ██████  ██████  ███████ ██████
-- ██      ████   ██ ██      ██    ██ ██   ██ ██      ██   ██
-- █████   ██ ██  ██ ██      ██    ██ ██   ██ █████   ██████
-- ██      ██  ██ ██ ██      ██    ██ ██   ██ ██      ██   ██
-- ███████ ██   ████  ██████  ██████  ██████  ███████ ██   ██
--
-- ██████  ███████  ██████  ██████  ██████  ███████ ██████
-- ██   ██ ██      ██      ██    ██ ██   ██ ██      ██   ██
-- ██   ██ █████   ██      ██    ██ ██   ██ █████   ██████
-- ██   ██ ██      ██      ██    ██ ██   ██ ██      ██   ██
-- ██████  ███████  ██████  ██████  ██████  ███████ ██   ██


encoder : State -> E.Value
encoder v =
    E.object
        [ ( "fieldsState", R10.Form.Internal.FieldState.encoderFieldState v.fieldsState )
        , ( "multiplicableQuantities", E.dict identity E.int v.multiplicableQuantities )
        , ( "activeTabs", E.dict identity E.string v.activeTabs )
        , ( "focused", E.maybe E.string v.focused )
        , ( "removed", E.list E.string (Set.toList v.removed) )
        , ( "qtySubmitAttempted", E.int (QtySubmitAttempted.toInt v.qtySubmitAttempted) )
        , ( "changesSinceLastSubmissions", E.bool v.changesSinceLastSubmissions )
        ]


decoder : D.Decoder State
decoder =
    D.succeed State
        |> D.required "fieldsState" R10.Form.Internal.FieldState.decoderFieldState
        |> D.required "multiplicableQuantities" (D.dict D.int)
        |> D.required "activeTabs" (D.dict D.string)
        |> D.optional "focused" (D.maybe D.string) Nothing
        |> D.optional "active" (D.maybe D.string) Nothing
        |> D.required "removed" (D.set D.string)
        |> D.required "qtySubmitAttempted" (D.map QtySubmitAttempted.fromInt D.int)
        |> D.required "changesSinceLastSubmissions" D.bool


toString : State -> String
toString v =
    E.encode 4 <| encoder v


fromString : String -> Result D.Error State
fromString string =
    D.decodeString decoder string
