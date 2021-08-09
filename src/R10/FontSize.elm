module R10.FontSize exposing
    ( large, normal, small, xlarge, xxlarge, xsmall, xxsmall
    , normalAsInt
    )

{-| Font sizes

@docs large, normal, small, xlarge, xxlarge, xsmall, xxsmall

@docs normalAsInt

-}

import Element.WithContext exposing (..)
import Element.WithContext.Font as Font
import R10.Context exposing (..)


{-| -}
xlarge : AttrC decorative msg
xlarge =
    Font.size 24


{-| -}
xxlarge : AttrC decorative msg
xxlarge =
    Font.size 32


{-| -}
large : AttrC decorative msg
large =
    Font.size 20


{-| -}
normalAsInt : Int
normalAsInt =
    16


{-| -}
normal : AttrC decorative msg
normal =
    Font.size normalAsInt


{-| -}
small : AttrC decorative msg
small =
    Font.size 14


{-| -}
xsmall : AttrC decorative msg
xsmall =
    Font.size 13


{-| -}
xxsmall : AttrC decorative msg
xxsmall =
    Font.size 12
