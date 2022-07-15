module R10.Svg.LogosExtra exposing (apple, apple_monochrome, elm, elm_monochrome, facebook, facebook_monochrome, github, google, google_monochrome, microsoft, microsoft_monochrome, pcHome24hours, pcHome24hours_monochrome, r10, visa, visa_monochrome, americanExpress_monochrome, americanExpress, cardVisa, cardMasterCard, cardDiscover, cardJCB, cardAmericanExpress, cardDiners, facebookMeta)

{-|

@docs apple, apple_monochrome, elm, elm_monochrome, facebook, facebook_monochrome, github, google, google_monochrome, microsoft, microsoft_monochrome, pcHome24hours, pcHome24hours_monochrome, r10, visa, visa_monochrome, americanExpress_monochrome, americanExpress, cardVisa, cardMasterCard, cardDiscover, cardJCB, cardAmericanExpress, cardDiners, facebookMeta

-}

import Element.WithContext exposing (..)
import Html.Attributes
import R10.Color.Utils
import R10.Context exposing (..)
import R10.Svg.Utils
import Svg
import Svg.Attributes as SA


{-| -}
r10 : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
r10 attrs cl size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 2370 672"
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M1207 129l-150 72-1 62c0 60 0 62 2 62a3071 3071 0 00113-55l3-1v209h-118v100h303V317l-1-261-151 72zM205 211v129h-3l-50 9-51 9h-2v110l53-9 53-9v128h185V419l62-11 61-9 101 89 101 90h256l-4-3-121-108c-93-82-118-105-116-105l208-36h4V82H205v129zm552 3l-1 32a80339 80339 0 00-365 61l-1-62v-63h367v32zM1501 330v248h730V82h-730v248zm466-147l-277 214-4 3V182h141c122 0 141 0 140 1zm79 186v109h-142c-124 0-141 0-140-2a37829 37829 0 00281-216l1 109z" ] []
        ]


{-| -}
elm : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
elm attrs size =
    elm_monochrome attrs (R10.Color.Utils.fromHex "#1293d8") size


{-| -}
elm_monochrome : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
elm_monochrome attrs cl size =
    let
        data =
            { p1 = ( 0, -210, 0 )
            , p2 = ( -210, 0, -90 )
            , p3 = ( 207, 207, -45 )
            , p4 = ( 150, 0, 0 )
            , p5 = ( -89, 239, 0 )
            , p6 = ( 0, 106, -180 )
            , p7 = ( 256, -150, -270 )
            }
    in
    R10.Svg.Utils.wrapperWithViewbox attrs
        "-300 -300 600 600"
        size
        [ Svg.g
            [ SA.transform "scale(1 -1)" ]
            [ poly (R10.Color.Utils.toCssRgba cl) "-280,-90 0,190 280,-90" data.p1
            , poly (R10.Color.Utils.toCssRgba cl) "-280,-90 0,190 280,-90" data.p2
            , poly (R10.Color.Utils.toCssRgba cl) "-198,-66 0,132 198,-66" data.p3
            , poly (R10.Color.Utils.toCssRgba cl) "-130,0 0,-130 130,0 0,130" data.p4
            , poly (R10.Color.Utils.toCssRgba cl) "-191,61 69,61 191,-61 -69,-61" data.p5
            , poly (R10.Color.Utils.toCssRgba cl) "-130,-44 0,86  130,-44" data.p6
            , poly (R10.Color.Utils.toCssRgba cl) "-130,-44 0,86  130,-44" data.p7
            ]
        ]


{-| -}
poly : String -> String -> ( Int, Int, Int ) -> Svg.Svg msg
poly color points ( translateX, translateY, rotation ) =
    Svg.polygon
        [ SA.fill color
        , SA.points points
        , Html.Attributes.style "transition" "1s"
        , SA.transform
            ("translate("
                ++ String.fromInt translateX
                ++ " "
                ++ String.fromInt translateY
                ++ ") rotate("
                ++ String.fromInt rotation
                ++ ")"
            )
        ]
        []


{-| -}
microsoft_ : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Color -> Color -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
microsoft_ attrs cl1 cl2 cl3 cl4 size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 21 21"
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl1, SA.d "M1 1h9v9H1z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl2, SA.d "M1 11h9v9H1z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl3, SA.d "M11 1h9v9h-9z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl4, SA.d "M11 11h9v9h-9z" ] []
        ]


{-| -}
microsoft : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
microsoft attrs size =
    microsoft_ attrs
        (R10.Color.Utils.fromHex "#f25022")
        (R10.Color.Utils.fromHex "#00a4ef")
        (R10.Color.Utils.fromHex "#7fba00")
        (R10.Color.Utils.fromHex "#ffb900")
        size


{-| -}
microsoft_monochrome : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
microsoft_monochrome attrs cl size =
    microsoft_ attrs
        cl
        cl
        cl
        cl
        size


{-| -}
google_ : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Color -> Color -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
google_ attrs cl1 cl2 cl3 cl4 size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "4 4 17 17"
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl1, SA.d "M20.66 12.693c0-.603-.054-1.182-.155-1.738H12.5v3.287h4.575a3.91 3.91 0 0 1-1.697 2.566v2.133h2.747c1.608-1.48 2.535-3.65 2.535-6.24z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl2, SA.d "M12.5 21c2.295 0 4.22-.76 5.625-2.06l-2.747-2.132c-.76.51-1.734.81-2.878.81-2.214 0-4.088-1.494-4.756-3.503h-2.84v2.202A8.498 8.498 0 0 0 12.5 21z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl3, SA.d "M7.744 14.115c-.17-.51-.267-1.055-.267-1.615s.097-1.105.267-1.615V8.683h-2.84A8.488 8.488 0 0 0 4 12.5c0 1.372.328 2.67.904 3.817l2.84-2.202z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl4, SA.d "M12.5 7.38c1.248 0 2.368.43 3.25 1.272l2.437-2.438C16.715 4.842 14.79 4 12.5 4a8.497 8.497 0 0 0-7.596 4.683l2.84 2.202c.668-2.01 2.542-3.504 4.756-3.504z" ] []
        ]


{-| -}
google : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
google attrs size =
    google_ attrs
        (R10.Color.Utils.fromHex "#4285F4")
        (R10.Color.Utils.fromHex "#34A853")
        (R10.Color.Utils.fromHex "#FBBC05")
        (R10.Color.Utils.fromHex "#EA4335")
        size


{-| -}
google_monochrome : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
google_monochrome attrs cl size =
    google_ attrs
        cl
        cl
        cl
        cl
        size


{-| -}
facebook : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
facebook attrs size =
    facebook_monochrome attrs (R10.Color.Utils.fromHex "#3b5998") size


{-| -}
facebook_monochrome : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
facebook_monochrome attrs cl size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "4 4 17 17"
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.fillRule "evenodd", SA.d "M20.292 4H4.709A.709.709 0 0 0 4 4.708v15.584c0 .391.317.708.709.708h8.323v-6.375h-2.125v-2.656h2.125V9.844c0-2.196 1.39-3.276 3.348-3.276.938 0 1.745.07 1.98.1v2.295h-1.358c-1.066 0-1.314.507-1.314 1.25v1.756h2.656l-.531 2.656h-2.125L15.73 21h4.562a.708.708 0 0 0 .708-.708V4.708A.708.708 0 0 0 20.292 4" ] []
        ]


{-| -}
facebookMeta : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
facebookMeta attrs size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 14222 14222"
        size
        [ Svg.path [ SA.d "M14222 7111C14222 3184 11038 0 7111 0S0 3184 0 7111c0 3549 2600 6491 6000 7025V9167H4194V7111h1806V5544c0-1782 1062-2767 2686-2767 778 0 1592 139 1592 139v1750h-897c-883 0-1159 548-1159 1111v1334h1972l-315 2056H8222v4969c3400-533 6000-3475 6000-7025z", SA.style "fill-rule: nonzero; fill: rgb(255, 255, 255);" ] []
        , Svg.path [ SA.d "m9879 9167 315-2056H8222V5777c0-562 275-1111 1159-1111h897V2916s-814-139-1592-139c-1624 0-2686 984-2686 2767v1567H4194v2056h1806v4969c362 57 733 86 1111 86s749-30 1111-86V9167h1657z", SA.style "fill-rule: nonzero; fill: rgba(0, 0, 0, 0);" ] []
        ]


{-| -}
apple : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
apple attrs size =
    apple_monochrome attrs (R10.Color.Utils.fromHex "#FFF") size


{-| -}
apple_monochrome : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
apple_monochrome attrs cl size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "-80 0 1187.2 1187.2"
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M979 925c-18 42-39 80-64 115-33 48-61 81-82 99-33 31-68 46-106 47-27 0-59-8-97-23-38-16-73-24-105-24-34 0-70 8-108 24-39 15-70 23-94 24-36 2-72-14-108-48A712 712 0 010 640c0-79 17-148 52-205a303 303 0 01254-151c29 0 66 9 113 27 47 17 77 26 90 26 9 0 43-10 99-31 53-19 98-27 135-24 100 8 175 47 225 118a250 250 0 00-133 227c1 76 29 139 83 189 24 23 52 41 82 54l-21 55zM750 24c0 59-22 115-65 166-52 61-115 96-184 91l-1-23c0-57 25-118 69-168 22-25 50-46 84-63 34-16 66-25 96-27l1 24z" ] []
        ]


{-| -}
pcHome24hours : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
pcHome24hours attrs size =
    pcHome24hours_ attrs
        False
        (R10.Color.Utils.fromHex "#d7000f")
        (R10.Color.Utils.fromHex "#b81c22")
        (R10.Color.Utils.fromHex "#ffffff")
        size


{-| -}
pcHome24hours_monochrome : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
pcHome24hours_monochrome attrs cl size =
    pcHome24hours_ attrs
        True
        (R10.Color.Utils.fromHex "#00000000")
        (R10.Color.Utils.fromHex "#00000000")
        cl
        size


{-| -}
pcHome24hours_ : List (Attribute (R10.Context.ContextInternal z) msg) -> Bool -> Color -> Color -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
pcHome24hours_ attrs isMonochrome cl1 cl2 cl3 size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 430.9 430.9"
        size
        ([]
            ++ (if isMonochrome then
                    []

                else
                    [ Svg.linearGradient [ SA.id "SVGID_1_", SA.x1 "59.3", SA.x2 "390.8", SA.y1 "46", SA.y "407.2", SA.gradientUnits "userSpaceOnUse" ]
                        [ Svg.stop [ SA.offset ".3", SA.stopColor <| R10.Color.Utils.toCssRgba cl1 ] []
                        , Svg.stop [ SA.offset ".9", SA.stopColor <| R10.Color.Utils.toCssRgba cl2 ] []
                        ]
                    , Svg.path [ SA.fill "url(#SVGID_1_)", SA.d "M430.2 364.7a66.1 66.1 0 0 1-66.1 66.1H66.4A66.1 66.1 0 0 1 .3 364.7V67.1A66.1 66.1 0 0 1 66.4 1H364a66.1 66.1 0 0 1 66.1 66.1v297.6z" ] []
                    ]
               )
            ++ [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl3, SA.d "M81.1 319.7L40.8 394l118.4 1.8 50-94.4zM349.4 319.7l40.3 74.3-118.5 1.8-49.9-94.4z" ] []
               , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl3, SA.d "M265.2 402l-50-97.5-49.9 97.5H83.1v24.7H347.4V402z" ] []
               , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl3, SA.d "M405.6 222H276l1.9-7.2h129.6zM401.6 236.5H272l2-7.3h129.6zM397.8 250.9H268.2l1.9-7.2h129.6zM126.2 151.5c.7-2.5.5-4.3-.4-5.4-.9-1.1-2.6-1.7-5.2-1.7-2.7 0-4.8.5-6.2 1.5-1.4 1-2.4 2.9-3.2 5.5l-4.5 18.5H62.9l1.9-8.9a44.9 44.9 0 0 1 19.7-28.6c9.5-5.6 23.6-8.4 42.2-8.4 17.4 0 29.7 2.7 36.9 8.2 7.1 5.5 9.2 13.8 6.3 24.9-3.5 13-18.7 29.9-45.6 50.9l-11.9 9.4c-9.7 7.7-19 15.9-22.6 20.7-3 4.1-4.3 7.1-4.3 7.1h61.1l-6.8 25.3H35.1l6.3-23.6a46.6 46.6 0 0 1 9.5-17.5c4.8-5.8 13.4-13.6 25.9-23.5l12.1-9.3c21.2-16.4 32.6-27.8 34.3-34.1l3-11z" ] []
               , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl3, SA.d "M197.3 270.7l9.2-34.3h-63.6l5.8-21.6 63.4-87.6h60.3l-21.6 80.3-36.2.1 19.9-57.4h-4.3l-42.4 64.6h82.4l-5.8 21.6h-21.3l-9.2 34.3zM279.8 207.5l21.5-80.3h39.1l-10.3 38.5h.6c4-4 8.5-7 13.6-8.9 5-1.9 10.7-2.9 17.1-2.9 8.5 0 14.5 1.6 17.9 4.9 3.4 3.3 4.2 8.2 2.5 14.7l-9.1 34h-39.4l6.9-25.6c.7-2.6.7-4.4-.2-5.4-.8-.9-2.5-1.4-5.2-1.4-2.4 0-4.4.5-5.8 1.6a8.7 8.7 0 0 0-3.1 5.1l-6.9 25.6h-39.2z" ] []
               ]
        )


{-| -}
github : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
github attrs cl size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "4.5 4.5 44 44"
        size
        [ Svg.path [ SA.fill "none", SA.d "M-.2.1h53.8v53.4H-.2z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M15.9 7.7a21.3 21.3 0 0121.6 0 21.3 21.3 0 016.6 31.2 20.5 20.5 0 01-10.6 7.7c-.5.1-.9 0-1.1-.2-.2-.2-.4-.5-.4-.8v-2.1-3.8c0-1.8-.5-3.1-1.5-4l2.9-.5c.8-.2 1.7-.6 2.6-1.1.9-.5 1.7-1.1 2.3-1.9.6-.7 1.1-1.7 1.5-2.9s.6-2.6.6-4.2a8 8 0 00-2.2-5.7c.7-1.7.6-3.6-.2-5.7-.5-.2-1.3-.1-2.3.3l-2.6 1.2-1.1.7a20 20 0 00-10.8 0l-1.2-.8a17 17 0 00-2.3-1.1c-1.1-.4-1.9-.5-2.4-.4-.8 2.1-.9 4-.2 5.7a8.8 8.8 0 00-2.1 5.8c0 1.6.2 3 .6 4.2a8.2 8.2 0 003.7 4.8c.9.5 1.8.9 2.6 1.1l2.9.5a5 5 0 00-1.4 2.9 5 5 0 01-1.3.4l-1.6.1c-.6 0-1.2-.2-1.8-.6a5 5 0 01-1.5-1.7 5 5 0 00-1.4-1.5c-.5-.4-1-.6-1.4-.7l-.6-.1-.8.1c-.1.1-.2.2-.1.3l.3.4.4.3.2.1c.4.2.8.5 1.2 1.1l.9 1.4.3.6c.2.7.7 1.3 1.2 1.7.6.4 1.2.7 1.9.8l1.9.2 1.5-.1.6-.1v4c0 .3-.1.6-.4.8-.2.2-.6.3-1.1.2A21.4 21.4 0 018 15.2c2-3 4.6-5.6 7.9-7.5zm-2.6 27.9c.1-.1 0-.2-.2-.3-.2-.1-.3 0-.4.1-.1.1 0 .2.2.3.2.1.4.1.4-.1zm.9 1c.1-.1.1-.2-.1-.4s-.3-.2-.4-.1c-.1.1-.1.2.1.4.1.2.3.2.4.1zm.8 1.2c.2-.1.2-.3 0-.5-.1-.2-.3-.3-.5-.2-.2.1-.2.3 0 .5s.4.3.5.2zm1.2 1.2c.1-.1.1-.3-.1-.5s-.4-.3-.6-.1c-.2.1-.1.3.1.5.3.2.5.2.6.1zm1.6.7c.1-.2-.1-.4-.4-.4-.3-.1-.5 0-.5.2-.1.2 0 .3.4.4.2.1.4 0 .5-.2zm1.8.1c0-.2-.2-.3-.5-.3s-.4.1-.4.3c0 .2.2.3.5.3.2 0 .4-.1.4-.3zm1.6-.3c0-.2-.2-.3-.5-.3-.3.1-.4.2-.4.4s.2.3.5.2c.3.1.4-.1.4-.3z" ] []
        ]


{-| -}
visa : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
visa attrs size =
    visa_ attrs (R10.Color.Utils.fromHex "#00579f") (R10.Color.Utils.fromHex "#faa61a") size


{-| -}
visa_monochrome : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
visa_monochrome attrs cl size =
    visa_ attrs cl cl size


{-| -}
visa_ : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
visa_ attrs cl1 cl2 size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 1000 323.7"
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl1, SA.d "M433 319h-81L403 6h81zM727 13c-16-6-41-13-73-13-80 0-136 43-136 104-1 45 40 70 71 85s42 25 42 39c-1 21-26 30-49 30-32 0-50-5-76-16l-11-5-11 70c19 9 54 16 90 17 85 0 141-42 141-107 1-36-21-63-68-86-28-14-45-24-45-38s14-27 46-27c27-1 46 5 61 12l7 3 11-68zm108 195l32-88 11-30 5 27 19 91h-67zM935 6h-63c-19 0-34 5-42 26L709 319h85l17-47h104l10 47h75L935 6zM285 6l-80 213-8-43C182 126 136 72 85 45l72 274h86L370 6h-85z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl2, SA.d "M132 6H1l-1 6c102 26 169 89 197 164L168 32c-4-20-19-26-36-26z" ] []
        ]


{-| -}
americanExpress : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
americanExpress attrs size =
    americanExpress_ attrs (R10.Color.Utils.fromHex "#007fff") size


{-| -}
americanExpress_monochrome : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
americanExpress_monochrome attrs cl size =
    americanExpress_ attrs cl size


{-| -}
americanExpress_ : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
americanExpress_ attrs cl size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 440 154"
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M38.7 38.3H54l-7.7-19.5zM120 103.7v9h25.8v9.7H120v10.5h28.5l13.3-14.6-12.6-14.6zM321 18.8l-8.4 19.5h16zM194.4 138.4V98.8l-18 19.5zM228.5 110c-.7-4.2-3.5-6.3-7.6-6.3h-14.6v12.5h15.3c4.1 0 7-2.1 7-6.3zM277.2 114.8c1.4-.7 2-2.8 2-4.9.8-2.7-.6-4.1-2-4.8-1.4-.7-3.5-.7-5.6-.7h-13.9v11.1h14c2 0 4 0 5.5-.7z" ] []
            , Svg.path [ SA.d "M377.3.8V9L373.1.8h-32.6V9L336.3.8h-44.5c-7.7 0-14 1.4-19.5 4.1V.8H241v4.1A20 20 0 00227.8.8h-112L108.3 18 100.6.8H65V9L61.6.8H31L17.1 33.4 1.1 69l-.3.7H37l.3-.7 4.2-10.4h9l4.2 11.1H95V61.3l3.5 8.3h20.1l3.5-8.3V69.6h96.7v-18h1.4c1.4 0 1.4 0 1.4 2V69h50v-4.2c4.2 2.1 10.4 4.2 18.8 4.2h20.9l4.1-11.1h9.8l4.1 11.1h40.4V58.5l6.2 10.4h32.7V.8h-31.3zM141.6 59.2h-11.1V21l-.7 1.5-16.2 36.7h-10.2L86.6 20.9v38.3H63l-4.9-10.5H34.5l-4.9 10.5H17.4L38 10.5h17.4l19.4 46.6V10.5h18.5l.3.7 8.8 19 6.3 14.4.2-.7 14-33.4h18.7v48.7zm48-38.3h-27.2v9H189v9.8h-26.5v9.7h27.2V60h-39V10.5h39v10.4zm49.6 18l.7.8c1.3 1.8 2.4 4.4 2.5 8.2v11.3H232v-5.6c0-2.8 0-7-2.1-9.7-.7-.7-1.3-1.1-2-1.4-1-.7-3-.7-6.3-.7H209v17.4h-11.8V10.5h26.4c6.3 0 10.5 0 14 2 3.4 2.1 5.4 5.5 5.5 10.9-.2 7.4-5 11.5-8.3 12.8 0 0 2.3.5 4.4 2.7zm23.4 20.3h-11.8V10.5h11.8v48.7zm135.6 0h-15.3l-22.3-36.9v36.9H337l-4.2-10.5h-24.3L304.3 60H291c-5.6 0-12.5-1.4-16.7-5.6-4.2-4.2-6.3-9.7-6.3-18.8 0-7 1.4-13.9 6.3-19.4 3.5-4.2 9.7-5.6 17.4-5.6h11.1v10.4h-11.1c-4.2 0-6.3.7-9 2.8-2.1 2.1-3.5 6.3-3.5 11.1 0 5.6.7 9 3.4 11.9 2.1 2 5 2.7 8.4 2.7h4.9l16-38.2h17.3l19.5 46.6V11.2h17.4l20.1 34v-34h11.9v48z" ] []
            , Svg.path [ SA.d "M229.2 30.8c.3-.2.4-.5.6-.8.6-1 1.3-2.8 1-5.2l-.2-.7V24c-.3-1.2-1.2-2-2-2.4-1.5-.7-3.6-.7-5.7-.7H209v11.2h14c2 0 4.1 0 5.5-.7l.6-.5.1-.1zM439.2 128.7c0-4.9-1.4-9.7-3.5-13.2V82.2h-33.5c-4.3 0-9.6 4-9.6 4v-4h-32c-4.8 0-11.1 1.3-13.9 4v-4h-57v4c-4.2-3.4-11.8-4-15.3-4h-37.6v4c-3.4-3.4-11.8-4-16-4h-41.7l-9.7 10.3-9-10.4H97.7v70.2H159l10-10 8.7 10H216.7v-15.9h3.5c4.8 0 11 0 16-2.1V153h31.2v-18h1.4c2.1 0 2.1 0 2.1 2v16h94.6c6.2 0 12.5-1.3 16-4.1v4.1h29.9c6.2 0 12.5-.7 16.7-3.4a23.4 23.4 0 0011-18.8v-.7-1.4zm-219-4.2h-14v18.1h-22.8l-13.3-15.3-.7-.7-15.3 16h-44.5V94h45.2l12.3 13.6 2.6 2.8.4-.4 14.6-16h36.9c7.1 0 15.1 1.8 18.1 9 .4 1.5.6 3.1.6 5 0 13.9-9.7 16.6-20.1 16.6zm69.5-.7c1.4 2.1 2 5 2 9v9.8H280v-6.2c0-2.8 0-7.7-2.1-9.8-1.4-2-4.2-2-8.4-2H257v18h-11.8V93.2h26.4c5.6 0 10.4 0 14 2.1 3.4 2.1 6.2 5.6 6.2 11.2 0 7.6-4.9 11.8-8.4 13.2 3.5 1.4 5.6 2.7 6.3 4.1zm48-20.1h-27.1v9H337v9.7h-26.4v9.8h27v10.4h-38.9V93.2h39v10.5zm29.2 39h-22.3v-10.5H367c2 0 3.5 0 4.8-1.4.7-.7 1.4-2 1.4-3.5 0-1.4-.7-2.8-1.4-3.5-.7-.7-2-1.3-4.1-1.3-11.2-.7-24.4 0-24.4-15.3 0-7 4.2-14.6 16.7-14.6h23v11.8h-21.6c-2 0-3.5 0-4.9.7-1.3.7-1.3 2-1.3 3.4 0 2.1 1.3 2.8 2.7 3.5 1.4.7 2.8.7 4.2.7h6.3c6.2 0 10.4 1.4 13.2 4.2 2 2 3.5 5.6 3.5 10.4 0 10.4-6.3 15.3-18.1 15.3zm59.8-5c-2.8 2.8-7.7 5-14.6 5h-22.3v-10.5h22.3c2 0 3.5 0 4.8-1.4.7-.7 1.4-2 1.4-3.5 0-1.4-.7-2.8-1.4-3.5-.7-.7-2-1.3-4.1-1.3-11.2-.7-24.4 0-24.4-15.3 0-6.7 3.8-12.6 13.1-14.4a26 26 0 013.6-.2h23v11.8H406.5c-2 0-3.5 0-4.9.7-.7.7-1.3 2-1.3 3.4 0 2.1.6 2.8 2.7 3.5 1.4.7 2.8.7 4.2.7h6.3c3 0 5.3.4 7.4 1.1a15 15 0 019.7 11c.2.8.2 1.6.2 2.5 0 4.2-1.3 7.7-4.1 10.4z" ] []
            ]
        ]



-- From https://github.com/aaronfagan/svg-credit-card-payment-icons
-- brandCodes: ['Visa', 'MasterCard', 'Discover', 'JCB', 'American Express']


{-| -}
cardVisa : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
cardVisa attrs size =
    -- From https://github.com/aaronfagan/svg-credit-card-payment-icons
    cardVisa_ attrs
        (R10.Color.Utils.fromHex "#0E4595")
        (R10.Color.Utils.fromHex "#fff")
        (R10.Color.Utils.fromHex "#F2AE14")
        size


{-| -}
cardVisa_ : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Color -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
cardVisa_ attrs cl1 cl2 cl3 size =
    -- From https://github.com/aaronfagan/svg-credit-card-payment-icons
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 780 500"
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl1, SA.d "M40 0h700c22 0 40 18 40 40v420c0 22-18 40-40 40H40c-22 0-40-18-40-40V40C0 18 18 0 40 0z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl2, SA.d "M293 349l34-196h53l-33 196h-54zm246-192c-10-4-27-8-48-8-52 0-89 27-90 65 0 28 27 43 47 53 21 9 28 15 28 24 0 13-17 19-32 19-22 0-33-3-50-10l-7-3-8 44c13 5 36 10 60 10 56 0 92-26 93-67 0-22-14-39-45-53-19-9-30-15-30-24 0-8 9-17 30-17 18 0 30 3 40 7l5 3 7-43m138-4h-42c-12 0-22 3-28 16l-79 180h56l11-30h69l6 30h50l-43-196zm-66 126l21-54 8-19 3 17 12 56h-44zM248 153l-52 133-6-27c-10-31-40-65-74-82l48 171h56l84-195h-56" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl3, SA.d "M147 153H61l-1 4c67 16 111 55 130 102l-19-90c-3-12-12-16-24-16" ] []
        ]


{-| -}
cardMasterCard : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
cardMasterCard attrs size =
    -- From https://github.com/aaronfagan/svg-credit-card-payment-icons
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 780 500"
        size
        [ Svg.path [ SA.fill "#16366F", SA.d "M40 0h700c22 0 40 18 40 40v420c0 22-18 40-40 40H40c-22 0-40-18-40-40V40C0 18 18 0 40 0z" ] []
        , Svg.path [ SA.fill "#D9222A", SA.d "M449 250a179.5 179.5 0 11-359 0 179.5 179.5 0 01359 0" ] []
        , Svg.path [ SA.fill "#EE9F2D", SA.d "M510.5 70.5A178.8 178.8 0 00371.9 136H408c5 6 9.6 12.3 13.7 19h-63.6a179 179 0 00-10.4 19h84.4c2.8 6.2 5.4 12.5 7.6 19h-99.6c-2 6.2-3.8 12.6-5.2 19h110a180.4 180.4 0 01-5.2 95h-99.6c2.2 6.5 4.7 12.8 7.6 19h84.4c-3.1 6.6-6.6 13-10.4 19h-63.6c4.1 6.7 8.7 13 13.7 19H408a179.3 179.3 0 01-18.1 19A179.5 179.5 0 10510.5 70.6" ] []

        -- , Svg.path [ SA.d "M666 350a5.8 5.8 0 1111.7 0 5.8 5.8 0 01-11.6 0zm5.9 4.5a4.4 4.4 0 000-8.8c-2.5 0-4.4 2-4.4 4.3 0 2.5 2 4.5 4.4 4.5zm-.8-1.9h-1.2v-5h2.2c.4 0 .9 0 1.3.2s.6.7.6 1.2c0 .6-.3 1.2-.9 1.4l1 2.2h-1.4l-.7-2h-1v2zm0-2.9h1.4c.2-.2.3-.4.3-.7 0-.2-.1-.4-.3-.5-.2-.1-.6 0-.8 0h-.6v1.2zm-443.5-80c-2-.3-3-.3-4.4-.3-11 0-16.6 3.7-16.6 11.2 0 4.6 2.7 7.6 7 7.6 8 0 13.7-7.6 14-18.5zm14.2 33h-16.2l.4-7.7c-5 6-11.5 9-20.4 9-10.6 0-17.8-8.3-17.8-20.3 0-18 12.6-28.5 34.2-28.5 2.2 0 5 .2 8 .5.5-2.4.7-3.5.7-4.8 0-4.9-3.4-6.7-12.5-6.7a64.6 64.6 0 00-20.6 3.3l2.7-16.6c9.7-2.9 16-4 23.3-4 16.7 0 25.6 7.6 25.6 21.8 0 3.8-.6 8.5-1.6 14.6-1.7 10.8-5.3 33.7-5.8 39.4zm-62.2 0h-19.5l11.2-70-25 70h-13.2l-1.7-69.6-11.7 69.6h-18.2l15.2-91.1h28l1.7 51 17.1-51h31.2l-15 91m354.9-33c-2-.2-3-.2-4.4-.2-11 0-16.6 3.7-16.6 11.2 0 4.6 2.7 7.6 7 7.6 8 0 13.7-7.6 14-18.5zm14.2 33h-16.2l.4-7.6c-5 6-11.5 9-20.4 9-10.6 0-17.8-8.3-17.8-20.3 0-18 12.6-28.5 34.2-28.5 2.2 0 5 .2 8 .5.5-2.4.7-3.5.7-4.8 0-4.9-3.4-6.7-12.5-6.7a64.7 64.7 0 00-20.6 3.3l2.7-16.6c9.7-2.9 16-4 23.3-4 16.7 0 25.6 7.6 25.6 21.8 0 3.8-.6 8.5-1.6 14.6-1.7 10.8-5.3 33.7-5.8 39.4zm-220.4-1a44.5 44.5 0 01-14 2.3c-10 0-15.4-5.7-15.4-16.2-.2-3.3 1.4-12 2.6-19.8l8.5-50.5h19.4l-2.3 11.2H339l-2.6 17.8h-11.8c-2.2 14-5.4 31.6-5.5 34 0 3.8 2 5.4 6.7 5.4 2.2 0 4-.2 5.3-.7l-2.6 16.4m59.4-.6c-6.7 2-13.1 3-20 3-21.6 0-32.9-11.3-32.9-33 0-25.3 14.4-44 33.9-44 16 0 26.2 10.5 26.2 26.8 0 5.5-.7 10.8-2.4 18.3H354c-1.3 10.7 5.6 15.2 16.8 15.2 7 0 13.2-1.5 20.2-4.7l-3.2 18.4zm-11-43.9c.2-1.5 2.1-13.2-9-13.2-6.1 0-10.5 4.7-12.3 13.2h21.4zm-123.3-5c0 9.4 4.5 15.8 14.8 20.7 7.9 3.7 9.1 4.8 9.1 8.2 0 4.6-3.5 6.7-11.2 6.7-5.8 0-11.2-1-17.4-3l-2.7 17.1c4.4 1 8.4 1.9 20.3 2.2 20.5 0 30-7.8 30-24.7 0-10.2-4-16.2-13.7-20.7-8.2-3.7-9.1-4.5-9.1-8 0-4 3.2-6 9.5-6 3.8 0 9 .4 14 1l2.8-17.1c-5-.8-12.7-1.5-17.2-1.5-21.8 0-29.3 11.4-29.2 25.1m229-23.1c5.5 0 10.5 1.4 17.5 5l3.2-19.8c-2.9-1.2-13-7.7-21.5-7.7-13 0-24 6.4-31.8 17.1-11.3-3.7-16 3.8-21.6 11.4l-5.1 1.1c.4-2.4.7-4.9.6-7.4H406c-2.4 23-6.8 46.1-10.2 69l-.8 5h19.5c3.2-21 5-34.6 6-43.8l7.4-4c1.1-4.2 4.5-5.5 11.4-5.4-.9 5-1.4 10.1-1.3 15.2 0 24.2 13 39.3 34 39.3 5.4 0 10-.7 17.2-2.6l3.5-20.8a37.9 37.9 0 01-16.6 4.7c-11.3 0-18.2-8.4-18.2-22.2 0-20 10.2-34.1 24.8-34.1" ] []
        -- , Svg.path [ SA.d "M647.5 211.6l-4.3 26.3c-5.3-7-11-12-18.6-12-9.8 0-18.8 7.4-24.7 18.3-8.1-1.6-16.5-4.5-16.5-4.5.6-6 .9-9.8.8-11.1h-17.9c-2.4 23-6.8 46.1-10.1 69l-1 5h19.5c2.7-17 4.7-31.2 6.2-42.5 6.6-6 10-11.3 16.7-11-3 7.3-4.7 15.6-4.7 24.1 0 18.5 9.3 30.7 23.5 30.7a23 23 0 0018-8.1l-1 6.8H652l14.8-91h-19.2zm-24.4 74c-6.6 0-10-5-10-14.7 0-14.5 6.3-24.8 15.2-24.8 6.7 0 10.3 5 10.3 14.5 0 14.7-6.4 25-15.4 25z" ] []
        , Svg.path [ SA.fill "#fff", SA.d "M185.2 297.2h-19.5l11.2-70-25 70h-13.2l-1.7-69.5-11.7 69.5h-18.2l15.2-91h28l.8 56.4 19-56.4h30.2l-15 91" ] []
        , Svg.path [ SA.fill "#fff", SA.d "M233.2 264.3c-2-.3-3-.3-4.4-.3-11 0-16.6 3.7-16.6 11.2 0 4.6 2.7 7.6 7 7.6 8 0 13.7-7.6 14-18.5zm14.2 33h-16.2l.4-7.7c-5 6-11.5 9-20.4 9-10.6 0-17.8-8.3-17.8-20.3 0-18 12.6-28.5 34.2-28.5 2.2 0 5 .2 8 .5.5-2.4.7-3.5.7-4.8 0-4.9-3.4-6.7-12.5-6.7a65 65 0 00-20.6 3.3l2.7-16.6c9.7-2.9 16-4 23.3-4 16.7 0 25.6 7.6 25.6 21.8 0 3.8-.6 8.5-1.6 14.6-1.7 10.8-5.3 33.8-5.8 39.3zm261.3-88.6l-3.1 19.7c-7-3.5-12-4.9-17.5-4.9-14.5 0-24.7 14-24.7 34.1 0 13.8 6.9 22.2 18.2 22.2 4.8 0 10-1.5 16.5-4.7l-3.4 20.8c-7.2 2-11.8 2.6-17.2 2.6-21 0-34-15-34-39.3 0-32.5 18-55.3 43.8-55.3 8.5 0 18.6 3.6 21.4 4.8m31.5 55.6c-2-.3-3-.3-4.4-.3-11 0-16.6 3.7-16.6 11.2 0 4.6 2.7 7.6 7 7.6 8 0 13.7-7.6 14-18.5zm14.2 33h-16.2l.4-7.7c-5 6-11.5 9-20.4 9-10.6 0-17.8-8.3-17.8-20.3 0-18 12.6-28.5 34.2-28.5 2.2 0 5 .2 8 .5.5-2.4.7-3.5.7-4.8 0-4.9-3.4-6.7-12.5-6.7a65.1 65.1 0 00-20.6 3.3l2.7-16.6c9.7-2.9 16-4 23.3-4 16.7 0 25.6 7.6 25.6 21.8a94 94 0 01-1.6 14.6c-1.7 10.8-5.3 33.8-5.8 39.3zM334 296a44.6 44.6 0 01-14 2.4c-10 0-15.4-5.7-15.4-16.2-.2-3.3 1.4-12 2.7-19.8 1-6.9 8.4-50.5 8.4-50.5h19.4l-2.3 11.2h10L340 241h-10c-2.2 14-5.4 31.6-5.5 34 0 3.8 2 5.4 6.7 5.4 2.2 0 4-.2 5.3-.7l-2.6 16.4m59.4-.6c-6.7 2-13.1 3-20 3-21.6 0-32.9-11.3-32.9-33 0-25.3 14.4-44 33.9-44 16 0 26.2 10.5 26.2 26.8 0 5.5-.7 10.8-2.4 18.3h-38.6c-1.3 10.7 5.6 15.2 16.9 15.2 6.9 0 13.1-1.5 20-4.7l-3.1 18.4zm-11-43.9c.2-1.5 2.1-13.2-9-13.2-6.1 0-10.5 4.7-12.3 13.2h21.4zm-123.3-5c0 9.4 4.5 15.8 14.8 20.7 7.9 3.7 9.1 4.8 9.1 8.2 0 4.6-3.5 6.7-11.2 6.7a55 55 0 01-17.4-3l-2.7 17.1c4.4 1 8.4 1.9 20.3 2.2 20.5 0 30-7.8 30-24.7 0-10.2-4-16.2-13.7-20.7-8.2-3.7-9.1-4.5-9.1-8 0-4 3.2-6 9.5-6 3.8 0 9 .4 14 1l2.8-17.1a132 132 0 00-17.2-1.5c-21.8 0-29.3 11.4-29.2 25.1m398.4 50.6h-18.4l.9-6.8a23 23 0 01-18 8.1c-14.1 0-23.5-12.2-23.5-30.7 0-24.6 14.5-45.4 31.7-45.4 7.6 0 13.3 3.1 18.6 10.1l4.3-26.3h19.3l-14.9 91zm-28.7-17c9 0 15.4-10.3 15.4-25 0-9.4-3.6-14.5-10.3-14.5-8.8 0-15.1 10.3-15.1 24.8 0 9.7 3.3 14.6 10 14.6zm-56.9-57c-2.4 23-6.8 46.1-10.1 69l-1 5h19.6c7-45.2 8.6-54 19.5-53 1.8-9.2 5-17.3 7.4-21.4-8.1-1.7-12.7 2.9-18.6 11.6.4-3.8 1.3-7.4 1.1-11.2H572m-160.4 0c-2.4 23-6.8 46.1-10.2 69l-.9 5H420c7-45.2 8.7-54 19.6-53 1.8-9.2 5-17.3 7.4-21.4-8.1-1.7-12.7 2.9-18.7 11.6.5-3.8 1.4-7.4 1.2-11.2h-17.9m254.6 68.2a5.8 5.8 0 1111.6 0 5.8 5.8 0 01-11.6 0zm5.8 4.5a4.4 4.4 0 000-8.8 4.4 4.4 0 000 8.8zm-.8-2h-1.2v-5h2.2c.4 0 .9 0 1.2.3.5.2.7.7.7 1.2 0 .6-.3 1.1-.9 1.3l1 2.3h-1.4l-.7-2h-1v2zm0-2.8h.6l.8-.1c.2-.1.3-.4.3-.6 0-.2-.2-.4-.3-.5-.2-.1-.6 0-.8 0h-.6v1.2z" ] []
        ]


{-| -}
cardDiscover : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
cardDiscover attrs size =
    -- From https://github.com/aaronfagan/svg-credit-card-payment-icons
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 780 500"
        size
        [ Svg.path [ SA.fill "#4D4D4D", SA.d "M55 0C25 0 0 25 0 55v391c0 30 25 55 55 55h670c30 0 55-25 55-55V55c0-30-25-55-55-55H55z" ] []
        , Svg.path [ SA.fill "#FFF", SA.d "M327 162c9 0 16 2 25 6v23c-8-8-16-11-25-11-20 0-35 15-35 34 0 20 15 34 36 34 9 0 16-3 24-11v23c-9 4-16 6-25 6-32 0-56-23-56-52s25-52 56-52zm-97 1c12 0 22 3 31 11l-11 13c-5-6-10-8-16-8-9 0-16 4-16 11 0 5 4 8 16 12 24 8 31 15 31 31 0 19-15 33-37 33-15 0-27-6-36-19l13-12c5 8 13 13 23 13 9 0 15-6 15-14 0-4-2-8-6-10l-14-6c-19-6-26-13-26-27 0-16 14-28 33-28zm235 1h22l28 67 29-67h22l-45 102h-12l-44-102zm-398 0h31c33 0 56 21 56 50 0 15-7 29-19 38-10 8-22 12-38 12H67V164zm97 0h20v100h-20V164zm411 0h59v17h-38v22h36v17h-36v27h38v17h-59V164zm72 0h31c23 0 37 11 37 30 0 15-9 25-24 28l33 42h-25l-29-40h-2v40h-21V164zm21 16v30h6c13 0 20-5 20-15s-7-15-20-15h-6zm-580 1v66h5c14 0 22-3 29-8 7-6 11-16 11-25 0-10-4-19-11-25s-15-8-29-8h-5z" ] []
        , Svg.path [ SA.fill "#F47216", SA.d "M415 161c31 0 56 24 56 53s-25 53-56 53-56-24-56-53 25-53 56-53zm365 127c-26 19-221 150-559 213h504c30 0 55-25 55-55V288z" ] []
        ]


{-| -}
cardJCB : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
cardJCB attrs size =
    -- From https://github.com/aaronfagan/svg-credit-card-payment-icons
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 780 500"
        size
        [ Svg.path [ SA.fill "#0E4C96", SA.d "M40 0h700c22 0 40 18 40 40v420c0 22-18 40-40 40H40c-22 0-40-18-40-40V40C0 18 18 0 40 0z" ] []
        , Svg.path [ SA.fill "#fff", SA.d "M632 361c0 42-33 76-75 76H148V139c0-42 33-76 75-76h409v298z" ] []
        , Svg.linearGradient [ SA.id "a", SA.x1 "84", SA.x2 "85", SA.y1 "645.5", SA.y2 "645.5", SA.gradientTransform "matrix(132.87 0 0 -323.02 -10686 208760)", SA.gradientUnits "userSpaceOnUse" ]
            [ Svg.stop [ SA.offset "0", SA.stopColor "#007B40" ] []
            , Svg.stop [ SA.offset "1", SA.stopColor "#55B330" ] []
            ]
        , Svg.path [ SA.fill "url(#a)", SA.d "M499 257h35c12 2 15 20 4 26-7 4-16 1-23 2h-16v-28zm42-33c2 10-7 18-15 17h-27v-27l32 1c5 1 9 5 10 9zm64-136v272c0 27-24 51-51 51l-81 1V302h88c14-1 29-10 29-25 2-15-12-26-26-28-5 0-5-1 0-2 13-2 23-16 19-29-3-14-18-20-31-20h-79v-61c2-27 27-49 53-49h79z" ] []
        , Svg.linearGradient [ SA.id "b", SA.x1 "84", SA.x2 "85", SA.y1 "645.5", SA.y2 "645.5", SA.gradientTransform "matrix(133.43 0 0 -323.02 -11031 208760)", SA.gradientUnits "userSpaceOnUse" ]
            [ Svg.stop [ SA.offset "0", SA.stopColor "#1D2970" ] []
            , Svg.stop [ SA.offset "1", SA.stopColor "#006DBA" ] []
            ]
        , Svg.path [ SA.fill "url(#b)", SA.d "M175 140c0-28 25-51 52-51l80-1v273c-1 27-25 50-51 50l-81 1V298c26 6 53 9 80 5 16-3 34-11 39-27 4-14 2-29 2-44v-34h-46v67c-2 14-15 23-28 22-16 1-48-11-48-11l1-136z" ] []
        , Svg.linearGradient [ SA.id "c", SA.x1 "84", SA.x2 "85", SA.y1 "645.5", SA.y2 "645.5", SA.gradientTransform "matrix(132.96 0 0 -323.03 -10842 208770)", SA.gradientUnits "userSpaceOnUse" ]
            [ Svg.stop [ SA.offset "0", SA.stopColor "#6E2B2F" ] []
            , Svg.stop [ SA.offset "1", SA.stopColor "#E30138" ] []
            ]
        , Svg.path [ SA.fill "url(#c)", SA.d "M325 212c-3 0-1-8-1-12v-63c2-27 27-49 54-49h78v273c-1 27-25 50-51 50l-81 1V287c18 15 43 18 66 18 17 0 35-3 51-7v-23c-19 10-41 16-62 10-14-3-25-18-25-33-2-15 8-32 23-37 19-6 40-1 58 7 4 2 8 4 6-2v-18c-30-7-62-10-92-2-9 2-17 6-24 12z" ] []
        ]


{-| -}
cardAmericanExpress : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
cardAmericanExpress attrs size =
    -- From https://github.com/aaronfagan/svg-credit-card-payment-icons
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 780 500"
        size
        [ Svg.path [ SA.fill "#2557D6", SA.d "M40 0h700c22 0 40 18 40 40v420c0 22-18 40-40 40H40c-22 0-40-18-40-40V40C0 18 18 0 40 0z" ] []
        , Svg.path [ SA.fill "#fff", SA.d "M0 236h38l8-20h19l8 20h74v-15l7 15h38l7-15v15h183v-32h3c3 0 3 0 3 4v28h95v-8c8 4 19 8 35 8h40l8-20h19l9 20h76v-19l12 19h62V113h-61v15l-9-15h-62v15l-8-15h-84c-15 0-27 2-37 7v-7h-58v7c-7-5-15-7-25-7H187l-14 32-15-32H91v15l-7-15H27L0 171v65zm237-18h-23v-69l-32 69h-19l-32-69v69H87l-9-20H33l-9 20H0l39-88h33l37 83v-83h36l29 60 26-60h37v88zM71 180l-15-35-15 35h30zm255 38h-73v-88h73v18h-51v16h50v18h-50v18h51v18zm103-64c0 14-10 21-15 23 5 2 9 5 11 8 3 4 3 8 3 16v17h-22v-11c0-5 1-13-3-17-4-3-9-4-16-4h-24v32h-22v-88h51c11 0 19 0 26 4s11 10 11 20zm-28 13c-3 2-6 2-10 2h-27v-20h27c4 0 8 0 10 2 3 1 5 4 5 8 0 3-2 6-5 8zm63 51h-22v-88h22v88zm260 0h-31l-42-66v66h-44l-9-20h-45l-9 20h-25c-11 0-24-2-32-10-8-7-12-17-12-33 0-13 3-25 12-35 7-7 18-10 33-10h22v19h-21c-8 0-13 1-17 5s-6 11-6 20c0 10 2 16 6 21 3 3 9 4 15 4h10l31-69h32l38 83v-83h33l38 61v-61h23v88zm-133-38l-16-35-15 35h31zm189 178c-6 8-16 12-30 12h-42v-19h42l9-2 2-6-2-6-8-2c-21-1-46 1-46-27 0-13 8-26 31-26h44v-18h-41c-12 0-21 3-27 7v-7h-60c-10 0-21 2-26 7v-7H518v7c-8-6-22-7-29-7h-71v7c-7-6-22-7-31-7h-79l-18 19-17-19H155v123h116l19-19 17 19h72v-29h7c9 0 20 0 30-4v33h59v-32h3c4 0 4 0 4 3v29h179c11 0 23-3 30-8v8h57c11 0 23-2 32-6v-23zm-355-47c0 25-19 30-38 30h-28v29h-42l-27-29-28 29h-87v-88h88l27 29 28-29h70c17 0 37 5 37 29zm-174 41h-54v-18h48v-18h-48v-16h55l24 26-25 26zm86 10l-33-36 33-35v71zm50-39h-28v-23h28c8 0 14 3 14 11s-5 12-14 12zm148-41h74v18h-52v16h50v18h-50v18h52v18h-74v-88zm-28 47c5 2 9 5 11 8 3 4 4 8 4 16v17h-22v-11c0-5 0-13-4-17-3-3-8-4-16-4h-23v32h-22v-88h50c11 0 19 1 27 4 7 4 11 10 11 20 0 14-10 21-16 23zm-12-11c-3 2-7 2-11 2h-26v-20h27c3 0 7 0 10 2 3 1 4 4 4 8 0 3-1 6-4 8zm198 6c4 4 6 9 6 18 0 19-12 28-34 28h-43v-19h43c4 0 7 0 9-2a8 8 0 000-12l-8-1c-21-1-46 0-46-28 0-12 8-26 31-26h44v19h-40l-9 1c-2 2-3 4-3 7s2 5 4 6l9 1 12 1c12 0 20 2 25 7zm87-24h-40c-4 0-7 0-9 2-2 1-3 3-3 6s2 6 5 7l8 1h12c12 0 20 2 25 7l2 2v-25z" ] []
        ]


{-| -}
cardDiners : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
cardDiners attrs size =
    -- From https://github.com/aaronfagan/svg-credit-card-payment-icons
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 780 500"
        size
        [ Svg.path [ SA.fill "#0079BE", SA.d "M40 0h700c22 0 40 18 40 40v420c0 22-18 40-40 40H40c-22 0-40-18-40-40V40C0 18 18 0 40 0z" ] []
        , Svg.path [ SA.fill "#fff", SA.d "M600 251.4c0-99.4-83-168-174-168h-78.2c-92 0-167.7 68.7-167.7 168 0 91 75.7 165.7 167.7 165.2H426c91 .5 174-74.2 174-165.2z" ] []
        , Svg.path [ SA.fill "#0079BE", SA.d "M348.3 97.4c-84 0-152.2 68.3-152.2 152.6s68.1 152.5 152.2 152.6c84 0 152.2-68.3 152.2-152.6S432.4 97.5 348.3 97.4z" ] []
        , Svg.path [ SA.fill "#fff", SA.d "M252 249.6a96.9 96.9 0 0162-90.3v180.5a96.8 96.8 0 01-62-90.2zm131 90.3V159.3a96.8 96.8 0 010 180.6z" ] []
        ]
