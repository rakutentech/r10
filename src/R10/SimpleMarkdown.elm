module R10.SimpleMarkdown exposing (MarkDown(..), elementMarkdown, elementMarkdownAdvanced, markdown, parseTextForLinks)

{-| Parser for seimplified markdown text.

@docs MarkDown, elementMarkdown, elementMarkdownAdvanced, markdown, parseTextForLinks

-}

import Array
import Element.WithContext exposing (..)
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Html.Attributes
import R10.Context exposing (..)
import Regex



-- ███████ ██ ███    ███ ██████  ██      ███████     ███    ███  █████  ██████  ██   ██ ██████   ██████  ██     ██ ███    ██
-- ██      ██ ████  ████ ██   ██ ██      ██          ████  ████ ██   ██ ██   ██ ██  ██  ██   ██ ██    ██ ██     ██ ████   ██
-- ███████ ██ ██ ████ ██ ██████  ██      █████       ██ ████ ██ ███████ ██████  █████   ██   ██ ██    ██ ██  █  ██ ██ ██  ██
--      ██ ██ ██  ██  ██ ██      ██      ██          ██  ██  ██ ██   ██ ██   ██ ██  ██  ██   ██ ██    ██ ██ ███ ██ ██  ██ ██
-- ███████ ██ ██      ██ ██      ███████ ███████     ██      ██ ██   ██ ██   ██ ██   ██ ██████   ██████   ███ ███  ██   ████


{-| -}
type MarkDown
    = MarkDownText String
    | MarkDownLink String String
    | MarkDownBold String
    | MarkDownBreakLine


regexForLinks : Maybe Regex.Regex
regexForLinks =
    -- This regex match constructs like "[Link text](Url)"
    Regex.fromString "\\[([^\\[\\]]+)\\]\\(([^()]+)\\)"


regexForBold : Maybe Regex.Regex
regexForBold =
    -- This regex match constructs like "**bold text**"
    Regex.fromString "\\*\\*([^*]*)\\*\\*"


regexForBreakLine : Maybe Regex.Regex
regexForBreakLine =
    -- This regex match "<br>"
    Regex.fromString "<br>"


markDownParseLinkData : List String -> MarkDown
markDownParseLinkData data =
    let
        text1 =
            Maybe.withDefault "" <| List.head data

        text2 =
            Maybe.withDefault "" <| List.head (Maybe.withDefault [] <| List.tail data)
    in
    MarkDownLink text1 text2


parseTextForBold : String -> List MarkDown
parseTextForBold text =
    --
    -- This function turn a bold text
    --
    -- "a**b**c"
    --
    -- into something like
    --
    -- [ MarkDownText "a"
    -- , MarkDownBold "b"
    -- , MarkDownText "c"
    -- ]
    --
    let
        ( find, split ) =
            case regexForBold of
                Just regex ->
                    ( Regex.find regex text, Regex.split regex text )

                Nothing ->
                    ( [], [] )
    in
    List.concat <|
        List.indexedMap
            (\index splitted ->
                let
                    maybeGetFinding =
                        Maybe.map
                            (\match ->
                                List.map
                                    (\item_ ->
                                        case item_ of
                                            Just i ->
                                                i

                                            Nothing ->
                                                ""
                                    )
                                    match.submatches
                            )
                            (Array.get index (Array.fromList find))
                in
                case maybeGetFinding of
                    Just getFinding ->
                        [ MarkDownText splitted
                        , markDownParseBoldData getFinding
                        ]

                    Nothing ->
                        [ MarkDownText splitted ]
            )
            split


parseBreakLine : String -> List MarkDown
parseBreakLine text =
    --
    -- This function turn a break line
    --
    -- "a<br>b"
    --
    -- into something like
    --
    -- [ MarkDownText "a"
    -- , MarkDownBreakLine
    -- , MarkDownText "b"
    -- ]
    --
    let
        split =
            case regexForBreakLine of
                Just regex ->
                    Regex.split regex text

                Nothing ->
                    [ text ]
    in
    List.concat <|
        List.indexedMap
            (\index splitted ->
                if index < List.length split - 1 then
                    [ MarkDownText splitted
                    , MarkDownBreakLine
                    ]

                else
                    [ MarkDownText splitted ]
            )
            split


markDownParseBoldData : List String -> MarkDown
markDownParseBoldData data =
    let
        text1 =
            Maybe.withDefault "" <| List.head data
    in
    MarkDownBold text1


{-| -}
parseTextForLinks : String -> List MarkDown
parseTextForLinks text =
    --
    -- This function turn a string like
    --
    -- "a[link1](label1)b[link2](label2)c"
    --
    -- into something like
    --
    -- [ MarkDownText "a"
    -- , MarkDownLink "link1" "label1"
    -- , MarkDownText "b"
    -- , MarkDownLink "link2" "label2"
    -- , MarkDownText "c"
    -- ]
    --
    -- It can be used to embedd links inside translations
    --
    let
        ( find, split ) =
            case regexForLinks of
                Just regex ->
                    ( Regex.find regex text, Regex.split regex text )

                Nothing ->
                    ( [], [] )
    in
    List.concat <|
        List.indexedMap
            (\index splitted ->
                let
                    maybeGetFinding =
                        Maybe.map
                            (\match ->
                                List.map
                                    (\item_ ->
                                        case item_ of
                                            Just i ->
                                                i

                                            Nothing ->
                                                ""
                                    )
                                    match.submatches
                            )
                            (Array.get index (Array.fromList find))
                in
                case maybeGetFinding of
                    Just getFinding ->
                        [ MarkDownText splitted
                        , markDownParseLinkData getFinding
                        ]

                    Nothing ->
                        [ MarkDownText splitted ]
            )
            split


{-| -}
markdown :
    (String -> Element (R10.Context.ContextInternal z) msg)
    -> (String -> Element (R10.Context.ContextInternal z) msg)
    -> (String -> String -> Element (R10.Context.ContextInternal z) msg)
    -> String
    -> List (Element (R10.Context.ContextInternal z) msg)
markdown boldGenerator textGenerator linkGenerator string =
    let
        step1 =
            parseTextForLinks string

        step2 =
            List.concat <|
                List.map
                    (\item ->
                        case item of
                            MarkDownText string_ ->
                                parseTextForBold string_

                            _ ->
                                [ item ]
                    )
                    step1

        step3 =
            List.concat <|
                List.map
                    (\item ->
                        case item of
                            MarkDownText string_ ->
                                parseBreakLine string_

                            _ ->
                                [ item ]
                    )
                    step2
    in
    List.map
        (\item ->
            case item of
                MarkDownText text ->
                    textGenerator text

                MarkDownBold text ->
                    boldGenerator text

                MarkDownLink linkLabel url ->
                    linkGenerator linkLabel url

                MarkDownBreakLine ->
                    elementBreakLineGenerator
        )
        step3


elementBoldGenerator : String -> Element (R10.Context.ContextInternal z) msg
elementBoldGenerator string =
    el [ Font.bold ] <| text string


elementTextGenerator : String -> Element (R10.Context.ContextInternal z) msg
elementTextGenerator string =
    text string


elementLabelGenerator : String -> Element (R10.Context.ContextInternal z) msg
elementLabelGenerator string =
    text string


elementLinkGenerator : String -> String -> Element (R10.Context.ContextInternal z) msg
elementLinkGenerator linkLabel url =
    newTabLink [] { url = url, label = elementLabelGenerator linkLabel }


elementLinkGeneratorAdvanced :
    { a
        | link : List (Attribute (R10.Context.ContextInternal z) msg)
    }
    -> String
    -> String
    -> Element (R10.Context.ContextInternal z) msg
elementLinkGeneratorAdvanced attrs linkLabel url =
    newTabLink
        ([ Border.rounded 4
         , focused [ Border.innerShadow { offset = ( 0, 0 ), size = 1, blur = 1, color = rgb 0.7 0.7 0.7 } ]
         , htmlAttribute <| Html.Attributes.tabindex 0
         ]
            ++ attrs.link
        )
        { url = url, label = elementLabelGenerator linkLabel }


elementBreakLineGenerator : Element (R10.Context.ContextInternal z) msg
elementBreakLineGenerator =
    el [ height <| px 8, htmlAttribute <| Html.Attributes.style "display" "block" ] none


{-| -}
elementMarkdown : String -> List (Element (R10.Context.ContextInternal z) msg)
elementMarkdown string =
    markdown elementBoldGenerator elementTextGenerator elementLinkGenerator string


{-| -}
elementMarkdownAdvanced :
    { link : List (Attribute (R10.Context.ContextInternal z) msg) }
    -> String
    -> List (Element (R10.Context.ContextInternal z) msg)
elementMarkdownAdvanced attrs string =
    markdown elementBoldGenerator elementTextGenerator (elementLinkGeneratorAdvanced attrs) string
