module R10.Link exposing (attrs)

{-|

@docs attrs

-}

import Element.WithContext exposing (..)
import Html.Attributes
import R10.Color.AttrsFont
import R10.Context exposing (..)
import R10.Transition


{-| Attributes for links, useful if you need to make some text to render as if it was a link.
-}
attrs : List (Attr (R10.Context.ContextInternal z) () msg)
attrs =
    [ R10.Color.AttrsFont.link
    , mouseOver [ R10.Color.AttrsFont.linkOver ]
    , transition
    ]


transition : Attribute (R10.Context.ContextInternal z) msg
transition =
    R10.Transition.transition "color .2s ease-out, background-color .2s ease-out"
