module R10.Color.Derived exposing
    ( Color(..), list, toColor
    , toString
    )

{-| Rakuten derived colors

@docs Color, list, toColor


# To String

@docs toString

-}

import Color
import Color.Accessibility
import Color.Manipulate
import Json.Decode
import Json.Encode
import R10.Color
import R10.Color.Base
import R10.Color.Primary
import R10.Mode
import R10.Theme


{-| -}
type Color
    = Success
    | Primary
    | Logo
    | FontMediumEmphasisWithMaximumContrast
    | FontMediumEmphasis
    | FontLink
    | FontHighEmphasisWithMaximumContrast
    | FontHighEmphasis
    | Error
    | Debugger
    | Border
    | BackgroundPhoneDropdown
    | BackgroundNormal
    | BackgroundInputFieldText
    | BackgroundButtonPrimaryOver
    | BackgroundButtonPrimaryDisabledOver
    | BackgroundButtonPrimaryDisabled
    | BackgroundButtonPrimary
    | BackgroundButtonMinorOver


{-| -}
encodeColor : Color -> Json.Encode.Value
encodeColor value =
    case value of
        Success ->
            Json.Encode.string "Success"

        Primary ->
            Json.Encode.string "Primary"

        Logo ->
            Json.Encode.string "Logo"

        FontMediumEmphasisWithMaximumContrast ->
            Json.Encode.string "FontMediumEmphasisWithMaximumContrast"

        FontMediumEmphasis ->
            Json.Encode.string "FontMediumEmphasis"

        FontLink ->
            Json.Encode.string "FontLink"

        FontHighEmphasisWithMaximumContrast ->
            Json.Encode.string "FontHighEmphasisWithMaximumContrast"

        FontHighEmphasis ->
            Json.Encode.string "FontHighEmphasis"

        Error ->
            Json.Encode.string "Error"

        Debugger ->
            Json.Encode.string "Debugger"

        Border ->
            Json.Encode.string "Border"

        BackgroundPhoneDropdown ->
            Json.Encode.string "BackgroundPhoneDropdown"

        BackgroundNormal ->
            Json.Encode.string "BackgroundNormal"

        BackgroundInputFieldText ->
            Json.Encode.string "BackgroundInputFieldText"

        BackgroundButtonPrimaryOver ->
            Json.Encode.string "BackgroundButtonPrimaryOver"

        BackgroundButtonPrimaryDisabledOver ->
            Json.Encode.string "BackgroundButtonPrimaryDisabledOver"

        BackgroundButtonPrimaryDisabled ->
            Json.Encode.string "BackgroundButtonPrimaryDisabled"

        BackgroundButtonPrimary ->
            Json.Encode.string "BackgroundButtonPrimary"

        BackgroundButtonMinorOver ->
            Json.Encode.string "BackgroundButtonMinorOver"


{-| -}
decodeColor : Json.Decode.Decoder Color
decodeColor =
    let
        findMatch str =
            case str of
                "Success" ->
                    Json.Decode.succeed Success

                "Primary" ->
                    Json.Decode.succeed Primary

                "Logo" ->
                    Json.Decode.succeed Logo

                "FontMediumEmphasisWithMaximumContrast" ->
                    Json.Decode.succeed FontMediumEmphasisWithMaximumContrast

                "FontMediumEmphasis" ->
                    Json.Decode.succeed FontMediumEmphasis

                "FontLink" ->
                    Json.Decode.succeed FontLink

                "FontHighEmphasisWithMaximumContrast" ->
                    Json.Decode.succeed FontHighEmphasisWithMaximumContrast

                "FontHighEmphasis" ->
                    Json.Decode.succeed FontHighEmphasis

                "Error" ->
                    Json.Decode.succeed Error

                "Debugger" ->
                    Json.Decode.succeed Debugger

                "Border" ->
                    Json.Decode.succeed Border

                "BackgroundPhoneDropdown" ->
                    Json.Decode.succeed BackgroundPhoneDropdown

                "BackgroundNormal" ->
                    Json.Decode.succeed BackgroundNormal

                "BackgroundInputFieldText" ->
                    Json.Decode.succeed BackgroundInputFieldText

                "BackgroundButtonPrimaryOver" ->
                    Json.Decode.succeed BackgroundButtonPrimaryOver

                "BackgroundButtonPrimaryDisabledOver" ->
                    Json.Decode.succeed BackgroundButtonPrimaryDisabledOver

                "BackgroundButtonPrimaryDisabled" ->
                    Json.Decode.succeed BackgroundButtonPrimaryDisabled

                "BackgroundButtonPrimary" ->
                    Json.Decode.succeed BackgroundButtonPrimary

                "BackgroundButtonMinorOver" ->
                    Json.Decode.succeed BackgroundButtonMinorOver

                _ ->
                    Json.Decode.fail "Unknown value for Color"
    in
    Json.Decode.string |> Json.Decode.andThen findMatch


{-| -}
toString : Color -> String
toString value =
    case value of
        Success ->
            "Success"

        Primary ->
            "Primary"

        Logo ->
            "Logo"

        FontMediumEmphasisWithMaximumContrast ->
            "FontMediumEmphasisWithMaximumContrast"

        FontMediumEmphasis ->
            "FontMediumEmphasis"

        FontLink ->
            "FontLink"

        FontHighEmphasisWithMaximumContrast ->
            "FontHighEmphasisWithMaximumContrast"

        FontHighEmphasis ->
            "FontHighEmphasis"

        Error ->
            "Error"

        Debugger ->
            "Debugger"

        Border ->
            "Border"

        BackgroundPhoneDropdown ->
            "BackgroundPhoneDropdown"

        BackgroundNormal ->
            "BackgroundNormal"

        BackgroundInputFieldText ->
            "BackgroundInputFieldText"

        BackgroundButtonPrimaryOver ->
            "BackgroundButtonPrimaryOver"

        BackgroundButtonPrimaryDisabledOver ->
            "BackgroundButtonPrimaryDisabledOver"

        BackgroundButtonPrimaryDisabled ->
            "BackgroundButtonPrimaryDisabled"

        BackgroundButtonPrimary ->
            "BackgroundButtonPrimary"

        BackgroundButtonMinorOver ->
            "BackgroundButtonMinorOver"


{-| -}
list : List Color
list =
    [ Success
    , Primary
    , Logo
    , FontMediumEmphasisWithMaximumContrast
    , FontMediumEmphasis
    , FontLink
    , FontHighEmphasisWithMaximumContrast
    , FontHighEmphasis
    , Error
    , Debugger
    , Border
    , BackgroundPhoneDropdown
    , BackgroundNormal
    , BackgroundInputFieldText
    , BackgroundButtonPrimaryOver
    , BackgroundButtonPrimaryDisabledOver
    , BackgroundButtonPrimaryDisabled
    , BackgroundButtonPrimary
    , BackgroundButtonMinorOver
    ]



-- EXTRAS


{-| Convert a primary color into a `avh4/elm-color` type of color. It requiires a `Mode` because the color can be sligtly different in Light or Dark mode.
-}
toColor : R10.Theme.Theme -> Color -> Color.Color
toColor theme colorDerived =
    case colorDerived of
        Success ->
            R10.Color.Base.toColor theme R10.Color.Base.Success

        Logo ->
            case theme.mode of
                R10.Mode.Light ->
                    primary theme

                R10.Mode.Dark ->
                    highEmphasis theme

        Primary ->
            primary theme

        FontMediumEmphasis ->
            mediumEmphasis theme

        FontHighEmphasis ->
            highEmphasis theme

        FontLink ->
            R10.Color.Base.toColor theme R10.Color.Base.FontLink

        Error ->
            R10.Color.Base.toColor theme R10.Color.Base.Error

        Debugger ->
            R10.Color.Primary.toColor theme R10.Color.Primary.LightBlue

        FontMediumEmphasisWithMaximumContrast ->
            let
                goesOn : R10.Theme.Theme -> Color.Color
                goesOn =
                    primary

                color1 : Color.Color
                color1 =
                    mediumEmphasis theme

                color2 : Color.Color
                color2 =
                    mediumEmphasisReversed theme

                colorFont : Color.Color
                colorFont =
                    Maybe.withDefault color1 <|
                        Color.Accessibility.maximumContrast (goesOn theme) [ color1, color2 ]
            in
            colorFont

        FontHighEmphasisWithMaximumContrast ->
            let
                goesOn : R10.Theme.Theme -> Color.Color
                goesOn =
                    primary

                color1 : Color.Color
                color1 =
                    highEmphasis theme

                color2 : Color.Color
                color2 =
                    highEmphasisReversed theme

                colorFont : Color.Color
                colorFont =
                    Maybe.withDefault color1 <|
                        Color.Accessibility.maximumContrast (goesOn theme) [ color1, color2 ]
            in
            colorFont

        Border ->
            R10.Color.Base.Font
                |> R10.Color.Base.toColor theme
                |> R10.Color.setAlpha 0.2

        BackgroundPhoneDropdown ->
            case theme.mode of
                R10.Mode.Light ->
                    R10.Color.Base.toColor theme R10.Color.Base.Background

                R10.Mode.Dark ->
                    R10.Color.Base.toColor theme R10.Color.Base.Background
                        |> Color.Manipulate.lighten 0.05

        BackgroundNormal ->
            R10.Color.Base.Background
                |> R10.Color.Base.toColor theme

        BackgroundInputFieldText ->
            case theme.mode of
                R10.Mode.Light ->
                    R10.Color.Base.toColor theme R10.Color.Base.Background
                        |> Color.Manipulate.darken 0.05

                R10.Mode.Dark ->
                    R10.Color.Base.toColor theme R10.Color.Base.Background
                        |> Color.Manipulate.lighten 0.05

        BackgroundButtonPrimaryOver ->
            R10.Color.Primary.toColor theme theme.primaryColor
                |> Color.Manipulate.scaleHsl
                    { saturationScale = 0.3
                    , lightnessScale = 0.2
                    , alphaScale = 0
                    }

        BackgroundButtonPrimaryDisabledOver ->
            backgroundButtonPrimaryDisabled theme
                |> Color.Manipulate.scaleHsl
                    { saturationScale = 0
                    , lightnessScale = 0.2
                    , alphaScale = 0
                    }

        BackgroundButtonPrimaryDisabled ->
            backgroundButtonPrimaryDisabled theme

        BackgroundButtonPrimary ->
            R10.Color.Primary.toColor theme theme.primaryColor

        BackgroundButtonMinorOver ->
            R10.Color.Base.Background
                |> R10.Color.Base.toColor theme
                |> (\color ->
                        case theme.mode of
                            R10.Mode.Dark ->
                                Color.Manipulate.lighten 0.07 color

                            R10.Mode.Light ->
                                Color.Manipulate.darken 0.08 color
                   )



-- From here colors that are used several times so they are
-- extracted in separated functions


backgroundButtonPrimaryDisabled : R10.Theme.Theme -> Color.Color
backgroundButtonPrimaryDisabled theme =
    R10.Color.Base.Background
        |> R10.Color.Base.toColor theme
        |> (\color ->
                case theme.mode of
                    R10.Mode.Dark ->
                        Color.Manipulate.lighten 0.2 color

                    R10.Mode.Light ->
                        Color.Manipulate.darken 0.2 color
           )


highEmphasis : R10.Theme.Theme -> Color.Color
highEmphasis theme =
    R10.Color.Base.toColor theme R10.Color.Base.Font
        -- https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
        |> R10.Color.setAlpha 0.87


highEmphasisReversed : R10.Theme.Theme -> Color.Color
highEmphasisReversed theme =
    R10.Color.Base.toColor theme R10.Color.Base.FontReversed
        -- https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
        |> R10.Color.setAlpha 0.87


mediumEmphasis : R10.Theme.Theme -> Color.Color
mediumEmphasis theme =
    R10.Color.Base.toColor theme R10.Color.Base.Font
        -- https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
        |> R10.Color.setAlpha 0.6


mediumEmphasisReversed : R10.Theme.Theme -> Color.Color
mediumEmphasisReversed theme =
    R10.Color.Base.toColor theme R10.Color.Base.FontReversed
        -- https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
        |> R10.Color.setAlpha 0.6


primary : R10.Theme.Theme -> Color.Color
primary theme =
    R10.Color.Primary.toColor theme theme.primaryColor
