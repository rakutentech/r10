# R10

![R10 logo](https://r10.netlify.app/images/r10.png)

**R10** is a library of interactive building blocks written in [Elm](https://elm-lang.org/) and [elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [Rakuten](https://global.rakuten.com/) for creating user interfaces.

### Links

* [R10 demo with documentation and examples](https://r10.netlify.app/)
* [R10 in the Elm's package website](https://package.elm-lang.org/packages/rakutentech/r10/latest/)
* [R10 in Github](https://github.com/rakutentech/r10)



# How to use the R10 library

If you already have an existing Elm project, install the library with

```bash
elm install rakutentech/r10
```

See [this Ellie](https://ellie-app.com/btv2tGK7tk8a1) or scroll down this page to see a real life example.


               
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

You can also find it at [github.com](https://github.com/rakutentech/r10/tree/master/examples/simple/src/Main.elm) or in  [this Ellie](https://ellie-app.com/btv2tGK7tk8a1).

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
    , primaryColor = R10.Color.Primary.Yellow
    }


main : Html.Html msg
main =
    layout [ R10.Color.Background.underModal theme, padding 20, R10.FontSize.normal ] <|
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
            , R10.Paragraph.normalMarkdown [] theme "Find the source code of this view at [github.com](https://github.com/rakutentech/r10/tree/master/examples/simple/src/Main.elm) or at [ellie-app.com](https://ellie-app.com/btv2tGK7tk8a1)."
            , R10.Button.primary []
                { label =
                    row [ spacing 15, centerX ]
                        [ R10.Paragraph.normal [] [ text "Primary Buttons" ]
                        , el [] <| R10.Svg.Icons.cart_f (R10.Color.CssRgba.fontButtonPrimary theme) 18
                        ]
                , libu = R10.Libu.Li "https://r10.netlify.app"
                , theme = theme
                }
            , R10.Button.secondary []
                { label =
                    row [ spacing 15, centerX ]
                        [ R10.Paragraph.normal [] [ text "Secondary Buttons" ]
                        , el [ moveUp 2 ] <| R10.Svg.Icons.like_f (R10.Color.CssRgba.fontNormal theme) 18
                        ]
                , libu = R10.Libu.Li "https://r10.netlify.app"
                , theme = theme
                }
            ]
```

# Other languages or frameworks

If you are looking for Rakuten UI components written in other languages or frameworks, have a look at the [ReX Github repository](https://github.com/rakuten-rex) and the [ReX Frontend Components Library](https://zeroheight.com/390c074f3/p/080991-).



# Thanks

Thanks to Evan Czaplicki, Matthew Griffith, Richard Feldman, the folks at NoRedInk, Ryan Haskell-Glatz, Ilias Van Peer, Aaron VonderHaar, Abadi Kurniawaan, Dillon Kearns, Jeroen Engels, Keith Lazuka, Luke Westby, Alex Korban, Thibaut Assus, Brian Hicks and many more from the Elm community that directly or indirectly supported us in this journey.
