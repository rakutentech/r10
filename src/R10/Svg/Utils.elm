module R10.Svg.Utils exposing (wrapperWithViewbox, wrapper32)

{-| Utilities to render SVG elements.

@docs wrapperWithViewbox, wrapper32

-}

import Element.WithContext exposing (..)
import Html.Attributes
import R10.Context exposing (..)
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
        ([ Html.Attributes.attribute "xmlns" "http://www.w3.org/2000/svg"
         , Html.Attributes.attribute "xmlns:xlink" "http://www.w3.org/1999/xlink"
         , SA.version "1.1"
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
wrapperWithViewbox : List (Attribute (R10.Context.ContextInternal z) msg) -> String -> Int -> List (Svg.Svg msg) -> Element (R10.Context.ContextInternal z) msg
wrapperWithViewbox attrs viewbox size listSvg =
    el attrs <| html <| wrapperWithViewbox_ viewbox size listSvg


{-| -}
wrapper32 : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> List (Svg.Svg msg) -> Element (R10.Context.ContextInternal z) msg
wrapper32 attrs size listSvg =
    wrapperWithViewbox attrs "0 0 32 32" size listSvg
