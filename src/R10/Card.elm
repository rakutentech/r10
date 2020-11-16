module R10.Card exposing (high, low, normal)

{-| Cards are area of the page surranded by a rounded border.

@docs high, low, normal

-}

import Element exposing (..)
import Element.Border as Border
import Html.Attributes
import R10.Color.AttrsBackground
import R10.Color.AttrsBorder
import R10.Color.AttrsFont
import R10.Theme


shadow : Float -> Attr decorative msg
shadow level =
    Border.shadow
        { offset = ( 0, level )
        , blur = level
        , size = 0
        , color = rgba255 0 0 0 0.14
        }


base : R10.Theme.Theme -> List (Attribute msg)
base theme =
    [ R10.Color.AttrsBackground.normal theme
    , R10.Color.AttrsBorder.normal theme
    , R10.Color.AttrsFont.normal theme
    , Border.rounded 10
    , Border.width 1
    , padding 30
    , width fill
    , height fill
    , htmlAttribute <| Html.Attributes.style "transition" "all 0.2s"
    ]


{-| Card with an high shadow
-}
high : R10.Theme.Theme -> List (Attribute msg)
high theme =
    --https://material.io/design/environment/elevation.html#elevation-in-material-design
    base theme ++ [ shadow 8 ]


{-| Card with a normal shadow
-}
normal : R10.Theme.Theme -> List (Attribute msg)
normal theme =
    base theme ++ [ shadow 2, mouseOver [ shadow 8 ] ]


{-| Card with a low shadow
-}
low : R10.Theme.Theme -> List (Attribute msg)
low theme =
    base theme ++ [ shadow 2 ]
