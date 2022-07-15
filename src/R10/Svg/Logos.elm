module R10.Svg.Logos exposing (authenticator, authenticator_monochrome, r, rakuten, rakutenMarketing, rakutenRagri, rakutenReady, barcelona)

{-|

@docs authenticator, authenticator_monochrome, r, rakuten, rakutenMarketing, rakutenRagri, rakutenReady, barcelona

-}

import Element.WithContext exposing (..)
import R10.Color.Utils
import R10.Context exposing (..)
import R10.Svg.Utils
import Svg
import Svg.Attributes as SA


{-| -}
rakuten : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
rakuten attrs cl size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 166 50"
        size
        [ Svg.path
            [ SA.fill <| R10.Color.Utils.toCssRgba cl
            , SA.d "M41.2 49.4l92.3-8H33.2l8 8zm1.3-14.3v1.2h6.2V9.1h-6.2v1.2a10 10 0 0 0-5.8-1.9c-7 0-12.4 6.4-12.4 14.3S29.6 37 36.7 37c2.3 0 4-.7 5.8-1.9zM30.7 22.7c0-4.3 2.5-7.7 6-7.7s5.9 3.4 5.9 7.7c0 4.3-2.5 7.7-5.9 7.7-3.5 0-6-3.4-6-7.7zm56 14.3c3 0 5.3-1.7 5.3-1.7v1h6.2V9.1H92v16c0 3-2.1 5.5-5.1 5.5s-5.1-2.5-5.1-5.5v-16h-6.2v16c0 6.6 4.5 11.9 11.1 11.9zm68.2-28.6c-3 0-5.3 1.7-5.3 1.7v-1h-6.2v27.2h6.2v-16c0-3 2.1-5.5 5.1-5.5s5.1 2.5 5.1 5.5v16h6.2v-16c0-6.6-4.5-11.9-11.1-11.9zM22.4 14c0-6.5-5.3-11.7-11.7-11.7H0v34h6.5V25.8h4.6L19 36.3h8.1l-9.6-12.7c3-2.1 4.9-5.6 4.9-9.6zm-11.7 5.3H6.5V8.7h4.2c2.9 0 5.3 2.4 5.3 5.3s-2.4 5.3-5.3 5.3zm92.9 8c0 6.1 4.6 9.7 9.2 9.7a13 13 0 0 0 6-1.7l-4-5.4c-.6.4-1.3.7-2.1.7-1 0-2.9-.8-2.9-3.3V15.6h5.3V9.1h-5.3V2.3h-6.2v6.8h-3.3v6.5h3.3v11.7zm-45.1-2.2l9.2 11.2h8.6L64 21.8 74.6 9.1H66l-7.5 9.5V0h-6.3v36.3h6.3V25.1zm70.6-16.7c-7.2 0-12.3 6.3-12.3 14.3 0 8.4 6.4 14.3 12.9 14.3 3.3 0 7.4-1.1 10.9-6.1l-5.5-3.2c-4.2 6.2-11.3 3.1-12.1-3.2h17.8c1.7-9.7-4.7-16.1-11.7-16.1zm-5.7 10.8c1.3-6.4 9.9-6.8 11.1 0h-11.1z"
            ]
            []
        ]


{-| -}
r : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
r attrs cl size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "7 4.6 22 22"
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M10.86 26.27L8 23.88h20l-17.14 2.39zM14.1 22.09v-5.3h2.29l3.97 5.3h4.06l-4.8-6.4A5.9 5.9 0 0 0 16.2 5h-5.36v17.08h3.24zm0-13.85h2.11a2.65 2.65 0 1 1 0 5.3H14.1v-5.3z" ] []
        ]


{-| -}
rakutenMarketing : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
rakutenMarketing attrs cl size =
    -- Default color "#fff"
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 400 56"
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M149.259 46.355H37.757l8.883 8.883 102.619-8.883zM41.617 34.144c-3.852 0-6.672-3.793-6.672-8.584 0-4.788 2.82-8.582 6.672-8.582 3.856 0 6.574 3.794 6.574 8.582 0 4.791-2.718 8.584-6.574 8.584zm6.469-23.714v1.344c-2.07-1.32-3.927-2.086-6.47-2.086-7.811 0-13.746 7.123-13.746 15.872 0 8.75 5.935 15.87 13.747 15.87 2.542 0 4.399-.764 6.469-2.086v1.342h6.867V10.43h-6.867zM103.092 10.43v17.774c0 3.334-2.29 6.15-5.626 6.15-3.333 0-5.625-2.816-5.625-6.15V10.43h-6.867v17.774c0 7.293 4.99 13.225 12.283 13.225 3.377 0 5.835-1.868 5.835-1.868v1.125h6.867V10.43h-6.867zM167.077 40.686V22.913c0-3.334 2.29-6.15 5.626-6.15 3.333 0 5.625 2.816 5.625 6.15v17.773h6.867V22.913c0-7.293-4.988-13.225-12.282-13.225-3.378 0-5.836 1.867-5.836 1.867V10.43h-6.868v30.256h6.868z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M8.079 10.067h4.687c3.225 0 5.862 2.623 5.862 5.855a5.868 5.868 0 0 1-5.862 5.862H8.079V10.067zm0 30.62V28.963h5.08l8.794 11.722h8.99L20.316 26.542c3.312-2.376 5.487-6.242 5.487-10.62 0-7.19-5.847-13.031-13.037-13.031H.898v37.795h7.18zM128.467 33.527c-.616.419-1.395.744-2.296.744-1.122 0-3.238-.857-3.238-3.711V17.612h5.872V10.43h-5.872V2.89h-6.866v7.54h-3.633v7.182h3.633v13.052c-.002 6.756 5.088 10.791 10.209 10.791 1.908 0 4.556-.624 6.717-1.904l-4.526-6.024zM72.024 24.613l11.78-14.183h-9.627L65.94 20.971V.391h-7.071v40.295h7.071V28.258l10.128 12.428h9.62L72.025 24.613z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M150.323 21.653h-12.368c1.445-7.087 11.029-7.492 12.368 0zm-5.995-11.99c-7.948 0-13.648 6.983-13.648 15.895 0 9.37 7.155 15.898 14.331 15.898 3.621 0 8.262-1.242 12.16-6.772l-6.064-3.502c-4.691 6.913-12.508 3.404-13.411-3.51l19.78.005c1.692-10.867-5.335-18.014-13.148-18.014M226.188 4.78v35.906h-4.104V9.936L211.361 27.41 200.64 9.936v30.75h-4.107V4.781h5.522l9.306 15.375 9.307-15.375h5.52zM233.685 26.315c0 6.524 3.56 11.269 8.396 11.269 4.835 0 8.348-4.699 8.348-11.223 0-6.57-3.513-11.27-8.394-11.27-4.79 0-8.35 4.792-8.35 11.224zm16.426 11.223c-2.236 2.647-4.791 3.878-8.122 3.878-7.528 0-12.684-6.159-12.684-15.1 0-8.943 5.202-15.056 12.776-15.056 3.42 0 5.794 1.003 8.074 3.376l.594-2.693h3.65v28.743h-3.65l-.638-3.148zM262.755 14.727c1.46-1.78 4.837-3.193 8.166-3.467v3.832c-4.516.547-7.984 3.285-7.984 6.341v19.253h-4.104V11.944h3.512l.41 2.783zM290.987 40.686l-12.547-15.1v15.1h-4.107V2.41h4.107v21.807l11.361-12.273H295l-12.18 13.14 13.869 15.603h-5.702z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M315.811 23.714c-.366-5.292-3.468-8.76-7.711-8.76-2.828 0-5.383 1.507-6.889 4.015-.822 1.415-1.232 2.647-1.46 4.745h16.06zm4.333 11.726c-2.464 3.878-6.479 5.976-11.541 5.976-7.803 0-13.276-6.25-13.276-15.147 0-8.85 5.2-15.01 12.728-15.01 6.98 0 12.454 6.114 12.454 13.916 0 .775-.045 1.368-.182 2.235h-20.622c.228 3.33 1.095 5.566 2.92 7.528 1.643 1.779 3.787 2.783 5.978 2.783 3.648 0 6.66-1.78 8.165-4.836l3.376 2.555zM330.224 5.648v6.295h7.209v3.833h-7.209v19.07c0 1.78 1.004 2.738 2.92 2.738 1.597 0 2.509-.547 3.467-2.19l3.102 2.144c-2.052 2.92-3.83 3.878-6.98 3.878-3.148 0-5.154-1.231-6.113-3.832-.365-.958-.501-1.962-.501-3.65V15.776h-4.927v-3.833h4.927V5.648h4.105zM342.784 40.686V11.944h4.105v28.742h-4.105zm-.32-32.3V3.64h4.745v4.744h-4.745zM355.523 14.225c1.732-1.779 4.881-2.965 7.893-2.965 6.159 0 10.356 4.699 10.356 11.542v17.884h-4.107v-17.93c0-4.698-2.646-7.664-6.844-7.664-3.877 0-7.39 3.559-7.39 7.528v18.066h-4.107V11.944h3.651l.548 2.28zM380.96 24.216c0 5.201 3.012 8.851 7.345 8.851 4.426 0 7.438-3.604 7.438-8.85 0-5.292-3.24-9.308-7.483-9.308-4.288 0-7.3 3.833-7.3 9.307zm19.025 10.585c0 8.76-4.197 13.596-11.77 13.596-4.152 0-7.619-1.597-10.266-4.745l2.738-2.6c1.825 2.235 4.7 3.695 7.208 3.695 5.292 0 7.574-3.513 7.756-11.908-1.643 2.51-4.426 3.878-8.075 3.878-6.388 0-10.904-5.11-10.904-12.318 0-7.665 4.699-13.14 11.223-13.14 3.193 0 5.704 1.004 7.665 3.011l.82-2.327h3.605v22.858z" ] []
        ]


{-| -}
rakutenRagri : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
rakutenRagri attrs cl size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 178 32"
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M113.7 23.5v-21h6.6c4.2 0 7.4 3.2 7.4 7.2 0 2.8-1 4.7-3.2 5.7l5.2 8.1h-5l-3.9-6.8h-3v6.8h-4.1zm4-10.5h2.6c1.8 0 3.2-1.6 3.2-3.3 0-2-1.4-3.4-3.2-3.4h-2.6V13zM140.8 22c-1 1.3-2.4 2-4.1 2-4.2 0-7.6-4-7.6-8.8 0-4.8 3.5-8.8 7.8-8.8 1.7 0 2.9.6 3.9 2l.5-1.6h3.5v16.8h-3.5l-.5-1.6zm-7.7-6.9c0 2.8 1.7 5 3.8 5 2.3 0 3.9-2 3.9-5s-1.6-5-3.9-5c-2.1 0-3.8 2.2-3.8 5zM161.5 19.3c0 5.5-2.9 8.7-7.6 8.7a8 8 0 0 1-7-3.6l2.9-2.3c1 1.4 2.4 2.2 3.8 2.2 2.2 0 3.6-1.7 3-5a4.4 4.4 0 0 1-4 2.1c-4 0-7-3.1-7-7.4 0-4.5 3-7.7 7.2-7.7 1.7 0 3.3.6 4.1 1.6l.3-1.2h3.4v12.6h.2zM150.3 14c0 2.2 1.6 3.9 3.6 3.9s3.6-1.8 3.6-4c0-2.1-1.5-3.8-3.6-3.8-2 0-3.6 1.8-3.6 4zM167.4 8.3c1-1.3 2.8-2 4.9-2V10c-1.9.2-3 .7-3.8 2-.4.6-.7 1.5-.7 2.3v9.2H164V6.8h3.2l.3 1.5zM174 5.1v-4h4v4h-4zm0 18.4V6.8h4v16.8h-4zM86.2 26.9H21.4l5.2 5.1 59.6-5.1zM27.4 5.8v.8a6.5 6.5 0 0 0-3.8-1.2c-4.5 0-8 4.1-8 9.2 0 5.2 3.5 9.3 8 9.3 1.5 0 2.6-.5 3.8-1.2v.7h4V5.8h-4zm-3.8 13.9c-2.2 0-3.8-2.2-3.8-5s1.6-5 3.8-5c2.3 0 3.8 2.2 3.8 5 .1 2.8-1.5 5-3.8 5zM59.4 5.8v10.4c0 2-1.4 3.6-3.3 3.6-2 0-3.3-1.7-3.3-3.6V5.8h-4v10.4c0 4.3 2.9 7.7 7.1 7.7 2 0 3.5-1 3.5-1v.5h4V5.8h-4zM96.6 23.5V13.2c0-2 1.3-3.6 3.2-3.6 2 0 3.3 1.6 3.3 3.6v10.3h4V13.2c0-4.3-2.9-7.7-7.1-7.7-2 0-3.4 1-3.4 1v-.7h-4v17.7h4z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M4.2 23.5v-6.8h3l5 6.8h5.2l-6.2-8.2A7.6 7.6 0 0 0 6.8 1.4H0v22h4.2v.1zm0-17.8h2.7c1.9 0 3.4 1.5 3.4 3.4S8.8 12.5 7 12.5H4.2V5.7zM74.2 19.4c-.4.2-.8.5-1.4.5-.6 0-1.8-.5-1.8-2.2V10h3.4V5.8H71V1.4h-4v4.4h-2.1V10h2v7.7c0 4 3 6.3 6 6.3 1.1 0 2.7-.4 3.9-1.1l-2.6-3.5zM41.3 14.2l6.9-8.4h-5.6L37.8 12V0h-4v23.5h4v-7.2l6 7.2h5.5l-8-9.3z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M83.4 5.5c-4.7 0-8 4-8 9.2 0 5.5 4.3 9.3 8.4 9.3 2 0 4.8-.7 7-4l-3.5-2c-2.7 4-7.3 2-7.8-2H91c1-6.4-3.1-10.5-7.6-10.5zm3.5 6.9h-7.2c.8-4.1 6.4-4.4 7.2 0z" ] []
        ]


{-| -}
rakutenReady : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
rakutenReady attrs cl size =
    -- Default color "#05B46E"
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 600 110"
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M362.6 49.3H373c7.6 0 13.3-5.8 13.3-13.6 0-7.7-5.7-13.5-13.3-13.5h-10.3v27zm-7.2 29.6V15.5h17.5C385 15.5 394 24 394 35.7c0 8.6-3.8 14.4-11.6 17.8l15.5 25.4h-9.2L375.8 56h-13.2v23h-7.2zM434.2 49c-.7-9.4-6.2-15.6-13.7-15.6-5 0-9.5 2.7-12.1 7.1a19 19 0 0 0-2.6 8.4h28.4zm7.6 20.7a23 23 0 0 1-20.4 10.5c-13.8 0-23.5-11-23.5-26.7s9.2-26.6 22.6-26.6c12.3 0 22 10.8 22 24.6 0 1.4-.1 2.4-.3 4h-36.5a20 20 0 0 0 5.2 13.3c2.9 3.1 6.7 4.9 10.5 4.9 6.5 0 11.8-3.1 14.5-8.6l6 4.6zM455 53.5c0 11.6 6.3 20 14.9 20 8.5 0 14.8-8.4 14.8-19.9 0-11.6-6.3-20-14.9-20-8.5 0-14.8 8.6-14.8 20zm29 19.9c-3.9 4.7-8.4 6.8-14.3 6.8-13.3 0-22.4-10.9-22.4-26.7 0-15.8 9.2-26.6 22.6-26.6a18 18 0 0 1 14.3 6l1-4.8h6.5V79h-6.5l-1.1-5.5zM505 53.5c0 11.6 6.2 20 14.8 20 8.5 0 14.7-8.4 14.7-19.9 0-11.6-6.2-20-14.8-20-8.5 0-14.8 8.6-14.8 20zm29 19.9c-4 4.7-8.5 6.8-14.4 6.8-13.3 0-22.4-10.9-22.4-26.7 0-15.8 9.2-26.6 22.5-26.6a17 17 0 0 1 14.6 7.4v-23h7.3v67.6H535l-1.1-5.5zM588.9 28.1l-18.2 55.3c-2 5.9-6.3 9.2-11.7 9.2-3.5 0-6.7-1.3-9-3.7l3.3-5.2a7.2 7.2 0 0 0 5.2 2c2.8 0 4.2-1.1 5.5-5l1.2-3-17.6-49.6h7.5l13.5 39.5L581.3 28h7.6zM271.8 89H74.6l15.7 15.7zM81.4 67.4c-6.8 0-11.8-6.7-11.8-15.2S74.6 37 81.4 37C88.2 37 93 43.7 93 52.2s-4.8 15.2-11.6 15.2zm11.5-42v2.4a20 20 0 0 0-11.5-3.7c-13.8 0-24.3 12.6-24.3 28.1 0 15.5 10.5 28 24.3 28 4.5 0 7.8-1.3 11.5-3.6v2.3h12V25.5H93zM190.1 25.5v31.4c0 5.9-4 10.8-10 10.8-5.8 0-9.9-5-9.9-10.8V25.5h-12.1v31.4c0 12.9 8.8 23.4 21.7 23.4 6 0 10.3-3.3 10.3-3.3v2h12.2V25.4H190zM303.3 79V47.4c0-5.9 4-10.9 10-10.9 5.8 0 9.9 5 9.9 11v31.3h12.1V47.5c0-12.9-8.8-23.4-21.7-23.4-6 0-10.3 3.3-10.3 3.3v-2H291V79h12.2z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M22.1 24.8h8.3a10.4 10.4 0 0 1 0 20.7H22V24.8zm0 54.1V58.2h9L46.6 79h16L43.6 54a23 23 0 0 0-13.3-41.8h-21V79h12.7zM235 66.3c-1.1.7-2.5 1.3-4 1.3-2 0-5.8-1.5-5.8-6.6V38.1h10.4V25.5h-10.4V12h-12.1v13.4h-6.5V38h6.5v23.1c0 12 9 19.1 18 19.1 3.4 0 8-1.1 11.9-3.4l-8-10.6zM135.2 50.5l20.8-25h-17L124.4 44V7.7H112v71.2h12.5V57l18 22h17z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M273.6 45.3h-21.8c2.5-12.5 19.5-13.3 21.8 0M263 24C249 24 239 36.4 239 52.2c0 16.6 12.7 28.1 25.3 28.1 6.4 0 14.7-2.2 21.5-12L275 62.1c-8.3 12.3-22.1 6-23.7-6.2h35c3-19.2-9.4-31.8-23.3-31.8" ] []
        ]



-- AUTHENTICATOR


{-| -}
authenticator_shapeSquare : String
authenticator_shapeSquare =
    "M64.8 0H12.2C5.48 0 0 5.49 0 12.2v52.6C0 71.52 5.49 77 12.2 77h52.6C71.52 77 77 71.51 77 64.8V12.2C77 5.48 71.51 0 64.8 0z"


{-| -}
authenticator_shapeShield : String
authenticator_shapeShield =
    "M38.5 9.63l-1.32.71a66.73 66.73 0 01-22.74 7.4V36.3a32.15 32.15 0 0014.75 27.1l8.23 5.25a2 2 0 002.16 0l8.22-5.26a32.14 32.14 0 0014.76-27.09V17.74a66.71 66.71 0 01-22.74-7.4l-1.32-.71z"


{-| -}
authenticator_shapeR : String
authenticator_shapeR =
    "M30.89 53.8l-3.86-3.24h27.1L30.89 53.8zM35.3 48.13v-7.19h3.1l5.4 7.19h5.5l-6.5-8.67a8 8 0 00-4.63-14.5h-7.28v23.16h4.4zm0-18.77h2.86a3.6 3.6 0 010 7.18H35.3v-7.18z"


{-| -}
authenticator : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
authenticator attrs _ size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 77 77"
        size
        [ Svg.path [ SA.fill "#BF0000", SA.d authenticator_shapeSquare ] []
        , Svg.path [ SA.fill "#fff", SA.d authenticator_shapeShield ] []
        , Svg.path [ SA.fill "#BF0000", SA.d authenticator_shapeR ] []
        ]


{-| -}
authenticator_monochrome : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
authenticator_monochrome attrs cl size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 77 77"
        size
        [ Svg.mask [ SA.id "authenticator_mask" ]
            [ Svg.path [ SA.fill "white", SA.d authenticator_shapeSquare ] []
            , Svg.path [ SA.fill "black", SA.d authenticator_shapeShield ] []
            ]
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d authenticator_shapeSquare, SA.mask "url(#authenticator_mask)" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d authenticator_shapeR ] []
        ]


{-| -}
barcelona : List (Attribute (R10.Context.ContextInternal z) msg) -> Int -> Element (R10.Context.ContextInternal z) msg
barcelona attrs size =
    R10.Svg.Utils.wrapperWithViewbox attrs
        "0 0 141 56"
        size
        [ Svg.path [ SA.fill "#000", SA.fillRule "evenodd", SA.d "M3.91 45.08c0-1.36.75-1.95 2-1.95 1.06 0 1.55.58 1.55.58v.78h-.83s-.12-.46-.75-.46c-.67 0-.95.33-.95 1.03v1.43c0 .72.3 1.02.94 1.02.5 0 .73-.27.73-.27v-1.08h-.78v-.89h1.71v3H6.8l-.13-.34h-.02s-.35.4-1.09.4c-1.08 0-1.65-.6-1.65-1.9v-1.35zM8.58 43.18H9.6v4.18h2.07l-.16.92H8.58v-5.1zM14.23 47.45c.67 0 .96-.32.96-1.07v-1.3c0-.75-.29-1.07-.96-1.07-.68 0-.96.32-.96 1.07v1.3c0 .75.28 1.07.96 1.07zm-1.98-2.3c0-1.33.69-2.05 1.98-2.05 1.28 0 1.98.72 1.98 2.05v1.16c0 1.32-.7 2.04-1.98 2.04-1.29 0-1.98-.72-1.98-2.04v-1.16zM18.14 46.13v1.27h.95c.42 0 .63-.26.63-.64 0-.47-.45-.63-.45-.63h-1.13zm0-2.07v1.2h1.11s.4-.15.4-.62c0-.31-.17-.58-.62-.58h-.89zm-.99-.88H19c1.22 0 1.65.55 1.65 1.4 0 .8-.6 1.12-.6 1.12v.01s.67.35.67 1.1c0 .92-.5 1.47-1.66 1.47h-1.9v-5.1zM22.76 46.36a3.8 3.8 0 001.35-.01l-.3-1.13-.27-1.13h-.2l-.28 1.13-.3 1.14zm-1.4 1.35l1.26-4.53h1.65l1.25 4.53v.57h-.91l-.28-1.08a4.54 4.54 0 01-1.8.01l-.27 1.07h-.9v-.57zM26.35 43.18h1.02v4.18h2.06l-.15.92h-2.93v-5.1zM31.95 47.48v-3.5l-.51-.09v-.71h2.04v.71l-.51.1v3.49l.5.09v.7h-2.03v-.7l.5-.1zM34.32 43.18h.94l1.46 2.4c.12.19.4.76.4.76h.02s-.04-.54-.04-1.05v-2.11h.99v5.1h-1v-.41l-1.27-2.1-.5-.87h-.03s.02.46.02.96v2.42h-.99v-5.1zM39.16 43.18h.94l1.45 2.4c.12.19.4.76.4.76h.02s-.03-.54-.03-1.05v-2.11h.99v5.1h-1v-.41l-1.28-2.1-.5-.87h-.02s.02.46.02.96v2.42h-.99v-5.1zM45.85 47.45c.68 0 .96-.32.96-1.07v-1.3c0-.75-.28-1.07-.96-1.07-.67 0-.96.32-.96 1.07v1.3c0 .75.29 1.07.96 1.07zm-1.98-2.3c0-1.33.7-2.05 1.98-2.05s1.98.72 1.98 2.05v1.16c0 1.32-.69 2.04-1.98 2.04-1.28 0-1.98-.72-1.98-2.04v-1.16zM49.33 43.18l.81 3.06c.13.47.25 1.13.25 1.13h.19s.13-.66.25-1.13l.8-3.06h.9v.6l-1.24 4.5h-1.65l-1.2-4.5v-.6h.9zM54.14 46.36a3.8 3.8 0 001.34-.01l-.3-1.13a56.9 56.9 0 01-.27-1.13h-.2s-.15.66-.28 1.13l-.3 1.14zm-1.4 1.35L54 43.18h1.65l1.25 4.53v.57h-.91l-.28-1.08a4.54 4.54 0 01-1.79.01l-.28 1.07h-.89v-.57zM59.26 44.1v4.18h-1.02V44.1h-1.21v-.92h3.5l-.16.92h-1.1zM61.66 47.48v-3.5l-.51-.09v-.71h2.04v.71l-.51.1v3.49l.5.09v.7h-2.03v-.7l.5-.1zM65.83 47.45c.67 0 .96-.32.96-1.07v-1.3c0-.75-.29-1.07-.96-1.07-.68 0-.96.32-.96 1.07v1.3c0 .75.28 1.07.96 1.07zm-1.98-2.3c0-1.33.69-2.05 1.98-2.05 1.28 0 1.98.72 1.98 2.05v1.16c0 1.32-.7 2.04-1.98 2.04s-1.98-.72-1.98-2.04v-1.16zM68.75 43.18h.94l1.45 2.4c.12.19.4.76.4.76h.02s-.03-.54-.03-1.05v-2.11h.99v5.1h-1v-.41l-1.28-2.1-.5-.87h-.02s.02.46.02.96v2.42h-.99v-5.1zM76.67 45.19l.17-.07c.54-.23.69-.38.69-.69 0-.37-.26-.5-.59-.5-.35 0-.57.16-.57.52 0 .24.07.45.3.74zm.17 2.34c.28 0 .5-.04.69-.14l-1.16-1.17c-.28.2-.37.42-.37.6 0 .48.3.7.84.7zm-1.04-1.94c-.28-.39-.4-.75-.4-1.14 0-.88.55-1.35 1.54-1.35 1 0 1.55.46 1.55 1.3 0 .72-.41 1.07-1.22 1.42l.74.76.01-.28v-.53h.86v.53c0 .37-.06.71-.18 1l.38.38v.6h-.67l-.27-.27c-.33.22-.75.34-1.32.34-1.27 0-1.8-.52-1.8-1.44 0-.63.31-1.03.78-1.32zM81.5 43.18h3.23l-.15.92h-2.06v1.17h1.86v.92h-1.86v1.17h2.13v.92H81.5v-5.1zM85.58 43.18h.94l1.45 2.4c.12.19.4.76.4.76h.02s-.04-.54-.04-1.05v-2.11h1v5.1h-1v-.41l-1.28-2.1-.5-.87h-.02s.02.46.02.96v2.42h-.99v-5.1zM92.34 44.1v4.18h-1.02V44.1h-1.21v-.92h3.5l-.16.92h-1.1zM94.34 43.18h3.23l-.15.92h-2.06v1.17h1.87v.92h-1.87v1.17h2.14v.92h-3.16v-5.1zM100.57 45.4s.48-.11.48-.66c0-.4-.25-.64-.66-.64h-.95v1.3h1.13zm-2.15-2.22h1.93c1.1 0 1.71.52 1.71 1.51a1.65 1.65 0 01-1.05 1.53s.5.9 1.03 1.44v.62h-.78c-.64-.7-1.29-1.95-1.29-1.95h-.53v1.95h-1.02v-5.1zM104.9 44.1v4.18h-1.02V44.1h-1.21v-.92h3.5l-.16.92h-1.1zM107.6 46.36a3.78 3.78 0 001.34-.01l-.3-1.13c-.13-.47-.27-1.13-.27-1.13h-.2l-.28 1.13-.3 1.14zm-1.4 1.35l1.25-4.53h1.65l1.25 4.53v.57h-.91l-.28-1.08a4.54 4.54 0 01-1.8.01l-.27 1.07h-.9v-.57zM111.58 47.48v-3.5l-.51-.09v-.71h2.04v.71l-.51.1v3.49l.5.09v.7h-2.03v-.7l.5-.1zM113.95 43.18h.94l1.46 2.4c.12.19.4.76.4.76h.02s-.04-.54-.04-1.05v-2.11h.99v5.1h-1v-.41l-1.27-2.1-.5-.87h-.03s.02.46.02.96v2.42h-.98v-5.1zM118.8 43.18h1.67l.6 2.75.26 1.5h.04s.15-.97.26-1.5l.6-2.75h1.67v5.1h-.98v-2.54l.03-1.72h-.08l-.33 1.5-.63 2.76h-1.12l-.63-2.75-.33-1.51h-.08l.03 1.72v2.54h-.99v-5.1zM124.98 43.18h3.23l-.15.92H126v1.17h1.87v.92H126v1.17h2.14v.92h-3.16v-5.1zM129.06 43.18h.94l1.46 2.4c.12.19.4.76.4.76h.02s-.04-.54-.04-1.05v-2.11h.99v5.1h-1v-.41l-1.27-2.1-.5-.87h-.03s.03.46.03.96v2.42h-1v-5.1zM135.83 44.1v4.18h-1.02V44.1h-1.22v-.92h3.5l-.15.92h-1.11zM26.95 53.14s.44-.16.44-.74c0-.39-.24-.65-.7-.65h-.88v1.39h1.14zm-2.16-2.31h1.9c1.13 0 1.71.56 1.71 1.6 0 1.25-1.11 1.63-1.11 1.63H25.8v1.86H24.8v-5.1zM30.1 54a3.8 3.8 0 001.34 0l-.3-1.13-.27-1.14h-.2s-.15.66-.28 1.14L30.1 54zm-1.4 1.35l1.26-4.52h1.65l1.25 4.52v.57h-.92l-.27-1.07a4.55 4.55 0 01-1.8.01l-.27 1.06h-.9v-.57zM35.84 53.05s.47-.12.47-.66c0-.4-.25-.64-.66-.64h-.94v1.3h1.13zm-2.15-2.22h1.92c1.11 0 1.72.52 1.72 1.51a1.65 1.65 0 01-1.05 1.53s.5.9 1.03 1.44v.61h-.78c-.64-.7-1.3-1.94-1.3-1.94h-.52v1.95h-1.02v-5.1zM40.17 51.75v4.17h-1.02v-4.17h-1.22v-.92h3.5l-.15.92h-1.11zM42.17 50.83h.93l1.46 2.39c.12.2.4.77.4.77h.02s-.04-.55-.04-1.05v-2.11h.99v5.1h-1v-.42l-1.27-2.09-.5-.88h-.03s.02.47.02.97v2.41h-.98v-5.1zM47 50.83h3.23l-.15.92h-2.06v1.17h1.87v.92h-1.87V55h2.14v.92H47v-5.1zM53.24 53.05s.47-.12.47-.66c0-.4-.25-.64-.66-.64h-.95v1.3h1.14zm-2.16-2.22h1.93c1.11 0 1.72.52 1.72 1.51 0 1.16-1.05 1.53-1.05 1.53s.5.9 1.02 1.44v.61h-.77c-.64-.7-1.3-1.94-1.3-1.94h-.53v1.95h-1.02v-5.1zM59 55.1c.67 0 .96-.32.96-1.07v-1.3c0-.76-.29-1.07-.96-1.07-.68 0-.96.31-.96 1.06v1.3c0 .76.28 1.07.96 1.07zm-1.98-2.3c0-1.33.69-2.05 1.98-2.05 1.28 0 1.98.72 1.98 2.05v1.15c0 1.32-.7 2.05-1.98 2.05s-1.98-.72-1.98-2.05V52.8zM61.92 50.83h3.16l-.15.92h-1.99v1.17h1.8v.92h-1.8v2.08h-1.02v-5.1zM67.37 50.83h3.16l-.15.92h-1.99v1.17h1.8v.92h-1.8v2.08h-1.02v-5.1zM71.07 52.73c0-1.35.67-1.96 1.9-1.96 1.04 0 1.52.57 1.52.57v.8h-.83s-.06-.46-.69-.46c-.67 0-.88.33-.88 1.03v1.33c0 .7.21 1.03.88 1.03.63 0 .7-.46.7-.46h.82v.8s-.48.57-1.53.57c-1.22 0-1.89-.61-1.89-1.96v-1.29zM77.91 53.77v1.28h.95c.42 0 .63-.26.63-.64 0-.47-.45-.64-.45-.64h-1.13zm.01-2.07v1.21h1.11s.4-.16.4-.62c0-.32-.17-.59-.61-.59h-.9zm-.99-.87h1.85c1.22 0 1.65.55 1.65 1.4 0 .8-.6 1.12-.6 1.12v.01s.67.35.67 1.1c0 .92-.5 1.47-1.65 1.47h-1.92v-5.1zM82.55 54a3.8 3.8 0 001.34 0l-.3-1.13-.27-1.14h-.2l-.28 1.14-.3 1.14zm-1.4 1.35l1.25-4.52h1.65l1.25 4.52v.57h-.91l-.28-1.07a4.55 4.55 0 01-1.79.01l-.28 1.06h-.89v-.57zM88.28 53.05s.48-.12.48-.66c0-.4-.25-.64-.66-.64h-.95v1.3h1.13zm-2.15-2.22h1.93c1.1 0 1.71.52 1.71 1.51a1.65 1.65 0 01-1.04 1.53s.5.9 1.02 1.44v.61h-.78c-.63-.7-1.29-1.94-1.29-1.94h-.53v1.95h-1.02v-5.1zM90.54 52.73c0-1.35.66-1.96 1.88-1.96 1.05 0 1.53.57 1.53.57v.8h-.83s-.06-.46-.69-.46c-.66 0-.87.33-.87 1.03v1.33c0 .7.2 1.03.87 1.03.63 0 .7-.46.7-.46h.82v.8s-.48.57-1.53.57c-1.22 0-1.88-.61-1.88-1.96v-1.29zM94.81 50.83h3.24l-.16.92h-2.06v1.17h1.87v.92h-1.87V55h2.14v.92h-3.16v-5.1zM98.9 50.83h1.02V55h2.06l-.15.92H98.9v-5.1zM104.54 55.1c.67 0 .96-.32.96-1.07v-1.3c0-.76-.29-1.07-.96-1.07-.68 0-.96.31-.96 1.06v1.3c0 .76.28 1.07.96 1.07zm-1.98-2.3c0-1.33.69-2.05 1.98-2.05 1.28 0 1.98.72 1.98 2.05v1.15c0 1.32-.7 2.05-1.98 2.05s-1.98-.72-1.98-2.05V52.8zM107.46 50.83h.94l1.45 2.39c.13.2.41.77.41.77h.02s-.04-.55-.04-1.05v-2.11h.99v5.1h-1v-.42l-1.27-2.09-.5-.88h-.03s.02.47.02.97v2.41h-.99v-5.1zM113.45 54a3.79 3.79 0 001.34 0l-.3-1.13-.27-1.14h-.2s-.15.66-.28 1.14l-.29 1.14zm-1.4 1.35l1.26-4.52h1.65l1.25 4.52v.57h-.92l-.27-1.07a4.54 4.54 0 01-1.8.01l-.27 1.06h-.9v-.57z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#C99900", SA.fillRule "evenodd", SA.d "M128.86.55l.18.12c1.94 1.29 3.5 1.52 5.88 1.52.84 0 1.74-.15 2.6-.45l.23-.08 1.13 1.58-.12.16c-4.19 5.57-.92 11.59 1.4 13.99l.2.22-.21.22-1.22 1.26-.13.14v.19l.01.06.01.2v.03c.2 3.71-.76 6.77-2.85 9.07-2.23 2.45-5.74 3.92-9.89 4.15h-.16l-.12.12a31.79 31.79 0 01-2.14 1.77l-.19.13-.18-.13a31.4 31.4 0 01-2.15-1.77l-.12-.11-.16-.01c-4.15-.23-7.66-1.7-9.88-4.15-2.1-2.3-3.06-5.36-2.86-9.08v-.03l.01-.18V19.42l.01-.2-.13-.13c-.37-.39-.9-.95-1.22-1.26l-.22-.22.22-.22c2.31-2.4 5.58-8.42 1.39-14l-.12-.15 1.13-1.58.23.08c.86.3 1.76.45 2.6.45 2.38 0 3.94-.23 5.88-1.52l.18-.12.18.12a8.83 8.83 0 005.21 1.75c1.84 0 3.5-.56 5.22-1.75l.17-.12z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#fff", SA.fillRule "evenodd", SA.d "M110.7 14.31c1.32-3 1.8-6.88-.4-10.66.55.1 1.13.16 1.72.16 2.26 0 4.04-.2 6.04-1.34a10.24 10.24 0 0010.82 0c2 1.13 3.78 1.34 6.04 1.34.6 0 1.17-.06 1.73-.17-2.22 3.8-1.73 7.66-.41 10.67H110.7z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#FFD200", SA.fillRule "evenodd", SA.d "M136.24 14.31c-1.32-3-1.8-6.88.4-10.67-.55.1-1.13.17-1.72.17-2.26 0-4.04-.2-6.04-1.34a10.25 10.25 0 01-5.41 1.56h-.06v10.28h12.83z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#002596", SA.fillRule "evenodd", SA.d "M133.42 28.87c2.52-1.83 4-4.77 3.79-9.06-.03-.24-.05-.26-.06-.5h-3.73v9.56z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#8B2346", SA.fillRule "evenodd", SA.d "M129.44 30.72a12 12 0 003.99-1.85v-9.56h-3.99v11.4zM113.52 28.87c1.14.84 2.48 1.44 3.98 1.85V19.3h-3.98v9.56z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#002596", SA.fillRule "evenodd", SA.d "M109.73 19.81c-.21 4.29 1.27 7.23 3.79 9.07V19.3h-3.72c-.02.24-.04.26-.07.5z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#8B2346", SA.fillRule "evenodd", SA.d "M123.48 21.42c.73 0 1.4.22 1.98.57v-2.68h-3.98V22a3.73 3.73 0 012-.59zM123.48 28.93c-.73 0-1.42-.21-2-.58v2.97l.21.01c1.32 0 2.52.02 3.56 0l.21-.01v-2.96c-.57.36-1.25.57-1.98.57z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#002596", SA.fillRule "evenodd", SA.d "M125.46 19.3V22a3.75 3.75 0 010 6.36v2.96a19 19 0 003.98-.6V19.3h-3.98zM119.73 25.18c0-1.34.7-2.5 1.75-3.17v-2.7h-3.98v11.4c1.24.34 2.58.54 3.98.61v-2.97a3.75 3.75 0 01-1.75-3.17z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#CC092F", SA.fillRule "evenodd", SA.d "M111.6 7.03c.27 1.3.28 2.58.1 3.8h3.88v3.48h3.8v-3.48h4.04v-3.8h-4.05V3.16c-.45-.2-.89-.43-1.31-.69a9.6 9.6 0 01-2.48 1v3.56h-3.98zM131.6 14.31V3.51a9.3 9.3 0 01-1.37-.4v11.2h1.37zM126.14 14.31V3.67c-.44.13-.9.22-1.37.28V14.3h1.37zM134.33 14.31V3.81c-.47-.02-.92-.04-1.36-.08V14.3h1.36zM128.87 14.31V2.48c-.44.27-.9.5-1.37.7v11.13h1.37z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#000", SA.fillRule "evenodd", SA.d "M138.47 19.1c.04.4.02.38.04.6.46 8.58-5.5 12.62-12.72 12.92-1.1 1.03-2.32 1.94-2.32 1.94s-1.22-.91-2.32-1.94c-7.21-.3-13.18-4.34-12.72-12.91.03-.23 0-.21.04-.6-.41-.44-1.1-1.15-1.46-1.51 2.59-2.69 5.6-8.83 1.42-14.4l.88-1.17c.84.28 1.77.47 2.7.47 2.41 0 4.05-.24 6.07-1.58a9.2 9.2 0 005.4 1.8c2.06 0 3.79-.69 5.39-1.8 2.01 1.34 3.65 1.58 6.05 1.58.94 0 1.87-.19 2.7-.47l.9 1.17c-4.2 5.57-1.18 11.71 1.4 14.4a94.2 94.2 0 00-1.45 1.5zm2.53-1.5l-.52-.53c-2.22-2.31-5.36-8.08-1.36-13.41l.32-.42-1.52-2.13-.54.2c-.82.28-1.67.42-2.46.42-2.29 0-3.79-.22-5.63-1.44l-.44-.29-.42.3a8.4 8.4 0 01-4.96 1.66A8.4 8.4 0 01118.51.3l-.42-.3-.44.29c-1.84 1.22-3.34 1.44-5.63 1.44-.8 0-1.64-.14-2.46-.43l-.54-.19-1.52 2.13.32.42c4 5.33.87 11.1-1.36 13.4l-.52.55.53.53c.29.28.8.8 1.21 1.25v.07l-.01.16v.04c-.2 3.85.8 7.02 2.97 9.41 2.31 2.54 5.93 4.07 10.2 4.3 1.06.96 2.13 1.76 2.18 1.8l.45.34.46-.34c.05-.04 1.12-.84 2.17-1.8 4.28-.23 7.89-1.76 10.2-4.3 2.18-2.4 3.18-5.56 2.98-9.4v-.05l-.02-.16v-.07l1.2-1.25.54-.53z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#000", SA.fillRule "evenodd", SA.d "M109.85 19.82l.03-.22.02-.18h27.14l.02.18.03.22c.17 3.23-.63 5.84-2.38 7.76-2.01 2.2-5.28 3.46-9.46 3.64h-3.56c-4.17-.18-7.44-1.43-9.45-3.64-1.75-1.92-2.56-4.53-2.4-7.76zm-.17-.52a3.24 3.24 0 01-.06.5c-.17 3.3.66 5.97 2.44 7.93 2.06 2.26 5.38 3.54 9.63 3.72h.16a379.54 379.54 0 003.4 0c4.25-.18 7.57-1.46 9.63-3.72 1.79-1.96 2.61-4.63 2.44-7.93a3.15 3.15 0 00-.03-.24l-.03-.26-.01-.1h-27.56v.1zM110.52 3.8a9.8 9.8 0 001.5.12c2.32 0 4.06-.21 6.04-1.32 1.68 1.01 3.4 1.52 5.25 1.55V14.2h-12.43c1.1-2.58 1.86-6.42-.36-10.4zm13.02.35c1.88-.02 3.63-.52 5.35-1.55 1.97 1.1 3.7 1.32 6.03 1.32.5 0 1-.04 1.5-.12-2.22 3.98-1.45 7.82-.36 10.4h-12.52V4.15zM110.6 14.27l-.07.16h25.88l-.07-.16c-1.12-2.58-1.97-6.5.4-10.57l.13-.22-.24.05c-.58.1-1.15.16-1.7.16-2.32 0-4.03-.21-5.99-1.32l-.06-.03-.06.03a10.11 10.11 0 01-10.7 0l-.06-.03-.06.03c-1.95 1.1-3.67 1.32-5.98 1.32-.54 0-1.11-.05-1.7-.15l-.24-.05.12.22c2.37 4.05 1.53 7.98.4 10.56zM120.2 15.8v-.75h-2.56v3.55h.77v-1.47h1.05v-.75h-1.05v-.58h1.8zM123.2 15.76c.28 0 .48.12.6.35l.02.04.72-.33-.02-.04c-.25-.51-.7-.79-1.3-.79-.94 0-1.59.76-1.59 1.83 0 1.11.62 1.83 1.56 1.83.62 0 1.06-.27 1.32-.8l.01-.03-.64-.39-.02.03c-.19.31-.36.43-.65.43-.47 0-.79-.43-.79-1.07 0-.65.3-1.06.78-1.06zM128.02 17.86h-.88v-.82h.88c.32 0 .46.13.46.4 0 .28-.16.42-.46.42zm-.88-2.1h.84c.35 0 .4.16.4.3 0 .2-.12.29-.36.29h-.88v-.59zm2.01.24c0-.6-.42-.95-1.14-.95h-1.63v3.55H128c.8 0 1.27-.44 1.27-1.16a.83.83 0 00-.45-.77c.21-.15.33-.39.33-.67z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#000", SA.fillRule "evenodd", SA.d "M121.19 22.36l-.19.73c-.18.85-.18 2.13.5 2.76-.23.42-.66.67-1.2.67l-.18-.01a3.59 3.59 0 011.06-4.15zm4.3.98c-.62-.35-1.45-.68-2.04-.43-.45-.28-.53-.98.04-1.36a3.6 3.6 0 013.56 3.39 4.18 4.18 0 00-1.55-1.6zm-.25 2.55c-.01-.14-.04-.28-.1-.42-.2-.46-.86-1.02-1.68-.44a1.17 1.17 0 01-.3-1.6c.41-.66 1.36-.4 2.23.1.71.39 1.45 1.21 1.66 1.96-.04.39-.14.76-.29 1.1-.24-.77-1.04-.88-1.52-.7zm-4.13-1.73c-.01-.7.19-1.32.34-2a3.57 3.57 0 011.7-.6 1 1 0 00.1 1.47c-.11.07-.2.17-.28.3-.32.5-.36 1.34.38 1.88-.05.42-.61.84-1 .79-.84-.1-1.23-.88-1.24-1.84zm.57 1.82c.18.12.39.2.64.23.5.06 1.2-.43 1.24-1 .69-.48 1.22-.04 1.38.34.32.76-.35 1.3-1.2 1.81a5.7 5.7 0 01-2.57.58c-.4-.33-.73-.74-.95-1.2h.08c.6 0 1.1-.28 1.38-.76zm1.78 2.78c-.75 0-1.44-.22-2.01-.61a5.7 5.7 0 002.4-.6c.6-.37 1.25-.82 1.37-1.42.44-.22 1.28-.12 1.4.77a3.6 3.6 0 01-3.16 1.86zm0 .23a3.84 3.84 0 10-.02-7.68 3.84 3.84 0 00.02 7.68z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#BF0000", SA.fillRule "evenodd", SA.d "M60.2 26.58H14.96l3.6 3.6 41.64-3.6zM16.52 21.62c-1.56 0-2.7-1.54-2.7-3.49 0-1.94 1.14-3.48 2.7-3.48 1.57 0 2.67 1.54 2.67 3.48 0 1.95-1.1 3.49-2.67 3.49zm2.63-9.63v.55a4.57 4.57 0 00-2.63-.85c-3.17 0-5.58 2.9-5.58 6.44 0 3.56 2.41 6.45 5.58 6.45 1.03 0 1.79-.31 2.63-.85v.54h2.78V12h-2.78zM41.46 12v7.2c0 1.36-.92 2.5-2.28 2.5-1.35 0-2.28-1.14-2.28-2.5V12H34.1v7.2c0 2.97 2.03 5.38 4.99 5.38 1.37 0 2.36-.76 2.36-.76v.45h2.8V12h-2.8zM67.43 24.27v-7.21c0-1.35.92-2.5 2.28-2.5 1.35 0 2.28 1.15 2.28 2.5v7.21h2.79v-7.21c0-2.96-2.03-5.37-4.99-5.37-1.37 0-2.36.76-2.36.76v-.46h-2.8v12.28h2.8z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#BF0000", SA.fillRule "evenodd", SA.d "M2.91 11.85h1.9a2.38 2.38 0 010 4.75h-1.9v-4.75zm0 12.42v-4.75h2.06l3.57 4.75h3.65l-4.31-5.74a5.3 5.3 0 00-3.06-9.6H0v15.34h2.91zM51.76 21.37c-.25.17-.57.3-.93.3-.46 0-1.31-.35-1.31-1.5V14.9h2.38v-2.92h-2.38V8.93h-2.8V12h-1.47v2.92h1.48v5.3a4.2 4.2 0 004.14 4.38c.78 0 1.85-.26 2.73-.78l-1.84-2.44zM28.86 17.75l4.78-5.76h-3.9l-3.35 4.28V7.92h-2.87v16.35h2.87v-5.04l4.1 5.04h3.91l-5.54-6.52z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#BF0000", SA.fillRule "evenodd", SA.d "M60.63 16.55H55.6c.59-2.88 4.48-3.04 5.02 0zm-2.43-4.87c-3.23 0-5.54 2.84-5.54 6.45 0 3.8 2.9 6.46 5.81 6.46 1.47 0 3.35-.5 4.94-2.75l-2.46-1.42c-1.9 2.8-5.08 1.38-5.45-1.43h8.03c.69-4.4-2.16-7.3-5.33-7.3z", SA.clipRule "evenodd" ] []
        , Svg.path [ SA.fill "#000", SA.fillRule "evenodd", SA.d "M90.11 35.5h.5V0h-.5v35.5z", SA.clipRule "evenodd" ] []
        ]
