module R10.FormComponents.Internal.EmailAutoSuggest exposing
    ( addOnRightKeyDownEvent
    , autoSuggestionsAttrs
    , emailDomainAutocomplete
    )

import Element.WithContext exposing (..)
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Element.WithContext.Input as Input
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
import R10.FontSize



-- ╔══════════════╤═════════════════════════════════════════════════╗
-- ║ FEATURE_NAME │ Email Input Field with Domain Suggestions       ║
-- ╚══════════════╧═════════════════════════════════════════════════╝
--
-- Inspired by mailcheck
-- https://medium.com/@chetan268/html-input-auto-complete-suggestion-with-tab-completion-html-vue-js-css-b3023bd27a86


autoSuggestionsAttrs :
    { userAgent : R10.Device.UserAgent
    , maybeEmailSuggestion : Maybe String
    , msgOnChange : String -> msg
    , value : String
    }
    -> List (Attribute Context msg)
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
                withContext <|
                    \c ->
                        row
                            [ moveDown 8
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
                            ]
                            [ text (args.value ++ suggestion) ]
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
            [ behindContent <|
                row
                    [ moveDown 21
                    , moveRight 16
                    , R10.Color.AttrsFont.normalLighter
                    , alpha 0.5
                    ]
                    [ el [ Font.color <| rgba 0 0 0 0 ] (text args.value)
                    , el [] (text suggestion)
                    ]
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
            List.Extra.getAt 1 <| String.split "@" email

        filterStartWith : List String -> String -> List String
        filterStartWith strings string_ =
            List.filter (String.startsWith string_) strings
    in
    --
    -- If input = "ciao@g", maybeEmailDomain == Just "g"
    --
    case maybeEmailDomain of
        Just emailDomain ->
            emailDomain
                -- output: "g"
                |> filterStartWith suggestions
                -- output: [ "google.com", "gmail.com" ]
                |> List.head
                -- output: Just "google.com"
                |> Maybe.map (String.dropLeft (String.length emailDomain))
                |> Maybe.andThen nothingWhenBlank

        -- output: Just "oogle.com"
        Nothing ->
            Nothing


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
