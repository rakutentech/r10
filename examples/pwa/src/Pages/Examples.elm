module Pages.Examples exposing
    ( Model
    , Msg
    , init
    , title
    , update
    , view
    )

import Color
import Color.Accessibility
import Color.Convert
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html
import Html.Attributes
import Markdown
import R10.Button
import R10.Color
import R10.Color.AttrsBackground
import R10.Color.AttrsBorder
import R10.Color.AttrsFont
import R10.Color.Svg
import R10.Color.Utils
import R10.Form
import R10.Form.Msg
import R10.Form.Update
import R10.FormComponents.Style
import R10.I18n
import R10.Language
import R10.LanguageSelector
import R10.Libu
import R10.Mode
import R10.Okaimonopanda
import R10.Paragraph
import R10.Svg.Icons
import R10.Svg.Lists
import R10.Theme
import R10.Translations


title : R10.Language.Translations
title =
    { key = "title"
    , en_us = "Overview"
    , ja_jp = "Overview"
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


type alias Model =
    { language : R10.Language.Language
    , theme : R10.Theme.Theme
    , formState : R10.Form.State
    }


defaultTheme : { mode : R10.Mode.Mode, primaryColor : R10.Color.Primary }
defaultTheme =
    { primaryColor = R10.Color.primary.crimsonRed
    , mode = R10.Mode.Light
    }


init : Model
init =
    { language = R10.Language.EN_US
    , theme = defaultTheme
    , formState = R10.Form.initState
    }


type Msg
    = ChangeLanguage R10.Language.Language
    | ChangePrimaryColor R10.Color.Primary
    | ChangeMode R10.Mode.Mode
    | MsgForm R10.Form.Msg.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeLanguage language ->
            { model | language = language }

        ChangePrimaryColor primaryColor ->
            let
                theme =
                    model.theme
            in
            { model | theme = { theme | primaryColor = primaryColor } }

        ChangeMode mode ->
            let
                theme =
                    model.theme
            in
            { model | theme = { theme | mode = mode } }

        MsgForm msgForm ->
            { model | formState = Tuple.first <| R10.Form.Update.update msgForm model.formState }


langauges : List R10.Language.Language
langauges =
    [ R10.Language.EN_US
    , R10.Language.JA_JP
    , R10.Language.ZH_TW
    , R10.Language.Key
    , R10.Language.Lollipop
    ]


titleSection : R10.Theme.Theme -> String -> Element msg
titleSection theme string =
    R10.Paragraph.xxlarge
        [ Font.bold
        , paddingEach { top = 70, right = 0, bottom = 20, left = 0 }
        , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
        , R10.Color.AttrsBorder.normal theme
        ]
        [ text string ]


titleSubSection : R10.Theme.Theme -> String -> Element msg
titleSubSection theme string =
    R10.Paragraph.xlarge [] [ text string ]


twoPalettes :
    R10.Theme.Theme
    ->
        (R10.Theme.Theme
         -> List { a | color : Color.Color, description : String, name : String }
        )
    -> Element msg
twoPalettes theme list =
    wrappedRow [ spacing 20 ]
        [ column [ width fill, spacing 10, alignTop ]
            [ el [ centerX ] <| text "Light Mode"
            , paletteView { theme | mode = R10.Mode.Light } list
            ]
        , column [ width fill, spacing 10, alignTop ]
            [ el [ centerX ] <| text "Dark Mode"
            , paletteView { theme | mode = R10.Mode.Dark } list
            ]
        ]


paletteView :
    R10.Theme.Theme
    -> (R10.Theme.Theme -> List { a | color : Color.Color, name : String, description : String })
    -> Element msg
paletteView theme list =
    column
        [ Border.widthEach { bottom = 0, left = 1, right = 0, top = 1 }
        , Border.color <| rgba 0 0 0 0.2
        ]
    <|
        List.map
            (\paletteColor ->
                let
                    elementColor : Element.Color
                    elementColor =
                        R10.Color.Utils.colorToElementColor color

                    color : Color.Color
                    color =
                        paletteColor.color

                    hex : String
                    hex =
                        color
                            |> Color.Convert.colorToHexWithAlpha

                    name : String
                    name =
                        paletteColor.name
                in
                el
                    [ padding 10
                    , Background.color elementColor
                    , width fill
                    , tooltip above (myTooltip paletteColor.description)
                    , Border.widthEach { bottom = 1, left = 0, right = 1, top = 0 }
                    , Border.color <| rgba 0 0 0 0.2
                    , Font.color <| fontColorMaxContrast color
                    ]
                <|
                    row [ Font.size 13, spacing 20, width fill ]
                        [ paragraph [ width <| px 100 ] [ text name ]
                        , el [ Font.family [ Font.monospace ], width <| px 80 ] <| text hex

                        -- , paragraph [] [ text paletteColor.description ]
                        -- , el [ Font.color <| rgb 1 1 1, alignRight ] <| text "⬤"
                        -- , el [ Font.color <| rgb 0 0 0 ] <| text "⬤"
                        ]
            )
            (list theme)


fontColorMaxContrast : Color.Color -> Color
fontColorMaxContrast color =
    R10.Color.Utils.colorToElementColor <| Maybe.withDefault (Color.rgb 0 0 0) <| Color.Accessibility.maximumContrast color [ Color.rgb 1 1 1, Color.rgb 0 0 0 ]


myTooltip : String -> Element msg
myTooltip str =
    paragraph
        [ Background.color (rgba 0.95 0.95 0.5 0.94)
        , Font.color (rgb 0 0 0)
        , padding 8
        , Border.rounded 5
        , Font.size 15
        , Border.shadow
            { offset = ( 0, 3 ), blur = 6, size = 0, color = rgba 0 0 0 0.32 }
        ]
        [ text str ]


tooltip : (Element msg -> Attribute msg) -> Element Never -> Attribute msg
tooltip usher tooltip_ =
    inFront <|
        el
            [ -- width fill
              width
                (fill
                    |> maximum 300
                )
            , height fill
            , transparent True
            , mouseOver [ transparent False ]
            , (usher << Element.map never) <|
                el
                    [ padding 10
                    , htmlAttribute (Html.Attributes.style "pointerEvents" "none")
                    ]
                    tooltip_
            ]
            none


formConf : R10.Form.Conf
formConf =
    [ R10.Form.entity.field
        { id = "binary"
        , idDom = Nothing
        , type_ = R10.Form.fieldType.binary R10.Form.binary.switch
        , label = "Binary Switch"
        , helperText = Just "Helper Text"
        , requiredLabel = Nothing
        , validationSpecs = Nothing
        }
    , R10.Form.entity.field
        { id = "binary"
        , idDom = Nothing
        , type_ = R10.Form.fieldType.binary R10.Form.binary.checkbox
        , label = "Checkbox"
        , helperText = Nothing
        , requiredLabel = Just <| "Required"
        , validationSpecs =
            Just
                { showPassedValidationMessages = False
                , hidePassedValidationStyle = True
                , validationIcon = R10.Form.validationIcon.noIcon
                , validation = R10.Form.validation.required
                }
        }
    , R10.Form.entity.field
        { id = "userId"
        , idDom = Nothing
        , type_ = R10.Form.fieldType.text R10.Form.text.username
        , label = "User ID"
        , helperText = Nothing
        , requiredLabel = Just "Required"
        , validationSpecs =
            Just
                { showPassedValidationMessages = False
                , hidePassedValidationStyle = True
                , validationIcon = R10.Form.validationIcon.noIcon
                , validation =
                    R10.Form.validation.allOf
                        [ R10.Form.validation.required
                        , R10.Form.validation.minLength 6
                        , R10.Form.validation.maxLength 128
                        , R10.Form.validation.withMsg { ok = "INVALID_FORMAT_INVALID_CHARACTERS", err = "INVALID_FORMAT_INVALID_CHARACTERS" }
                            (R10.Form.validation.regex "^((?!(/|\\\\))[\\x21-\\x7F])+$")
                        ]
                }
        }
    , R10.Form.entity.field
        { id = "password"
        , idDom = Nothing
        , type_ = R10.Form.fieldType.text R10.Form.text.passwordCurrent
        , label = "Password"
        , helperText = Nothing
        , requiredLabel = Just <| "Required"
        , validationSpecs =
            Just
                { showPassedValidationMessages = False
                , hidePassedValidationStyle = True
                , validationIcon = R10.Form.validationIcon.noIcon
                , validation = R10.Form.validation.required
                }
        }
    , R10.Form.entity.field
        { id = "single"
        , idDom = Nothing
        , type_ =
            R10.Form.fieldType.single R10.Form.single.radio
                [ { value = "option1"
                  , label = "Option 1"
                  }
                , { value = "option2"
                  , label = "Option 2"
                  }
                ]
        , label = "Radio"
        , helperText = Nothing
        , requiredLabel = Just <| "Required"
        , validationSpecs = Nothing
        }
    , R10.Form.entity.field
        { id = "single"
        , idDom = Nothing
        , type_ =
            R10.Form.fieldType.single R10.Form.single.combobox
                [ { value = "option1"
                  , label = "Option 1"
                  }
                , { value = "option2"
                  , label = "Option 2"
                  }
                ]
        , label = "Radio"
        , helperText = Nothing
        , requiredLabel = Just <| "Required"
        , validationSpecs = Nothing
        }
    ]


view : Model -> { x : Int, y : Int } -> { x : Int, y : Int } -> List (Element Msg)
view model mouse windowSize =
    let
        theme =
            model.theme
    in
    [ titleSection model.theme "Palettes"
    , titleSubSection model.theme "Palette Base"
    , twoPalettes theme R10.Color.listBase
    , titleSubSection model.theme "Palette Primary"
    , twoPalettes theme R10.Color.listPrimary
    , titleSubSection model.theme "Palette Derived"
    , twoPalettes theme R10.Color.listDerived
    , titleSection model.theme "Buttons"
    , column
        [ padding 20
        , spacing 20
        , R10.Color.AttrsBackground.normal model.theme
        , R10.Color.AttrsFont.normal model.theme
        ]
        [ R10.Button.primary []
            { label = text "Primary Button"
            , libu = R10.Libu.Li "#"
            , theme = model.theme
            }
        , R10.Button.primary []
            { label =
                row [ spacing 10 ]
                    [ R10.Svg.Icons.arrow_left_l [] (R10.Color.Svg.fontButtonPrimary model.theme) 24
                    , text "Primary Button"
                    ]
            , libu = R10.Libu.Li "#"
            , theme = model.theme
            }
        , R10.Button.secondary []
            { label = text "Secondary Button"
            , libu = R10.Libu.Li "#"
            , theme = model.theme
            }
        , R10.Button.tertiary []
            { label = text "Tertiary Button"
            , libu = R10.Libu.Li "#"
            , theme = model.theme
            }
        , R10.Button.quaternary []
            { label = text "Quaternary Button"
            , libu = R10.Libu.Li "#"
            , theme = model.theme
            }
        ]
    , titleSection model.theme "Forms"
    , el [] <| html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """Forms are defined by two things: Configuration and State.

An example of `Configuration` is

    [ R10.Form.entity.field
        { id = "userId"
        , idDom = Nothing
        , type_ = R10.Form.fieldType.text R10.Form.text.username
        , label = "User ID"
        , helperText = Nothing
        , requiredLabel = Just "Required"
        , validationSpecs =
            Just
                { showPassedValidationMessages = False
                , hidePassedValidationStyle = True
                , validationIcon = R10.Form.validationIcon.noIcon
                , validation =
                    R10.Form.validation.allOf
                        [ R10.Form.validation.required
                        , R10.Form.validation.minLength 6
                        , R10.Form.validation.maxLength 128
                        , R10.Form.validation.withMsg
                            { ok = "INVALID_FORMAT_INVALID_CHARACTERS"
                            , err = "INVALID_FORMAT_INVALID_CHARACTERS"
                            }
                            (R10.Form.validation.regex "^((?!(/|\\\\))[\\x21-\\x7F])+$")
                        ]
                }
        }
    ]

Forms have two different styles: **Outlined** and **Filled**.
        
#### Examples:"""
    , row [ spacing 40 ]
        [ column [ spacing 30 ] <|
            [ paragraph [ Font.bold ] [ text "Style: Outlined" ] ]
                ++ R10.Form.view
                    { state = model.formState, conf = formConf }
                    MsgForm
        , column [ spacing 30 ] <|
            [ paragraph [ Font.bold ] [ text "Style: Filled" ] ]
                ++ R10.Form.viewWithOptions
                    { state = model.formState, conf = formConf }
                    MsgForm
                    { maker = Nothing
                    , translator = Nothing
                    , style = R10.FormComponents.Style.Filled
                    , palette = Nothing
                    }
        ]
    , titleSection model.theme "Translations"
    , el [] <| html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """To translate some text:

    R10.I18n.t model.language R10.Translations.signInHeader

Where `signInHeader` is defined as

    signInHeader : Translations
    signInHeader =
        { key = "signInHeader"
        , en_us = "Sign in to your Rakuten account"
        , zh_tw = "會員登入"
        , ja_jp = "楽天会員 ログイン"
        ...
        }

#### Examples:"""
    , wrappedRow [ spacing 16 ] <|
        List.map
            (\language ->
                R10.Button.secondary []
                    { label = text <| R10.Language.toLongString R10.Language.International language
                    , libu = R10.Libu.Bu <| Just <| ChangeLanguage language
                    , theme = model.theme
                    }
            )
            langauges
    , text <| R10.I18n.t model.language R10.Translations.signInHeader
    , titleSection model.theme "Language Selector"
    , R10.LanguageSelector.view []
        { changeMsg =
            \result ->
                case result of
                    Ok language ->
                        ChangeLanguage language

                    Err _ ->
                        ChangeLanguage R10.Language.default
        , colorBackground = Color.rgb 1 1 1
        , colorFont = Color.rgb 0 0 0
        , currentLocale = model.language
        , supportedLanguageList = R10.Language.defaultSupportedLanguageList
        , withLanguageSelector = True
        }
    , titleSection model.theme "Okaimono Panda"
    , el [] <|
        html <|
            Html.div [] <|
                R10.Okaimonopanda.view
                    { mouse = mouse
                    , screen = windowSize
                    }
    , el [] <| html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """
```
R10.Okaimonopanda.view
    { mouse = mouse
    , screen = windowSize
    }
```
"""

    --
    -- LOGOS & ICONS
    --
    , titleSection model.theme "Logos & Icons"
    , titleSubSection model.theme "Logos"
    , f R10.Svg.Lists.listLogos 30
    , titleSubSection model.theme "Logos Extra"
    , f R10.Svg.Lists.listLogosExtra 30
    , titleSubSection model.theme "Icons"
    , f R10.Svg.Lists.listIcons 30
    , titleSubSection model.theme "Icons Extra"
    , f R10.Svg.Lists.listIconsExtra 30
    , titleSubSection model.theme "Others"
    , f R10.Svg.Lists.listOthers 200
    , el
        [ htmlAttribute <| Html.Attributes.style "position" "fixed"
        , htmlAttribute <| Html.Attributes.style "bottom" "0"
        , htmlAttribute <| Html.Attributes.style "left" "0"
        , padding 10
        , width fill
        , R10.Color.AttrsBackground.normal theme
        , R10.Color.AttrsFont.normal model.theme
        , Border.color <| rgba 0 0 0 0.05
        , Border.widthEach { bottom = 0, left = 0, right = 0, top = 1 }
        , Border.shadow { offset = ( 0, 0 ), size = 2, blur = 10, color = rgba 0 0 0 0.05 }
        ]
      <|
        wrappedRow [ spacing 10, centerX ] <|
            List.map
                (\{ color, name, type_ } ->
                    R10.Button.primary
                        [ width shrink, padding 16 ]
                        { label =
                            el
                                [ alpha <|
                                    if theme.primaryColor == type_ then
                                        1

                                    else
                                        0
                                ]
                            <|
                                text "⬤"

                        -- stext name
                        , libu = R10.Libu.Bu <| Just <| ChangePrimaryColor type_
                        , theme = { theme | primaryColor = type_ }
                        }
                )
                (R10.Color.listPrimary defaultTheme)
                ++ List.map
                    (\mode ->
                        R10.Button.secondary [ width shrink ]
                            { label = text <| R10.Mode.toString mode
                            , libu = R10.Libu.Bu <| Just <| ChangeMode mode
                            , theme = theme
                            }
                    )
                    [ R10.Mode.Light, R10.Mode.Dark ]
    ]


f : (Int -> Color.Color -> List ( Element msg, String )) -> Int -> Element msg
f list size =
    Element.wrappedRow
        [ spacing 10 ]
    <|
        List.map
            (\( svg, name ) ->
                row [ spacing 20 ]
                    [ el [] <| svg
                    , el [ width <| px 300, alpha 0.3 ] <| text name
                    ]
            )
            (list size (R10.Color.Utils.fromHex "#333"))
