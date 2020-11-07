module Pages.Top exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html.Attributes
import Markdown
import R10.Color.Primary
import R10.I18n
import R10.Language
import R10.Mode
import R10.Svg.Icons
import R10.Svg.IconsExtra
import R10.Svg.Logos
import R10.Svg.LogosExtra
import R10.Theme


theme : R10.Theme.Theme
theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.Primary.Blue
    }


linkAttrs : List (Attr () msg)
linkAttrs =
    mouseOverEffect
        ++ [ htmlAttribute <| Html.Attributes.style "text-decoration" "underline" ]


mouseOverEffect : List (Attr () msg)
mouseOverEffect =
    [ mouseOver [ alpha 1, Background.color <| rgba 0 0 0 0.2 ]
    , htmlAttribute <| Html.Attributes.style "transition" "0.3s"
    ]


viewMessage : R10.Language.Language -> Element msg
viewMessage language =
    column
        [ spacing 14
        , centerX
        , paddingXY 20 0
        , htmlAttribute <| Html.Attributes.style "word-spacing" "5px"
        , htmlAttribute <| Html.Attributes.style "letter-spacing" "1px"
        , Font.color <| rgb 1 1 1
        ]
        [ column
            [ Font.center
            , width (fill |> maximum 500)
            , spacing 10
            ]
            [ html <| Markdown.toHtml [ Html.Attributes.class "markdown whiteLinks" ] (R10.I18n.t language intro) ]
        , el [ centerX, moveDown 60, alpha 0.2 ] <| R10.Svg.IconsExtra.keyboardArrowDown "#fff" 100
        ]


view : R10.Language.Language -> Attribute msg -> List (Element msg) -> (String -> msg) -> Element msg
view language heroBackgroundColor content onClick =
    let
        columnAttrs =
            [ width (fill |> maximum 800)
            , padding 20
            , centerX
            ]
    in
    column [ width fill ] <|
        [ column
            [ width fill
            , paddingXY 0 140
            , spacing 70

            -- , R10.Color.Background.backgroundButtonPrimary theme
            -- , Background.color <| R10.Color.Primary.toColor theme R10.Color.Primary.Blue
            -- , Background.color <| rgb 0.5 0.5 1
            , heroBackgroundColor
            ]
            [ row [ spacing 40, centerX, centerY ]
                [ el [] <| R10.Svg.LogosExtra.elm_monocrome "#ffffff" 155
                , el [ moveRight 15 ] <| R10.Svg.Icons.x "#ffffff" 100
                , el [ moveDown 19 ] <| R10.Svg.Logos.r "#ffffff" 200
                ]
            , viewMessage language
            ]
        , column columnAttrs [ html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] readme1 ]
        , column columnAttrs [ html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] "# Content" ]
        , column (columnAttrs ++ [ paddingEach { top = 0, right = 20, bottom = 40, left = 50 } ]) content
        , column columnAttrs [ html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] readme ]
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
    , it_it = "[**R10**](https://package.elm-lang.org/packages/rakutentech/r10/latest/) is a library of interactive building blocks written in [**Elm**](https://elm-lang.org/) and [**elm-ui**](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [**Rakuten**](https://global.rakuten.com/) for creating user interfaces."
    , nl_nl = "[**R10**](https://package.elm-lang.org/packages/rakutentech/r10/latest/) is a library of interactive building blocks written in [**Elm**](https://elm-lang.org/) and [**elm-ui**](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [**Rakuten**](https://global.rakuten.com/) for creating user interfaces."
    , pt_pt = "[**R10**](https://package.elm-lang.org/packages/rakutentech/r10/latest/) is a library of interactive building blocks written in [**Elm**](https://elm-lang.org/) and [**elm-ui**](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [**Rakuten**](https://global.rakuten.com/) for creating user interfaces."
    , nb_no = "[**R10**](https://package.elm-lang.org/packages/rakutentech/r10/latest/) is a library of interactive building blocks written in [**Elm**](https://elm-lang.org/) and [**elm-ui**](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [**Rakuten**](https://global.rakuten.com/) for creating user interfaces."
    , fi_fl = "[**R10**](https://package.elm-lang.org/packages/rakutentech/r10/latest/) is a library of interactive building blocks written in [**Elm**](https://elm-lang.org/) and [**elm-ui**](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [**Rakuten**](https://global.rakuten.com/) for creating user interfaces."
    , da_dk = "[**R10**](https://package.elm-lang.org/packages/rakutentech/r10/latest/) is a library of interactive building blocks written in [**Elm**](https://elm-lang.org/) and [**elm-ui**](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [**Rakuten**](https://global.rakuten.com/) for creating user interfaces."
    , sv_se = "[**R10**](https://package.elm-lang.org/packages/rakutentech/r10/latest/) is a library of interactive building blocks written in [**Elm**](https://elm-lang.org/) and [**elm-ui**](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [**Rakuten**](https://global.rakuten.com/) for creating user interfaces."
    }


readme1 : String
readme1 =
    --
    -- This is copied and pasted from /README.md
    --
    """
### Links

* [R10 demo with documentation and examples](https://r10.netlify.app/)
* [R10 in the Elm's package website](https://package.elm-lang.org/packages/rakutentech/r10/latest/)
* [R10 in Github](https://github.com/rakutentech/r10)



# How to use the R10 library

If you already have an existing Elm project, install the library with

```bash
elm install rakutentech/r10
```

See [this Ellie](https://ellie-app.com/bsZTBJxHFrna1) or scroll down this page to see a real life example.


               
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


### Website characteristics

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

1. Remove `"../../src"` from the list of `"source-directories"`
2. Run `elm install rakutentech/r10` that will add this library as dependency

# Example

This is a real-life fully working example that render a view like these:

![Examples](https://r10.netlify.app/images/examples.png)

The differences among these views are coming from different `theme` definitions. From left to right:

```elm
theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.Primary.CrimsonRed
    }

theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.Primary.Green
    }

theme =
    { mode = R10.Mode.Dark
    , primaryColor = R10.Color.Primary.CrimsonRed
    }
```

This is the source code of this view.

You can also find it at [github.com](https://github.com/rakutentech/r10/tree/master/examples/simple/src/Main.elm) or in  [this Ellie](https://ellie-app.com/bsZTBJxHFrna1).

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
import R10.Color.Background
import R10.Color.CssRgba
import R10.Color.Derived
import R10.Color.Primary
import R10.Libu
import R10.Mode
import R10.Paragraph
import R10.Svg.Icons
import R10.Svg.Logos
import R10.Svg.LogosExtra
import R10.Theme

theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.Primary.CrimsonRed
    }

main =
    layout [ R10.Color.Background.underModal theme, padding 20 ] <|
        column
            (R10.Card.high theme
                ++ [ centerX
                   , centerY
                   , width (fill |> maximum 360)
                   , height shrink
                   , spacing 30
                   ]
            )
            [ R10.Svg.Logos.rakuten [] (R10.Color.Derived.toColor theme R10.Color.Derived.Logo) 32
            , R10.Paragraph.normalMarkdown [] theme "This is an example of view made with **Elm**, **elm-ui** and [R10](https://r10.netlify.app)."
            , el [ Font.size 60, centerX, padding 10 ] <| text "🎉"
            , R10.Paragraph.normalMarkdown [] theme "Find the source code of this view at [github.com](https://github.com/rakutentech/r10/tree/master/examples/simple/src/Main.elm) or at [ellie-app.com](https://ellie-app.com/bsZTBJxHFrna1)."
            , R10.Button.primary []
                { label =
                    row [ spacing 15, centerX ]
                        [ el [] <| R10.Svg.Icons.cart_f (R10.Color.CssRgba.fontButtonPrimary theme) 20
                        , R10.Paragraph.normal [] [ text "Primary Buttons" ]
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

# Other languages or frameworks

If you are looking for Rakuten UI components written in other languages or frameworks, have a look at the [ReX Github repository](https://github.com/rakuten-rex) and the [ReX Frontend Components Library](https://zeroheight.com/390c074f3/p/080991-).



# Thanks

Thanks to Evan Czaplicki, Matthew Griffith, Richard Feldman, the folks at NoRedInk, Ryan Haskell-Glatz, Ilias Van Peer, Aaron VonderHaar, Abadi Kurniawaan, Dillon Kearns, Jeroen Engels, Keith Lazuka, Luke Westby, Alex Korban, Thibaut Assus, Brian Hicks and many more from the Elm community that directly or indirectly supported us in this journey."""


readme : String
readme =
    ""
