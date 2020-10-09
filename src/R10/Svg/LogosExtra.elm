module R10.Svg.LogosExtra exposing (apple, apple_monochrome, elm, elm_monocrome, facebook, facebook_monochrome, github, google, google_monochrome, microsoft, microsoft_monochrome, pcHome24hours, pcHome24hours_monochrome)

{-|

@docs apple, apple_monochrome, elm, elm_monocrome, facebook, facebook_monochrome, github, google, google_monochrome, microsoft, microsoft_monochrome, pcHome24hours, pcHome24hours_monochrome

-}

import Element
import Html.Attributes
import R10.Svg exposing (wrapperWithViewbox)
import Svg
import Svg.Attributes as SA


{-| -}
elm : Int -> Element.Element msg
elm size =
    elm_monocrome "#1293d8" size


{-| -}
elm_monocrome : String -> Int -> Element.Element msg
elm_monocrome color size =
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
    wrapperWithViewbox
        "-300 -300 600 600"
        size
        [ Svg.g
            [ SA.transform "scale(1 -1)" ]
            [ poly color "-280,-90 0,190 280,-90" data.p1
            , poly color "-280,-90 0,190 280,-90" data.p2
            , poly color "-198,-66 0,132 198,-66" data.p3
            , poly color "-130,0 0,-130 130,0 0,130" data.p4
            , poly color "-191,61 69,61 191,-61 -69,-61" data.p5
            , poly color "-130,-44 0,86  130,-44" data.p6
            , poly color "-130,-44 0,86  130,-44" data.p7
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
microsoft_ : String -> String -> String -> String -> Int -> Element.Element msg
microsoft_ cl1 cl2 cl3 cl4 size =
    wrapperWithViewbox "0 0 21 21"
        size
        [ Svg.path [ SA.fill cl1, SA.d "M1 1h9v9H1z" ] []
        , Svg.path [ SA.fill cl2, SA.d "M1 11h9v9H1z" ] []
        , Svg.path [ SA.fill cl3, SA.d "M11 1h9v9h-9z" ] []
        , Svg.path [ SA.fill cl4, SA.d "M11 11h9v9h-9z" ] []
        ]


{-| -}
microsoft : Int -> Element.Element msg
microsoft size =
    microsoft_ "#f25022" "#00a4ef" "#7fba00" "#ffb900" size


{-| -}
microsoft_monochrome : String -> Int -> Element.Element msg
microsoft_monochrome cl size =
    microsoft_ cl cl cl cl size


{-| -}
google_ : String -> String -> String -> String -> Int -> Element.Element msg
google_ cl1 cl2 cl3 cl4 size =
    wrapperWithViewbox "4 4 17 17"
        size
        [ Svg.path [ SA.fill cl1, SA.d "M20.66 12.693c0-.603-.054-1.182-.155-1.738H12.5v3.287h4.575a3.91 3.91 0 0 1-1.697 2.566v2.133h2.747c1.608-1.48 2.535-3.65 2.535-6.24z" ] []
        , Svg.path [ SA.fill cl2, SA.d "M12.5 21c2.295 0 4.22-.76 5.625-2.06l-2.747-2.132c-.76.51-1.734.81-2.878.81-2.214 0-4.088-1.494-4.756-3.503h-2.84v2.202A8.498 8.498 0 0 0 12.5 21z" ] []
        , Svg.path [ SA.fill cl3, SA.d "M7.744 14.115c-.17-.51-.267-1.055-.267-1.615s.097-1.105.267-1.615V8.683h-2.84A8.488 8.488 0 0 0 4 12.5c0 1.372.328 2.67.904 3.817l2.84-2.202z" ] []
        , Svg.path [ SA.fill cl4, SA.d "M12.5 7.38c1.248 0 2.368.43 3.25 1.272l2.437-2.438C16.715 4.842 14.79 4 12.5 4a8.497 8.497 0 0 0-7.596 4.683l2.84 2.202c.668-2.01 2.542-3.504 4.756-3.504z" ] []
        ]


{-| -}
google : Int -> Element.Element msg
google size =
    google_ "#4285F4" "#34A853" "#FBBC05" "#EA4335" size


{-| -}
google_monochrome : String -> Int -> Element.Element msg
google_monochrome cl size =
    google_ cl cl cl cl size


{-| -}
facebook : Int -> Element.Element msg
facebook size =
    facebook_monochrome "#3b5998" size


{-| -}
facebook_monochrome : String -> Int -> Element.Element msg
facebook_monochrome cl size =
    wrapperWithViewbox "4 4 17 17"
        size
        [ Svg.path [ SA.fill cl, SA.fillRule "evenodd", SA.d "M20.292 4H4.709A.709.709 0 0 0 4 4.708v15.584c0 .391.317.708.709.708h8.323v-6.375h-2.125v-2.656h2.125V9.844c0-2.196 1.39-3.276 3.348-3.276.938 0 1.745.07 1.98.1v2.295h-1.358c-1.066 0-1.314.507-1.314 1.25v1.756h2.656l-.531 2.656h-2.125L15.73 21h4.562a.708.708 0 0 0 .708-.708V4.708A.708.708 0 0 0 20.292 4" ] []
        ]


{-| -}
apple : Int -> Element.Element msg
apple size =
    apple_monochrome "#555" size


{-| -}
apple_monochrome : String -> Int -> Element.Element msg
apple_monochrome cl size =
    wrapperWithViewbox "-80 0 1187.2 1187.2"
        size
        [ Svg.path [ SA.fill cl, SA.d "M979 925c-18 42-39 80-64 115-33 48-61 81-82 99-33 31-68 46-106 47-27 0-59-8-97-23-38-16-73-24-105-24-34 0-70 8-108 24-39 15-70 23-94 24-36 2-72-14-108-48A712 712 0 010 640c0-79 17-148 52-205a303 303 0 01254-151c29 0 66 9 113 27 47 17 77 26 90 26 9 0 43-10 99-31 53-19 98-27 135-24 100 8 175 47 225 118a250 250 0 00-133 227c1 76 29 139 83 189 24 23 52 41 82 54l-21 55zM750 24c0 59-22 115-65 166-52 61-115 96-184 91l-1-23c0-57 25-118 69-168 22-25 50-46 84-63 34-16 66-25 96-27l1 24z" ] []
        ]


{-| -}
pcHome24hours : Int -> Element.Element msg
pcHome24hours size =
    pcHome24hours_ False "#d7000f" "#b81c22" "#ffffff" size


{-| -}
pcHome24hours_monochrome : String -> Int -> Element.Element msg
pcHome24hours_monochrome cl size =
    pcHome24hours_ True "" "" cl size


{-| -}
pcHome24hours_ : Bool -> String -> String -> String -> Int -> Element.Element msg
pcHome24hours_ isMonochrome cl1 cl2 cl3 size =
    wrapperWithViewbox "0 0 430.9 430.9"
        size
        ([]
            ++ (if isMonochrome then
                    []

                else
                    [ Svg.linearGradient [ SA.id "SVGID_1_", SA.x1 "59.3", SA.x2 "390.8", SA.y1 "46", SA.y "407.2", SA.gradientUnits "userSpaceOnUse" ]
                        [ Svg.stop [ SA.offset ".3", SA.stopColor cl1 ] []
                        , Svg.stop [ SA.offset ".9", SA.stopColor cl2 ] []
                        ]
                    , Svg.path [ SA.fill "url(#SVGID_1_)", SA.d "M430.2 364.7a66.1 66.1 0 0 1-66.1 66.1H66.4A66.1 66.1 0 0 1 .3 364.7V67.1A66.1 66.1 0 0 1 66.4 1H364a66.1 66.1 0 0 1 66.1 66.1v297.6z" ] []
                    ]
               )
            ++ [ Svg.path [ SA.fill cl3, SA.d "M81.1 319.7L40.8 394l118.4 1.8 50-94.4zM349.4 319.7l40.3 74.3-118.5 1.8-49.9-94.4z" ] []
               , Svg.path [ SA.fill cl3, SA.d "M265.2 402l-50-97.5-49.9 97.5H83.1v24.7H347.4V402z" ] []
               , Svg.path [ SA.fill cl3, SA.d "M405.6 222H276l1.9-7.2h129.6zM401.6 236.5H272l2-7.3h129.6zM397.8 250.9H268.2l1.9-7.2h129.6zM126.2 151.5c.7-2.5.5-4.3-.4-5.4-.9-1.1-2.6-1.7-5.2-1.7-2.7 0-4.8.5-6.2 1.5-1.4 1-2.4 2.9-3.2 5.5l-4.5 18.5H62.9l1.9-8.9a44.9 44.9 0 0 1 19.7-28.6c9.5-5.6 23.6-8.4 42.2-8.4 17.4 0 29.7 2.7 36.9 8.2 7.1 5.5 9.2 13.8 6.3 24.9-3.5 13-18.7 29.9-45.6 50.9l-11.9 9.4c-9.7 7.7-19 15.9-22.6 20.7-3 4.1-4.3 7.1-4.3 7.1h61.1l-6.8 25.3H35.1l6.3-23.6a46.6 46.6 0 0 1 9.5-17.5c4.8-5.8 13.4-13.6 25.9-23.5l12.1-9.3c21.2-16.4 32.6-27.8 34.3-34.1l3-11z" ] []
               , Svg.path [ SA.fill cl3, SA.d "M197.3 270.7l9.2-34.3h-63.6l5.8-21.6 63.4-87.6h60.3l-21.6 80.3-36.2.1 19.9-57.4h-4.3l-42.4 64.6h82.4l-5.8 21.6h-21.3l-9.2 34.3zM279.8 207.5l21.5-80.3h39.1l-10.3 38.5h.6c4-4 8.5-7 13.6-8.9 5-1.9 10.7-2.9 17.1-2.9 8.5 0 14.5 1.6 17.9 4.9 3.4 3.3 4.2 8.2 2.5 14.7l-9.1 34h-39.4l6.9-25.6c.7-2.6.7-4.4-.2-5.4-.8-.9-2.5-1.4-5.2-1.4-2.4 0-4.4.5-5.8 1.6a8.7 8.7 0 0 0-3.1 5.1l-6.9 25.6h-39.2z" ] []
               ]
        )


{-| -}
github : String -> Int -> Element.Element msg
github cl size =
    wrapperWithViewbox "4.5 4.5 44 44"
        size
        [ Svg.path [ SA.fill "none", SA.d "M-.2.1h53.8v53.4H-.2z" ] []
        , Svg.path [ SA.fill cl, SA.d "M15.9 7.7a21.3 21.3 0 0121.6 0 21.3 21.3 0 016.6 31.2 20.5 20.5 0 01-10.6 7.7c-.5.1-.9 0-1.1-.2-.2-.2-.4-.5-.4-.8v-2.1-3.8c0-1.8-.5-3.1-1.5-4l2.9-.5c.8-.2 1.7-.6 2.6-1.1.9-.5 1.7-1.1 2.3-1.9.6-.7 1.1-1.7 1.5-2.9s.6-2.6.6-4.2a8 8 0 00-2.2-5.7c.7-1.7.6-3.6-.2-5.7-.5-.2-1.3-.1-2.3.3l-2.6 1.2-1.1.7a20 20 0 00-10.8 0l-1.2-.8a17 17 0 00-2.3-1.1c-1.1-.4-1.9-.5-2.4-.4-.8 2.1-.9 4-.2 5.7a8.8 8.8 0 00-2.1 5.8c0 1.6.2 3 .6 4.2a8.2 8.2 0 003.7 4.8c.9.5 1.8.9 2.6 1.1l2.9.5a5 5 0 00-1.4 2.9 5 5 0 01-1.3.4l-1.6.1c-.6 0-1.2-.2-1.8-.6a5 5 0 01-1.5-1.7 5 5 0 00-1.4-1.5c-.5-.4-1-.6-1.4-.7l-.6-.1-.8.1c-.1.1-.2.2-.1.3l.3.4.4.3.2.1c.4.2.8.5 1.2 1.1l.9 1.4.3.6c.2.7.7 1.3 1.2 1.7.6.4 1.2.7 1.9.8l1.9.2 1.5-.1.6-.1v4c0 .3-.1.6-.4.8-.2.2-.6.3-1.1.2A21.4 21.4 0 018 15.2c2-3 4.6-5.6 7.9-7.5zm-2.6 27.9c.1-.1 0-.2-.2-.3-.2-.1-.3 0-.4.1-.1.1 0 .2.2.3.2.1.4.1.4-.1zm.9 1c.1-.1.1-.2-.1-.4s-.3-.2-.4-.1c-.1.1-.1.2.1.4.1.2.3.2.4.1zm.8 1.2c.2-.1.2-.3 0-.5-.1-.2-.3-.3-.5-.2-.2.1-.2.3 0 .5s.4.3.5.2zm1.2 1.2c.1-.1.1-.3-.1-.5s-.4-.3-.6-.1c-.2.1-.1.3.1.5.3.2.5.2.6.1zm1.6.7c.1-.2-.1-.4-.4-.4-.3-.1-.5 0-.5.2-.1.2 0 .3.4.4.2.1.4 0 .5-.2zm1.8.1c0-.2-.2-.3-.5-.3s-.4.1-.4.3c0 .2.2.3.5.3.2 0 .4-.1.4-.3zm1.6-.3c0-.2-.2-.3-.5-.3-.3.1-.4.2-.4.4s.2.3.5.2c.3.1.4-.1.4-.3z" ] []
        ]
