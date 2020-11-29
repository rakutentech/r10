module Pages.Overview exposing
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
import R10.Card
import R10.Color
import R10.Color.AttrsBackground
import R10.Color.AttrsBorder
import R10.Color.Svg
import R10.Color.Utils
import R10.FontSize
import R10.Form
import R10.FormComponents
import R10.Language
import R10.Libu
import R10.Link
import R10.Mode
import R10.Okaimonopanda
import R10.Paragraph
import R10.Svg.Icons
import R10.Svg.Lists
import R10.Theme


title : R10.Language.Translations
title =
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


type alias Model =
    { formState : R10.Form.State }


init : Model
init =
    { formState = R10.Form.initState }


type Msg
    = MsgForm R10.Form.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        MsgForm msgForm ->
            { model | formState = Tuple.first <| R10.Form.update msgForm model.formState }


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
    R10.Color.Utils.colorToElementColor <| Maybe.withDefault (Color.rgb 0 0 0) <| R10.Color.maximumContrast color [ Color.rgb 1 1 1, Color.rgb 0 0 0 ]


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
                , validation = [ R10.Form.validation.required ]
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
                , validation = [ R10.Form.validation.required ]
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


view : Model -> R10.Theme.Theme -> { x : Int, y : Int } -> { x : Int, y : Int } -> List (Element Msg)
view model theme mouse windowSize =
    --
    -- BUTTONS
    --
    [ titleSection theme "Buttons"
    , el [ width fill ] <| html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """There are 4 levels of buttons, form primary to quaternary:"""
    , column
        (R10.Card.normal theme
            ++ [ centerX
               , centerY
               , width (fill |> maximum 360)
               , height shrink
               , spacing 30
               , R10.Color.AttrsBackground.surface2dp theme
               ]
        )
        [ R10.Button.primary []
            { label =
                row [ spacing 15, centerX ]
                    [ R10.Paragraph.normal [] [ text "Primary button" ]
                    , R10.Svg.Icons.cart_f [] (R10.Color.Svg.fontButtonPrimary theme) 18
                    ]
            , libu = R10.Libu.Li "https://r10.netlify.app"
            , theme = theme
            }
        , R10.Button.secondary []
            { label = R10.Paragraph.normal [] [ text "Secondary button" ]
            , libu = R10.Libu.Li "https://r10.netlify.app"
            , theme = theme
            }
        , R10.Button.tertiary []
            { label =
                R10.Paragraph.normal []
                    [ text "Tertiary "
                    , el (R10.Link.attrs theme) <| text "button"
                    ]
            , libu = R10.Libu.Li "https://r10.netlify.app"
            , theme = theme
            }
        , row [ width fill ]
            [ R10.Button.quaternary [ moveLeft 13 ]
                { label = R10.Paragraph.normal [] [ text "Quaternary button" ]
                , libu = R10.Libu.Li "https://r10.netlify.app"
                , theme = theme
                }
            , R10.Button.quaternary [ alignRight, moveRight 13 ]
                { label = R10.Paragraph.normal [] [ text "Quaternary button" ]
                , libu = R10.Libu.Li "https://r10.netlify.app"
                , theme = theme
                }
            ]
        ]
    , el [ width fill ] <|
        html <|
            Markdown.toHtml [ Html.Attributes.class "markdown" ]
                """
```elm
[ R10.Button.primary []
    { label =
        row [ spacing 15, centerX ]
            [ R10.Paragraph.normal [] [ text "Primary button" ]
            , R10.Svg.Icons.cart_f [] (R10.Color.Svg.fontButtonPrimary theme) 18
            ]
    , libu = R10.Libu.Li "https://r10.netlify.app"
    , theme = theme
    }
, R10.Button.secondary []
    { label = R10.Paragraph.normal [] [ text "Secondary button" ]
    , libu = R10.Libu.Li "https://r10.netlify.app"
    , theme = theme
    }
, R10.Button.tertiary []
    { label =
        R10.Paragraph.normal []
            [ text "Tertiary "
            , el (R10.Link.attrs theme) <| text "button"
            ]
    , libu = R10.Libu.Li "https://r10.netlify.app"
    , theme = theme
    }
, row [ width fill ]
    [ R10.Button.quaternary [ moveLeft 13 ]
        { label = R10.Paragraph.normal [] [ text "Quaternary button" ]
        , libu = R10.Libu.Li "https://r10.netlify.app"
        , theme = theme
        }
    , R10.Button.quaternary [ alignRight, moveRight 13 ]
        { label = R10.Paragraph.normal [] [ text "Quaternary button" ]
        , libu = R10.Libu.Li "https://r10.netlify.app"
        , theme = theme
        }
    ]
]
```
    """

    --
    -- FONT SIZES
    --
    , titleSection theme
        "Font sizes"
    , column
        (R10.Card.normal theme
            ++ [ centerX
               , centerY
               , width (fill |> maximum 360)
               , height shrink
               , spacing 15
               , R10.Color.AttrsBackground.surface2dp theme
               ]
        )
        [ el [ R10.FontSize.xxlarge ] <| text "Font size: XX Large"
        , el [ R10.FontSize.xlarge ] <| text "Font size: X Large"
        , el [ R10.FontSize.large ] <| text "Font size: Large"
        , el [ R10.FontSize.normal ] <| text "Font size: Normal"
        , el [ R10.FontSize.small ] <| text "Font size: Small"
        , el [ R10.FontSize.xsmall ] <| text "Font size: X Small"
        , el [ R10.FontSize.xxsmall ] <| text "Font size: XX Small"
        ]
    , el [ width fill ] <| html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """
```elm
[ el [ R10.FontSize.xxlarge ] <| text "Font size: XX Large"
, el [ R10.FontSize.xlarge ] <| text "Font size: X Large"
, el [ R10.FontSize.large ] <| text "Font size: Large"
, el [ R10.FontSize.normal ] <| text "Font size: Normal"
, el [ R10.FontSize.small ] <| text "Font size: Small"
, el [ R10.FontSize.xsmall ] <| text "Font size: X Small"
, el [ R10.FontSize.xxsmall ] <| text "Font size: XX Small"
]
```"""

    --
    -- FORMS
    --
    , titleSection theme "Forms"
    , el [ width fill ] <| html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """Forms have two different styles: **Outlined** and **Filled**:"""
    , row [ spacing 40, centerX ]
        [ column
            (R10.Card.normal theme
                ++ [ centerX
                   , centerY
                   , width (fill |> maximum 360)
                   , height shrink
                   , spacing 30
                   , R10.Color.AttrsBackground.surface2dp theme
                   ]
            )
          <|
            [ R10.Paragraph.xlarge [ Font.center, paddingXY 0 20 ] [ text "Outlined" ] ]
                ++ R10.Form.viewWithOptions
                    { state = model.formState, conf = formConf }
                    MsgForm
                    { maker = Nothing
                    , translator = Nothing
                    , style = R10.FormComponents.style.outlined
                    , palette = Just <| R10.Form.themeToPalette theme
                    }
        , column
            (R10.Card.normal theme
                ++ [ centerX
                   , centerY
                   , width (fill |> maximum 360)
                   , height shrink
                   , spacing 30
                   , R10.Color.AttrsBackground.surface2dp theme
                   ]
            )
          <|
            [ R10.Paragraph.xlarge [ Font.center, paddingXY 0 20 ] [ text "Filled" ] ]
                ++ R10.Form.viewWithOptions
                    { state = model.formState, conf = formConf }
                    MsgForm
                    { maker = Nothing
                    , translator = Nothing
                    , style = R10.FormComponents.style.filled
                    , palette = Just <| R10.Form.themeToPalette theme
                    }
        ]
    , el [ width fill ] <| html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """Forms are defined by two things: Configuration and State. This is an example of configuration:

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
"""

    --
    -- TRANSLATIONS
    --
    , titleSection theme "Translations"
    , el [ width fill ] <| html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """To translate some text:
    
    R10.I18n.t language R10.Translations.signInHeader

Where `signInHeader` is defined as

    signInHeader : Translations
    signInHeader =
        { key = "signInHeader"
        , en_us = "Sign in to your Rakuten account"
        , zh_tw = "會員登入"
        , ja_jp = "楽天会員 ログイン"
        ...
        }
"""

    --
    -- OKAIMONO PANDA
    --
    , titleSection theme "Okaimono Panda"
    , el [] <|
        html <|
            Html.div [] <|
                R10.Okaimonopanda.view
                    { mouse = mouse
                    , screen = windowSize
                    }
    , el [ width fill ] <| html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """
```
R10.Okaimonopanda.view
    { mouse = mouse
    , screen = windowSize
    }
```
"""

    --
    -- PALETTES
    --
    , titleSection theme "Palettes"
    , titleSubSection theme "Palette Base"
    , twoPalettes theme R10.Color.listBase
    , titleSubSection theme "Palette Primary"
    , twoPalettes theme R10.Color.listPrimary
    , titleSubSection theme "Palette Derived"
    , twoPalettes theme R10.Color.listDerived

    --
    -- LOGOS & ICONS
    --
    , titleSection theme "Logos & Icons"
    , titleSubSection theme "Logos"
    , viewIcons theme R10.Svg.Lists.listLogos 30
    , titleSubSection theme "Logos Extra"
    , viewIcons theme R10.Svg.Lists.listLogosExtra 30
    , titleSubSection theme "Icons"
    , viewIcons theme R10.Svg.Lists.listIcons 30
    , titleSubSection theme "Icons Extra"
    , viewIcons theme R10.Svg.Lists.listIconsExtra 30
    , titleSubSection theme "Others"
    , viewIcons theme R10.Svg.Lists.listOthers 200
    , el [ width fill ] <| html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """
# More about colors

Material Design Colors

![alt text](/images/material-colors.png "Material Colors")

Overview Colors

![alt text](/images/colors-overview1.png)

System Colors

![alt text](/images/system-color.png)

Palette

![alt text](/images/palette.png)

# Theme

UI.Theme.Theme`contains two values:

   * "primaryColor" (pink, red, etc.)
   * "mode" (light or dark)

`UI.Theme.Theme` is generated from flags using `UI.Theme.fromFlags`

# About Dark mode

* https://material.io/design/color/dark-theme.html
* http://rex.public.rakuten-it.com/design/mobile/mobile-apps/dark-mode/
* https://uxplanet.org/8-tips-for-dark-theme-design-8dfc2f8f7ab6
* https://material.io/design/color/the-color-system.html#color-usage-and-palettes
* https://material.io/resources/color/#!/?view.left=0&view.right=0&primary.color=6002ee


# Other Design Frameworks

* Material: https://material.io/components
* Tailwind:  https://tailwindui.com/components
* Semantic: https://semantic-ui.com/elements/button.html
* Ant: https://ant.design/components/button/
* Onsen: https://onsen.io/theme-roller/
* Apple: https://developer.apple.com/design/human-interface-guidelines/
* noredink-ui: https://package.elm-lang.org/packages/NoRedInk/noredink-ui/latest/
    
    
# ReX Links

* ReX on github: https://github.com/rakuten-rex
* ReX on zeroheight: https://zeroheight.com/390c074f3/p/080991-
* ReX icons: https://rakuten-rex.github.io/icons
* ReX text field: https://rakuten-rex.github.io/text-field/
* Rex button: https://rakuten-rex.github.io/button/
* ReX demo booking: https://rakuten-rex.github.io/demo-booking/
* ReX demo registration: https://rakuten-rex.github.io/demo-register/
* ReX demo sign-up: https://rakuten-rex.github.io/demo-sign-up/
    
# Rakuten Branding Tram

* Brand Guideline: https://global.rakuten.com/corp/brand/
* Logos (internal): https://global.rakuten.com/corp/brand/logos_temp_visual/logos/files/subbrand_japan_logos.html

# Elm open source projects in Rakuten

* R10: https://github.com/rakutentech/r10/
* http-trinity: https://github.com/rakutentech/http-trinity
* rakutentech.github.io: https://github.com/rakutentech/rakutentech.github.io
* Elm projects: https://rakutentech.github.io/#/filter/elm

# Others

* https://github.com/NoRedInk/noredink-ui
* https://github.com/rakutentech/http-trinity/commits/master
* https://elm.dmy.fr/packages/NoRedInk/noredink-ui/latest/

    
"""
    ]


viewIcons : R10.Theme.Theme -> (Int -> Color.Color -> List ( Element msg, String )) -> Int -> Element msg
viewIcons theme list size =
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
            (list size (R10.Color.Svg.fontNormal theme))
