module R10.Color.Internal.Derived exposing (Color(..), list, toColor)

import Color
import Color.Accessibility
import Color.Manipulate
import Json.Decode
import Json.Encode
import R10.Color.Internal.Base
import R10.Color.Internal.Primary
import R10.Color.Utils
import R10.Mode
import R10.Theme


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


list : R10.Theme.Theme -> List { color : Color.Color, name : String }
list theme =
    List.map
        (\color ->
            { color = toColor theme color
            , name = toString_ color
            }
        )
        list_


toString_ : Color -> String
toString_ value =
    case value of
        Success ->
            "Success"

        Primary ->
            "Primary"

        Logo ->
            "Logo"

        FontMediumEmphasisWithMaximumContrast ->
            "Font Medium Emphasis With Maximum Contrast"

        FontMediumEmphasis ->
            "Font Medium Emphasis"

        FontLink ->
            "Font Link"

        FontHighEmphasisWithMaximumContrast ->
            "Font High Emphasis With Maximum Contrast"

        FontHighEmphasis ->
            "Font High Emphasis"

        Error ->
            "Error"

        Debugger ->
            "Debugger"

        Border ->
            "Border"

        BackgroundPhoneDropdown ->
            "Background Phone Dropdown"

        BackgroundNormal ->
            "Background Normal"

        BackgroundInputFieldText ->
            "Background Input Field Text"

        BackgroundButtonPrimaryOver ->
            "Background Button Primary Over"

        BackgroundButtonPrimaryDisabledOver ->
            "Background Button Primary Disabled Over"

        BackgroundButtonPrimaryDisabled ->
            "Background Button Primary Disabled"

        BackgroundButtonPrimary ->
            "Background Button Primary"

        BackgroundButtonMinorOver ->
            "Background Button Minor Over"


list_ : List Color
list_ =
    [ BackgroundNormal
    , FontMediumEmphasis
    , Primary
    , Success
    , Error
    , Logo
    , FontMediumEmphasisWithMaximumContrast
    , FontLink
    , FontHighEmphasisWithMaximumContrast
    , FontHighEmphasis
    , Debugger
    , Border
    , BackgroundPhoneDropdown
    , BackgroundInputFieldText
    , BackgroundButtonPrimaryOver
    , BackgroundButtonPrimaryDisabledOver
    , BackgroundButtonPrimaryDisabled
    , BackgroundButtonPrimary
    , BackgroundButtonMinorOver
    ]



-- EXTRAS
--
-- Convert a derived color into a `avh4/elm-color` type of color.
-- It requiires a `Mode` because the color can be sligtly different
-- in Light or Dark mode.


toColor : R10.Theme.Theme -> Color -> Color.Color
toColor theme colorDerived =
    case colorDerived of
        Success ->
            R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Success

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
            R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.FontLink

        Error ->
            R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Error

        Debugger ->
            R10.Color.Internal.Primary.toColor theme R10.Color.Internal.Primary.LightBlue

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
            R10.Color.Internal.Base.Font
                |> R10.Color.Internal.Base.toColor theme
                |> R10.Color.Utils.setAlpha 0.2

        BackgroundPhoneDropdown ->
            case theme.mode of
                R10.Mode.Light ->
                    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Background

                R10.Mode.Dark ->
                    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Background
                        |> Color.Manipulate.lighten 0.05

        BackgroundNormal ->
            R10.Color.Internal.Base.Background
                |> R10.Color.Internal.Base.toColor theme

        BackgroundInputFieldText ->
            case theme.mode of
                R10.Mode.Light ->
                    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Background
                        |> Color.Manipulate.darken 0.05

                R10.Mode.Dark ->
                    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Background
                        |> Color.Manipulate.lighten 0.05

        BackgroundButtonPrimaryOver ->
            R10.Color.Internal.Primary.toColor theme theme.primaryColor
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
            R10.Color.Internal.Primary.toColor theme theme.primaryColor

        BackgroundButtonMinorOver ->
            R10.Color.Internal.Base.Background
                |> R10.Color.Internal.Base.toColor theme
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
    R10.Color.Internal.Base.Background
        |> R10.Color.Internal.Base.toColor theme
        |> (\color ->
                case theme.mode of
                    R10.Mode.Dark ->
                        Color.Manipulate.lighten 0.2 color

                    R10.Mode.Light ->
                        Color.Manipulate.darken 0.2 color
           )


highEmphasis : R10.Theme.Theme -> Color.Color
highEmphasis theme =
    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Font
        -- https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
        |> R10.Color.Utils.setAlpha 0.87


highEmphasisReversed : R10.Theme.Theme -> Color.Color
highEmphasisReversed theme =
    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.FontReversed
        -- https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
        |> R10.Color.Utils.setAlpha 0.87


mediumEmphasis : R10.Theme.Theme -> Color.Color
mediumEmphasis theme =
    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Font
        -- https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
        |> R10.Color.Utils.setAlpha 0.6


mediumEmphasisReversed : R10.Theme.Theme -> Color.Color
mediumEmphasisReversed theme =
    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.FontReversed
        -- https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
        |> R10.Color.Utils.setAlpha 0.6


primary : R10.Theme.Theme -> Color.Color
primary theme =
    R10.Color.Internal.Primary.toColor theme theme.primaryColor
