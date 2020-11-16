module R10.DropDown exposing (Option, extraCss, view, viewBorderLess)

{-| Craate a Dropdown using HTML `select`

@docs Option, extraCss, view, viewBorderLess

-}

import Color
import Element exposing (..)
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import R10.Color.Utils


{-| -}
type alias Option =
    { value : String
    , text : String
    }


type Type
    = BorderLess


getBorderAttr : Int -> String -> String
getBorderAttr width colorHex =
    String.join " " [ String.fromInt width ++ "px", "solid", colorHex ]


triangle : Color.Color -> Element msg
triangle colorFont =
    el
        (List.map htmlAttribute <|
            [ Html.Attributes.style "width" "0"
            , Html.Attributes.style "height" "0"
            , Html.Attributes.style "border-left" <| getBorderAttr 4 "transparent"
            , Html.Attributes.style "border-right" <| getBorderAttr 4 "transparent"
            , Html.Attributes.style "border-top" <| getBorderAttr 6 (R10.Color.Utils.toHex colorFont)
            , Html.Attributes.style "position" "absolute"
            , Html.Attributes.style "right" "12px"
            ]
        )
        none


renderHtmlOption : Option -> Html.Html msg
renderHtmlOption { value, text } =
    Html.option [ Html.Attributes.value value ] [ Html.text text ]


commonStyle : Color.Color -> Color.Color -> List (Html.Attribute msg)
commonStyle colorFont colorBackground =
    [ Html.Attributes.style "font-size" "12px"
    , Html.Attributes.style "padding" "8px 12px"
    , Html.Attributes.style "padding-right" "2.5em"
    , Html.Attributes.style "color" (R10.Color.Utils.toHex colorFont)
    , Html.Attributes.style "background-color" (R10.Color.Utils.toHex colorBackground)
    , Html.Attributes.style "-webkit-appearance" "none"
    , Html.Attributes.style "-moz-appearance" "none"
    , Html.Attributes.style "border-radius" "5px"
    , Html.Attributes.style "cursor" "pointer"
    , Html.Attributes.style "outline" "none"
    , Html.Attributes.class "drop-down"
    , Html.Attributes.style "transition" "color .2s ease-out, background-color .2s ease-out"
    ]


getDropDownStyle : Color.Color -> Color.Color -> Type -> List (Html.Attribute msg)
getDropDownStyle colorFont colorBackground dropDownType =
    case dropDownType of
        BorderLess ->
            -- Set margin left for alignment by compensating the spacing gap of padding left
            commonStyle colorFont colorBackground
                ++ [ Html.Attributes.style "border" "none"
                   , Html.Attributes.style "margin-left" "-8px"
                   ]


{-| The dropdown.
-}
view :
    List (Attribute msg)
    ->
        { a
            | colorBackground : Color.Color
            , colorFont : Color.Color
            , currentValue : String
            , inputHandler : String -> msg
            , optionList : List Option
        }
    -> Type
    -> Element msg
view attrs args dropDownType =
    row
        attrs
        [ html <|
            Html.select
                ([ Html.Events.on "change" (Json.Decode.map args.inputHandler Html.Events.targetValue)
                 , Html.Attributes.value args.currentValue
                 ]
                    ++ getDropDownStyle args.colorFont args.colorBackground dropDownType
                )
                (List.map renderHtmlOption args.optionList)
        , triangle args.colorFont
        ]



-- Public interface
-- Facade based on `view` to construct different appearance of drop down components.


{-| Slightly different version of the dropdown that has no borders.
-}
viewBorderLess :
    List (Attribute msg)
    ->
        { a
            | colorBackground : Color.Color
            , colorFont : Color.Color
            , currentValue : String
            , inputHandler : String -> msg
            , optionList : List Option
        }
    -> Element msg
viewBorderLess attrs args =
    view attrs args BorderLess


{-| This is some extra CSS that you need to add to the page if you use this module. The String argument is the `colorHover`
-}
extraCss : Color.Color -> String
extraCss colorHover =
    """
.drop-down:hover, .drop-down:focus {
    background-color: """ ++ R10.Color.Utils.toHex colorHover ++ """ !important;
}
"""
