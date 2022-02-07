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
import R10.Color.AttrsBackground
import R10.Color.AttrsBorder
import R10.Color.AttrsFont
import R10.Context exposing (..)
import R10.Device
import R10.FormComponents.Internal.Style



-- ╔══════════════╤═════════════════════════════════════════════════╗
-- ║ FEATURE_NAME │ Email Input Field with Domain Suggestions       ║
-- ╚══════════════╧═════════════════════════════════════════════════╝
--
-- Inspired by mailcheck
-- https://medium.com/@chetan268/html-input-auto-complete-suggestion-with-tab-completion-html-vue-js-css-b3023bd27a86


autoSuggestionsAttrs :
    { userAgent : R10.Device.UserAgent
    , style : R10.FormComponents.Internal.Style.Style
    , maybeEmailSuggestion : Maybe String
    , msgOnChange : String -> msg
    , value : String
    }
    -> List (Attribute (R10.Context.ContextInternal z) msg)
autoSuggestionsAttrs args =
    case ( args.maybeEmailSuggestion, R10.Device.isMobileOS args.userAgent ) of
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
                    case args.style of
                        R10.FormComponents.Internal.Style.Filled ->
                            [ moveDown 23
                            , moveRight 0
                            ]

                        R10.FormComponents.Internal.Style.Outlined ->
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
                    case args.style of
                        R10.FormComponents.Internal.Style.Filled ->
                            -- For this style, no padding, but has validation icon
                            "15"

                        R10.FormComponents.Internal.Style.Outlined ->
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
        maybeEmailDomain : Maybe String
        maybeEmailDomain =
            if String.contains "@" email then
                List.head <| List.reverse <| String.split "@" email

            else
                Nothing

        filterStartWith : List String -> String -> List String
        filterStartWith strings string_ =
            List.filter (String.startsWith string_) strings

        hasMultipleAtSymbol : Bool
        hasMultipleAtSymbol =
            String.indexes "@" email
                |> List.length
                |> (\len -> len > 1)
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
                        |> filterStartWith suggestions
                        -- output: [ "google.com", "gmail.com" ]
                        |> List.head
                        -- output: Just "google.com"
                        |> Maybe.map (String.dropLeft (String.length emailDomain))
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
    , "@rakuten.ml"
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
