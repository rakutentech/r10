module Pages.UIComponents exposing
    ( Model
    , Msg
    , init
    , title
    , update
    , view
    )

import Color
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
import R10.Color.Utils
import R10.Form
import R10.Form.Conf
import R10.Form.FieldConf
import R10.Form.Helpers
import R10.Form.Msg
import R10.Form.State
import R10.Form.Update
import R10.FormComponents.Style
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
    { formState : R10.Form.State.State }


init : Model
init =
    { formState = R10.Form.State.init }


type Msg
    = FormMsg R10.Form.Msg.Msg
    | DoNothing


update : Msg -> Model -> Model
update msg model =
    case msg of
        DoNothing ->
            model

        FormMsg formMsg ->
            let
                ( newFormState, _ ) =
                    R10.Form.Update.update formMsg model.formState
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


formConf : R10.Form.Conf.Conf
formConf =
    -- Same as WidgetLogin.Shared.userIdInputField
    [ R10.Form.Conf.EntityField
        { id = "mode"
        , idDom = Nothing
        , type_ = R10.Form.FieldConf.TypeBinary R10.Form.FieldConf.BinarySwitch
        , label = "Light ⇔ Dark"
        , helperText = Just "Mode"
        , requiredLabel = Nothing
        , validationSpecs = Nothing
        }
    , R10.Form.Conf.EntityField
        { id = "primaryColor"
        , idDom = Nothing
        , type_ = R10.Form.FieldConf.TypeBinary R10.Form.FieldConf.BinarySwitch
        , label = "Pink ⇔ Blue"
        , helperText = Just "Primary Color"
        , requiredLabel = Nothing
        , validationSpecs = Nothing
        }
    , R10.Form.Conf.EntityField
        { id = "explain"
        , idDom = Nothing
        , type_ = R10.Form.FieldConf.TypeBinary R10.Form.FieldConf.BinarySwitch
        , label = "OFF ⇔ ON"
        , helperText = Just "Explain"
        , requiredLabel = Nothing
        , validationSpecs = Nothing
        }
    , R10.Form.Conf.EntityField
        { id = "width"
        , idDom = Nothing
        , type_ = R10.Form.FieldConf.TypeBinary R10.Form.FieldConf.BinarySwitch
        , label = "Fill ⇔ Shrink"
        , helperText = Just "Width"
        , requiredLabel = Nothing
        , validationSpecs = Nothing
        }
    ]


formView : R10.Form.State.State -> (R10.Form.Msg.Msg -> msg) -> List (Element msg)
formView formState msgMapper =
    R10.Form.view
        { conf = formConf
        , state = formState
        }
        msgMapper


subTitleAttrs : List (Attr () msg)
subTitleAttrs =
    [ Font.size 20, Font.bold, paddingXY 0 20 ]


paletteBase : R10.Theme.Theme -> Element msg
paletteBase theme =
    paletteAdv2 theme R10.Color.listBase


palettePrimary : R10.Theme.Theme -> Element msg
palettePrimary theme =
    paletteAdv2 theme R10.Color.listPrimary


paletteDerived : R10.Theme.Theme -> Element msg
paletteDerived theme =
    paletteAdv2 theme R10.Color.listDerived


paletteAdv :
    R10.Theme.Theme
    -> (R10.Theme.Theme -> a -> Color.Color)
    -> (a -> String)
    -> List a
    -> Element msg
paletteAdv theme toColor toString list =
    column [ centerX, scrollbars ]
        [ el subTitleAttrs <| text <| R10.Mode.toString theme.mode
        , el [ width fill, height <| px 50, Background.color <| rgb 0 0 0 ] none
        , row [] <|
            List.map
                (\paletteColor ->
                    let
                        elementColor : Element.Color
                        elementColor =
                            R10.Color.Utils.colorToElementColor color

                        color : Color.Color
                        color =
                            toColor theme paletteColor

                        hex : String
                        hex =
                            color
                                |> Color.Convert.colorToHexWithAlpha

                        name : String
                        name =
                            toString paletteColor
                    in
                    el
                        [ padding 10
                        , Background.color elementColor
                        , width <| px 80
                        , scrollbarX
                        ]
                    <|
                        column [ Font.size 13, spacing 4 ]
                            [ el [ Font.color <| rgb 1 1 1, Font.family [ Font.monospace ] ] <| text hex
                            , el [ Font.color <| rgb 1 1 1 ] <| text name
                            , el [ Font.color <| rgb 0 0 0, Font.family [ Font.monospace ] ] <| text hex
                            , el [ Font.color <| rgb 0 0 0 ] <| text name
                            ]
                )
                list
        ]


paletteAdv2 :
    R10.Theme.Theme
    -> (R10.Theme.Theme -> List { a | color : Color.Color, name : String })
    -> Element msg
paletteAdv2 theme list =
    column [ centerX, scrollbars ]
        [ el subTitleAttrs <| text <| R10.Mode.toString theme.mode
        , el [ width fill, height <| px 50, Background.color <| rgb 0 0 0 ] none
        , row [] <|
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
                        , width <| px 80
                        , scrollbarX
                        ]
                    <|
                        column [ Font.size 13, spacing 4 ]
                            [ el [ Font.color <| rgb 1 1 1, Font.family [ Font.monospace ] ] <| text hex
                            , el [ Font.color <| rgb 1 1 1 ] <| text name
                            , el [ Font.color <| rgb 0 0 0, Font.family [ Font.monospace ] ] <| text hex
                            , el [ Font.color <| rgb 0 0 0 ] <| text name
                            ]
                )
                (list theme)
        ]


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
    let
        backgroundColor : Attr decorative msg
        backgroundColor =
            if R10.Mode.isLight data.theme.mode then
                Background.color <| rgb 0.95 0.95 0.9

            else
                Background.color <| rgb 0.25 0.25 0.15
    in
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
            [ el codeAttrs <| html <| Html.pre [] [ Html.text component.componentAsStringCode ]
            , el
                (exampleAttrs
                    ++ [ backgroundColor
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


view : Model -> List (Element Msg)
view model =
    let
        mode : R10.Mode.Mode
        mode =
            case R10.Form.Helpers.getFieldValueAsBool "mode" model.formState of
                Just True ->
                    R10.Mode.fromString "dark"

                _ ->
                    R10.Mode.fromString "light"

        primaryColor : R10.Color.Primary
        primaryColor =
            case R10.Form.Helpers.getFieldValueAsBool "primaryColor" model.formState of
                Just True ->
                    R10.Color.primary.blue

                _ ->
                    R10.Color.primary.pink

        theme : R10.Theme.Theme
        theme =
            R10.Theme.fromFlags
                { primaryColor = primaryColor
                , mode = mode
                }

        widthMode : Attribute msg
        widthMode =
            case R10.Form.Helpers.getFieldValueAsBool "width" model.formState of
                Just True ->
                    width shrink

                _ ->
                    width fill

        explainComponent : Element msg -> Element msg
        explainComponent =
            case R10.Form.Helpers.getFieldValueAsBool "explain" model.formState of
                Just True ->
                    el
                        [ Border.width 4
                        , Border.dashed
                        , Border.color <| rgb 0 0.5 0.8
                        , Background.color <| rgba 0 0.5 1 0.3
                        , htmlAttribute <| Html.Attributes.style "transition" "background-color 0.4s"
                        , widthMode
                        , centerX
                        ]

                _ ->
                    el
                        [ htmlAttribute <| Html.Attributes.style "transition" "background-color 0.4s"
                        , widthMode
                        , centerX
                        ]
    in
    []
        ++ [ el [] <| html <| Html.node "style" [] [ Html.text """.pre div {line-height: 18px}""" ] ]
        ++ [ section "Buttons Hierarchy"
                (el [ width <| px 300 ] <|
                    image
                        [ Border.width 1
                        , Border.color <| rgba 0 0 0 0.2
                        , Border.rounded 5
                        , padding 5
                        , width fill
                        ]
                        { src = "/images/buttons.png", description = "Buttons" }
                )
           ]
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
            --
            -- type alias Data msg =
            --     { doSomething : msg
            --     , formState : R10.Form.State.State
            --     , msgMapper : R10.Form.Msg.Msg -> msg
            --     , theme : R10.Theme.Theme
            --     , widthMode : Attribute msg
            --     }
            --
            components
        ++ [ section "Colors" (paragraph [] [ html <| Markdown.toHtml [] notesAboutColors ])
           , section "Palette Base"
                (el [] <|
                    paletteBase
                        { mode = mode
                        , primaryColor = primaryColor
                        }
                )
           , section "Palette Primary"
                (el [] <|
                    palettePrimary
                        { mode = mode
                        , primaryColor = primaryColor
                        }
                )
           , section "Palette Derived"
                (el [] <|
                    paletteDerived
                        { mode = mode
                        , primaryColor = primaryColor
                        }
                )
           , section "Notes" (paragraph [] [ html <| Markdown.toHtml [] notes ])
           , section "Links" (paragraph [] [ html <| Markdown.toHtml [] links ])
           , el
                [ alignLeft
                , Font.size 16
                , htmlAttribute <| Html.Attributes.style "position" "fixed"
                , htmlAttribute <| Html.Attributes.style "bottom" "0"
                , htmlAttribute <| Html.Attributes.style "left" "0"
                , padding 30
                , width fill
                , Background.color <| rgba 1 1 1 1
                , Border.color <| rgba 0 0 0 0.05
                , Border.widthEach { bottom = 0, left = 0, right = 0, top = 1 }
                , Border.shadow { offset = ( 0, 0 ), size = 2, blur = 10, color = rgba 0 0 0 0.05 }
                ]
             <|
                row
                    [ centerX ]
                <|
                    formView model.formState FormMsg
           ]


notes : String
notes =
    """`UI.Theme.Theme`contains two values:

   * "primaryColor" (pink, red, etc.)
   * "mode" (light or dark)

`UI.Theme.Theme` is generated from flags using `UI.Theme.fromFlags`

# About Dark mode

* https://material.io/design/color/dark-theme.html
* http://rex.public.rakuten-it.com/design/mobile/mobile-apps/dark-mode/
* https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
* https://material.io/design/color/the-color-system.html#color-usage-and-palettes
* https://material.io/resources/color/#!/?view.left=0&view.right=0&primary.color=6002ee"""


notesAboutColors : String
notesAboutColors =
    """Material Design Colors

![alt text](/images/material-colors.png "Material Colors")

Overview Colors

![alt text](/images/colors-overview1.png)

System Colors

![alt text](/images/system-color.png)"""



-- ![alt text](/images/palette.png)"""


links : String
links =
    """
* Material: https://material.io/components
* Tailwind:  https://tailwindui.com/components
* Semantic: https://semantic-ui.com/elements/button.html
* Ant: https://ant.design/components/button/
* Onsen: https://onsen.io/theme-roller/
* Apple: https://developer.apple.com/design/human-interface-guidelines/"""



--
--
--


type alias Data msg =
    { doSomething : msg
    , formState : R10.Form.State.State
    , msgMapper : R10.Form.Msg.Msg -> msg
    , theme : R10.Theme.Theme
    , widthMode : Attribute msg
    }


type alias Component msg =
    { componentAsElmCode : Data msg -> Element msg
    , componentAsStringCode : String
    , name : String
    }


components : List (Component msg)
components =
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
            """UI.Button.primary []
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
            """UI.Button.primary []
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
      , componentAsStringCode = """UI.Button.primary []
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
      , componentAsStringCode = """UI.Button.primary R10.Button.withLimitedWidth
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
      , componentAsStringCode = """UI.Button.secondary []
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
      , componentAsStringCode = """UI.Button.tertiary []
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
            """UI.Button.tertiary []
    { label =
        paragraph []
            [ text "Text with "
            , el R10.Button.attrsLink <| text <| "link"
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
                    R10.Form.view
                        { conf = v01
                        , state = formState
                        }
                        msgMapper
      , componentAsStringCode = """Form.view
    { conf = Flow.Login.FormConfs.v01 Utils.I18n.Language.EN_US
    , state = formState
    }"""
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
                        , style = R10.FormComponents.Style.Filled
                        , palette = Nothing
                        }
      , componentAsStringCode = """Form.viewWith
    { conf = Flow.Login.FormConfs.v01 Utils.I18n.Language.EN_US
    , state = formState
    }
    msgMapper
    { maker = Nothing
    , translator = Nothing
    , style = R10.FormComponents.Style.Filled
    , palette = Nothing
    }"""
      }

    --
    --
    --
    , { name = "Form - Password - Outlined"
      , componentAsElmCode =
            \{ formState, msgMapper, widthMode } ->
                column [ widthMode ] <|
                    R10.Form.view
                        { conf = v11
                        , state = formState
                        }
                        msgMapper
      , componentAsStringCode = """Form.view
    { conf = Flow.Login.FormConfs.v11 Utils.I18n.Language.EN_US
    , state = formState
    }
    msgMapper"""
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
                        , style = R10.FormComponents.Style.Filled
                        , palette = Nothing
                        }
      , componentAsStringCode = """Form.viewWith
    { conf = Flow.Login.FormConfs.v11 Utils.I18n.Language.EN_US
    , state = model.formState
    }
    msgMapper
    { maker = Nothing
    , translator = Nothing
    , style = R10.FormComponents.Style.Filled
    , palette = Nothing
    }"""
      }
    ]


v01 : R10.Form.Conf.Conf
v01 =
    [ R10.Form.Conf.EntityField
        { id = "userId"
        , idDom = Nothing
        , type_ = R10.Form.FieldConf.TypeText R10.Form.FieldConf.TextUsername
        , label = "Label"
        , helperText = Nothing
        , requiredLabel = Just "Required"
        , validationSpecs =
            Just
                { showPassedValidationMessages = False
                , hidePassedValidationStyle = True
                , validationIcon = R10.Form.FieldConf.NoIcon
                , validation =
                    R10.Form.FieldConf.AllOf
                        [ R10.Form.FieldConf.Required
                        , R10.Form.FieldConf.MinLength 6
                        , R10.Form.FieldConf.MaxLength 128
                        , R10.Form.FieldConf.WithMsg { ok = "INVALID_FORMAT_INVALID_CHARACTERS", err = "INVALID_FORMAT_INVALID_CHARACTERS" }
                            (R10.Form.FieldConf.Regex "^((?!(/|\\\\))[\\x21-\\x7F])+$")
                        ]
                }
        }
    ]


v11 : R10.Form.Conf.Conf
v11 =
    [ R10.Form.Conf.EntityField
        { id = "password"
        , idDom = Nothing
        , type_ = R10.Form.FieldConf.TypeText R10.Form.FieldConf.TextPasswordCurrent
        , label = "Label"
        , helperText = Nothing
        , requiredLabel = Just "Required"
        , validationSpecs =
            Just
                { showPassedValidationMessages = False
                , hidePassedValidationStyle = True
                , validationIcon = R10.Form.FieldConf.NoIcon
                , validation = R10.Form.FieldConf.Required
                }
        }
    ]
