module R10.I18n exposing (t, tmd, replace)

{-| Internationalization stuff

@docs t, tmd, replace

-}

import Element exposing (..)
import Element.Border as Border
import R10.Language
import R10.SimpleMarkdown
import Regex



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


{-| Translate some text with markdown
-}
tmd : R10.Language.Language -> R10.Language.Translations -> List (Element msg)
tmd language translation =
    R10.Language.select language translation
        |> trimComments
        |> R10.SimpleMarkdown.elementMarkdownAdvanced
            { link =
                [ Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
                , Border.rounded 0
                , Border.color <| rgba 0 0 0 0.3
                ]
            }


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
