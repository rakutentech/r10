module R10.Color.Primary exposing
    ( Color(..), list, default, toColor
    , toString
    , decoderExploration
    )

{-| Rakuten brand colors

![Colors](https://r10.netlify.app/images/colors-overview400.png)

More info about colors at <https://r10.netlify.app/>

@docs Color, list, default, toColor


# To String

@docs toString


# Encoders/Decoders

@docs decoderExploration

-}

import Color
import Json.Decode
import Json.Decode.Exploration
import Json.Encode
import R10.Color
import R10.Mode


{-| -}
type Color
    = Yellow
    | Purple
    | Pink
    | Orange
    | LightBlue
    | Green
    | CrimsonRed
    | Blue


{-| -}
encodeColor : Color -> Json.Encode.Value
encodeColor value =
    case value of
        Yellow ->
            Json.Encode.string "Yellow"

        Purple ->
            Json.Encode.string "Purple"

        Pink ->
            Json.Encode.string "Pink"

        Orange ->
            Json.Encode.string "Orange"

        LightBlue ->
            Json.Encode.string "LightBlue"

        Green ->
            Json.Encode.string "Green"

        CrimsonRed ->
            Json.Encode.string "CrimsonRed"

        Blue ->
            Json.Encode.string "Blue"


{-| -}
decodeColor : Json.Decode.Decoder Color
decodeColor =
    let
        findMatch str =
            case str of
                "Yellow" ->
                    Json.Decode.succeed Yellow

                "Purple" ->
                    Json.Decode.succeed Purple

                "Pink" ->
                    Json.Decode.succeed Pink

                "Orange" ->
                    Json.Decode.succeed Orange

                "LightBlue" ->
                    Json.Decode.succeed LightBlue

                "Green" ->
                    Json.Decode.succeed Green

                "CrimsonRed" ->
                    Json.Decode.succeed CrimsonRed

                "Blue" ->
                    Json.Decode.succeed Blue

                _ ->
                    Json.Decode.fail "Unknown value for Color"
    in
    Json.Decode.string |> Json.Decode.andThen findMatch


{-| -}
toString : Color -> String
toString value =
    case value of
        Yellow ->
            "Yellow"

        Purple ->
            "Purple"

        Pink ->
            "Pink"

        Orange ->
            "Orange"

        LightBlue ->
            "LightBlue"

        Green ->
            "Green"

        CrimsonRed ->
            "CrimsonRed"

        Blue ->
            "Blue"


{-| -}
list : List Color
list =
    [ Yellow
    , Purple
    , Pink
    , Orange
    , LightBlue
    , Green
    , CrimsonRed
    , Blue
    ]



-- EXTRA


{-| -}
default : Color
default =
    CrimsonRed


{-| -}
fromString : String -> Color
fromString string =
    Result.withDefault default <|
        Json.Decode.decodeValue decodeColor (Json.Encode.string string)


{-| -}
decoderExploration : Json.Decode.Exploration.Decoder Color
decoderExploration =
    Json.Decode.Exploration.string
        |> Json.Decode.Exploration.andThen (fromString >> Json.Decode.Exploration.succeed)


{-| -}
toColorLight : Color -> Color.Color
toColorLight color =
    case color of
        CrimsonRed ->
            R10.Color.fromHex "#bf0000"

        Orange ->
            R10.Color.fromHex "#f59600"

        Yellow ->
            R10.Color.fromHex "#ffcc00"

        Green ->
            R10.Color.fromHex "#00b900"

        LightBlue ->
            R10.Color.fromHex "#00a0f0"

        Blue ->
            R10.Color.fromHex "#002896"

        Purple ->
            R10.Color.fromHex "#7d00be"

        Pink ->
            R10.Color.fromHex "#ff41be"


{-| -}
toColorDark : Color -> Color.Color
toColorDark color =
    case color of
        CrimsonRed ->
            R10.Color.fromLightToDark <| toColorLight color

        Orange ->
            R10.Color.fromLightToDark <| toColorLight color

        Yellow ->
            R10.Color.fromLightToDark <| toColorLight color

        Green ->
            R10.Color.fromLightToDark <| toColorLight color

        LightBlue ->
            R10.Color.fromLightToDark <| toColorLight color

        Blue ->
            R10.Color.fromLightToDark <| toColorLight color

        Purple ->
            R10.Color.fromLightToDark <| toColorLight color

        Pink ->
            R10.Color.fromLightToDark <| toColorLight color


{-| Convert a primary color into a `avh4/elm-color` type of color. It requiires a `Mode` because the color can be sligtly different in Light or Dark mode.
-}
toColor : { a | mode : R10.Mode.Mode } -> Color -> Color.Color
toColor theme =
    case theme.mode of
        R10.Mode.Light ->
            toColorLight

        R10.Mode.Dark ->
            toColorDark
