module R10.Color exposing
    ( Base
    , Primary, primary, primaryDefault, primaryToString, primaryDecoder, primaryDecoderExploration
    , Derived
    , listPrimary, listBase, listDerived
    , maximumContrast
    )

{-| These lists are just to be used to create documentations, not to actually use colors in the layout.


# Base

Base colors are the only color, together with one primary color, that are used to derive all other colors for the interface.

They are different depending on the mode:

![Colors](https://r10.netlify.app/images/base_500.png)

@docs Base


# Primary

These represent the brands color of Rakuten.

Rakuten Brand guideline: <https://global.rakuten.com/corp/brand/>

![Colors](https://r10.netlify.app/images/colors-overview400.png)

@docs Primary, primary, primaryDefault, primaryToString, primaryDecoder, primaryDecoderExploration


# Derived

@docs Derived


# Lists

These lists should only be used to generate documentation.

@docs listPrimary, listBase, listDerived


# Utils

@docs maximumContrast

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
    , red : Primary
    , orange : Primary
    , yellow : Primary
    , green : Primary
    , lightBlue : Primary
    , blue : Primary
    , blueSky : Primary
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
    , red = R10.Color.Internal.Primary.CrimsonRed
    , blue = R10.Color.Internal.Primary.Blue
    , blueSky = R10.Color.Internal.Primary.BlueSky
    }


{-| -}
primaryDecoder : Json.Decode.Decoder Primary
primaryDecoder =
    R10.Color.Internal.Primary.decoder


{-| -}
primaryDecoderExploration : Json.Decode.Exploration.Decoder Primary
primaryDecoderExploration =
    R10.Color.Internal.Primary.decoderExploration


{-| -}
primaryToString : Primary -> String
primaryToString =
    R10.Color.Internal.Primary.toString


{-| -}
primaryDefault : Primary
primaryDefault =
    R10.Color.Internal.Primary.default



-- EXPOSING BASE COLOR STUFF


{-| -}
type alias Base =
    R10.Color.Internal.Base.Color



-- EXPOSING DERIVED COLOR STUFF


{-| -}
type alias Derived =
    R10.Color.Internal.Derived.Color



-- LISTS


{-| -}
listPrimary : R10.Theme.Theme -> List { color : Color.Color, name : String, description : String, type_ : Primary }
listPrimary =
    R10.Color.Internal.Primary.list


{-| -}
listBase : R10.Theme.Theme -> List { color : Color.Color, name : String }
listBase theme =
    R10.Color.Internal.Base.list theme


{-| -}
listDerived : R10.Theme.Theme -> List { color : Color.Color, name : String, description : String }
listDerived theme =
    R10.Color.Internal.Derived.list theme


{-| A sligtly modified version of `Color.Accessibility.maximumContrast`
-}
maximumContrast : Color.Color -> List Color.Color -> Maybe Color.Color
maximumContrast =
    R10.Color.Internal.Derived.maximumContrast
