module R10.Svg.Utils exposing (wrapperWithViewbox, wrapper32)

{-| Utilities to render SVG elements.

@docs wrapperWithViewbox, wrapper32

-}

import Element exposing (..)
import Html.Attributes
import Svg
import Svg.Attributes as SA



-- WRAPPERS


svgSize_ : String -> Int -> List (Svg.Attribute msg)
svgSize_ viewbox ySize =
    --
    -- IE11 is very picky about knowing all sizes of a SVG so
    -- here we calculate the width starting from the height
    -- using the viewbox.
    --
    case String.split " " viewbox of
        [ x, y, dx, dy ] ->
            Maybe.withDefault [ SA.height <| String.fromInt ySize ] <|
                Maybe.map4
                    (\_ _ dx_ dy_ ->
                        let
                            xSize : Float
                            xSize =
                                (dx_ * toFloat ySize) / dy_
                        in
                        [ SA.height <| String.fromInt ySize
                        , SA.width <| String.fromFloat xSize
                        ]
                    )
                    (String.toFloat x)
                    (String.toFloat y)
                    (String.toFloat dx)
                    (String.toFloat dy)

        _ ->
            [ SA.height <| String.fromInt ySize ]


{-| -}
wrapperWithViewbox_ : String -> Int -> List (Svg.Svg msg) -> Svg.Svg msg
wrapperWithViewbox_ viewbox ySize listSvg =
    Svg.svg
        ([ SA.xmlSpace "http://www.w3.org/2000/svg"
         , SA.preserveAspectRatio "xMinYMin slice"
         , SA.viewBox viewbox

         -- This fix a bug in IE11:
         -- https://stackoverflow.com/questions/29393144/how-to-prevent-svg-elements-from-gaining-focus-with-tabs-in-ie11
         --
         , Html.Attributes.attribute "focusable" "false"
         ]
            ++ svgSize_ viewbox ySize
        )
        listSvg


{-| -}
wrapperWithViewbox : List (Attribute msg) -> String -> Int -> List (Svg.Svg msg) -> Element.Element msg
wrapperWithViewbox attrs viewbox size listSvg =
    el attrs <| Element.html <| wrapperWithViewbox_ viewbox size listSvg


{-| -}
wrapper32 : List (Attribute msg) -> Int -> List (Svg.Svg msg) -> Element.Element msg
wrapper32 attrs size listSvg =
    wrapperWithViewbox attrs "0 0 32 32" size listSvg
