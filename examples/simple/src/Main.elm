module Main exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html
import R10.Button
import R10.Card
import R10.Color
import R10.Color.AttrBackground
import R10.Color.CssRgba
import R10.Color.Internal.Primary
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
    , primaryColor = R10.Color.Internal.Primary.Yellow
    }


main : Html.Html msg
main =
    layout [ R10.Color.AttrBackground.underModal theme, padding 20, R10.FontSize.normal ] <|
        column
            (R10.Card.high theme
                ++ [ centerX
                   , centerY
                   , width (fill |> maximum 360)
                   , height shrink
                   , spacing 30
                   ]
            )
            [ R10.Svg.Logos.rakuten [] (R10.Color.logo theme) 32
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
            , row [ width fill ]
                [ R10.Button.quaternary []
                    { label =
                        row [ spacing 15, centerX ]
                            [ R10.Paragraph.normal [] [ text "Help" ]
                            ]
                    , libu = R10.Libu.Li "https://r10.netlify.app"
                    , theme = theme
                    }
                , R10.Button.quaternary [ alignRight ]
                    { label =
                        el [ spacing 15, centerX ] <|
                            R10.Paragraph.normal [] [ text "Terms" ]
                    , libu = R10.Libu.Li "https://r10.netlify.app"
                    , theme = theme
                    }
                ]
            ]
