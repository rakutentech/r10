module R10.Palette exposing
    ( Palette
    , black
    , crimson
    , crimsonLight
    , danger
    , dark
    , fromTheme
    , gray
    , grayDark
    , grayDarker
    , grayDarkest
    , grayLight
    , grayLighter
    , grayLightest
    , grayMedium
    , grayMediumLight
    , indigo
    , info
    , light
    , pink
    , success
    , warning
    , white
    , withOpacity
    )

import Color
import R10.Color.Svg
import R10.Color.Utils
import R10.Theme


{-|

    type alias Palette =
        { primary : Color
        , primaryVariant : Color
        , success : Color
        , error : Color

        -- Text Colors
        --
        , onSurface : Color
        , onPrimary : Color

        -- Background Colors
        --
        , surface : Color
        , background : Color
        }

Note that these are `Color` from `elm-ui`.

See <https://material.io/design/color/dark-theme.html#properties> for more details.

If you want to use the default palette, just pass `Nothing`

-}
type alias Palette =
    { -- Colors
      primary : Color.Color
    , primaryVariant : Color.Color
    , success : Color.Color
    , error : Color.Color
    , border : Color.Color

    -- Text Colors
    , onSurface : Color.Color
    , onPrimary : Color.Color

    -- Background Colors
    , surface : Color.Color -- Card, List background color https://material.io/design/color/dark-theme.html#properties
    , background : Color.Color
    }


{-| get Palette to use with R10.FormComponents lib
-}
fromTheme : R10.Theme.Theme -> Palette
fromTheme theme =
    { primary = R10.Color.Utils.toColorColor <| R10.Color.Svg.primary theme
    , onPrimary = R10.Color.Utils.toColorColor <| R10.Color.Svg.fontHighEmphasisWithMaximumContrast theme

    --
    , surface = R10.Color.Utils.toColorColor <| R10.Color.Svg.surface2dp theme
    , onSurface = R10.Color.Utils.toColorColor <| R10.Color.Svg.fontHighEmphasis theme

    --
    , primaryVariant = R10.Color.Utils.toColorColor <| R10.Color.Svg.primaryVariant theme
    , success = R10.Color.Utils.toColorColor <| R10.Color.Svg.fontAlertSuccess theme
    , error = R10.Color.Utils.toColorColor <| R10.Color.Svg.fontAlertDanger theme
    , background = R10.Color.Utils.toColorColor <| R10.Color.Svg.background theme

    --
    , border = R10.Color.Utils.toColorColor <| R10.Color.Svg.border theme
    }



{- Utils for working with colors. -}


{-| Change Color opacity
-}
withOpacity : Float -> Color.Color -> Color.Color
withOpacity opacity =
    Color.toRgba >> (\rgba -> { rgba | alpha = opacity }) >> Color.fromRgba



{-
   Palette Colors Examples
-}


dark : Palette
dark =
    { primary = indigo
    , primaryVariant = indigoVariant
    , success = success
    , error = warning
    , onSurface = grayLightest
    , onPrimary = white
    , surface = grayDarker
    , background = grayDarkest
    , border = gray
    }


light : Palette
light =
    { primary = pink
    , primaryVariant = pinkVariant
    , success = success
    , error = warning
    , onSurface = black -- https://material.io/design/color/text-legibility.html#text-types
    , onPrimary = white -- https://material.io/design/color/text-legibility.html#text-types
    , surface = white
    , background = grayLightest
    , border = gray
    }



{-
   System Color
-}


indigo : Color.Color
indigo =
    -- @indigo: #9fa8da
    Color.rgb255 159 168 218


indigoVariant : Color.Color
indigoVariant =
    -- @indigo-variant: #6f79a8
    Color.rgb255 111 121 168


pink : Color.Color
pink =
    -- @mssp-pink: #FF3366
    Color.rgb255 255 51 102


pinkVariant : Color.Color
pinkVariant =
    -- @mssp-pink-light: #ff6f93
    Color.rgb255 255 111 147


crimson : Color.Color
crimson =
    -- @rakuten-red: #BF0000
    Color.rgb255 191 0 0


crimsonLight : Color.Color
crimsonLight =
    -- @rakuten-red: #BF0000
    Color.rgb255 249 76 46


success : Color.Color
success =
    -- @success: #069907
    Color.rgb255 6 153 7


info : Color.Color
info =
    -- @info: #009AE9
    Color.rgb255 0 154 233


warning : Color.Color
warning =
    -- @warning: #ff9100
    Color.rgb255 255 145 0


danger : Color.Color
danger =
    -- @danger: #FF3939
    Color.rgb255 255 57 57



{-
   Grayscale Color
-}


black : Color.Color
black =
    -- @black: #000
    Color.rgb255 0 0 0


grayDarkest : Color.Color
grayDarkest =
    -- @gray-darkest: lighten(#000, 80%) // #333
    Color.rgb255 51 51 51


grayDarker : Color.Color
grayDarker =
    -- @gray-darker: lighten(#000, 70%) // #4D4D4D
    Color.rgb255 77 77 77


grayDark : Color.Color
grayDark =
    -- @gray-dark: lighten(#000, 59%) // #686868
    Color.rgb255 104 104 104


gray : Color.Color
gray =
    -- @gray: lighten(#000, 49%) // #828282
    Color.rgb255 130 130 130


grayMedium : Color.Color
grayMedium =
    -- @gray-medium: lighten(#000, 39%) // #9c9c9c
    Color.rgb255 156 156 156


grayMediumLight : Color.Color
grayMediumLight =
    -- @gray-medium-light: lighten(#000, 29%) // #B6B6B6
    Color.rgb255 182 182 182


grayLight : Color.Color
grayLight =
    -- @gray-light: lighten(#000, 18%) // #D1D1D1
    Color.rgb255 209 209 209


grayLighter : Color.Color
grayLighter =
    -- @gray-lighter: lighten(#000, 8%) // #EBEBEB
    Color.rgb255 235 235 235


grayLightest : Color.Color
grayLightest =
    -- @gray-lightest: lighten(#000, 3%) // #F7F7F7
    Color.rgb255 247 247 247


white : Color.Color
white =
    -- @white: #FFF
    Color.rgb255 255 255 255
