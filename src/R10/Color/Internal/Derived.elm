module R10.Color.Internal.Derived exposing (Color(..), list, toColor)

import Color
import Color.Accessibility
import Color.Manipulate
import R10.Color.Internal.Base
import R10.Color.Internal.Primary
import R10.Color.Utils
import R10.Mode
import R10.Theme


type Color
    = Success
    | Primary
    | PrimaryVariant
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
    | Background
    | Surface
    | Surface2dp
    | BackgroundInputFieldText
    | BackgroundButtonPrimaryOver
    | BackgroundButtonPrimaryDisabledOver
    | BackgroundButtonPrimaryDisabled
    | BackgroundButtonPrimary
    | BackgroundButtonMinorOver


list : R10.Theme.Theme -> List { color : Color.Color, name : String, description : String }
list theme =
    List.map
        (\color ->
            let
                ( color_, description ) =
                    toColor_ theme color
            in
            { color = color_
            , name = toString_ color
            , description = description
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

        PrimaryVariant ->
            "Primary Variant"

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

        Background ->
            "Background Normal"

        Surface ->
            "Surface"

        Surface2dp ->
            "Surface 2dp"

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
    [ Background
    , Surface
    , Surface2dp
    , FontMediumEmphasis
    , Primary
    , PrimaryVariant
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
    Tuple.first <| toColor_ theme colorDerived


toColor_ : R10.Theme.Theme -> Color -> ( Color.Color, String )
toColor_ theme colorDerived =
    case colorDerived of
        Success ->
            ( R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Success
            , "same as base color `Succes`"
            )

        Logo ->
            ( case theme.mode of
                R10.Mode.Light ->
                    primary_ theme

                R10.Mode.Dark ->
                    highEmphasis_ theme
            , "Logo color is the same as primary color in light mode and `highEmphasis` in dark mode"
            )

        Primary ->
            ( primary_ theme
            , "Just the primary color"
            )

        PrimaryVariant ->
            ( primary_ theme
                |> Color.Manipulate.scaleHsl
                    { saturationScale = -0.4
                    , lightnessScale = 0
                    , alphaScale = -0.6
                    }
            , "Like the primary, but more subtle"
            )

        FontMediumEmphasis ->
            ( mediumEmphasis_ theme
            , "A color used for fonts when they carry a less important message. It is made changing the alpha channel to 0.6 so the result is that is going to be more similar to the background."
            )

        FontHighEmphasis ->
            ( highEmphasis_ theme
            , "The default color for text. It is made changing the alpha channel to 0.87."
            )

        FontLink ->
            ( R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.FontLink
            , "The same as the base `FontLink` color"
            )

        Error ->
            ( R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Error
            , "The same as the base `Error` color"
            )

        Debugger ->
            ( R10.Color.Internal.Primary.toColor theme R10.Color.Internal.Primary.LightBlue
            , "The same as the base `LightBlue` color"
            )

        FontMediumEmphasisWithMaximumContrast ->
            let
                goesOn : R10.Theme.Theme -> Color.Color
                goesOn =
                    primary_

                color1 : Color.Color
                color1 =
                    mediumEmphasis_ theme

                color2 : Color.Color
                color2 =
                    mediumEmphasisReversed_ theme

                colorFont : Color.Color
                colorFont =
                    Maybe.withDefault color1 <|
                        Color.Accessibility.maximumContrast (goesOn theme) [ color1, color2 ]
            in
            ( colorFont
            , "A `mediumEmphasis` color for less important text that goes above a primary color"
            )

        FontHighEmphasisWithMaximumContrast ->
            let
                goesOn : R10.Theme.Theme -> Color.Color
                goesOn =
                    primary_

                color1 : Color.Color
                color1 =
                    highEmphasis_ theme

                color2 : Color.Color
                color2 =
                    highEmphasisReversed_ theme

                colorFont : Color.Color
                colorFont =
                    Maybe.withDefault color1 <|
                        Color.Accessibility.maximumContrast (goesOn theme) [ color1, color2 ]
            in
            ( colorFont
            , "A `highEmphasis` color for regular text that goes above a primary color"
            )

        Border ->
            ( R10.Color.Internal.Base.Font
                |> R10.Color.Internal.Base.toColor theme
                |> R10.Color.Utils.setAlpha 0.2
            , "Color for borders derived from the base `Font` changing the alpha channel to 0.2"
            )

        BackgroundPhoneDropdown ->
            -- TODO - Verify if this color can actually be replaced with BackgroundInputFieldText
            ( case theme.mode of
                R10.Mode.Light ->
                    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Background

                R10.Mode.Dark ->
                    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Background
                        |> Color.Manipulate.lighten 0.05
            , "A special background for the phone dropdown. On `light` mode is the same as the base `Background` but in `dark` mode is lighter 0.05 compared to the base `Background` so that it became visible."
            )

        Background ->
            ( R10.Color.Internal.Base.Background
                |> R10.Color.Internal.Base.toColor theme
            , "The same as the base `Background`."
            )

        Surface ->
            ( case theme.mode of
                R10.Mode.Light ->
                    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Background
                        |> Color.Manipulate.lighten 0.05

                R10.Mode.Dark ->
                    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Background
                        |> Color.Manipulate.lighten 0.05
            , "A color for surfaces above the background, 1dp (See https://material.io/design/color/dark-theme.html#anatomy)"
            )

        Surface2dp ->
            ( case theme.mode of
                R10.Mode.Light ->
                    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Background
                        |> Color.Manipulate.lighten 0.1

                R10.Mode.Dark ->
                    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Background
                        |> Color.Manipulate.lighten 0.1
            , "A color for surfaces above the background, 2dp (See https://material.io/design/color/dark-theme.html#anatomy)"
            )

        BackgroundInputFieldText ->
            ( case theme.mode of
                R10.Mode.Light ->
                    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Background
                        |> Color.Manipulate.darken 0.05

                R10.Mode.Dark ->
                    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Background
                        |> Color.Manipulate.lighten 0.05
            , "A special background color for input fields. In `light` mode is sligthly darken than normal background. In `dark` mode is sligthly lighten than normal background."
            )

        BackgroundButtonPrimaryOver ->
            ( R10.Color.Internal.Primary.toColor theme theme.primaryColor
                |> Color.Manipulate.scaleHsl
                    { saturationScale = -0.15
                    , lightnessScale = 0.17
                    , alphaScale = 0
                    }
            , "The mouse-over color for the primary button obtained adding a `scaleHsl` transformation to the primary color."
            )

        BackgroundButtonPrimaryDisabledOver ->
            ( backgroundButtonPrimaryDisabled_ theme
                |> Color.Manipulate.scaleHsl
                    { saturationScale = 0
                    , lightnessScale = 0.2
                    , alphaScale = 0
                    }
            , "The mouse-over color for the disabled primary button obtained adding a `scaleHsl` transformation to the primary color that has been already transformed to change it to disabled."
            )

        BackgroundButtonPrimaryDisabled ->
            ( backgroundButtonPrimaryDisabled_ theme
            , "The background color of disabled primary button obtained. This is made making it ligher on Light mode and darker on Dark mode."
            )

        BackgroundButtonPrimary ->
            ( R10.Color.Internal.Primary.toColor theme theme.primaryColor
            , "Just the primary color, extracted from the `theme`."
            )

        BackgroundButtonMinorOver ->
            ( R10.Color.Internal.Base.Background
                |> R10.Color.Internal.Base.toColor theme
                |> (\color ->
                        case theme.mode of
                            R10.Mode.Dark ->
                                Color.Manipulate.lighten 0.07 color

                            R10.Mode.Light ->
                                Color.Manipulate.darken 0.08 color
                   )
            , "Background of minors buttons based on the normal background color. Just making it lighter in Dark mode and darker in Light mode"
            )



-- From here colors that are used several times so they are
-- extracted in separated functions


backgroundButtonPrimaryDisabled_ : R10.Theme.Theme -> Color.Color
backgroundButtonPrimaryDisabled_ theme =
    R10.Color.Internal.Base.Background
        |> R10.Color.Internal.Base.toColor theme
        |> (\color ->
                case theme.mode of
                    R10.Mode.Dark ->
                        Color.Manipulate.lighten 0.2 color

                    R10.Mode.Light ->
                        Color.Manipulate.darken 0.2 color
           )


highEmphasis_ : R10.Theme.Theme -> Color.Color
highEmphasis_ theme =
    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Font
        -- https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
        |> R10.Color.Utils.setAlpha 0.87


highEmphasisReversed_ : R10.Theme.Theme -> Color.Color
highEmphasisReversed_ theme =
    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.FontReversed
        -- https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
        |> R10.Color.Utils.setAlpha 0.87


mediumEmphasis_ : R10.Theme.Theme -> Color.Color
mediumEmphasis_ theme =
    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.Font
        -- https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
        |> R10.Color.Utils.setAlpha 0.6


mediumEmphasisReversed_ : R10.Theme.Theme -> Color.Color
mediumEmphasisReversed_ theme =
    R10.Color.Internal.Base.toColor theme R10.Color.Internal.Base.FontReversed
        -- https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
        |> R10.Color.Utils.setAlpha 0.6


primary_ : R10.Theme.Theme -> Color.Color
primary_ theme =
    R10.Color.Internal.Primary.toColor theme theme.primaryColor
