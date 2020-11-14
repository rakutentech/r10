module R10.Color.Internal.Base exposing (Color(..), list, toColor)

{-| Rakuten base colors.

From these 6 colors all other colors are generated programmatically.

This module is not exposed as these colors should not be used directly.

The only way to get these color is through `list` just for documentation purpose.

@docs Color, list, toColor

-}

-- import R10.Color

import Color
import Color.Manipulate
import Json.Decode
import Json.Encode
import R10.Color.Utils
import R10.Mode
import R10.Theme


type Color
    = Background
    | Font
    | FontReversed
    | FontLink
    | Success
    | Error


toColor : R10.Theme.Theme -> (Color -> Color.Color)
toColor theme =
    case theme.mode of
        R10.Mode.Light ->
            toColorLight_

        R10.Mode.Dark ->
            toColorDark


list : R10.Theme.Theme -> List { color : Color.Color, name : String }
list theme =
    List.map
        (\color ->
            { color = toColor theme color
            , name = toString_ color
            }
        )
        list_



-- INTERNALS


toString_ : Color -> String
toString_ value =
    case value of
        Background ->
            "Background"

        Font ->
            "Font"

        FontReversed ->
            "Font Reversed"

        FontLink ->
            "Font Link"

        Success ->
            "Success"

        Error ->
            "Error"


list_ : List Color
list_ =
    [ Background
    , Font
    , FontReversed
    , FontLink
    , Success
    , Error
    ]


toColorLight_ : Color -> Color.Color
toColorLight_ color =
    case color of
        Font ->
            Color.rgb 0 0 0

        FontReversed ->
            Color.rgb 1 1 1

        FontLink ->
            R10.Color.Utils.fromHex "#00a0f0"

        Error ->
            R10.Color.Utils.fromHex "#df0101"

        Success ->
            R10.Color.Utils.fromHex "#047205"

        Background ->
            R10.Color.Utils.fromHex "#ffffff"


toColorDark : Color -> Color.Color
toColorDark color =
    case color of
        Font ->
            Color.rgb 1 1 1

        FontReversed ->
            Color.rgb 0 0 0

        FontLink ->
            R10.Color.Utils.fromLightToDark <| toColorLight_ color

        Error ->
            color
                |> toColorLight_
                |> Color.Manipulate.lighten 0.1
                |> Color.Manipulate.desaturate 0.4

        Success ->
            color
                |> toColorLight_
                |> Color.Manipulate.lighten 0.15
                |> Color.Manipulate.desaturate 0.4

        Background ->
            R10.Color.Utils.fromHex "#121212"
