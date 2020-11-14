module R10.Color exposing
    ( Base
    , Primary, primary, decoder, decoderExploration
    , Derived
    , logo
    , listPrimary, listBase, listDerived
    )

{-| These lists are just to be used to create documentations, not to actually use colors in the layout.


# Base

Base colors are the only color, together with one primary color, that are used to derive all other colors for the interface.

They are different depending on the mode:

![Colors](https://r10.netlify.app/images/base_500.png)

@docs Base


# Primary

These represent the brands color of Rakuten.

Rakutenn Brand guideline: <https://global.rakuten.com/corp/brand/>

![Colors](https://r10.netlify.app/images/colors-overview400.png)

@docs Primary, primary, decoder, decoderExploration


# Derived

@docs Derived


# Colors

These are colors that can be used for SVGs because SVGs don't accept `Element.Attr` as they are not part of the `elm-ui` package.

For all other colors, look into `R10.Color.Attr...` modules.

@docs logo


# Lists

These lists should only be used to generate documentation.

@docs listPrimary, listBase, listDerived

-}

import Color
import Json.Decode
import Json.Decode.Exploration
import R10.Color.Internal.Base
import R10.Color.Internal.Derived
import R10.Color.Internal.Primary
import R10.Theme



-- EXPOSING PRIMARY COLOR STUFF


{-| -}
type alias Primary =
    R10.Color.Internal.Primary.Color


{-| -}
primary :
    { crimsonRed : Primary
    , orange : Primary
    , yellow : Primary
    , green : Primary
    , lightBlue : Primary
    , blue : Primary
    , purple : Primary
    , pink : Primary
    }
primary =
    { yellow = R10.Color.Internal.Primary.Yellow
    , purple = R10.Color.Internal.Primary.Purple
    , pink = R10.Color.Internal.Primary.Pink
    , orange = R10.Color.Internal.Primary.Orange
    , lightBlue = R10.Color.Internal.Primary.LightBlue
    , green = R10.Color.Internal.Primary.Green
    , crimsonRed = R10.Color.Internal.Primary.CrimsonRed
    , blue = R10.Color.Internal.Primary.Blue
    }


{-| -}
decoder : Json.Decode.Decoder Primary
decoder =
    R10.Color.Internal.Primary.decoder


{-| -}
decoderExploration : Json.Decode.Exploration.Decoder Primary
decoderExploration =
    R10.Color.Internal.Primary.decoderExploration



-- EXPOSING BASE COLOR STUFF


{-| -}
type alias Base =
    R10.Color.Internal.Base.Color



-- EXPOSING DERIVED COLOR STUFF


{-| -}
type alias Derived =
    R10.Color.Internal.Derived.Color



-- COLORS


{-| -}
logo : R10.Theme.Theme -> Color.Color
logo theme =
    R10.Color.Internal.Derived.Logo
        |> R10.Color.Internal.Derived.toColor theme



-- LISTS


{-| -}
listPrimary : R10.Theme.Theme -> List { color : Color.Color, name : String, type_ : Primary }
listPrimary =
    R10.Color.Internal.Primary.list


{-| -}
listBase : R10.Theme.Theme -> List { color : Color.Color, name : String }
listBase theme =
    R10.Color.Internal.Base.list theme


{-| -}
listDerived : R10.Theme.Theme -> List { color : Color.Color, name : String }
listDerived theme =
    R10.Color.Internal.Derived.list theme
