module R10.Table.Internal.Placeholder exposing (placeholderSvg, view)

import Element.WithContext exposing (..)
import Element.WithContext.Border as Border
import R10.Context exposing (..)
import Svg
import Svg.Attributes as SA


toRadix : Int -> String
toRadix n =
    -- Internal Utils for getting radix number
    let
        getChr c =
            if c < 10 then
                String.fromInt c

            else
                String.fromChar <| Char.fromCode (87 + c)

        result =
            if n < 16 then
                getChr n

            else
                toRadix (n // 16) ++ getChr (remainderBy 16 n)
    in
    result


toHex : Color -> String
toHex color =
    let
        { red, green, blue } =
            toRgb color
    in
    [ red * 255, green * 255, blue * 255 ]
        |> List.map ceiling
        |> List.map (toRadix >> String.padLeft 2 '0')
        |> (::) "#"
        |> String.join ""


placeholderSvg : Color -> Element (R10.Context.ContextInternal z) msg
placeholderSvg color =
    let
        stringColor =
            toHex color

        fillId =
            "fill" ++ stringColor

        speed =
            "2s"
    in
    Element.WithContext.html <|
        Svg.svg
            [ SA.xmlSpace "http://www.w3.org/2000/svg"
            , SA.width "auto"
            , SA.height "auto"
            ]
            [ Svg.rect
                [ SA.fill "none"
                , SA.x "0"
                , SA.y "0"
                , SA.width "100%"
                , SA.height "100%"
                , SA.style <| "fill: url(#" ++ fillId ++ ");"
                ]
                []
            , Svg.defs []
                [ Svg.linearGradient
                    [ SA.id fillId ]
                    [ Svg.stop
                        [ SA.offset "0.599964"
                        , SA.stopColor stringColor
                        , SA.stopOpacity "0.7"
                        ]
                        [ Svg.animate
                            [ SA.attributeName "offset"
                            , SA.values "-2; -2; 1"
                            , SA.keyTimes "0; 0.25; 1"
                            , SA.dur speed
                            , SA.repeatCount "indefinite"
                            ]
                            []
                        ]
                    , Svg.stop
                        [ SA.offset "1.59996"
                        , SA.stopColor stringColor
                        , SA.stopOpacity "1"
                        ]
                        [ Svg.animate
                            [ SA.attributeName "offset"
                            , SA.values "-1; -1; 2"
                            , SA.keyTimes "0; 0.25; 1"
                            , SA.dur speed
                            , SA.repeatCount "indefinite"
                            ]
                            []
                        ]
                    , Svg.stop
                        [ SA.offset "2.59996"
                        , SA.stopColor stringColor
                        , SA.stopOpacity "0.7"
                        ]
                        [ Svg.animate
                            [ SA.attributeName "offset"
                            , SA.values "0; 0; 3"
                            , SA.keyTimes "0; 0.25; 1"
                            , SA.dur speed
                            , SA.repeatCount "indefinite"
                            ]
                            []
                        ]
                    ]
                ]
            ]


view : Color -> List (Attribute (R10.Context.ContextInternal z) msg) -> Element (R10.Context.ContextInternal z) msg
view color attrs =
    el ([ width fill, height <| px 16, Border.rounded 4, clip, alpha 0.6 ] ++ attrs) <|
        (placeholderSvg <| color)
