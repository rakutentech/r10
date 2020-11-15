module R10.FontSize exposing (large, normal, small, xlarge, xxlarge, xsmall, xxsmall)

{-| Font sizes

@docs large, normal, small, xlarge, xxlarge, xsmall, xxsmall

-}

import Element exposing (..)
import Element.Font


{-| -}
xlarge : Attr decorative msg
xlarge =
    Element.Font.size 24


{-| -}
xxlarge : Attr decorative msg
xxlarge =
    Element.Font.size 32


{-| -}
large : Attr decorative msg
large =
    Element.Font.size 20


{-| -}
normal : Attr decorative msg
normal =
    Element.Font.size 16


{-| -}
small : Attr decorative msg
small =
    Element.Font.size 14


{-| -}
xsmall : Attr decorative msg
xsmall =
    Element.Font.size 13


{-| -}
xxsmall : Attr decorative msg
xxsmall =
    Element.Font.size 12
