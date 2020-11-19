module R10.FormComponents.Utils.SimpleMarkdown exposing
    ( MarkDown(..)
    , elementMarkdown
    , elementMarkdownAdvanced
    , markdown
    , parseTextForLinks
    )

import Array
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Html.Attributes
import Regex



-- ███████ ██ ███    ███ ██████  ██      ███████     ███    ███  █████  ██████  ██   ██ ██████   ██████  ██     ██ ███    ██
-- ██      ██ ████  ████ ██   ██ ██      ██          ████  ████ ██   ██ ██   ██ ██  ██  ██   ██ ██    ██ ██     ██ ████   ██
-- ███████ ██ ██ ████ ██ ██████  ██      █████       ██ ████ ██ ███████ ██████  █████   ██   ██ ██    ██ ██  █  ██ ██ ██  ██
--      ██ ██ ██  ██  ██ ██      ██      ██          ██  ██  ██ ██   ██ ██   ██ ██  ██  ██   ██ ██    ██ ██ ███ ██ ██  ██ ██
-- ███████ ██ ██      ██ ██      ███████ ███████     ██      ██ ██   ██ ██   ██ ██   ██ ██████   ██████   ███ ███  ██   ████


type MarkDown
    = MarkDownText String
    | MarkDownLink String String
    | MarkDownBold String


regexForLinks : Maybe Regex.Regex
regexForLinks =
    -- This regex match constructs like "[Link text](Url)"
    Regex.fromString "\\[([^\\[\\]]+)\\]\\(([^()]+)\\)"


regexForBold : Maybe Regex.Regex
regexForBold =
    -- This regex match constructs like "**bold text**"
    Regex.fromString "\\*\\*([^*]*)\\*\\*"


markDownParseLinkData : List String -> MarkDown
markDownParseLinkData data =
    let
        text1 : String
        text1 =
            Maybe.withDefault "" <| List.head data

        text2 : String
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
                    maybeGetFinding : Maybe (List String)
                    maybeGetFinding =
                        case Array.get index (Array.fromList find) of
                            Just match ->
                                Just <|
                                    List.map
                                        (\item_ ->
                                            case item_ of
                                                Just i ->
                                                    i

                                                Nothing ->
                                                    ""
                                        )
                                        match.submatches

                            Nothing ->
                                Nothing
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


markDownParseBoldData : List String -> MarkDown
markDownParseBoldData data =
    let
        text1 : String
        text1 =
            Maybe.withDefault "" <| List.head data
    in
    MarkDownBold text1


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
                    maybeGetFinding : Maybe (List String)
                    maybeGetFinding =
                        case Array.get index (Array.fromList find) of
                            Just match ->
                                Just <|
                                    List.map
                                        (\item_ ->
                                            case item_ of
                                                Just i ->
                                                    i

                                                Nothing ->
                                                    ""
                                        )
                                        match.submatches

                            Nothing ->
                                Nothing
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


markdown : (String -> Element msg) -> (String -> Element msg) -> (String -> String -> Element msg) -> String -> List (Element msg)
markdown boldGenerator textGenerator linkGenerator string =
    let
        step1 : List MarkDown
        step1 =
            parseTextForLinks string

        step2 : List MarkDown
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
        )
        step2


elementBoldGenerator : String -> Element msg
elementBoldGenerator string =
    el [ Font.bold ] <| text string


elementTextGenerator : String -> Element msg
elementTextGenerator string =
    text string


elementLabelGenerator : String -> Element msg
elementLabelGenerator string =
    text string


elementLinkGenerator : String -> String -> Element msg
elementLinkGenerator linkLabel url =
    newTabLink [] { url = url, label = elementLabelGenerator linkLabel }


elementLinkGeneratorAdvanced :
    { a
        | link : List (Attribute msg)
    }
    -> String
    -> String
    -> Element msg
elementLinkGeneratorAdvanced attrs linkLabel url =
    newTabLink
        ([ Border.rounded 4
         , focused [ Border.innerShadow { offset = ( 0, 0 ), size = 1, blur = 1, color = rgb 0.7 0.7 0.7 } ]
         , htmlAttribute <| Html.Attributes.tabindex 0
         ]
            ++ attrs.link
        )
        { url = url, label = elementLabelGenerator linkLabel }


elementMarkdown : String -> List (Element msg)
elementMarkdown string =
    markdown elementBoldGenerator elementTextGenerator elementLinkGenerator string


elementMarkdownAdvanced :
    { link : List (Attribute msg)
    }
    -> String
    -> List (Element msg)
elementMarkdownAdvanced attrs string =
    markdown elementBoldGenerator elementTextGenerator (elementLinkGeneratorAdvanced attrs) string
