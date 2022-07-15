module R10.LanguageSelector exposing (view)

{-| Dropdown for the language selector

@docs view

-}

import Element.WithContext exposing (..)
import Element.WithContext.Font as Font
import Html.Attributes
import R10.Color.Utils
import R10.Context exposing (..)
import R10.DropDown
import R10.Language
import R10.Svg.Icons


{-| -}
view :
    List (Attribute (R10.Context.ContextInternal z) msg)
    ->
        { changeMsg : Result String R10.Language.Language -> msg
        , colorBackground : Color
        , colorFont : Color
        , currentLanguage : R10.Language.Language
        , supportedLanguages : List R10.Language.Language
        , fontSize : Int
        }
    -> Element (R10.Context.ContextInternal z) msg
view attrs args =
    let
        handleInputChange : String -> msg
        handleInputChange string =
            string
                |> R10.Language.decoder args.supportedLanguages
                |> args.changeMsg

        optionList : List R10.DropDown.Option
        optionList =
            args.supportedLanguages
                |> List.map
                    (\locale ->
                        R10.DropDown.Option
                            (R10.Language.toString locale)
                            (R10.Language.toStringLong R10.Language.Localization locale)
                    )
    in
    el
        (attrs
            ++ [ inFront <|
                    row
                        [ spacing 7
                        , htmlAttribute <| Html.Attributes.style "pointer-events" "none"
                        , htmlAttribute <| Html.Attributes.style "letter-spacing" "0px"
                        , centerY
                        , moveRight 2
                        , Font.size args.fontSize
                        , Font.color args.colorFont
                        ]
                        [ R10.Svg.Icons.world_l [] args.colorFont args.fontSize
                        , el [ Font.color <| rgba 0 0 0 0 ] <| text <| R10.Language.toStringLong R10.Language.Localization args.currentLanguage
                        , triangle args.colorFont
                        ]
               ]
        )
        (R10.DropDown.viewBorderLess []
            { colorBackground = args.colorBackground
            , colorFont = args.colorFont
            , currentValue = R10.Language.toString args.currentLanguage
            , inputHandler = handleInputChange
            , optionList = optionList
            , fontSize = args.fontSize
            }
        )


getBorderAttr : Int -> String -> String
getBorderAttr width colorHex =
    String.join " " [ String.fromInt width ++ "px", "solid", colorHex ]


triangle : Color -> Element (R10.Context.ContextInternal z) msg
triangle colorFont =
    el
        (List.map htmlAttribute <|
            [ Html.Attributes.style "width" "0"
            , Html.Attributes.style "height" "0"
            , Html.Attributes.style "border-left" <| getBorderAttr 4 "transparent"
            , Html.Attributes.style "border-right" <| getBorderAttr 4 "transparent"
            , Html.Attributes.style "border-top" <| getBorderAttr 6 (R10.Color.Utils.toCssRgba colorFont)

            -- , Html.Attributes.style "position" "absolute"
            -- , Html.Attributes.style "right" "12px"
            , Html.Attributes.style "pointer-events" "none"
            ]
        )
        none
