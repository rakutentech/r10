module R10.I18n exposing (t, replace, text, paragraph, RenderingMode(..), paragraphFromString)

{-| Internationalization stuff

@docs t, replace, text, paragraph, RenderingMode, paragraphFromString

-}

import Element.WithContext exposing (..)
import Element.WithContext.Font as Font
import Html.Attributes
import Html.Events
import Json.Decode
import R10.Color.AttrsFont
import R10.Color.Svg
import R10.Context exposing (..)
import R10.Device
import R10.Language
import R10.Link
import R10.Paragraph
import R10.SimpleMarkdown
import R10.Svg.Others
import R10.Transition
import Regex
import Url



-- There are two types of substitutions:
--
--      * Tag subsitituton, that use culry brackets: {tag}
--      * Link substitution, similar to markdown: [label](tag)
--
-- Rulses
--
--      * "tag" can be a pre-defined value, such as "notifyText",
--        "company_name", "cookie", etc. or a numeric value, such as "1", "2", etc.
--        Pre-defined value are replaced with fix values coming from flags,
--        numeric values are replaced by elements contained in a list.
--
--      * Links are created composing the "label", that contain the text of the
--        link already translated in the proper language, and the tag, that
--        is the url of the link.
--
--      * If the url start with "http" then is considered an external link and
--        and icon is attached.
--
--      * There are special cases where link cannot be clicked, in this case
--        we show in clear what the content of the link is
--


{-| -}
paragraph :
    List (Attribute (R10.Context.ContextInternal z) msg)
    ->
        { renderingMode : RenderingMode
        , tagReplacer : R10.Context.ContextInternal z -> String -> String
        , translation : R10.Language.Translations
        }
    -> Element (R10.Context.ContextInternal z) msg
paragraph attrs { renderingMode, tagReplacer, translation } =
    withContext <|
        \c ->
            paragraphFromString
                attrs
                { renderingMode = renderingMode
                , tagReplacer = tagReplacer
                , string = t c.contextR10.language translation
                , msgNoOp = Nothing
                }


{-| -}
paragraphFromString :
    List (Attribute (R10.Context.ContextInternal z) msg)
    ->
        { renderingMode : RenderingMode
        , tagReplacer : R10.Context.ContextInternal z -> String -> String
        , string : String
        , msgNoOp : Maybe msg
        }
    -> Element (R10.Context.ContextInternal z) msg
paragraphFromString attrs args =
    --
    -- 2022.06.02 - Introduced this system so that if the text contains
    -- new lines "\n", these get respected in the final output.
    --
    let
        interim : List (Element (R10.Context.ContextInternal z) msg)
        interim =
            args.string
                |> String.split "\n"
                |> List.map (\subString -> paragraphFromString_ attrs { args | string = subString })

        fixFlexIE : R10.Device.Device -> List (Attribute (R10.Context.ContextInternal z) msg)
        fixFlexIE device =
            if R10.Device.isInternetExplorer device then
                [ htmlAttribute <| Html.Attributes.style "width" "100%" ]

            else
                []

    in
    withContext <|
        \c ->
            column
                ([ width fill
                , spacing 10
                ]
                    -- Fix break line issue for IE
                    ++ fixFlexIE c.contextR10.device
                )
                interim


paragraphFromString_ :
    List (Attribute (R10.Context.ContextInternal z) msg)
    ->
        { renderingMode : RenderingMode
        , tagReplacer : R10.Context.ContextInternal z -> String -> String
        , string : String
        , msgNoOp : Maybe msg
        }
    -> Element (R10.Context.ContextInternal z) msg
paragraphFromString_ attrs { renderingMode, tagReplacer, string, msgNoOp } =
    withContext <|
        \c ->
            case renderingMode of
                Normal ->
                    R10.Paragraph.normal
                        attrs
                        (string
                            |> applySubstitutions
                                { tagReplacer = tagReplacer
                                , context = c
                                , renderingMode = renderingMode
                                , msgNoOp = msgNoOp
                                }
                        )

                Error ->
                    R10.Paragraph.small
                        ([ htmlAttribute <| Html.Attributes.id "ie-flex-fix-320"
                         , R10.Color.AttrsFont.fontAlertDanger
                         ]
                            ++ attrs
                        )
                        (string
                            |> applySubstitutions
                                { tagReplacer = tagReplacer
                                , context = c
                                , renderingMode = renderingMode
                                , msgNoOp = msgNoOp
                                }
                        )


applySubstitutions :
    { a
        | context : R10.Context.ContextInternal z
        , renderingMode : RenderingMode
        , tagReplacer : R10.Context.ContextInternal z -> String -> String
        , msgNoOp : Maybe msg
    }
    -> String
    -> List (Element (R10.Context.ContextInternal z) msg)
applySubstitutions { tagReplacer, context, renderingMode, msgNoOp } translationAsString =
    translationAsString
        |> tagReplacer context
        |> specialMarkdown
            { tagReplacer = tagReplacer
            , renderingMode = renderingMode
            , msgNoOp = msgNoOp
            }


{-| -}
type RenderingMode
    = Normal
    | Error


specialMarkdown :
    { a
        | renderingMode : RenderingMode
        , tagReplacer : R10.Context.ContextInternal z -> String -> String
        , msgNoOp : Maybe msg
    }
    -> String
    -> List (Element (R10.Context.ContextInternal z) msg)
specialMarkdown { tagReplacer, renderingMode, msgNoOp } translationAsString =
    let
        boldGenerator : String -> Element (R10.Context.ContextInternal z) msg
        boldGenerator string_ =
            el [ Font.bold ] <| Element.WithContext.text string_

        textGenerator : String -> Element (R10.Context.ContextInternal z) msg
        textGenerator string_ =
            Element.WithContext.text string_

        elementLabelGenerator : String -> Element (R10.Context.ContextInternal z) msg
        elementLabelGenerator string_ =
            Element.WithContext.text string_

        linkGenerator : String -> String -> Element (R10.Context.ContextInternal z) msg
        linkGenerator label tag =
            withContext <|
                \c ->
                    let
                        newTag : String
                        newTag =
                            ("{" ++ tag ++ "}")
                                |> tagReplacer c
                                |> (\tag_ ->
                                        -- If the tag has not been replace, we put back the original tag
                                        if tag_ == "{" ++ tag ++ "}" then
                                            tag

                                        else
                                            tag_
                                   )

                        focusedOrOver : List (Decoration (R10.Context.ContextInternal z))
                        focusedOrOver =
                            case renderingMode of
                                Normal ->
                                    [ R10.Color.AttrsFont.linkOver ]

                                Error ->
                                    []

                        isInternal =
                            isInternalLink c.contextR10.currentUrl newTag
                    in
                    if tag == "fake_link" then
                        case renderingMode of
                            Normal ->
                                el R10.Link.attrsUnderline <| Element.WithContext.text label

                            Error ->
                                el [ Font.underline ] <| Element.WithContext.text label

                    else
                        row
                            (spacing 5
                                :: (case msgNoOp of
                                        Just msg ->
                                            [ htmlAttribute <| Html.Events.stopPropagationOn "click" <| Json.Decode.map (\a -> ( a, True )) (Json.Decode.succeed msg) ]

                                        Nothing ->
                                            []
                                   )
                            )
                            ([ (if isInternal then
                                    link

                                else
                                    newTabLink
                               )
                                --
                                -- There was a tabindex 0 before, not sure why this
                                -- was needed. Removing it now.
                                --
                                -- [ htmlAttribute <| Html.Attributes.tabindex 0 ]
                                --
                                ([]
                                    ++ (case renderingMode of
                                            Normal ->
                                                R10.Link.attrsUnderline

                                            Error ->
                                                [ Font.underline ]
                                       )
                                    ++ [ focused focusedOrOver
                                       , mouseOver focusedOrOver
                                       , R10.Transition.transition "all 0.15s"
                                       ]
                                )
                                { url = newTag, label = elementLabelGenerator label }

                             -- , el [ Font.color <| rgb 0 0.6 0 ] <| Element.WithContext.text <| "<TEMP : " ++ newTag ++ ">"
                             ]
                                ++ (if isInternal then
                                        []

                                    else
                                        [ R10.Svg.Others.externalLink
                                            [ htmlAttribute <| Html.Attributes.style "vertical-align" "middle"
                                            , paddingEach { top = 0, right = 3, bottom = 0, left = 0 }
                                            ]
                                            ((case renderingMode of
                                                Normal ->
                                                    R10.Color.Svg.link

                                                Error ->
                                                    R10.Color.Svg.fontAlertDanger
                                             )
                                                c.contextR10.theme
                                            )
                                            16
                                        ]
                                   )
                            )
    in
    translationAsString
        |> R10.SimpleMarkdown.markdown boldGenerator textGenerator linkGenerator


isInternalLink : Url.Url -> String -> Bool
isInternalLink current target =
    if String.startsWith "#" target then
        -- Only fragment, so it is internal link
        True

    else
        target
            |> Url.fromString
            |> Maybe.map
                (\target_ ->
                    -- Check if the url is all the same, except the fragment
                    target_.host
                        == current.host
                        && target_.port_
                        == current.port_
                        && target_.path
                        == current.path
                        && target_.protocol
                        == current.protocol
                        && target_.query
                        == current.query
                )
            -- In case we cannot compare, we assume it is internal
            |> Maybe.withDefault False



--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- OLD STUFF
--
-- Naming was inspired by ruby-i18n
-- https://github.com/ruby-i18n/i18n


trimComments : String -> String
trimComments =
    -- Removing all pairs of square brackets that just contain comments
    Regex.replace
        (Maybe.withDefault Regex.never <|
            Regex.fromStringWith
                { caseInsensitive = True
                , multiline = True
                }
                "\\[\\[[^]]*\\]\\]"
        )
        (\_ -> "")



{- Util to find translation based on given locale and trim unnecessary comments on translation.

   @example
    lastName : R10.Language.Translations
    lastName =
        { key = "fieldLastName"
        , en_us = "Last name[[R]]"
        , zh_tw = "姓氏"
        , ja_jp = "姓"
        , fr_fr = ""
        , de_de = ""
        ...
        , da_dk = ""
        , sv_se = ""
        }

    R10.I18n.t R10.Language.EN_US lastName
    #=> "Last name"
-}


{-| Translate some text
-}
t : R10.Language.Language -> R10.Language.Translations -> String
t language translation =
    R10.Language.select language translation
        |> trimComments


{-| Shorthand to transform a translation into an `Element.text`
-}
text : R10.Language.Translations -> Element (R10.Context.ContextInternal z) msg
text translation =
    withContext <| \c -> Element.WithContext.text <| t c.contextR10.language translation


{-| Utility for variable replacement in translation.


    raw : String
    raw =
        "Hello my name is '{firstName}, {lastName}'"

    result =
        raw
            |> R10.I18n.replace [ ( "{firstName}", "foo" ), ( "{lastName}", "bar" ) ]

    -- result == "Hello my name is 'foo, bar'"

-}
replace : List ( String, String ) -> String -> String
replace variableList translation =
    let
        replacement =
            \( pattern, value ) acc ->
                String.join value <| String.split pattern acc
    in
    List.foldl replacement translation variableList
