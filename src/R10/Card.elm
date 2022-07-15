module R10.Card exposing (high, low, normal, noShadow)

{-| Cards are area of the page surranded by a rounded border.

@docs high, low, normal, noShadow

-}

import Element.WithContext exposing (..)
import Element.WithContext.Border as Border
import R10.Color.AttrsBackground
import R10.Color.AttrsBorder
import R10.Color.AttrsFont
import R10.Context exposing (..)
import R10.Mode
import R10.Transition


shadow : Float -> Attr (R10.Context.ContextInternal z) decorative msg
shadow level =
    Border.shadow
        { offset = ( 0, level )
        , blur = level + 2
        , size = level - 2
        , color = rgba255 0 0 0 0.07
        }


base : List (Attribute (R10.Context.ContextInternal context) msg)
base =
    [ R10.Color.AttrsBackground.surface
    , R10.Color.AttrsBorder.normal
    , R10.Color.AttrsFont.normal
    , Border.rounded 10
    , Border.width 1
    , withContextAttribute <|
        \c ->
            Border.color <|
                case c.contextR10.theme.mode of
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
high : List (Attribute (R10.Context.ContextInternal context) msg)
high =
    -- https://material.io/design/environment/elevation.html#elevation-in-material-design
    base ++ [ shadow 8 ]


{-| Card with a normal shadow
-}
normal : List (Attribute (R10.Context.ContextInternal context) msg)
normal =
    -- base  ++ [ shadow 2, mouseOver [ shadow 8 ] ]
    base ++ [ shadow 4 ]


{-| Card with a low shadow
-}
low : List (Attribute (R10.Context.ContextInternal context) msg)
low =
    base ++ [ shadow 2 ]


{-| Card without a shadow
-}
noShadow : List (Attribute (R10.Context.ContextInternal context) msg)
noShadow =
    base
