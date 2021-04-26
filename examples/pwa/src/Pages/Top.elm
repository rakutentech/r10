module Pages.Top exposing
    ( maxWidth
    , view
    )

import Color
import Element exposing (..)
import Element.Font as Font
import Html.Attributes
import Markdown
import R10.Card
import R10.I18n
import R10.Language
import R10.Svg.Icons
import R10.Svg.IconsExtra
import R10.Svg.Logos
import R10.Svg.LogosExtra
import R10.Theme


maxWidth : Attribute msg
maxWidth =
    width (fill |> maximum 1000)


responsive : number -> a -> a -> a
responsive x mobile desktop =
    if x < 600 then
        mobile

    else
        desktop


view : R10.Theme.Theme -> R10.Language.Language -> { x : Int, y : Int } -> Attribute msg -> List (Element msg) -> (String -> msg) -> Element msg
view theme language windowSize heroBackgroundColor content _ =
    column [ width fill ] <|
        [ column
            [ width fill
            , paddingXY 0 80
            , spacing 60
            , heroBackgroundColor
            , htmlAttribute <| Html.Attributes.style "transition" "background-color 1.2s"
            ]
            [ row
                [ spacing <| responsive windowSize.x 20 40, centerX, centerY, moveDown 40 ]
                [ R10.Svg.LogosExtra.elm_monochrome []
                    (rgb 1 1 1)
                    (responsive windowSize.x (155 // 2) 155)
                , R10.Svg.Icons.x [ moveRight (responsive windowSize.x 10 15) ] (rgb 1 1 1) (responsive windowSize.x (100 // 2) 100)
                , R10.Svg.Logos.r [ moveDown (responsive windowSize.x 9 19) ] (rgb 1 1 1) (responsive windowSize.x (200 // 2) 200)
                ]
            , viewMessage language
            ]
        , el
            [ padding 40
            , centerX
            ]
          <|
            column
                (R10.Card.normal theme
                    ++ [ centerX
                       , paddingXY 20 40
                       , maxWidth
                       , spacing 40
                       ]
                )
                [ paragraph [] [ html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] readme ]

                -- , paragraph [] [ html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] "# Content" ]
                -- , paragraph [ paddingEach { top = 0, right = 20, bottom = 40, left = 50 } ] content
                ]
        ]


viewMessage : R10.Language.Language -> Element msg
viewMessage language =
    column
        [ spacing 0
        , centerX
        , paddingXY 20 0
        , htmlAttribute <| Html.Attributes.style "word-spacing" "5px"
        , htmlAttribute <| Html.Attributes.style "letter-spacing" "1px"
        , Font.color <| rgb 1 1 1
        ]
        [ paragraph
            [ Font.center
            , width (fill |> maximum 500)
            , spacing 10
            ]
            [ html <| Markdown.toHtml [ Html.Attributes.class "markdown whiteLinks" ] (R10.I18n.t language intro) ]
        , R10.Svg.IconsExtra.keyboardArrowDown [ centerX, moveDown 30, alpha 0.2 ] (rgb 1 1 1) 100
        ]


intro : R10.Language.Translations
intro =
    { key = "title"
    , en_us = "[**R10**](https://package.elm-lang.org/packages/rakutentech/r10/latest/) is a library of interactive building blocks written in [**Elm**](https://elm-lang.org/) and [**elm-ui**](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [**Rakuten**](https://global.rakuten.com/) for creating user interfaces."
    , ja_jp = "[R10](https://package.elm-lang.org/packages/rakutentech/r10/latest/)は、[楽天](https://global.rakuten.com/)でユーザーインターフェイスを作成するために使用する[Elm](https://elm-lang.org/)および[elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/)で記述されたインタラクティブなビルディングブロックのライブラリです。"
    , zh_tw = "[**R10**](https://package.elm-lang.org/packages/rakutentech/r10/latest/) is a library of interactive building blocks written in [**Elm**](https://elm-lang.org/) and [**elm-ui**](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [**Rakuten**](https://global.rakuten.com/) for creating user interfaces."
    , es_es = "[**R10**](https://package.elm-lang.org/packages/rakutentech/r10/latest/) is a library of interactive building blocks written in [**Elm**](https://elm-lang.org/) and [**elm-ui**](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [**Rakuten**](https://global.rakuten.com/) for creating user interfaces."
    , fr_fr = "[**R10**](https://package.elm-lang.org/packages/rakutentech/r10/latest/) is a library of interactive building blocks written in [**Elm**](https://elm-lang.org/) and [**elm-ui**](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [**Rakuten**](https://global.rakuten.com/) for creating user interfaces."
    , de_de = "[**R10**](https://package.elm-lang.org/packages/rakutentech/r10/latest/) is a library of interactive building blocks written in [**Elm**](https://elm-lang.org/) and [**elm-ui**](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [**Rakuten**](https://global.rakuten.com/) for creating user interfaces."
    }


readme : String
readme =
    --
    -- This is copied and pasted from /README.md
    --
    """**Disclaimer**: This library is actively used in our live projects and the code and the documentation can be rough in most places because, you know, deadlines! It is also tailored for our use so it is probably useful as source of information rather than as a real dependency to add in your projects.

### Links

* [R10 demo with documentation and examples](https://r10.netlify.app/)
* [R10 in the Elm's package website](https://package.elm-lang.org/packages/rakutentech/r10/latest/)
* [R10 in Github](https://github.com/rakutentech/r10)
* [Ellie: R10 Simple View](https://ellie-app.com/c5SL2qqLZP2a1)
* [Ellie: R10 Simple Form](https://ellie-app.com/c5SKjKvwnNRa1)
* [Ellie: R10 Credit Card](https://ellie-app.com/c5SH5HxBXPHa1)

# How to use the R10 library

If you already have an existing Elm project, install the library with

```bash
elm install rakutentech/r10
```

See [this Ellie](https://ellie-app.com/c5SL2qqLZP2a1) or scroll down this page to see an usage code sample.


               
# How to bootstrap a new project

You can find a fully functional project in the folder [`examples/pwa`](https://github.com/rakutentech/r10/tree/master/examples/pwa). You can use it as a base for a new project simply copying it.

From the root folder of the example, run

```bash
npm install
npm start
```

Then you can preview the website at http://localhost:8000.

Changing `src/Main.elm` will automatically recompile the application and refresh the browser.

To build the files optimized for the release in production, run:

```bash
npm run build
```

You can then find the files in `elm-stuff/elm-starter-files/build`.


## Website characteristics

The bootstrapped website showcases has these characteristics:

* Single Page Application (**SPA**)
* Progressive Web Application (**PWA**)
* **Static SSR** (pre-render during the build)
* Works **off-line** and **without Javascript**
* **Installable** on desktop and mobile
* Friendly to search engines (**SEO**)
* Supports **custom previews** so it looks good when you share links
* **Best practices**, **Accessibility**, etc. (High scores with Lighthouse)
* Includes **R10 building blocks** such as logos, icons, buttons, forms, etc. with coding playgrounds.
* Supports **multi language** websites
* Standard **header and footer**

To know more, read the [`elm-starter` documentation](https://github.com/lucamug/elm-starter) and the [`r10` documentation](https://package.elm-lang.org/packages/rakutentech/r10/latest/).
    
Note: If you copied the file in a new folder you need to modify the `elm.json` file:

1. Remove `../../src` from the list of `source-directories`
2. Run `elm install rakutentech/r10` that will add this library as dependency



# Other languages or frameworks

If you are looking for Rakuten UI components written in other languages or frameworks, have a look at the [ReX Github repository](https://github.com/rakuten-rex) and the [ReX Frontend Components Library](https://zeroheight.com/390c074f3/p/080991-).



# Thanks

Thanks to Evan Czaplicki, Matthew Griffith, Richard Feldman, the folks at NoRedInk, Ryan Haskell-Glatz, Ilias Van Peer, Aaron VonderHaar, Abadi Kurniawaan, Dillon Kearns, Jeroen Engels, Keith Lazuka, Luke Westby, Alex Korban, Thibaut Assus, Brian Hicks and many more from the Elm community that directly or indirectly supported us in this journey.



# Examples

These are real-life fully working code samples that render these views:

![Examples](https://r10.netlify.app/images/examples-600.png)

The primary color and the light/dark mode can be changed through the `theme` definitions. For example:

```elm
theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.primary.blueSky
    }

theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.primary.green
    }

theme =
    { mode = R10.Mode.Dark
    , primaryColor = R10.Color.primary.blueSky
    }
```

This is the source code for the example with two buttons.

You can also find it at [github.com](https://github.com/rakutentech/r10/tree/master/examples/simpleView/src/Main.elm) or in  [this Ellie](https://ellie-app.com/c5SL2qqLZP2a1).

```elm
module Main exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html
import R10.Button
import R10.Card
import R10.Color
import R10.Color.AttrsBackground
import R10.Color.Svg
import R10.FontSize
import R10.Libu
import R10.Mode
import R10.Paragraph
import R10.Svg.Icons
import R10.Svg.Logos
import R10.Svg.LogosExtra
import R10.Theme


theme : R10.Theme.Theme
theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.primary.blueSky
    }


main : Html.Html msg
main =
    layout [ R10.Color.AttrsBackground.underModal theme, padding 20, R10.FontSize.normal ] <|
        column
            (R10.Card.high theme
                ++ [ centerX
                   , centerY
                   , width (fill |> maximum 360)
                   , height shrink
                   , spacing 30
                   ]
            )
            [ R10.Svg.LogosExtra.r10 [ centerX ] (R10.Color.Svg.logo theme) 32
            , R10.Paragraph.normalMarkdown [ Font.center ] theme "This is an example of a view made with [Elm](https://elm-lang.org/), [elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) and [R10](https://package.elm-lang.org/packages/rakutentech/r10/latest/) ([Source code](https://github.com/rakutentech/r10/blob/master/examples/simpleView/src/Main.elm))."
            , el [ Font.size 60, centerX, padding 10 ] <| text "🎉"
            , R10.Button.primary []
                { label =
                    row [ spacing 15, centerX ]
                        [ R10.Paragraph.normal [] [ text "Primary Buttons" ]
                        , R10.Svg.Icons.cart_f [] (R10.Color.Svg.fontButtonPrimary theme) 18
                        ]
                , libu = R10.Libu.Li "https://r10.netlify.app"
                , theme = theme
                }
            , R10.Button.secondary []
                { label = R10.Paragraph.normal [] [ text "Secondary Buttons" ]
                , libu = R10.Libu.Li "https://r10.netlify.app"
                , theme = theme
                }
            ]
```

This is the code sample for the view with the form ([Source code](https://github.com/rakutentech/r10/blob/master/examples/simpleForm/src/Main.elm)).

```elm
module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Font as Font
import Html
import R10.Button
import R10.Card
import R10.Color
import R10.Color.AttrsBackground
import R10.Color.Svg
import R10.FontSize
import R10.Form
import R10.Language
import R10.Libu
import R10.Mode
import R10.Paragraph
import R10.Svg.Logos
import R10.Svg.LogosExtra
import R10.Theme


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { form : R10.Form.Form }


type Msg
    = MsgForm R10.Form.Msg


init : Model
init =
    { form =
        { conf =
            [ R10.Form.entity.field
                { id = "email"
                , idDom = Nothing
                , type_ = R10.Form.fieldType.text R10.Form.text.email
                , label = "Email"
                , helperText = Just "Helper text for Email"
                , requiredLabel = Just "(required)"
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = False
                        , hidePassedValidationStyle = False
                        , validationIcon = R10.Form.validationIcon.noIcon
                        , validation =
                            [ R10.Form.commonValidation.email
                            , R10.Form.validation.minLength 5
                            , R10.Form.validation.maxLength 50
                            , R10.Form.validation.required
                            ]
                        }
                }
            , R10.Form.entity.field
                { id = "password"
                , idDom = Nothing
                , type_ = R10.Form.fieldType.text R10.Form.text.passwordNew
                , label = "Password"
                , helperText = Just "Helper text for Password"
                , requiredLabel = Just "(required)"
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = True
                        , hidePassedValidationStyle = False
                        , validationIcon = R10.Form.validationIcon.noIcon
                        , validation =
                            [ R10.Form.commonValidation.password
                            , R10.Form.validation.minLength 8
                            , R10.Form.validation.required
                            ]
                        }
                }
            , R10.Form.entity.field
                { id = "password_repeat"
                , idDom = Nothing
                , type_ = R10.Form.fieldType.text R10.Form.text.passwordNew
                , label = "Repeat Password"
                , helperText = Just "Helper text for Repeat  Password"
                , requiredLabel = Just "(required)"
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = True
                        , hidePassedValidationStyle = False
                        , validationIcon = R10.Form.validationIcon.noIcon
                        , validation =
                            [ R10.Form.validation.withMsg
                                { ok = "Passwords are the same"
                                , err = "Passwords are not the same"
                                }
                              <|
                                R10.Form.validation.dependant "password" (R10.Form.validation.equal "password_repeat")
                            ]
                        }
                }
            ]
        , state = R10.Form.initState
        }
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        MsgForm msgForm ->
            let
                form : R10.Form.Form
                form =
                    model.form

                newForm : R10.Form.Form
                newForm =
                    { form
                        | state =
                            form.state
                                |> R10.Form.update msgForm
                                |> Tuple.first
                    }
            in
            { model | form = newForm }


theme : R10.Theme.Theme
theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.primary.blueSky
    }


view : Model -> Html.Html Msg
view model =
    layoutWith
        { options =
            [ focusStyle
                { borderColor = Nothing
                , backgroundColor = Nothing
                , shadow = Nothing
                }
            ]
        }
        [ R10.Color.AttrsBackground.underModal theme, padding 20, R10.FontSize.normal ]
        (column
            (R10.Card.high theme
                ++ [ centerX
                   , centerY
                   , width (fill |> maximum 360)
                   , height shrink
                   , spacing 30
                   ]
            )
            [ R10.Svg.LogosExtra.r10 [ centerX ] (R10.Color.Svg.logo theme) 32
            , R10.Paragraph.normalMarkdown [ Font.center ] theme "This is an example of a form made with [Elm](https://elm-lang.org/), [elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) and [R10](https://package.elm-lang.org/packages/rakutentech/r10/latest/) ([Source code](https://github.com/rakutentech/r10/blob/master/examples/simpleForm/src/Main.elm))."
            , column [ spacing 20 ] <| R10.Form.view model.form MsgForm
            , Element.map MsgForm <|
                R10.Button.primary []
                    { label = text "Sign In"
                    , libu = R10.Libu.Bu <| Just <| R10.Form.msg.submit model.form.conf
                    , theme = theme
                    }
            ]
        )
```"""
