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
xlarge : Attr (R10.Context.ContextInternal z) decorative msg
xlarge =
    Font.size 24


{-| -}
xxlarge : Attr (R10.Context.ContextInternal z) decorative msg
xxlarge =
    Font.size 32


{-| -}
large : Attr (R10.Context.ContextInternal z) decorative msg
large =
    Font.size 20


{-| -}
normalAsInt : Int
normalAsInt =
    16


{-| -}
normal : Attr (R10.Context.ContextInternal z) decorative msg
normal =
    Font.size normalAsInt


{-| -}
small : Attr (R10.Context.ContextInternal z) decorative msg
small =
    Font.size 14


{-| -}
xsmall : Attr (R10.Context.ContextInternal z) decorative msg
xsmall =
    Font.size 13


{-| -}
xxsmall : Attr (R10.Context.ContextInternal z) decorative msg
xxsmall =
    Font.size 12
