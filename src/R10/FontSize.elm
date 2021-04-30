module R10.FontSize exposing
    ( large, normal, small, xlarge, xxlarge, xsmall, xxsmall
    , normalAsInt
    )

{-| Font sizes

@docs large, normal, small, xlarge, xxlarge, xsmall, xxsmall

@docs normalAsInt

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
normalAsInt : Int
normalAsInt =
    16


{-| -}
normal : Attr decorative msg
normal =
    Element.Font.size normalAsInt


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
