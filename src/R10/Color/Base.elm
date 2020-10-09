module R10.Color.Base exposing
    ( Color(..), list, toColor
    , toString
    )

{-| Rakuten base colors

More info about colors at <https://r10.netlify.app/>

@docs Color, list, toColor


# To/From String

@docs toString

-}

import Color
import Color.Manipulate
import Json.Decode
import Json.Encode
import R10.Color
import R10.Mode
import R10.Theme


{-| -}
type Color
    = Success
    | FontReversed
    | FontLink
    | Font
    | Error
    | Background


{-| -}
encodeColor : Color -> Json.Encode.Value
encodeColor value =
    case value of
        Success ->
            Json.Encode.string "Success"

        FontReversed ->
            Json.Encode.string "FontReversed"

        FontLink ->
            Json.Encode.string "FontLink"

        Font ->
            Json.Encode.string "Font"

        Error ->
            Json.Encode.string "Error"

        Background ->
            Json.Encode.string "Background"


{-| -}
decodeColor : Json.Decode.Decoder Color
decodeColor =
    let
        findMatch str =
            case str of
                "Success" ->
                    Json.Decode.succeed Success

                "FontReversed" ->
                    Json.Decode.succeed FontReversed

                "FontLink" ->
                    Json.Decode.succeed FontLink

                "Font" ->
                    Json.Decode.succeed Font

                "Error" ->
                    Json.Decode.succeed Error

                "Background" ->
                    Json.Decode.succeed Background

                _ ->
                    Json.Decode.fail "Unknown value for Color"
    in
    Json.Decode.string |> Json.Decode.andThen findMatch


{-| -}
toString : Color -> String
toString value =
    case value of
        Success ->
            "Success"

        FontReversed ->
            "FontReversed"

        FontLink ->
            "FontLink"

        Font ->
            "Font"

        Error ->
            "Error"

        Background ->
            "Background"


{-| -}
list : List Color
list =
    [ Success
    , FontReversed
    , FontLink
    , Font
    , Error
    , Background
    ]



-- EXTRAS
-- This library should be imported only by
--
-- * MainWithDebugger.UiComponentsDocumentation
-- * R10.Color.Derived
-- * R10.Color


toColorLight : Color -> Color.Color
toColorLight color =
    case color of
        Font ->
            Color.rgb 0 0 0

        FontReversed ->
            Color.rgb 1 1 1

        FontLink ->
            R10.Color.fromHex "#00a0f0"

        Error ->
            R10.Color.fromHex "#df0101"

        Success ->
            R10.Color.fromHex "#047205"

        Background ->
            R10.Color.fromHex "#ffffff"


toColorDark : Color -> Color.Color
toColorDark color =
    case color of
        Font ->
            Color.rgb 1 1 1

        FontReversed ->
            Color.rgb 0 0 0

        FontLink ->
            R10.Color.fromLightToDark <| toColorLight color

        Error ->
            color
                |> toColorLight
                |> Color.Manipulate.lighten 0.1
                |> Color.Manipulate.desaturate 0.4

        Success ->
            color
                |> toColorLight
                |> Color.Manipulate.lighten 0.15
                |> Color.Manipulate.desaturate 0.4

        Background ->
            R10.Color.fromHex "#121212"


{-| -}
toColor : R10.Theme.Theme -> (Color -> Color.Color)
toColor theme =
    case theme.mode of
        R10.Mode.Light ->
            toColorLight

        R10.Mode.Dark ->
            toColorDark
