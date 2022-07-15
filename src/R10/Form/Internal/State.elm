module R10.Form.Internal.State exposing
    ( State
    , encoder
    , fromString
    , init
    , toString
    )

import Dict
import Json.Decode as D
import Json.Decode.Extra
import Json.Decode.Pipeline
import Json.Encode as E
import Json.Encode.Extra
import R10.Form.Internal.FieldState
import R10.Form.Internal.Key
import R10.Form.Internal.QtySubmitAttempted
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
    , qtySubmitAttempted : R10.Form.Internal.QtySubmitAttempted.QtySubmitAttempted
    , changesSinceLastSubmissions : Bool
    , lastKeyDownIsProcess : Bool
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
    , qtySubmitAttempted = R10.Form.Internal.QtySubmitAttempted.fromInt 0
    , changesSinceLastSubmissions = False
    , lastKeyDownIsProcess = False
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
        , ( "focused", Json.Encode.Extra.maybe E.string v.focused )

        -- We don't want to save active state since it can cause incorrect render on load
        , ( "active", Json.Encode.Extra.maybe E.string Nothing )
        , ( "removed", E.list E.string (Set.toList v.removed) )
        , ( "qtySubmitAttempted", E.int (R10.Form.Internal.QtySubmitAttempted.toInt v.qtySubmitAttempted) )
        , ( "changesSinceLastSubmissions", E.bool v.changesSinceLastSubmissions )
        , ( "lastKeyDownIsProcess", E.bool v.lastKeyDownIsProcess )
        ]


decoder : D.Decoder State
decoder =
    D.succeed State
        |> Json.Decode.Pipeline.required "fieldsState" R10.Form.Internal.FieldState.decoderFieldState
        |> Json.Decode.Pipeline.required "multiplicableQuantities" (D.dict D.int)
        |> Json.Decode.Pipeline.required "activeTabs" (D.dict D.string)
        |> Json.Decode.Pipeline.required "focused" (D.nullable D.string)
        |> Json.Decode.Pipeline.required "active" (D.nullable D.string)
        |> Json.Decode.Pipeline.required "removed" (Json.Decode.Extra.set D.string)
        |> Json.Decode.Pipeline.required "qtySubmitAttempted" (D.map R10.Form.Internal.QtySubmitAttempted.fromInt D.int)
        |> Json.Decode.Pipeline.required "changesSinceLastSubmissions" D.bool
        |> Json.Decode.Pipeline.required "lastKeyDownIsProcess" D.bool


toString : State -> String
toString v =
    E.encode 4 <| encoder v


fromString : String -> Result D.Error State
fromString string =
    D.decodeString decoder string
