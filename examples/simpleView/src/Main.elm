module Main exposing (main)

import Element.WithContext exposing (..)
import Element.WithContext.Font as Font
import Html
import R10.Button
import R10.Card
import R10.Color
import R10.Color.AttrsBackground
import R10.Color.Svg
import R10.Context
import R10.FontSize
import R10.Libu
import R10.Mode
import R10.Paragraph
import R10.Svg.Icons
import R10.Svg.LogosExtra
import R10.Theme


context : R10.Context.Context
context =
    R10.Context.empty


theme : R10.Theme.Theme
theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.primary.blueSky
    }


main : Html.Html msg
main =
    layoutWith { context | theme = theme }
        { options =
            [ focusStyle
                { borderColor = Nothing
                , backgroundColor = Nothing
                , shadow = Nothing
                }
            ]
        }
        [ R10.Color.AttrsBackground.background, padding 20, R10.FontSize.normal ]
    <|
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
            , R10.Paragraph.normalMarkdown [ Font.center ] "This is an example of a view made with [Elm](https://elm-lang.org/), [elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) and [R10](https://package.elm-lang.org/packages/rakutentech/r10/latest/) ([Source code](https://github.com/rakutentech/r10/blob/master/examples/simpleView/src/Main.elm))."
            , el [ Font.size 60, centerX, padding 10 ] <| text "🎉"
            , R10.Button.primary []
                { label =
                    row [ spacing 15, centerX ]
                        [ R10.Paragraph.normal [] [ text "Primary Buttons" ]
                        , R10.Svg.Icons.cart_f [] (R10.Color.Svg.fontHighEmphasis theme) 18
                        ]
                , libu = R10.Libu.Li "https://r10.netlify.app"
                }
            , R10.Button.secondary []
                { label = R10.Paragraph.normal [] [ text "Secondary Buttons" ]
                , libu = R10.Libu.Li "https://r10.netlify.app"
                }
            ]
