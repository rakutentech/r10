module Pages.UIComponents exposing
    ( Model
    , Msg
    , init
    , title
    , update
    , view
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html
import Html.Attributes
import Markdown
import R10.Button
import R10.Card
import R10.Color
import R10.Color.AttrsBackground
import R10.Form
import R10.FormComponents
import R10.Language
import R10.Libu
import R10.Link
import R10.Mode
import R10.Theme



-- Bring this page! http://ft86nje023mzbpr69fb3rngdw4yy5o6ge35r3e3.surge.sh/
-- Link this page
-- https://github.com/NoRedInk/noredink-ui
-- https://github.com/rakutentech/http-trinity/commits/master
-- https://elm.dmy.fr/packages/NoRedInk/noredink-ui/latest/


title : R10.Language.Translations
title =
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


type alias Model =
    { formState : R10.Form.State }


init : Model
init =
    { formState = R10.Form.initState }


type Msg
    = FormMsg R10.Form.Msg
    | DoNothing


update : Msg -> Model -> Model
update msg model =
    case msg of
        DoNothing ->
            model

        FormMsg formMsg ->
            let
                ( newFormState, _ ) =
                    R10.Form.update formMsg model.formState
            in
            { model | formState = newFormState }


codeAttrs : List (Attribute msg)
codeAttrs =
    [ Background.color <| rgb 0.95 0.95 0.95
    , Font.color <| rgb 0.3 0.3 0.3
    , padding 20
    , width <| fillPortion 3
    , scrollbarX
    , Border.rounded 5
    ]


exampleAttrs : List (Attribute msg)
exampleAttrs =
    [ width <| fillPortion 2
    , alignTop
    , Border.rounded 5
    , Border.color <| rgb 0.8 0.8 0.8
    , padding 30
    , height fill
    ]


rowAttrs : List (Attribute msg)
rowAttrs =
    [ spacing 30
    , width fill
    ]


formConf : R10.Form.Conf
formConf =
    [ R10.Form.entity.field
        { id = "explain"
        , idDom = Nothing
        , type_ = R10.Form.fieldType.binary R10.Form.binary.switch
        , label = "Explain: OFF ⇔ ON"
        , helperText = Nothing
        , requiredLabel = Nothing
        , validationSpecs = Nothing
        }
    , R10.Form.entity.field
        { id = "width"
        , idDom = Nothing
        , type_ = R10.Form.fieldType.binary R10.Form.binary.switch
        , label = "Width: Fill ⇔ Shrink"
        , helperText = Nothing
        , requiredLabel = Nothing
        , validationSpecs = Nothing
        }
    ]


formView : R10.Theme.Theme -> R10.Form.State -> (R10.Form.Msg -> msg) -> List (Element msg)
formView theme formState msgMapper =
    R10.Form.viewWithTheme
        { conf = formConf
        , state = formState
        }
        msgMapper
        theme


subTitleAttrs : List (Attr () msg)
subTitleAttrs =
    [ Font.size 20, Font.bold, paddingXY 0 20 ]


titleAttrs : List (Attribute msg)
titleAttrs =
    [ alignTop
    , Font.size 30
    , paddingXY 0 6
    , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
    , Border.color <| rgba 0 0 0 0.2
    , width fill
    ]


viewHelper :
    (Element msg -> Element msg)
    -> Data msg
    -> Int
    -> Component msg
    -> Element msg
viewHelper explainComponent data index component =
    section
        (String.fromInt (index + 1)
            ++ ". "
            ++ component.name
            ++ " - "
            ++ (if R10.Mode.isLight data.theme.mode then
                    "Light"

                else
                    "Dark"
               )
        )
        (row rowAttrs
            [ -- el codeAttrs <| html <| Html.pre [] [ Html.text component.componentAsStringCode ]
              el [ width <| fillPortion 3, padding 0 ] <| html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] ("```\n" ++ component.componentAsStringCode ++ "```")
            , el
                -- exampleAttrs
                (R10.Card.noShadow data.theme
                    ++ [ R10.Color.AttrsBackground.surface2dp data.theme
                       , width <| fillPortion 2
                       , htmlAttribute <| Html.Attributes.style "transition" "background-color 0.4s"
                       ]
                )
              <|
                explainComponent <|
                    component.componentAsElmCode data
            ]
        )


section : String -> Element msg -> Element msg
section title_ content =
    column [ spacing 30, width fill ]
        [ el titleAttrs <| text title_
        , content
        ]


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
    let
        mode : R10.Mode.Mode
        mode =
            case R10.Form.getFieldValueAsBool "mode" model.formState of
                Just True ->
                    R10.Mode.fromString "dark"

                _ ->
                    R10.Mode.fromString "light"

        primaryColor : R10.Color.Primary
        primaryColor =
            case R10.Form.getFieldValueAsBool "primaryColor" model.formState of
                Just True ->
                    R10.Color.primary.blue

                _ ->
                    R10.Color.primary.pink

        widthMode : Attribute msg
        widthMode =
            case R10.Form.getFieldValueAsBool "width" model.formState of
                Just True ->
                    width shrink

                _ ->
                    width fill

        explainComponent : Element msg -> Element msg
        explainComponent =
            case R10.Form.getFieldValueAsBool "explain" model.formState of
                Just True ->
                    el
                        [ Border.width 4
                        , Border.dashed
                        , Border.color <| rgb 0 0.5 0.8
                        , Background.color <| rgba 0 0.5 1 0.3
                        , widthMode
                        , centerX
                        , htmlAttribute <| Html.Attributes.style "transition" "background-color 0.4s"
                        ]

                _ ->
                    el
                        [ widthMode
                        , centerX
                        , htmlAttribute <| Html.Attributes.style "transition" "background-color 0.4s"
                        ]
    in
    []
        ++ [ el [] <| html <| Html.node "style" [] [ Html.text """.pre div {line-height: 18px}""" ] ]
        ++ List.indexedMap
            (viewHelper
                explainComponent
                { theme = theme
                , doSomething = DoNothing
                , formState = model.formState
                , msgMapper = FormMsg
                , widthMode = widthMode
                }
            )
            (components theme)
        ++ [ el
                [ alignLeft
                , Font.size 16
                , htmlAttribute <| Html.Attributes.style "position" "fixed"
                , htmlAttribute <| Html.Attributes.style "bottom" "0"
                , htmlAttribute <| Html.Attributes.style "left" "0"
                , padding 30
                , width fill
                , R10.Color.AttrsBackground.surface2dp theme
                , Border.color <| rgba 0 0 0 0.05
                , Border.widthEach { bottom = 0, left = 0, right = 0, top = 1 }
                , Border.shadow { offset = ( 0, 0 ), size = 2, blur = 10, color = rgba 0 0 0 0.05 }
                ]
             <|
                row
                    [ centerX ]
                <|
                    formView theme model.formState FormMsg
           ]



--
--
--


type alias Data msg =
    { doSomething : msg
    , formState : R10.Form.State
    , msgMapper : R10.Form.Msg -> msg
    , theme : R10.Theme.Theme
    , widthMode : Attribute msg
    }


type alias Component msg =
    { componentAsElmCode : Data msg -> Element msg
    , componentAsStringCode : String
    , name : String
    }


components : R10.Theme.Theme -> List (Component msg)
components theme_ =
    --
    --
    --
    [ { name = "Button - Primary"
      , componentAsElmCode =
            \{ doSomething, theme } ->
                R10.Button.primary []
                    { label = text "Text"
                    , libu = R10.Libu.Bu <| Just doSomething
                    , theme = theme
                    }
      , componentAsStringCode =
            """R10.Button.primary []
    { label = text "Text"
    , libu = R10.Libu.Bu <| Just doSomething
    , theme = theme
    }"""
      }

    --
    --
    --
    , { name = "Button - Primary - Disabled"
      , componentAsElmCode =
            \{ theme } ->
                R10.Button.primary []
                    { label = text "Text"
                    , libu = R10.Libu.Bu <| Nothing
                    , theme = theme
                    }
      , componentAsStringCode =
            """R10.Button.primary []
    { label = text "Text"
    , libu = R10.Libu.Bu <| Nothing
    , theme = theme
    }"""
      }

    --
    --
    --
    , { name = "Button - Primary - as Link"
      , componentAsElmCode =
            \{ theme } ->
                R10.Button.primary []
                    { label = text "Text"
                    , libu = R10.Libu.Li "https://www.example.com"
                    , theme = theme
                    }
      , componentAsStringCode = """R10.Button.primary []
    { label = text "Text"
    , libu = R10.Libu.Li "https://www.example.com"
    , theme = theme
    }"""
      }

    --
    --
    --
    , { name = "Button - Primary - Limited Width"
      , componentAsElmCode =
            \{ doSomething, theme } ->
                R10.Button.primary R10.Button.withLimitedWidth
                    { label = text "Text"
                    , libu = R10.Libu.Bu <| Just doSomething
                    , theme = theme
                    }
      , componentAsStringCode = """R10.Button.primary R10.Button.withLimitedWidth
    { label = text "Text"
    , libu = R10.Libu.Bu <| Just doSomething
    , theme = theme
    }"""
      }

    --
    --
    --
    , { name = "Button - Secondary"
      , componentAsElmCode =
            \{ doSomething, theme } ->
                R10.Button.secondary []
                    { label = text "Text"
                    , libu = R10.Libu.Bu <| Just doSomething
                    , theme = theme
                    }
      , componentAsStringCode = """R10.Button.secondary []
    { label = text "Text"
    , libu = R10.Libu.Bu <| Just doSomething
    , theme = theme
    }"""
      }

    --
    --
    --
    , { name = "Button - Tertiary"
      , componentAsElmCode =
            \{ doSomething, theme } ->
                R10.Button.tertiary []
                    { label = text "Text"
                    , libu = R10.Libu.Bu <| Just doSomething
                    , theme = theme
                    }
      , componentAsStringCode = """R10.Button.tertiary []
    { label = text "Text"
    , libu = R10.Libu.Bu <| Just doSomething
    , theme = theme
    }"""
      }

    --
    --
    --
    , { name = "Button - Tertiary with link"
      , componentAsElmCode =
            \{ doSomething, theme } ->
                R10.Button.tertiary []
                    { label =
                        paragraph []
                            [ text "Text with "
                            , el (R10.Link.attrs theme) <| text <| "link"
                            ]
                    , libu = R10.Libu.Bu <| Just doSomething
                    , theme = theme
                    }
      , componentAsStringCode =
            """R10.Button.tertiary []
    { label =
        paragraph []
            [ text "Text with "
            , el (R10.Link.attrs theme) <| text <| "link"
            ]
    , libu = R10.Libu.Bu <| Just doSomething
    , theme = theme
    }"""
      }

    --
    --
    --
    , { name = "Form - Login - Outlined"
      , componentAsElmCode =
            \{ formState, msgMapper, widthMode } ->
                column [ widthMode ] <|
                    R10.Form.viewWithTheme
                        { conf = v01
                        , state = formState
                        }
                        msgMapper
                        theme_
      , componentAsStringCode = """R10.Form.viewWithTheme
    { conf = v01
    , state = formState
    }
    msgMapper
    theme_"""
      }

    --
    --
    --
    , { name = "Form - Login - Filled"
      , componentAsElmCode =
            \{ formState, msgMapper, widthMode } ->
                column [ widthMode ] <|
                    R10.Form.viewWithOptions
                        { conf = v01
                        , state = formState
                        }
                        msgMapper
                        { maker = Nothing
                        , translator = Nothing
                        , style = R10.FormComponents.style.filled
                        , palette = Just <| R10.Form.themeToPalette theme_
                        }
      , componentAsStringCode = """R10.Form.viewWithOptions
    { conf = v01
    , state = formState
    }
    msgMapper
    { maker = Nothing
    , translator = Nothing
    , style = R10.FormComponents.style.filled
    , palette = Just <| R10.Form.themeToPalette theme_
    }"""
      }

    --
    --
    --
    , { name = "Form - Password - Outlined"
      , componentAsElmCode =
            \{ formState, msgMapper, widthMode } ->
                column [ widthMode ] <|
                    R10.Form.viewWithTheme
                        { conf = v11
                        , state = formState
                        }
                        msgMapper
                        theme_
      , componentAsStringCode = """                    R10.Form.viewWithTheme
    { conf = v11
    , state = formState
    }
    msgMapper
    theme_"""
      }

    --
    --
    --
    , { name = "Form - Password - Filled"
      , componentAsElmCode =
            \{ formState, msgMapper, widthMode } ->
                column [ widthMode ] <|
                    R10.Form.viewWithOptions
                        { conf = v11
                        , state = formState
                        }
                        msgMapper
                        { maker = Nothing
                        , translator = Nothing
                        , style = R10.FormComponents.style.filled
                        , palette = Just <| R10.Form.themeToPalette theme_
                        }
      , componentAsStringCode = """                    R10.Form.viewWithOptions
    { conf = v11
    , state = formState
    }
    msgMapper
    { maker = Nothing
    , translator = Nothing
    , style = R10.FormComponents.style.filled
    , palette = Just <| R10.Form.themeToPalette theme_
    }"""
      }
    ]


v01 : R10.Form.Conf
v01 =
    [ R10.Form.entity.field
        { id = "userId"
        , idDom = Nothing
        , type_ = R10.Form.fieldType.text R10.Form.text.username
        , label = "Label"
        , helperText = Nothing
        , requiredLabel = Just "Required"
        , validationSpecs =
            Just
                { showPassedValidationMessages = False
                , hidePassedValidationStyle = True
                , validationIcon = R10.Form.validationIcon.noIcon
                , validation =
                    [ R10.Form.validation.required
                    , R10.Form.validation.minLength 6
                    , R10.Form.validation.maxLength 128
                    , R10.Form.validation.withMsg { ok = "INVALID_FORMAT_INVALID_CHARACTERS", err = "INVALID_FORMAT_INVALID_CHARACTERS" }
                        (R10.Form.validation.regex "^((?!(/|\\\\))[\\x21-\\x7F])+$")
                    ]
                }
        }
    ]


v11 : R10.Form.Conf
v11 =
    [ R10.Form.entity.field
        { id = "password"
        , idDom = Nothing
        , type_ = R10.Form.fieldType.text R10.Form.text.passwordCurrent
        , label = "Label"
        , helperText = Nothing
        , requiredLabel = Just "Required"
        , validationSpecs =
            Just
                { showPassedValidationMessages = False
                , hidePassedValidationStyle = True
                , validationIcon = R10.Form.validationIcon.noIcon
                , validation = [ R10.Form.validation.required ]
                }
        }
    ]
