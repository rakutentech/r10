module Routes exposing
    ( Route(..)
    , pathsForSSR
    , routeDetails
    , routeFromLocationHref
    , routeToLanguage
    , routeToPath
    , routeToPathWithoutLanguage
    , routesList
    , supportedLanguages
    )

import R10.Language
import Url
import Url.Parser exposing ((</>))



-- ROUTES


type Route
    = Route_Top R10.Language.Language
    | Route_Overview R10.Language.Language
    | Route_UIComponents R10.Language.Language
    | Route_Form_Introduction R10.Language.Language
    | Route_Form_Entities R10.Language.Language
    | Route_Form_Boilerplate R10.Language.Language
    | Route_Form_Example_Table R10.Language.Language
    | Route_Form_Example_CreditCard R10.Language.Language
    | Route_Form_Example_PhoneSelector R10.Language.Language
    | Route_Form_FieldType_Text R10.Language.Language
    | Route_Form_FieldType_Single R10.Language.Language
    | Route_Form_FieldType_Binary R10.Language.Language
    | Route_Form_States R10.Language.Language
    | Route_Counter R10.Language.Language
    | Route_TableExample R10.Language.Language
    | Route_NotFound R10.Language.Language


routesList : List (R10.Language.Language -> Route)
routesList =
    [ Route_Overview
    , Route_UIComponents
    , Route_Form_Introduction
    , Route_Form_Entities
    , Route_Form_Boilerplate
    , Route_Form_Example_Table
    , Route_Form_Example_CreditCard
    , Route_Form_Example_PhoneSelector
    , Route_Form_FieldType_Text
    , Route_Form_FieldType_Single
    , Route_Form_FieldType_Binary
    , Route_Form_States
    , Route_Counter
    , Route_TableExample
    ]


routeDetails :
    Route
    ->
        { language : R10.Language.Language
        , routeLabel : String
        , fileName : String
        , title : R10.Language.Translations
        }
routeDetails route =
    case route of
        Route_Top language ->
            { routeLabel = ""
            , fileName = "Top.elm"
            , language = language
            , title = translationR10
            }

        Route_Overview language ->
            { routeLabel = "overview"
            , fileName = "Overview.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Overview"
                , ja_jp = "前書き"
                , zh_tw = "Overview"
                , es_es = "Overview"
                , fr_fr = "Overview"
                , de_de = "Overview"
                , it_it = "Overview"
                , nl_nl = "Overview"
                , pt_pt = "Overview"
                , nb_no = "Overview"
                , fi_fl = "Overview"
                , da_dk = "Overview"
                , sv_se = "Overview"
                }
            }

        Route_Form_Entities language ->
            { routeLabel = "form_entities"
            , fileName = "Form_Entities.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Form Entities"
                , ja_jp = "Form Entities"
                , zh_tw = "Form Entities"
                , es_es = "Form Entities"
                , fr_fr = "Form Entities"
                , de_de = "Form Entities"
                , it_it = "Form Entities"
                , nl_nl = "Form Entities"
                , pt_pt = "Form Entities"
                , nb_no = "Form Entities"
                , fi_fl = "Form Entities"
                , da_dk = "Form Entities"
                , sv_se = "Form Entities"
                }
            }

        Route_Form_Example_CreditCard language ->
            { routeLabel = "form_example_credit_card"
            , fileName = "Form_Example_CreditCard.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Form Example - Credit Card"
                , ja_jp = "フォームの例-クレジットカード"
                , zh_tw = "Form Example - Credit Card"
                , es_es = "Form Example - Credit Card"
                , fr_fr = "Form Example - Credit Card"
                , de_de = "Form Example - Credit Card"
                , it_it = "Form Example - Credit Card"
                , nl_nl = "Form Example - Credit Card"
                , pt_pt = "Form Example - Credit Card"
                , nb_no = "Form Example - Credit Card"
                , fi_fl = "Form Example - Credit Card"
                , da_dk = "Form Example - Credit Card"
                , sv_se = "Form Example - Credit Card"
                }
            }

        Route_Form_Example_Table language ->
            { routeLabel = "form_example_table"
            , fileName = "Form_Example_Table.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Form Example - Table"
                , ja_jp = "Form Example - Table"
                , zh_tw = "Form Example - Table"
                , es_es = "Form Example - Table"
                , fr_fr = "Form Example - Table"
                , de_de = "Form Example - Table"
                , it_it = "Form Example - Table"
                , nl_nl = "Form Example - Table"
                , pt_pt = "Form Example - Table"
                , nb_no = "Form Example - Table"
                , fi_fl = "Form Example - Table"
                , da_dk = "Form Example - Table"
                , sv_se = "Form Example - Table"
                }
            }

        Route_Form_Example_PhoneSelector language ->
            { routeLabel = "form_example_phone_selector"
            , fileName = "Form_Example_PhoneSelector.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Form Example - Phone Selector"
                , ja_jp = "Form Example - Phone Selector"
                , zh_tw = "Form Example - Phone Selector"
                , es_es = "Form Example - Phone Selector"
                , fr_fr = "Form Example - Phone Selector"
                , de_de = "Form Example - Phone Selector"
                , it_it = "Form Example - Phone Selector"
                , nl_nl = "Form Example - Phone Selector"
                , pt_pt = "Form Example - Phone Selector"
                , nb_no = "Form Example - Phone Selector"
                , fi_fl = "Form Example - Phone Selector"
                , da_dk = "Form Example - Phone Selector"
                , sv_se = "Form Example - Phone Selector"
                }
            }

        Route_Form_Boilerplate language ->
            { routeLabel = "form_boilerplate"
            , fileName = "Form_Boilerplate.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Form Boilerplate"
                , ja_jp = "Form Boilerplate"
                , zh_tw = "Form Boilerplate"
                , es_es = "Form Boilerplate"
                , fr_fr = "Form Boilerplate"
                , de_de = "Form Boilerplate"
                , it_it = "Form Boilerplate"
                , nl_nl = "Form Boilerplate"
                , pt_pt = "Form Boilerplate"
                , nb_no = "Form Boilerplate"
                , fi_fl = "Form Boilerplate"
                , da_dk = "Form Boilerplate"
                , sv_se = "Form Boilerplate"
                }
            }

        Route_Form_FieldType_Text language ->
            { routeLabel = "form_field_type_text"
            , fileName = "Form_FieldType_Text.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Input Field: Text"
                , ja_jp = "Input Field: Text"
                , zh_tw = "Input Field: Text"
                , es_es = "Input Field: Text"
                , fr_fr = "Input Field: Text"
                , de_de = "Input Field: Text"
                , it_it = "Input Field: Text"
                , nl_nl = "Input Field: Text"
                , pt_pt = "Input Field: Text"
                , nb_no = "Input Field: Text"
                , fi_fl = "Input Field: Text"
                , da_dk = "Input Field: Text"
                , sv_se = "Input Field: Text"
                }
            }

        Route_Form_FieldType_Single language ->
            { routeLabel = "form_field_type_single"
            , fileName = "Form_FieldType_Single.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Input Field: Single"
                , ja_jp = "Input Field: Single"
                , zh_tw = "Input Field: Single"
                , es_es = "Input Field: Single"
                , fr_fr = "Input Field: Single"
                , de_de = "Input Field: Single"
                , it_it = "Input Field: Single"
                , nl_nl = "Input Field: Single"
                , pt_pt = "Input Field: Single"
                , nb_no = "Input Field: Single"
                , fi_fl = "Input Field: Single"
                , da_dk = "Input Field: Single"
                , sv_se = "Input Field: Single"
                }
            }

        Route_Form_FieldType_Binary language ->
            { routeLabel = "form_field_type_binary"
            , fileName = "Form_FieldType_Binary.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Input Field: Binary"
                , ja_jp = "Input Field: Binary"
                , zh_tw = "Input Field: Binary"
                , es_es = "Input Field: Binary"
                , fr_fr = "Input Field: Binary"
                , de_de = "Input Field: Binary"
                , it_it = "Input Field: Binary"
                , nl_nl = "Input Field: Binary"
                , pt_pt = "Input Field: Binary"
                , nb_no = "Input Field: Binary"
                , fi_fl = "Input Field: Binary"
                , da_dk = "Input Field: Binary"
                , sv_se = "Input Field: Binary"
                }
            }

        Route_Form_States language ->
            { routeLabel = "form_states"
            , fileName = "Form_States.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Form States"
                , ja_jp = "Form States"
                , zh_tw = "Form States"
                , es_es = "Form States"
                , fr_fr = "Form States"
                , de_de = "Form States"
                , it_it = "Form States"
                , nl_nl = "Form States"
                , pt_pt = "Form States"
                , nb_no = "Form States"
                , fi_fl = "Form States"
                , da_dk = "Form States"
                , sv_se = "Form States"
                }
            }

        Route_Form_Introduction language ->
            { routeLabel = "form"
            , fileName = "Form_Introduction.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Form"
                , ja_jp = "Form"
                , zh_tw = "Form"
                , es_es = "Form"
                , fr_fr = "Form"
                , de_de = "Form"
                , it_it = "Form"
                , nl_nl = "Form"
                , pt_pt = "Form"
                , nb_no = "Form"
                , fi_fl = "Form"
                , da_dk = "Form"
                , sv_se = "Form"
                }
            }

        Route_UIComponents language ->
            { routeLabel = "ui_components"
            , fileName = "Form_FieldType_Text.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "UI Components"
                , ja_jp = "UI Components"
                , zh_tw = "UI Components"
                , es_es = "UI Components"
                , fr_fr = "UI Components"
                , de_de = "UI Components"
                , it_it = "UI Components"
                , nl_nl = "UI Components"
                , pt_pt = "UI Components"
                , nb_no = "UI Components"
                , fi_fl = "UI Components"
                , da_dk = "UI Components"
                , sv_se = "UI Components"
                }
            }

        Route_Counter language ->
            { routeLabel = "counter"
            , fileName = "Counter.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Counter"
                , ja_jp = "カウンター"
                , zh_tw = "Counter"
                , es_es = "Counter"
                , fr_fr = "Counter"
                , de_de = "Counter"
                , it_it = "Counter"
                , nl_nl = "Counter"
                , pt_pt = "Counter"
                , nb_no = "Counter"
                , fi_fl = "Counter"
                , da_dk = "Counter"
                , sv_se = "Counter"
                }
            }

        Route_TableExample language ->
            { routeLabel = "sortable_table"
            , fileName = "TableExample.elm"
            , language = language
            , title =
                { key = "title"
                , en_us = "Sortable Table"
                , ja_jp = "Sortable Table"
                , zh_tw = "Sortable Table"
                , es_es = "Sortable Table"
                , fr_fr = "Sortable Table"
                , de_de = "Sortable Table"
                , it_it = "Sortable Table"
                , nl_nl = "Sortable Table"
                , pt_pt = "Sortable Table"
                , nb_no = "Sortable Table"
                , fi_fl = "Sortable Table"
                , da_dk = "Sortable Table"
                , sv_se = "Sortable Table"
                }
            }

        Route_NotFound language ->
            { routeLabel = "not_found"
            , fileName = ""
            , language = language
            , title = translationsError
            }


pathsForSSR : List String
pathsForSSR =
    let
        routes : List Route
        routes =
            List.map (\lang -> Route_Top lang) supportedLanguages
                ++ List.concat (List.map (\lang -> List.map (\route -> route lang) routesList) supportedLanguages)
    in
    List.map routeToPathWithoutLanguage routes


routeToPathWithoutLanguage : Route -> String
routeToPathWithoutLanguage route =
    routeToPath (routeToLanguage route) route


routeToPath : R10.Language.Language -> Route -> String
routeToPath language route =
    let
        lang : List String
        lang =
            if language == languageDefault then
                []

            else
                [ R10.Language.toStringShort language ]

        path : String
        path =
            String.join "/" <|
                case route of
                    Route_Top _ ->
                        lang

                    _ ->
                        lang ++ [ .routeLabel (routeDetails route) ]
    in
    if String.isEmpty path then
        "/"

    else
        "/" ++ path ++ "/"


routeToLanguage : Route -> R10.Language.Language
routeToLanguage route =
    .language (routeDetails route)


urlToRoute : Url.Url -> Route
urlToRoute url =
    Maybe.withDefault (Route_NotFound languageDefault) <| Url.Parser.parse routeParser url


routeFromLocationHref : String -> Route
routeFromLocationHref locationHref =
    locationHref
        |> Url.fromString
        |> Maybe.map urlToRoute
        |> Maybe.withDefault (Route_NotFound languageDefault)


routeWithLanguage : (R10.Language.Language -> Route) -> Url.Parser.Parser (Route -> c) c
routeWithLanguage route =
    Url.Parser.map route (R10.Language.urlParser </> Url.Parser.s (.routeLabel (routeDetails (route languageDefault))))


routeWithDefaultLanguage : (R10.Language.Language -> Route) -> Url.Parser.Parser (Route -> c) c
routeWithDefaultLanguage route =
    Url.Parser.map (route languageDefault) (Url.Parser.s (.routeLabel (routeDetails (route languageDefault))))


routeParser : Url.Parser.Parser (Route -> b) b
routeParser =
    Url.Parser.oneOf
        ([]
            -- The RouteTop is special because doesn't have any label
            ++ [ Url.Parser.map Route_Top R10.Language.urlParser
               , Url.Parser.map (Route_Top languageDefault) Url.Parser.top
               ]
            ++ List.map routeWithLanguage routesList
            ++ List.map routeWithDefaultLanguage routesList
        )



-- TRANSLATIONS


translationsError : R10.Language.Translations
translationsError =
    { key = "error"
    , en_us = "Error"
    , ja_jp = "Error"
    , zh_tw = "Error"
    , es_es = "Error"
    , fr_fr = "Error"
    , de_de = "Error"
    , it_it = "Error"
    , nl_nl = "Error"
    , pt_pt = "Error"
    , nb_no = "Error"
    , fi_fl = "Error"
    , da_dk = "Error"
    , sv_se = "Error"
    }


translationR10 : R10.Language.Translations
translationR10 =
    { key = "r10"
    , en_us = "R10"
    , ja_jp = "R10"
    , zh_tw = "R10"
    , es_es = "R10"
    , fr_fr = "R10"
    , de_de = "R10"
    , it_it = "R10"
    , nl_nl = "R10"
    , pt_pt = "R10"
    , nb_no = "R10"
    , fi_fl = "R10"
    , da_dk = "R10"
    , sv_se = "R10"
    }



-- LANGUAGE


languageDefault : R10.Language.Language
languageDefault =
    R10.Language.EN_US


supportedLanguages : List R10.Language.Language
supportedLanguages =
    [ R10.Language.EN_US
    , R10.Language.JA_JP
    ]
