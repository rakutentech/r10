module R10.FormComponents.Internal.EmailAutoSuggest exposing
    ( addOnRightKeyDownEvent
    , autoSuggestionsAttrs
    , emailDomainAutocomplete
    , mobileEmailSupportDomainList
    )

import Element.WithContext exposing (..)
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import List.Extra
import R10.Color.AttrsBackground
import R10.Color.AttrsBorder
import R10.Color.AttrsFont
import R10.Context exposing (..)
import R10.Device
import R10.FormComponents.Internal.Style
import Regex



-- ╔══════════════╤═════════════════════════════════════════════════╗
-- ║ FEATURE_NAME │ Email Input Field with Domain Suggestions       ║
-- ╚══════════════╧═════════════════════════════════════════════════╝
--
-- Inspired by mailcheck
-- https://medium.com/@chetan268/html-input-auto-complete-suggestion-with-tab-completion-html-vue-js-css-b3023bd27a86


autoSuggestionsAttrs :
    { device : R10.Device.Device
    , style : R10.FormComponents.Internal.Style.Style
    , maybeEmailSuggestion : Maybe String
    , msgOnChange : String -> msg
    , value : String
    }
    -> List (Attribute (R10.Context.ContextInternal z) msg)
autoSuggestionsAttrs args =
    case ( args.maybeEmailSuggestion, R10.Device.isMobileOS args.device ) of
        ( Just suggestion, True ) ->
            --
            -- isMobileOS
            --
            -- In case of mobile we add a popup above the input field (to avoid
            -- conflicts with the browsers' built-in email suggestion tool)
            -- because mobile devices don't have easy access to right arrow
            -- key
            --
            [ above <|
                row
                    [ moveDown 8
                    , scrollbarX
                    , width fill
                    , paddingXY 15 12
                    , R10.Color.AttrsBackground.dropdown
                    , R10.Color.AttrsBorder.shadow { offset = ( 0, 0 ), size = 0, blur = 2 }
                    , Border.rounded 5
                    , mouseDown [ R10.Color.AttrsBackground.dropdownSelected ]
                    , mouseOver [ R10.Color.AttrsBackground.dropdownHover ]
                    , htmlAttribute <| Html.Attributes.style "user-select" "none"
                    , htmlAttribute <|
                        Html.Events.preventDefaultOn "mouseup"
                            (Json.Decode.succeed ( args.msgOnChange (args.value ++ suggestion), True ))
                    , -- Keep the same value on mousedown without loosing focus
                      htmlAttribute <|
                        Html.Events.preventDefaultOn "mousedown"
                            (Json.Decode.succeed ( args.msgOnChange args.value, True ))
                    , -- Show last chars first, like auto scroll to end
                      htmlAttribute <| Html.Attributes.style "direction" "rtl"
                    ]
                    [ column
                        --
                        -- Strange issue when input '.' and '@' at front.
                        -- showing like 'aol.com@.', should be '.@aol.com'
                        -- add the direction style to fix
                        --
                        [ htmlAttribute <| Html.Attributes.style "direction" "ltr" ]
                        [ text (args.value ++ suggestion) ]
                    ]
            ]

        ( Nothing, True ) ->
            -- Replicating an empty element to avoid the field loosing focus
            [ above <| row [] [] ]

        ( Just suggestion, False ) ->
            --
            -- not isMobileOS
            --
            -- We add, behind the input field, the suggestion. User will accept
            -- it pressing the "right arrow" key (see "addOnRightKeyDownEvent")
            --
            let
                positionAttrs =
                    [ moveDown 20
                    , moveRight 16
                    ]

                suggestionViewWidth : String
                suggestionViewWidth =
                    String.length suggestion
                        * 10
                        |> String.fromInt

                diffStaticSpaceWidth : String
                diffStaticSpaceWidth =
                    -- For this style, has padding 16*2, the validation icon not use the space for line.
                    "32"
            in
            [ behindContent <|
                row
                    ([ R10.Color.AttrsFont.normalLighter
                     , alpha 0.5
                     , width fill
                     , clip
                     ]
                        ++ positionAttrs
                    )
                    [ el
                        [ Font.color <| rgba 0 0 0 0
                        , htmlAttribute <|
                            Html.Attributes.style "max-width" <|
                                "calc(100% - "
                                    ++ diffStaticSpaceWidth
                                    ++ "px - "
                                    ++ suggestionViewWidth
                                    ++ "px)"
                        ]
                        (text args.value)
                    , el [] (text suggestion)
                    ]
            , htmlAttribute <|
                Html.Attributes.style "max-width" <|
                    "calc(100% - "
                        ++ suggestionViewWidth
                        ++ "px)"
            ]

        ( Nothing, False ) ->
            -- Replicating an empty element to avoid the field loosing focus
            [ behindContent <| row [] [] ]


emailDomainAutocomplete : List String -> String -> Maybe String
emailDomainAutocomplete suggestions email =
    --
    -- Provides suggestiongs while users type emails.
    -- Note that only the first occurrence in the list is
    -- suggested, so suggestions should be orderd by popularity,
    -- from the most probable to the least probable.
    --
    -- Example:
    --
    --  In: suggestions = [ "google.com", "gmail.com", "yahoo.co.jp" ]
    --      string = "ciao@g"
    --
    -- Out: Just "oogle.com"
    --
    let
        fullDomainSuggestions : List String
        fullDomainSuggestions =
            suggestions
                |> List.filter
                    (\domain ->
                        (not <| String.contains "*." domain)
                            && (not <| (String.contains "[" domain && String.contains "]" domain))
                    )

        maybeEmailDomain : Maybe String
        maybeEmailDomain =
            if String.contains "@" email then
                List.head <| List.reverse <| String.split "@" email

            else
                Nothing

        filterStartWithForFullDomain : String -> List String
        filterStartWithForFullDomain inputValue =
            List.filter (String.startsWith inputValue) fullDomainSuggestions

        hasMultipleAtSymbol : Bool
        hasMultipleAtSymbol =
            String.indexes "@" email
                |> List.length
                |> (\len -> len > 1)

        sortAndMatchWildcardDomain : String -> List String
        sortAndMatchWildcardDomain inputValue =
            -- For example, input: a.b.c
            -- try to match each of [ "c", ".c", "b.c", ".b.c", "a.b.c" ]
            -- then unique and reverse
            --
            let
                wildcardDomainList : List String
                wildcardDomainList =
                    List.filter
                        (String.startsWith "*.")
                        suggestions

                matchWithSubString : String -> List String
                matchWithSubString str =
                    List.filter
                        (\domain ->
                            String.dropLeft 1 domain
                                |> String.startsWith str
                        )
                        wildcardDomainList

                fullMatchWithSubString : String -> Bool
                fullMatchWithSubString str =
                    List.any
                        (\domain ->
                            String.dropLeft 1 domain == str
                        )
                        wildcardDomainList
            in
            inputValue
                |> String.foldr
                    (\char ( combString, matchedDomainList, hasFullMatch ) ->
                        ( String.fromChar char ++ combString
                        , if String.isEmpty combString then
                            []

                          else
                            matchWithSubString combString ++ matchedDomainList
                        , if not hasFullMatch then
                            fullMatchWithSubString combString

                          else
                            True
                        )
                    )
                    ( "", [], False )
                |> (\( _, matchedDomainList, hasFullMatch ) ->
                        if hasFullMatch then
                            -- If already matched some domain, do not suggest.
                            []

                        else
                            matchedDomainList
                                |> List.Extra.unique
                                -- Sort by matched character length
                                -- by default will be [ 1a, 1b, 2 ]
                                -- 1a, 1b means matched length is 1, but not same value, and the a should be prefered than b
                                -- but now we need to suggessted the 2.
                                -- if use the List.reverse, the order of 1a and 1b will be reversed
                                -- so use 0 - length here to keep the order of which values matched by same length
                                --
                                |> List.sortBy (\v -> 0 - getMatchedLength inputValue v)
                   )

        filterWithWildcard : String -> List String -> List String
        filterWithWildcard inputValue suggestedList =
            List.head suggestedList
                |> Maybe.map (\a -> a == inputValue)
                |> Maybe.withDefault False
                |> (\isFullMatched ->
                        if isFullMatched then
                            suggestedList

                        else
                            suggestedList ++ sortAndMatchWildcardDomain inputValue
                   )

        getRemainingString : String -> String -> String
        getRemainingString inputValue suggestionValue =
            if String.startsWith "*." suggestionValue then
                String.dropLeft
                    (1 + getMatchedLength inputValue suggestionValue)
                    suggestionValue

            else if String.startsWith suggestionByPartRegexPrefix suggestionValue then
                -- Remove the [REG] prefix
                String.dropLeft 5 suggestionValue

            else
                String.dropLeft (String.length inputValue) suggestionValue

        getMatchedLength : String -> String -> Int
        getMatchedLength inputValue suggestionValue =
            let
                suggestionValue_ : String
                suggestionValue_ =
                    String.dropLeft 1 suggestionValue
            in
            inputValue
                |> String.foldr
                    (\char ( str, num ) ->
                        if String.startsWith str suggestionValue_ then
                            ( String.fromChar char ++ str, String.length str )

                        else
                            ( String.fromChar char ++ str, num )
                    )
                    ( "", 0 )
                |> Tuple.second

        suggestionByPartRegexPrefix : String
        suggestionByPartRegexPrefix =
            -- For the results of filterWithPartRegexDomain, should be suggesting directly.
            -- So set the prefix to help to check in the getRemainingString function
            "[REG]"

        filterWithPartRegexDomain : String -> List String -> List String
        filterWithPartRegexDomain inputValue suggestedList =
            List.head suggestedList
                |> Maybe.map (\a -> a == inputValue)
                |> Maybe.withDefault False
                |> (\isFullMatched ->
                        if isFullMatched then
                            suggestedList

                        else
                            suggestedList ++ sortAndMatchPartRegexDomain inputValue
                   )

        sortAndMatchPartRegexDomain : String -> List String
        sortAndMatchPartRegexDomain inputValue =
            --
            -- Try to match some domain contains a part as simple regex
            -- like jp-[a-zA-Z0-9].ne.jp, think [a-zA-Z0-9] part as regex
            --
            -- For example, input: a.b.c
            -- try to match each of [ "c", ".c", "b.c", ".b.c", "a.b.c" ]
            -- then unique and reverse
            --
            let
                partRegexDomainList : List String
                partRegexDomainList =
                    -- matched some domains like jp-[a-zA-Z0-9].ne.jp
                    List.filter
                        (\v ->
                            String.contains "[" v && String.contains "]" v
                        )
                        suggestions

                regexStringStartIndex : String -> Int
                regexStringStartIndex str =
                    str
                        |> String.indexes "["
                        |> List.head
                        |> Maybe.withDefault 0

                regexStringEndIndex : String -> Int
                regexStringEndIndex str =
                    str
                        |> String.indexes "]"
                        |> List.head
                        |> Maybe.withDefault 0

                domainPrefix : String -> String
                domainPrefix str =
                    -- Output jp-
                    String.slice 0 (regexStringStartIndex str) str

                domainSuffix : String -> String
                domainSuffix str =
                    -- Output .ne.jp
                    String.slice
                        (regexStringEndIndex str + 1)
                        (String.length str)
                        str

                regexPart : String -> String
                regexPart str =
                    String.slice
                        (regexStringStartIndex str)
                        (regexStringEndIndex str + 1)
                        str
                        -- Output ^[a-zA-Z0-9]+
                        -- Append a ^, meaning the substring of input value, excepted the prefix, need to matched start with the string that can be matched the regex.
                        -- Append a +, meaning can input multiple characters which can passed the regex.
                        |> (\regStr -> "^" ++ regStr ++ "+")
            in
            partRegexDomainList
                |> List.filter
                    (\suggestion ->
                        String.startsWith
                            (domainPrefix suggestion)
                            inputValue
                    )
                |> List.filterMap
                    (\suggestion ->
                        let
                            remeaningStringExceptedPrefix : String
                            remeaningStringExceptedPrefix =
                                -- The sub string except the matched domain prefix
                                String.replace (domainPrefix suggestion) "" inputValue

                            regex : Regex.Regex
                            regex =
                                regexPart suggestion
                                    |> Regex.fromString
                                    |> Maybe.withDefault Regex.never

                            canMatchedRegexPart : Bool
                            canMatchedRegexPart =
                                -- That is meaning the remeaningStringExceptedPrefix is start with the string that can be matched the regex
                                Regex.find regex remeaningStringExceptedPrefix
                                    |> List.isEmpty
                                    |> not

                            remeaningStringExceptedPrefixAndRegexMatched : String
                            remeaningStringExceptedPrefixAndRegexMatched =
                                Regex.replaceAtMost 1 regex (always "") remeaningStringExceptedPrefix

                            canMatchedSuffix : Bool
                            canMatchedSuffix =
                                domainSuffix suggestion
                                    |> String.startsWith remeaningStringExceptedPrefixAndRegexMatched
                        in
                        if canMatchedRegexPart && canMatchedSuffix then
                            -- The string should be suggested directly
                            -- Add the prefix to help to check in the getRemainingString function
                            Just <| suggestionByPartRegexPrefix ++ String.dropLeft (String.length remeaningStringExceptedPrefixAndRegexMatched) (domainSuffix suggestion)

                        else
                            Nothing
                    )
    in
    if hasMultipleAtSymbol then
        Nothing

    else
        --
        -- If input = "ciao@g", maybeEmailDomain == Just "g"
        --
        maybeEmailDomain
            |> Maybe.andThen
                (\emailDomain ->
                    emailDomain
                        -- output: "g"
                        |> filterStartWithForFullDomain
                        |> filterWithPartRegexDomain emailDomain
                        |> filterWithWildcard emailDomain
                        -- output: [ "google.com", "gmail.com" ]
                        |> List.head
                        -- output: Just "google.com"
                        |> Maybe.map (getRemainingString emailDomain)
                        |> Maybe.andThen nothingWhenBlank
                 -- output: Just "oogle.com"
                )


nothingWhenBlank : String -> Maybe String
nothingWhenBlank string =
    case string of
        "" ->
            Nothing

        _ ->
            Just string


addOnRightKeyDownEvent : (String -> msg) -> String -> String -> Html.Attribute msg
addOnRightKeyDownEvent msg userInput suggestion =
    --
    -- Add the observer for the press of "right" arrow, in which case
    -- it will accept the suggestion. Only for desktop, as mobile doesn't
    -- have easy access to right arrow button. Mobile will have a popup instead.
    --
    let
        arrowRight : Int
        arrowRight =
            39
    in
    Html.Events.keyCode
        |> Json.Decode.andThen
            (\key ->
                Json.Decode.succeed
                    (if key == arrowRight then
                        msg suggestion

                     else
                        msg userInput
                    )
            )
        |> Html.Events.on "keydown"


mobileEmailSupportDomainList : List String
mobileEmailSupportDomainList =
    [ "@docomo.ne.jp"
    , "@ezweb.ne.jp"
    , "@au.com"
    , "@softbank.ne.jp"
    , "@rakuten.jp"
    , "@rakumail.jp"
    , "@t.vodafone.ne.jp"
    , "@k.vodafone.ne.jp"
    , "@c.vodafone.ne.jp"
    , "@q.vodafone.ne.jp"
    , "@h.vodafone.ne.jp"
    , "@n.vodafone.ne.jp"
    , "@disney.ne.jp"
    , "@d.vodafone.ne.jp"
    , "@r.vodafone.ne.jp"
    , "@s.vodafone.ne.jp"
    , "@jp-t.ne.jp"
    , "@pdx.ne.jp"
    , "@wm.pdx.ne.jp"
    , "@jp-k.ne.jp"
    , "@jp-c.ne.jp"
    , "@dj.pdx.ne.jp"
    , "@di.pdx.ne.jp"
    , "@dk.pdx.ne.jp"
    , "@jp-q.ne.jp"
    , "@jp-n.ne.jp"
    , "@jp-h.ne.jp"
    , "@jp-d.ne.jp"
    , "@jp-r.ne.jp"
    , "@jp-s.ne.jp"
    , "@pipopa.ne.jp"
    , "@moco.ne.jp"
    , "@sky.tkk.ne.jp"
    , "@sky.tkc.ne.jp"
    , "@i.pakeo.ne.jp"
    , "@ido.ne.jp"
    , "@tu-ka.ne.jp"

    -- Not includes @, since some email can be @xx.domain.com, e.g. @a1.biz.au.com
    -- Also do not suggestion them
    , "biz.ezweb.ne.jp"
    , "biz.au.com"
    ]
