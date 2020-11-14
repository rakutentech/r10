module R10.Color.Internal.Primary exposing
    ( Color(..), list, default, toColor
    , decoderExploration, decoder
    )

{-| Rakuten brand colors

![Colors](https://r10.netlify.app/images/colors-overview400.png)

More info about colors at <https://r10.netlify.app/>

@docs Color, list, default, toColor


# Encoders/Decoders

@docs decoderExploration, decoder

-}

import Color
import Json.Decode
import Json.Decode.Exploration
import Json.Encode
import R10.Color.Utils
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
            Json.Encode.string "Light Blue"

        Green ->
            Json.Encode.string "Green"

        CrimsonRed ->
            Json.Encode.string "Crimson Red"

        Blue ->
            Json.Encode.string "Blue"


{-| -}
decoder : Json.Decode.Decoder Color
decoder =
    let
        findMatch str =
            case
                str
                    |> String.toLower
                    |> String.replace " " ""
                    |> String.replace "crimson" ""
            of
                "yellow" ->
                    Json.Decode.succeed Yellow

                "purple" ->
                    Json.Decode.succeed Purple

                "pink" ->
                    Json.Decode.succeed Pink

                "orange" ->
                    Json.Decode.succeed Orange

                "lightblue" ->
                    Json.Decode.succeed LightBlue

                "green" ->
                    Json.Decode.succeed Green

                "red" ->
                    Json.Decode.succeed CrimsonRed

                "blue" ->
                    Json.Decode.succeed Blue

                _ ->
                    Json.Decode.fail "Unknown value for Color"
    in
    Json.Decode.string |> Json.Decode.andThen findMatch


{-| -}
toString_ : Color -> String
toString_ value =
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
            "Light Blue"

        Green ->
            "Green"

        CrimsonRed ->
            "Crimson Red"

        Blue ->
            "Blue"



-- Cannot add the type signature here, otherwise we create a loop of imports
-- list : R10.Theme.Theme -> List { color : Color.Color, name : String }


list theme =
    List.map
        (\color ->
            { color = toColor theme color
            , name = toString_ color
            , type_ = color
            }
        )
        list_


{-| -}
list_ : List Color
list_ =
    [ CrimsonRed
    , Pink
    , Purple
    , Blue
    , LightBlue
    , Green
    , Orange
    , Yellow
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
        Json.Decode.decodeValue decoder (Json.Encode.string string)


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
            R10.Color.Utils.fromHex "#bf0000"

        Orange ->
            R10.Color.Utils.fromHex "#f59600"

        Yellow ->
            R10.Color.Utils.fromHex "#ffcc00"

        Green ->
            R10.Color.Utils.fromHex "#00b900"

        LightBlue ->
            R10.Color.Utils.fromHex "#00a0f0"

        Blue ->
            R10.Color.Utils.fromHex "#002896"

        Purple ->
            R10.Color.Utils.fromHex "#7d00be"

        Pink ->
            R10.Color.Utils.fromHex "#ff41be"


{-| -}
toColorDark : Color -> Color.Color
toColorDark color =
    case color of
        CrimsonRed ->
            R10.Color.Utils.fromLightToDark <| toColorLight color

        Orange ->
            R10.Color.Utils.fromLightToDark <| toColorLight color

        Yellow ->
            R10.Color.Utils.fromLightToDark <| toColorLight color

        Green ->
            R10.Color.Utils.fromLightToDark <| toColorLight color

        LightBlue ->
            R10.Color.Utils.fromLightToDark <| toColorLight color

        Blue ->
            R10.Color.Utils.fromLightToDark <| toColorLight color

        Purple ->
            R10.Color.Utils.fromLightToDark <| toColorLight color

        Pink ->
            R10.Color.Utils.fromLightToDark <| toColorLight color


{-| Convert a primary color into a `avh4/elm-color` type of color. It requiires a `Mode` because the color can be sligtly different in Light or Dark mode.
-}
toColor : { a | mode : R10.Mode.Mode } -> Color -> Color.Color
toColor theme =
    case theme.mode of
        R10.Mode.Light ->
            toColorLight

        R10.Mode.Dark ->
            toColorDark
