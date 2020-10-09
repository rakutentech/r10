module R10.Mode exposing (Mode(..), decodeJsonString, decoderExploration, default, fromString, isLight, toString, toggle)

{-| Use `Mode` to determine if the application should be rendered with a `Light` or a `Dark` palette of colors.

@docs Mode, decodeJsonString, decoderExploration, default, fromString, isLight, toString, toggle

-}

import Json.Decode
import Json.Decode.Exploration


{-| -}
type Mode
    = Dark
    | Light


{-| -}
default : Mode
default =
    Light


{-| -}
isLight : Mode -> Bool
isLight mode =
    mode == Light


{-| -}
toggle : Mode -> Mode
toggle mode =
    case mode of
        Dark ->
            Light

        Light ->
            Dark


{-| -}
fromString : String -> Mode
fromString string =
    case String.toLower string of
        "dark" ->
            Dark

        _ ->
            default


{-| -}
toString : Mode -> String
toString theme =
    case theme of
        Dark ->
            "Dark"

        Light ->
            "Light"


{-| -}
decoderExploration : Json.Decode.Exploration.Decoder Mode
decoderExploration =
    Json.Decode.Exploration.string |> Json.Decode.Exploration.andThen (fromString >> Json.Decode.Exploration.succeed)


decoder : Json.Decode.Decoder Mode
decoder =
    Json.Decode.string |> Json.Decode.andThen (fromString >> Json.Decode.succeed)


{-| -}
decodeJsonString : Json.Decode.Value -> Result Json.Decode.Error Mode
decodeJsonString value =
    Json.Decode.decodeValue decoder value
