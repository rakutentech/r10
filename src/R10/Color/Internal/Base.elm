module R10.Color.Internal.Base exposing (Color(..), list, toColor)

{-| Rakuten base colors.

From these 6 colors all other colors are generated programmatically.

This module is not exposed as these colors should not be used directly.

The only way to get these color is through `list` just for documentation purpose.

@docs Color, list, toColor

-}

import Color
import Color.Manipulate
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
            \c -> Tuple.first (toColorLight_ c)

        R10.Mode.Dark ->
            \c -> Tuple.first (toColorDark_ c)


list : R10.Theme.Theme -> List { color : Color.Color, name : String, description : String }
list theme =
    List.map
        (\color ->
            let
                ( color_, description_ ) =
                    case theme.mode of
                        R10.Mode.Light ->
                            toColorLight_ color

                        R10.Mode.Dark ->
                            toColorDark_ color
            in
            { color = color_
            , name = toString_ color
            , description = description_
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


toColorLight_ : Color -> ( Color.Color, String )
toColorLight_ color =
    case color of
        Font ->
            ( R10.Color.Utils.fromHex "#000000"
            , "Hard coded as #000000"
            )

        FontReversed ->
            ( R10.Color.Utils.fromHex "#ffffff"
            , "Hard coded as #ffffff"
            )

        FontLink ->
            ( R10.Color.Utils.fromHex "#00a0f0"
            , "Hard coded as #00a0f0"
            )

        Error ->
            ( R10.Color.Utils.fromHex "#df0101"
            , "Hard coded as #df0101"
            )

        Success ->
            ( R10.Color.Utils.fromHex "#047205"
            , "Hard coded as #047205"
            )

        Background ->
            ( R10.Color.Utils.fromHex "#ffffff"
            , "Hard coded as #ffffff"
            )


toColorDark_ : Color -> ( Color.Color, String )
toColorDark_ color =
    case color of
        Font ->
            ( R10.Color.Utils.fromHex "#ffffff"
            , "Hard coded as #ffffff"
            )

        FontReversed ->
            ( R10.Color.Utils.fromHex "#000000"
            , "Hard coded as #000000"
            )

        FontLink ->
            ( R10.Color.Utils.fromLightToDark <| Tuple.first <| toColorLight_ color
            , "Converted from light mode using `R10.Color.Utils.fromLightToDark`"
            )

        Error ->
            ( color
                |> toColorLight_
                |> Tuple.first
                |> Color.Manipulate.lighten 0.1
                |> Color.Manipulate.desaturate 0.4
            , "Same as light mode but lighten (0.1) and desaturate (0.4)"
            )

        Success ->
            ( color
                |> toColorLight_
                |> Tuple.first
                |> Color.Manipulate.lighten 0.15
                |> Color.Manipulate.desaturate 0.4
            , "Same as light mode but lighten (0.15) and desaturate (0.4)"
            )

        Background ->
            ( R10.Color.Utils.fromHex "#121212"
            , "Hard coded as #121212"
            )
