module R10.Language exposing (Language(..), LanguageType(..), Translations, decodeJsonString, decoder, default, defaultSupportedLanguageList, list, listStringTolistLanguagesRemovingUnsupported, preferredLanguage, select, toStringLong, toString, toStringShort, urlParser, fromStringWithSupportedLanguages)

{-| Internationalization stuff

"Language" is sometime also called "Locale". We call it "Language" as it seems more common to refer to it this way.

Also in Html these are called "[lang](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/lang)".

So we consider British English and American English as two different languages rather than two different locales of the same language.

@docs Language, LanguageType, Translations, decodeJsonString, decoder, default, defaultSupportedLanguageList, list, listStringTolistLanguagesRemovingUnsupported, preferredLanguage, select, toStringLong, toString, toStringShort, urlParser, fromStringWithSupportedLanguages

-}

import Json.Decode
import Url.Parser


{-| -}
type alias Translations =
    { key : String
    , en_us : String
    , ja_jp : String
    , zh_tw : String
    , es_es : String
    , fr_fr : String
    , de_de : String
    , zh_cn : String
    , it_it : String
    , uk_ua : String
    , pt_pt : String
    , nl_nl : String
    }


{-| -}
toStringShort : Language -> String
toStringShort language =
    String.left 2 (toString language)


{-| -}
urlParser : Url.Parser.Parser (Language -> b) b
urlParser =
    Url.Parser.custom "LANGUAGE ROUTE PARSER" fromStringUsingDefaultListOfSupportedLanguages


{-| -}
type
    Language
    -- A language to verify the keys
    = Key
      -- A language that replace all text with 🍭
    | Lollipop
      -- American English
    | EN_US
      -- Japanese
    | JA_JP
      -- Taiwanese Mandarin https://en.wikipedia.org/wiki/Taiwanese_Mandarin
    | ZH_TW
      -- Mainland Chinese
    | ZH_CN
      -- Spanish
    | ES_ES
      -- French
    | FR_FR
      -- German
    | DE_DE
      -- Italian
    | IT_IT
      -- Ukrainian
    | UK_UA
      -- European Portuguese
    | PT_PT
      -- Dutch (Netherlands)
    | NL_NL


{-| -}
list : List Language
list =
    [ Key
    , EN_US
    , ZH_TW
    , ZH_CN
    , JA_JP
    , FR_FR
    , DE_DE
    , ES_ES
    , IT_IT
    , UK_UA
    , PT_PT
    , NL_NL
    ]


{-| -}
default : Language
default =
    EN_US


{-| -}
defaultSupportedLanguageList : List Language
defaultSupportedLanguageList =
    [ EN_US
    , JA_JP
    , ZH_TW
    , ZH_CN
    , DE_DE
    , ES_ES
    , FR_FR
    , IT_IT
    , UK_UA
    , PT_PT
    , NL_NL
    ]


{-| -}
decoder : List Language -> String -> Result String Language
decoder supportedLanguageList string =
    let
        decoderFromString : String -> Result String Language
        decoderFromString string_ =
            case decoderFourLettersLanguage string_ of
                Ok language ->
                    Ok language

                Err _ ->
                    case decoderTwoLettersLanguage string_ of
                        Ok language ->
                            Ok language

                        Err error ->
                            Err error
    in
    case decoderFromString string of
        Ok language ->
            if List.member language supportedLanguageList then
                Ok language

            else
                Err <| "Language " ++ toString language ++ "is not supported yet"

        Err err ->
            Err err


{-| -}
decoderFourLettersLanguage : String -> Result String Language
decoderFourLettersLanguage string =
    case clean string of
        "lollipop" ->
            Ok Lollipop

        "key" ->
            Ok Key

        "enus" ->
            Ok EN_US

        "jajp" ->
            Ok JA_JP

        "zhtw" ->
            Ok ZH_TW

        "zhcn" ->
            Ok ZH_CN

        "dede" ->
            Ok DE_DE

        "eses" ->
            Ok ES_ES

        "frfr" ->
            Ok FR_FR

        "itit" ->
            Ok IT_IT

        "ukua" ->
            Ok UK_UA

        "ptpt" ->
            Ok PT_PT

        "nlnl" ->
            Ok NL_NL

        "zhhk" ->
            Ok ZH_TW

        "zhmo" ->
            Ok ZH_TW

        "zhsg" ->
            Ok ZH_CN

        "zhid" ->
            Ok ZH_TW

        "zhmy" ->
            Ok ZH_CN

        "hant" ->
            Ok ZH_TW

        "hans" ->
            Ok ZH_CN

        _ ->
            Err <| string ++ " is not a valid language"


{-| -}
decoderTwoLettersLanguage : String -> Result String Language
decoderTwoLettersLanguage string =
    case String.left 2 <| clean string of
        "en" ->
            Ok EN_US

        "ja" ->
            Ok JA_JP

        "zh" ->
            Ok ZH_CN

        "de" ->
            Ok DE_DE

        "es" ->
            Ok ES_ES

        "fr" ->
            Ok FR_FR

        "it" ->
            Ok IT_IT

        "uk" ->
            Ok UK_UA

        "pt" ->
            Ok PT_PT

        "nl" ->
            Ok NL_NL

        _ ->
            Err <| string ++ " is not a valid language"


{-| -}
listStringTolistLanguagesRemovingUnsupported : List Language -> List String -> List Language
listStringTolistLanguagesRemovingUnsupported supportedLanguageList strings =
    List.foldr
        (\string acc ->
            case decoder supportedLanguageList string of
                Ok lang ->
                    lang :: acc

                Err _ ->
                    acc
        )
        []
        strings


{-| -}
preferredLanguage :
    { supportedLanguages : List Language
    , navigatorLanguages : List String
    }
    -> Maybe Language
preferredLanguage { supportedLanguages, navigatorLanguages } =
    --
    -- "navigatorLanguages" contains the preferred languages of the user,
    -- ranked by preference.
    --
    -- "supportedLanguages" contains a list of supported languages for this
    -- instance.
    --
    -- For each language in the preferred list we check if there is a
    -- match among the supported languages. As soon we find a match we
    -- short circuit the fold and we return the value.
    --
    let
        preferredLanguageList : List Language
        preferredLanguageList =
            listStringTolistLanguagesRemovingUnsupported
                supportedLanguages
                navigatorLanguages
    in
    if preferredLanguageList == [] then
        Nothing

    else
        List.head preferredLanguageList


{-| -}
clean : String -> String
clean string =
    if String.contains "hant" (String.toLower string) then
        "hant"

    else if String.contains "hans" (String.toLower string) then
        "hans"

    else
        string
            |> String.toLower
            |> String.split "-"
            |> String.join ""
            |> String.split "_"
            |> String.join ""
            |> String.split " "
            |> String.join ""


{-| -}
fromStringUsingDefaultListOfSupportedLanguages : String -> Maybe Language
fromStringUsingDefaultListOfSupportedLanguages string =
    fromStringWithSupportedLanguages defaultSupportedLanguageList string


{-| Parse Language from string (IETF format). It's case insensitive.

Parsing language from flags

    Utils.I18n.Language.fromString "zh-TW" ===> Just ZH_TW

    Utils.I18n.Language.fromString "ZH-TW" ===> Just ZH_TW

    Utils.I18n.Language.fromString "foo" ===> Nothing

-}
fromStringWithSupportedLanguages : List Language -> String -> Maybe Language
fromStringWithSupportedLanguages supportedLanguageList string =
    case decoder supportedLanguageList string of
        Ok language ->
            Just language

        Err _ ->
            Nothing


{-| -}
decodeJsonString : List Language -> Json.Decode.Value -> Result String Language
decodeJsonString supportedLanguageList jsonString =
    case Json.Decode.decodeValue Json.Decode.string jsonString of
        Ok string ->
            decoder supportedLanguageList string

        Err error ->
            Err <| ("Error while decoding the language: " ++ Json.Decode.errorToString error)


{-| -}
toString : Language -> String
toString language =
    case language of
        Key ->
            "key"

        Lollipop ->
            "lollipop"

        EN_US ->
            "en-US"

        JA_JP ->
            "ja-JP"

        ZH_TW ->
            "zh-TW"

        ZH_CN ->
            "zh-CN"

        ES_ES ->
            "es-ES"

        FR_FR ->
            "fr-FR"

        DE_DE ->
            "de-DE"

        IT_IT ->
            "it-IT"

        UK_UA ->
            "uk-UA"

        PT_PT ->
            "pt-PT"

        NL_NL ->
            "nl-NL"


{-| -}
type LanguageType
    = International
    | Localization


{-| Convert Language to full language description

Example to convert ZH\_TW to translation in English and Traditional Chinese

    toStringLong International ZH_TW ===> "Taiwanese"

    toStringLong Localization ZH_TW ===> "繁體中文"

-}
toStringLong : LanguageType -> Language -> String
toStringLong languageType language =
    case ( languageType, language ) of
        ( _, Key ) ->
            "Key"

        ( _, Lollipop ) ->
            "🍭"

        ( International, EN_US ) ->
            "English"

        ( Localization, EN_US ) ->
            "English"

        ( International, JA_JP ) ->
            "Japanese"

        ( Localization, JA_JP ) ->
            "日本語"

        ( International, ZH_TW ) ->
            "Taiwanese"

        ( Localization, ZH_TW ) ->
            "繁體中文"

        ( International, ZH_CN ) ->
            "Chinese"

        ( Localization, ZH_CN ) ->
            "简体中文"

        ( International, ES_ES ) ->
            "Spanish"

        ( Localization, ES_ES ) ->
            "Español"

        ( International, FR_FR ) ->
            "French"

        ( Localization, FR_FR ) ->
            "Français"

        ( International, DE_DE ) ->
            "German"

        ( Localization, DE_DE ) ->
            "Deutsch"

        ( International, IT_IT ) ->
            "Italian"

        ( Localization, IT_IT ) ->
            "Italiano"

        ( International, UK_UA ) ->
            "Ukrainian"

        ( Localization, UK_UA ) ->
            "Українська"

        ( International, PT_PT ) ->
            "Portuguese"

        ( Localization, PT_PT ) ->
            "Português"

        ( International, NL_NL ) ->
            "Dutch"

        ( Localization, NL_NL ) ->
            "Nederlands"


{-| -}
select : Language -> Translations -> String
select language translation =
    case language of
        Key ->
            .key translation

        Lollipop ->
            "🍭"

        EN_US ->
            .en_us translation

        JA_JP ->
            .ja_jp translation

        ZH_TW ->
            .zh_tw translation

        ZH_CN ->
            .zh_cn translation

        ES_ES ->
            .es_es translation

        FR_FR ->
            .fr_fr translation

        DE_DE ->
            .de_de translation

        IT_IT ->
            .it_it translation

        UK_UA ->
            .uk_ua translation

        PT_PT ->
            .pt_pt translation

        NL_NL ->
            .nl_nl translation
