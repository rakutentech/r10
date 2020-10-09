module R10.Language exposing (Language(..), LanguageType(..), Translations, decodeJsonString, decoder, default, defaultSupportedLanguageList, fromString, list, listStringTolistLanguagesRemovingUnsupported, preferredLanguage, select, toLongString, toString, toStringShort, urlParser)

{-| Internationalization stuff

"Language" is sometime also called "Locale". We call it "Language" as it seems more common to refer to it this way.

Also in Html these are called "[lang](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/lang)".

So we consider British English and American English as two different languages rather than two different locales of the same language.

@docs Language, LanguageType, Translations, decodeJsonString, decoder, default, defaultSupportedLanguageList, fromString, list, listStringTolistLanguagesRemovingUnsupported, preferredLanguage, select, toLongString, toString, toStringShort, urlParser

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
    , it_it : String
    , nl_nl : String
    , pt_pt : String
    , nb_no : String
    , fi_fl : String
    , da_dk : String
    , sv_se : String
    }


{-| -}
toStringShort : Language -> String
toStringShort language =
    String.left 2 (toString language)


{-| -}
urlParser : Url.Parser.Parser (Language -> b) b
urlParser =
    Url.Parser.custom "LANGUAGE ROUTE PARSER" fromString2


{-| -}
fromString2 : String -> Maybe Language
fromString2 string =
    fromStringWithSupportedLanguages defaultSupportedLanguageList string


{-| -}
fromStringWithSupportedLanguages : List Language -> String -> Maybe Language
fromStringWithSupportedLanguages supportedLanguageList string =
    case decoder supportedLanguageList string of
        Ok language ->
            Just language

        Err _ ->
            Nothing


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
      -- Spanish
    | ES_ES
      -- French
    | FR_FR
      -- German
    | DE_DE
      -- Italian
    | IT_IT
      -- Dutch
    | NL_NL
      -- Protuguese(Portugal)
    | PT_PT
      -- Norwegian
    | NB_NO
      -- Finish
    | FI_FL
      -- Danish
    | DA_DK
      -- Swedish
    | SV_SE


{-| -}
list : List Language
list =
    [ Key
    , EN_US
    , ZH_TW
    , JA_JP
    , FR_FR
    , DE_DE
    , IT_IT
    , ES_ES
    , NL_NL
    , PT_PT
    , NB_NO
    , FI_FL
    , DA_DK
    , SV_SE
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
    , DE_DE
    , ES_ES
    ]


{-| -}
decoder : List Language -> String -> Result String Language
decoder supportedLanguageList string =
    let
        decoderFromString : String -> Result String Language
        decoderFromString string_ =
            case decoderFourLettersLangauge string_ of
                Ok language ->
                    Ok language

                Err _ ->
                    case decoderTwoLettersLangauge string_ of
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
decoderFourLettersLangauge : String -> Result String Language
decoderFourLettersLangauge string =
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

        "dede" ->
            Ok DE_DE

        "eses" ->
            Ok ES_ES

        "frfr" ->
            Ok FR_FR

        "itit" ->
            Ok IT_IT

        "nlnl" ->
            Ok NL_NL

        "ptpt" ->
            Ok PT_PT

        "nbno" ->
            Ok NB_NO

        "fifl" ->
            Ok FI_FL

        "dadk" ->
            Ok DA_DK

        "svse" ->
            Ok SV_SE

        _ ->
            Err <| string ++ " is not a valid language"


{-| -}
decoderTwoLettersLangauge : String -> Result String Language
decoderTwoLettersLangauge string =
    case String.left 2 <| clean string of
        "en" ->
            Ok EN_US

        "ja" ->
            Ok JA_JP

        "zh" ->
            Ok ZH_TW

        "de" ->
            Ok DE_DE

        "es" ->
            Ok ES_ES

        "fr" ->
            Ok FR_FR

        "it" ->
            Ok IT_IT

        "nl" ->
            Ok NL_NL

        "pt" ->
            Ok PT_PT

        "nb" ->
            Ok NB_NO

        "fi" ->
            Ok FI_FL

        "da" ->
            Ok DA_DK

        "sv" ->
            Ok SV_SE

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
preferredLanguage : List Language -> List String -> Maybe Language
preferredLanguage supportedLanguageList navigatorLanguages =
    --
    -- "navigatorLanguages" contains the preferred languages of the user,
    -- ranked by preference.
    --
    -- "supportedLanguageList" contains a list of supported languages for this
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
                supportedLanguageList
                navigatorLanguages
    in
    if preferredLanguageList == [] then
        Nothing

    else
        List.head preferredLanguageList


{-| -}
clean : String -> String
clean string =
    string
        |> String.toLower
        |> String.split "-"
        |> String.join ""
        |> String.split "_"
        |> String.join ""
        |> String.split " "
        |> String.join ""


{-| Parse Language from string (IETF format). It's case insensitive.

Parsing language from flags

    Utils.I18n.Language.fromString "zh-TW" ===> Just ZH_TW

    Utils.I18n.Language.fromString "ZH-TW" ===> Just ZH_TW

    Utils.I18n.Language.fromString "foo" ===> Nothing

-}
fromString : List Language -> String -> Maybe Language
fromString supportedLanguageList string =
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

        ES_ES ->
            "es-ES"

        FR_FR ->
            "fr-FR"

        DE_DE ->
            "de-DE"

        IT_IT ->
            "it-IT"

        NL_NL ->
            "nl-NL"

        PT_PT ->
            "pt-PT"

        NB_NO ->
            "nb-NO"

        FI_FL ->
            "fi-FL"

        DA_DK ->
            "da-DK"

        SV_SE ->
            "sv-SE"


{-| -}
type LanguageType
    = International
    | Localization


{-| Convert Language to full language description

Example to convert ZH\_TW to translation in English and Traditional Chinese

    toLongString International ZH_TW ===> "Taiwanese"

    toLongString Localization ZH_TW ===> "繁體中文"

-}
toLongString : LanguageType -> Language -> String
toLongString languageType language =
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

        ( International, NL_NL ) ->
            "Dutch"

        ( Localization, NL_NL ) ->
            "Nederlands"

        ( International, PT_PT ) ->
            "Portuguese"

        ( Localization, PT_PT ) ->
            "Português"

        ( International, NB_NO ) ->
            "Norwegian"

        ( Localization, NB_NO ) ->
            "Norsk"

        ( International, FI_FL ) ->
            "Finish"

        ( Localization, FI_FL ) ->
            "Suomi"

        ( International, DA_DK ) ->
            "Danish"

        ( Localization, DA_DK ) ->
            "Dansk"

        ( International, SV_SE ) ->
            "Swedish"

        ( Localization, SV_SE ) ->
            "Svenska"


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

        ES_ES ->
            .es_es translation

        FR_FR ->
            .fr_fr translation

        DE_DE ->
            .de_de translation

        IT_IT ->
            .it_it translation

        NL_NL ->
            .nl_nl translation

        PT_PT ->
            .pt_pt translation

        NB_NO ->
            .nb_no translation

        FI_FL ->
            .fi_fl translation

        DA_DK ->
            .da_dk translation

        SV_SE ->
            .sv_se translation
