module Main exposing (main)

import Browser
import Countries
import Dict
import Element.WithContext exposing (..)
import Element.WithContext.Font as Font
import Html
import R10.Color
import R10.Context
import R10.DropDown
import R10.Form
import R10.FormTypes
import R10.Language
import R10.Mode
import R10.Theme


initTheme : R10.Theme.Theme
initTheme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.primary.blueSky
    }


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = view initTheme
        }


type alias Model =
    { modelPhone : R10.Form.PhoneModel
    , modelForm : R10.Form.Form
    , disabled : Bool
    , messages : List String
    , valid : Maybe Bool
    , dropdown1 : String
    , dropdown2 : String
    , language : R10.Language.Language
    }


init : () -> ( Model, Cmd msg )
init flags =
    let
        state =
            R10.Form.initState

        language =
            R10.Language.JA_JP
    in
    ( { modelPhone = R10.Form.phoneInit
      , modelForm =
            { state = R10.Form.setFieldValue "country" "JP" state
            , conf =
                let
                    fieldConfInit : R10.Form.FieldConf
                    fieldConfInit =
                        R10.Form.initFieldConf
                in
                [ R10.Form.entity.field
                    { fieldConfInit
                        | id = "country"
                        , type_ =
                            R10.FormTypes.inputField.singleCombobox <|
                                List.map
                                    (\country ->
                                        { label = country.flag ++ " " ++ country.name
                                        , value = country.code
                                        }
                                    )
                                    (fixCountries language Countries.all)
                        , label = "Country"
                        , helperText = Just "Helper text"
                    }
                ]
            }
      , disabled = False
      , messages = []
      , valid = Nothing
      , dropdown1 = "JP"
      , dropdown2 = "JP"
      , language = language
      }
    , Cmd.none
    )


type Msg
    = MsgMapperPhone R10.Form.MsgPhone
    | MsgMapperForm R10.Form.Msg
    | Change1 String
    | Change2 String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgMapperForm msg3 ->
            let
                modelForm =
                    model.modelForm

                ( newState, cmd ) =
                    R10.Form.update (\_ a -> a) msg3 modelForm.state
            in
            ( { model | modelForm = { modelForm | state = newState } }, Cmd.map MsgMapperForm cmd )

        Change1 string ->
            ( { model | dropdown1 = string }, Cmd.none )

        Change2 string ->
            ( { model | dropdown2 = string }, Cmd.none )

        MsgMapperPhone singleMsg ->
            let
                ( selectState, selectCmd ) =
                    R10.Form.updatePhone singleMsg model.modelPhone
            in
            ( { model | modelPhone = selectState }, Cmd.map MsgMapperPhone selectCmd )


context : R10.Context.Context
context =
    R10.Context.empty


view : R10.Theme.Theme -> Model -> Html.Html Msg
view theme model =
    layoutWith { context | theme = theme }
        { options =
            [ focusStyle
                { borderColor = Nothing
                , backgroundColor = Nothing
                , shadow = Nothing
                }
            ]
        }
        [ Font.family [ Font.sansSerif ]
        , Font.size 16
        ]
    <|
        column [ padding 10, width fill ]
            [ paragraph [] [ text "Page for testing components on mobile devices. Scroll down..." ]
            , column
                [ paddingXY 0 400
                , width fill
                , spacing 50
                ]
                [ column [ width fill ] <|
                    R10.Form.view model.modelForm MsgMapperForm
                , R10.Form.phoneView
                    []
                    model.modelPhone
                    { maybeValid = model.valid
                    , toMsg = MsgMapperPhone
                    , label = "Telephone"
                    , helperText = Nothing
                    , disabled = model.disabled
                    , requiredLabel = Nothing
                    , style = R10.Form.style.outlined
                    , key = "field2"
                    , palette = R10.Form.themeToPalette theme
                    , countryOptions = Nothing
                    }
                , R10.DropDown.viewBorderLess [ width fill ]
                    { colorBackground = rgba 0 0 0 0.03
                    , colorFont = rgb 0 0 0
                    , currentValue = model.dropdown1
                    , inputHandler = Change1
                    , optionList =
                        List.map
                            (\country ->
                                { text = country.flag ++ " " ++ country.name
                                , value = country.code
                                }
                            )
                            (fixCountries model.language Countries.all)
                    , fontSize = 12
                    }
                , R10.DropDown.viewBorderLess [ width fill ]
                    { colorBackground = rgba 0 0 0 0.03
                    , colorFont = rgb 0 0 0
                    , currentValue = model.dropdown2
                    , inputHandler = Change2
                    , optionList =
                        List.map
                            (\country ->
                                { text = country.name ++ " " ++ country.flag
                                , value = country.code
                                }
                            )
                            (List.sortBy .name Countries.all)
                    , fontSize = 12
                    }
                ]
            ]


simplifyCountryName : String -> String
simplifyCountryName string =
    case Dict.get string countryNameSimplifications of
        Just replacement ->
            replacement

        Nothing ->
            string


countryNameSimplifications : Dict.Dict String String
countryNameSimplifications =
    Dict.fromList
        [ ( "United Kingdom of Great Britain and Northern Ireland", "United Kingdom" )
        , ( "United States of America", "United States" )
        , ( "Korea (Democratic People's Republic of)", "North Korea" )
        , ( "Korea, Republic of", "South Korea" )
        , ( "Bonaire, Sint Eustatius and Saba", "Caribbean Netherlands" )
        , ( "Moldova, Republic of", "Moldova" )
        , ( "Congo, Democratic Republic of the", "Congo" )
        , ( "Iran (Islamic Republic of)", "Iran" )
        , ( "Taiwan, Province of China", "Taiwan" )
        , ( "Bolivia (Plurinational State of)", "Bolivia" )
        , ( "Brunei Darussalam", "Brunei" )
        , ( "Lao People's Democratic Republic", "Lao" )
        , ( "Micronesia (Federated States of)", "Micronesia" )
        , ( "Tanzania, United Republic of", "Tanzania" )
        , ( "Venezuela (Bolivarian Republic of)", "Venezuela" )
        ]


translateCountryName :
    R10.Language.Language
    -> { a | code : String, name : String }
    -> { a | code : String, name : String }
translateCountryName language country =
    case Dict.get country.code (countriesTranslations language) of
        Just translation ->
            { country | name = translation ++ " (" ++ country.name ++ ")" }

        Nothing ->
            country


countriesTranslations : R10.Language.Language -> Dict.Dict String String
countriesTranslations language =
    case language of
        R10.Language.JA_JP ->
            Dict.fromList
                [ ( "JP", "日本" )
                , ( "GB", "イギリス" )
                , ( "FR", "フランス" )
                , ( "TW", "台湾" )
                , ( "US", "アメリカ" )
                , ( "ES", "スペイン" )
                , ( "DE", "ドイツ" )
                , ( "KR", "韓国" )
                , ( "KP", "北朝鮮" )
                ]

        R10.Language.ZH_TW ->
            Dict.fromList
                [ ( "JP", "日本" )
                , ( "GB", "英國" )
                , ( "FR", "法國" )
                , ( "TW", "台灣" )
                , ( "US", "美國" )
                , ( "ES", "西班牙" )
                , ( "DE", "德國" )
                ]

        R10.Language.ES_ES ->
            Dict.fromList
                [ ( "JP", "Japona" )
                , ( "GB", "Reino Unido" )
                , ( "FR", "Francia" )
                , ( "US", "Estados Unidos" )
                , ( "ES", "España" )
                , ( "DE", "Alemania" )
                ]

        R10.Language.DE_DE ->
            Dict.fromList
                [ ( "GB", "Großbritannien" )
                , ( "FR", "Frankreich" )
                , ( "US", "Vereinigte Staaten" )
                , ( "ES", "Spanien" )
                , ( "DE", "Deutschland" )
                ]

        R10.Language.FR_FR ->
            Dict.fromList
                [ ( "JP", "Japon" )
                , ( "US", "États Unis" )
                , ( "ES", "Espagne" )
                , ( "DE", "Allemagne" )
                ]

        _ ->
            Dict.empty


addTranslation : R10.Language.Language -> String -> String
addTranslation languages string =
    string


addSort :
    { code : String, flag : String, name : String }
    -> { code : String, flag : String, name : String, sort : String }
addSort country =
    { code = country.code
    , flag = country.flag
    , name = country.name
    , sort = String.toLower country.name
    }


fixName : R10.Language.Language -> { a | name : String } -> { a | name : String }
fixName language country =
    { country
        | name =
            country.name
                |> simplifyCountryName
                |> addTranslation language
    }


addCountries :
    List { code : String, flag : String, name : String, sort : String }
    -> List { code : String, flag : String, name : String, sort : String }
addCountries countries =
    countries
        ++ [ { name = "UK", flag = "🇬🇧", code = "GB", sort = "uk" }
           , { name = "USA", flag = "🇺🇸", code = "US", sort = "usa" }

           -- , { name = "Japan", flag = "🇯🇵", code = "JP", sort = "aa" }
           ]


fixCountries :
    R10.Language.Language
    -> List { code : String, flag : String, name : String }
    -> List { code : String, flag : String, name : String, sort : String }
fixCountries language countries =
    countries
        |> List.map addSort
        |> addCountries
        |> List.map (fixName language)
        |> List.map (translateCountryName language)
        |> List.sortBy .sort
