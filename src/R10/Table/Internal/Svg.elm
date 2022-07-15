module R10.Table.Internal.Svg exposing
    ( arrowDown
    , arrowNext
    , arrowPrev
    , filterList
    , removeCircle
    )

import Svg
import Svg.Attributes as SA


wrapperWithViewbox : Int -> String -> List (Svg.Svg msg) -> Svg.Svg msg
wrapperWithViewbox size viewbox listSvg =
    Svg.svg
        [ SA.xmlSpace "http://www.w3.org/2000/svg"
        , SA.viewBox viewbox
        , SA.height <| String.fromInt size
        , SA.preserveAspectRatio "xMinYMin slice"
        ]
        listSvg


arrowPrev : String -> Int -> Svg.Svg msg
arrowPrev color size =
    wrapperWithViewbox
        size
        "0 0 24 24"
        [ Svg.path [ SA.fill color, SA.d "M16.62 2.99c-.49-.49-1.28-.49-1.77 0L6.54 11.3c-.39.39-.39 1.02 0 1.41l8.31 8.31c.49.49 1.28.49 1.77 0s.49-1.28 0-1.77L9.38 12l7.25-7.25c.48-.48.48-1.28-.01-1.76z" ] []
        ]


arrowNext : String -> Int -> Svg.Svg msg
arrowNext color size =
    wrapperWithViewbox
        size
        "0 0 24 24"
        [ Svg.path [ SA.fill color, SA.d "M7.38 21.01c.49.49 1.28.49 1.77 0l8.31-8.31c.39-.39.39-1.02 0-1.41L9.15 2.98c-.49-.49-1.28-.49-1.77 0s-.49 1.28 0 1.77L14.62 12l-7.25 7.25c-.48.48-.48 1.28.01 1.76z" ] []
        ]


arrowDown : String -> Int -> Svg.Svg msg
arrowDown color size =
    wrapperWithViewbox
        size
        "0 0 24 24"
        [ Svg.path [ SA.fill color, SA.d "M11 5v11.17l-4.88-4.88c-.39-.39-1.03-.39-1.42 0-.39.39-.39 1.02 0 1.41l6.59 6.59c.39.39 1.02.39 1.41 0l6.59-6.59c.39-.39.39-1.02 0-1.41-.39-.39-1.02-.39-1.41 0L13 16.17V5c0-.55-.45-1-1-1s-1 .45-1 1z" ] []
        ]


removeCircle : String -> Int -> Svg.Svg msg
removeCircle color size =
    wrapperWithViewbox
        size
        "0 0 24 24"
        [ Svg.path [ SA.fill color, SA.d "M12 2C6.47 2 2 6.47 2 12s4.47 10 10 10 10-4.47 10-10S17.53 2 12 2zm5 13.59L15.59 17 12 13.41 8.41 17 7 15.59 10.59 12 7 8.41 8.41 7 12 10.59 15.59 7 17 8.41 13.41 12 17 15.59z" ] []
        ]


filterList : String -> Int -> Svg.Svg msg
filterList color size =
    wrapperWithViewbox
        size
        "0 0 24 24"
        [ Svg.path [ SA.fill color, SA.d "M11 18h2c.55 0 1-.45 1-1s-.45-1-1-1h-2c-.55 0-1 .45-1 1s.45 1 1 1zM3 7c0 .55.45 1 1 1h16c.55 0 1-.45 1-1s-.45-1-1-1H4c-.55 0-1 .45-1 1zm4 6h10c.55 0 1-.45 1-1s-.45-1-1-1H7c-.55 0-1 .45-1 1s.45 1 1 1z" ] []
        ]
