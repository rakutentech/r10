module R10.Link exposing (attrs)

{-|

@docs attrs

-}

import Element exposing (..)
import Html.Attributes
import R10.Color.AttrFont
import R10.Theme


{-| Attributes for links, useful if you need to make some text to render as if it was a link.
-}
attrs : R10.Theme.Theme -> List (Attr () msg)
attrs theme =
    [ R10.Color.AttrFont.link theme
    , mouseOver [ R10.Color.AttrFont.linkOver theme ]
    , transition
    ]


transition : Attribute msg
transition =
    htmlAttribute <| Html.Attributes.style "transition" "color .2s ease-out, background-color .2s ease-out"
