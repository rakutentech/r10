module R10.Card exposing (high, low, normal, noShadow)

{-| Cards are area of the page surranded by a rounded border.

@docs high, low, normal, noShadow

-}

import Element.WithContext exposing (..)
import Element.WithContext.Border as Border
import Html.Attributes
import R10.Color.AttrsBackground
import R10.Color.AttrsBorder
import R10.Color.AttrsFont
import R10.Context exposing (..)
import R10.Mode
import R10.Theme


shadow : Float -> AttrC decorative msg
shadow level =
    Border.shadow
        { offset = ( 0, level )
        , blur = level + 2
        , size = level - 2
        , color = rgba255 0 0 0 0.07
        }


base : R10.Theme.Theme -> List (AttributeC msg)
base theme =
    [ R10.Color.AttrsBackground.surface
    , R10.Color.AttrsBorder.normal
    , R10.Color.AttrsFont.normal
    , Border.rounded 10
    , Border.width 1
    , Border.color <|
        case theme.mode of
            R10.Mode.Light ->
                rgba 0 0 0 0.1

            R10.Mode.Dark ->
                rgba 1 1 1 0.08
    , padding 30
    , width fill
    , height fill
    , R10.Transition.transition "background-color 0.8s"
    ]


{-| Card with an high shadow
-}
high : R10.Theme.Theme -> List (AttributeC msg)
high theme =
    --https://material.io/design/environment/elevation.html#elevation-in-material-design
    base theme ++ [ shadow 8 ]


{-| Card with a normal shadow
-}
normal : R10.Theme.Theme -> List (AttributeC msg)
normal theme =
    -- base theme ++ [ shadow 2, mouseOver [ shadow 8 ] ]
    base theme ++ [ shadow 4 ]


{-| Card with a low shadow
-}
low : R10.Theme.Theme -> List (AttributeC msg)
low theme =
    base theme ++ [ shadow 2 ]


{-| Card without a shadow
-}
noShadow : R10.Theme.Theme -> List (AttributeC msg)
noShadow theme =
    base theme
