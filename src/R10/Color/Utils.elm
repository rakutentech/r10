module R10.Color.Utils exposing (colorToElementColor, elementColorToColor, fromHex, toHex, fromLightToDark, setAlpha)

{-| Utilities for colors.

@docs colorToElementColor, elementColorToColor, fromHex, toHex, fromLightToDark, setAlpha

-}

import Color
import Color.Convert
import Color.Manipulate
import Element


{-| Change the alpha channel in a color.
-}
setAlpha : Float -> Color.Color -> Color.Color
setAlpha newAlpha color =
    let
        c : { alpha : Float, blue : Float, green : Float, red : Float }
        c =
            Color.toRgba color
    in
    Color.fromRgba { red = c.red, green = c.green, blue = c.blue, alpha = newAlpha }


{-| Transform a color, as defined in `avh4/elm-color`, to an Element color, as defined in `mdgriffith/elm-ui`.
-}
colorToElementColor : Color.Color -> Element.Color
colorToElementColor color =
    let
        { red, green, blue, alpha } =
            Color.toRgba color
    in
    Element.rgba red green blue alpha


{-| Transform a color, as defined in `mdgriffith/elm-ui`, to an Element color, as defined in `avh4/elm-color`.
-}
elementColorToColor : Element.Color -> Color.Color
elementColorToColor elementColor =
    let
        { red, green, blue, alpha } =
            Element.toRgb elementColor
    in
    Color.fromRgba { red = red, green = green, blue = blue, alpha = alpha }


{-| Convert a string containing an hexadecimal number to a Color.
-}
fromHex : String -> Color.Color
fromHex hex =
    let
        resultColor : Result String Color.Color
        resultColor =
            Color.Convert.hexToColor hex

        color : Color.Color
        color =
            Result.withDefault (Color.fromRgba { red = 0, green = 0, blue = 0, alpha = 0 }) resultColor
    in
    color


{-| -}
toHex : Color.Color -> String
toHex =
    Color.Convert.colorToCssRgba


{-| Convert a color from Light Mode to Dark Mode.
-}
fromLightToDark : Color.Color -> Color.Color
fromLightToDark color =
    color
        |> Color.Manipulate.scaleHsl
            { saturationScale = -0.17
            , lightnessScale = -0.04
            , alphaScale = 0
            }
