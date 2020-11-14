module R10.Color exposing
    ( Primary, primary
    , Base
    , listPrimary, listBase
    )

{-| These lists are just to be used to create documentations, not to actually use colors in the layout.


# Primary

These represent the brands color of Rakuten.

Rakutenn Brand guideline: <https://global.rakuten.com/corp/brand/>

![Colors](https://r10.netlify.app/images/colors-overview400.png)

@docs Primary, primary


# Base

![Colors](https://r10.netlify.app/images/base_500.png)

@docs Base


# Lists

These lists should only be used to generate documentation.

@docs listPrimary, listBase

-}

import Color
import R10.Color.Internal.Base
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



-- EXPOSING BASE COLOR STUFF


{-| -}
type alias Base =
    R10.Color.Internal.Base.Color



-- LISTS


{-| -}
listPrimary : R10.Theme.Theme -> List { color : Color.Color, name : String }
listPrimary =
    R10.Color.Internal.Primary.list


{-| -}
listBase : R10.Theme.Theme -> List { color : Color.Color, name : String }
listBase theme =
    R10.Color.Internal.Base.list theme
