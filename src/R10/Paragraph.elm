module R10.Paragraph exposing
    ( large, normal, small, xlarge, xxlarge, xsmall, xxsmall
    , normalMarkdown
    )

{-| Paraggraphs.

@docs large, normal, small, xlarge, xxlarge, xsmall, xxsmall

@docs normalMarkdown

-}

import Element.WithContext exposing (..)
import R10.FontSize
import R10.Link
import R10.SimpleMarkdown
import R10.Context exposing (..)


spacingNormal : Int
spacingNormal =
    10


paragraphSpacing : AttributeC msg
paragraphSpacing =
    spacing spacingNormal


{-| -}
xxlarge : List (AttributeC msg) -> List (ElementC msg) -> ElementC msg
xxlarge attrs children =
    paragraph ([ R10.FontSize.xxlarge, spacing <| spacingNormal ] ++ attrs) children


{-| -}
xlarge : List (AttributeC msg) -> List (ElementC msg) -> ElementC msg
xlarge attrs children =
    paragraph ([ R10.FontSize.xlarge, spacing <| spacingNormal ] ++ attrs) children


{-| -}
large : List (AttributeC msg) -> List (ElementC msg) -> ElementC msg
large attrs children =
    paragraph ([ R10.FontSize.large, spacing <| spacingNormal ] ++ attrs) children


{-| -}
normalMarkdown : List (AttributeC msg) -> String -> ElementC msg
normalMarkdown attrs string =
    normal attrs
        (R10.SimpleMarkdown.elementMarkdownAdvanced
            { link = R10.Link.attrs }
            string
        )


{-| -}
normal : List (AttributeC msg) -> List (ElementC msg) -> ElementC msg
normal attrs children =
    paragraph ([ R10.FontSize.normal, spacing <| spacingNormal ] ++ attrs) children


{-| -}
small : List (AttributeC msg) -> List (ElementC msg) -> ElementC msg
small attrs children =
    paragraph ([ R10.FontSize.small, spacing <| spacingNormal - 3 ] ++ attrs) children


{-| -}
xsmall : List (AttributeC msg) -> List (ElementC msg) -> ElementC msg
xsmall attrs children =
    paragraph ([ R10.FontSize.xsmall, spacing <| spacingNormal - 6 ] ++ attrs) children


{-| -}
xxsmall : List (AttributeC msg) -> List (ElementC msg) -> ElementC msg
xxsmall attrs children =
    paragraph ([ R10.FontSize.xsmall, spacing <| spacingNormal - 9 ] ++ attrs) children
