module R10.Paragraph exposing
    ( large, normal, small, xlarge, xxlarge, xsmall, xxsmall
    , normalMarkdown
    )

{-| Paraggraphs.

@docs large, normal, small, xlarge, xxlarge, xsmall, xxsmall

@docs normalMarkdown

-}

import Element.WithContext exposing (..)
import R10.Context exposing (..)
import R10.FontSize
import R10.Link
import R10.SimpleMarkdown


spacingNormal : Int
spacingNormal =
    10


{-| -}
xxlarge : List (Attribute (R10.Context.ContextInternal z) msg) -> List (Element (R10.Context.ContextInternal z) msg) -> Element (R10.Context.ContextInternal z) msg
xxlarge attrs children =
    paragraph ([ R10.FontSize.xxlarge, spacing <| spacingNormal ] ++ attrs) children


{-| -}
xlarge : List (Attribute (R10.Context.ContextInternal z) msg) -> List (Element (R10.Context.ContextInternal z) msg) -> Element (R10.Context.ContextInternal z) msg
xlarge attrs children =
    paragraph ([ R10.FontSize.xlarge, spacing <| spacingNormal ] ++ attrs) children


{-| -}
large : List (Attribute (R10.Context.ContextInternal z) msg) -> List (Element (R10.Context.ContextInternal z) msg) -> Element (R10.Context.ContextInternal z) msg
large attrs children =
    paragraph ([ R10.FontSize.large, spacing <| spacingNormal ] ++ attrs) children


{-| -}
normalMarkdown : List (Attribute (R10.Context.ContextInternal z) msg) -> String -> Element (R10.Context.ContextInternal z) msg
normalMarkdown attrs string =
    normal attrs
        (R10.SimpleMarkdown.elementMarkdownAdvanced
            { link = R10.Link.attrsUnderline }
            string
        )


{-| -}
normal : List (Attribute (R10.Context.ContextInternal z) msg) -> List (Element (R10.Context.ContextInternal z) msg) -> Element (R10.Context.ContextInternal z) msg
normal attrs children =
    paragraph ([ R10.FontSize.normal, spacing <| spacingNormal ] ++ attrs) children


{-| -}
small : List (Attribute (R10.Context.ContextInternal z) msg) -> List (Element (R10.Context.ContextInternal z) msg) -> Element (R10.Context.ContextInternal z) msg
small attrs children =
    paragraph ([ R10.FontSize.small, spacing <| spacingNormal - 3 ] ++ attrs) children


{-| -}
xsmall : List (Attribute (R10.Context.ContextInternal z) msg) -> List (Element (R10.Context.ContextInternal z) msg) -> Element (R10.Context.ContextInternal z) msg
xsmall attrs children =
    paragraph ([ R10.FontSize.xsmall, spacing <| spacingNormal - 6 ] ++ attrs) children


{-| -}
xxsmall : List (Attribute (R10.Context.ContextInternal z) msg) -> List (Element (R10.Context.ContextInternal z) msg) -> Element (R10.Context.ContextInternal z) msg
xxsmall attrs children =
    paragraph ([ R10.FontSize.xsmall, spacing <| spacingNormal - 9 ] ++ attrs) children
