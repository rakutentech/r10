module R10.Color.Utils exposing (fromColorColor, toColorColor, fromHex, fromLightToDark, setAlpha, toCssRgba, fromHexToColorColor)

{-| Utilities for colors.

There are two competing color types in this library:

  - `Color.Color` (from `avh4/elm-color`)
  - `Color` (from `mdgriffith/elm-ui`)

The default color type is `Color`.

@docs fromColorColor, toColorColor, fromHex, fromLightToDark, setAlpha, toCssRgba, fromHexToColorColor

-}

import Color
import Color.Convert
import Color.Manipulate
import Element.WithContext exposing (..)



-- import R10.Context exposing (..)


{-| Transform a `Color.Color` into an `Color`.
-}
fromColorColor : Color.Color -> Color
fromColorColor color =
    let
        { red, green, blue, alpha } =
            Color.toRgba color
    in
    rgba red green blue alpha


{-| Transform an `Color` into a `Color.Color`.
-}
toColorColor : Color -> Color.Color
toColorColor elementColor =
    let
        { red, green, blue, alpha } =
            toRgb elementColor
    in
    Color.fromRgba { red = red, green = green, blue = blue, alpha = alpha }


{-| Convert a string containing an hexadecimal number into a `Color.Color`.
-}
fromHexToColorColor : String -> Color.Color
fromHexToColorColor hex =
    let
        resultColor : Result String Color.Color
        resultColor =
            Color.Convert.hexToColor hex

        color : Color.Color
        color =
            Result.withDefault (Color.fromRgba { red = 0, green = 0, blue = 0, alpha = 0 }) resultColor
    in
    color


{-| Convert a string containing an hexadecimal number into an `Color`.
-}
fromHex : String -> Color
fromHex hex =
    hex
        |> fromHexToColorColor
        |> fromColorColor


{-| Convert an `Color` to a RGBA string, for example: rgba(100, 200, 0, 1)
-}
toCssRgba : Color -> String
toCssRgba elementColor =
    elementColor
        |> toColorColor
        |> Color.Convert.colorToCssRgba


{-| Convert a color from Light Mode to Dark Mode. This function works for `Color.Color` type.
-}
fromLightToDark : Color.Color -> Color.Color
fromLightToDark color =
    color
        |> Color.Manipulate.scaleHsl
            { saturationScale = -0.17
            , lightnessScale = -0.04
            , alphaScale = 0
            }


{-| Change the alpha channel in a color. This function works for `Color.Color` type.
-}
setAlpha : Float -> Color.Color -> Color.Color
setAlpha newAlpha color =
    let
        c : { alpha : Float, blue : Float, green : Float, red : Float }
        c =
            Color.toRgba color
    in
    Color.fromRgba { red = c.red, green = c.green, blue = c.blue, alpha = newAlpha }
