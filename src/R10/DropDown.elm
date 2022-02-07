module R10.DropDown exposing (Option, extraCss, view, viewBorderLess)

{-| Craate a Dropdown using HTML `select`

@docs Option, extraCss, view, viewBorderLess

-}

import Element.WithContext exposing (..)
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import R10.Color.Utils
import R10.Context exposing (..)
import R10.Transition


{-| -}
type alias Option =
    { value : String
    , text : String
    }


type Type
    = BorderLess


renderHtmlOption : String -> Option -> Html.Html msg
renderHtmlOption selected { value, text } =
    Html.option
        [ Html.Attributes.value value
        , Html.Attributes.selected (value == selected)
        ]
        [ Html.text text ]


commonStyle : Float -> Int -> Color -> Color -> List (Html.Attribute msg)
commonStyle ratio fontSize colorFont colorBackground =
    [ Html.Attributes.style "font-size" (String.fromInt fontSize ++ "px")
    , Html.Attributes.style "padding" "8px 28px 8px 30px"
    , Html.Attributes.style "color" (R10.Color.Utils.toCssRgba colorFont)
    , Html.Attributes.style "background-color" (R10.Color.Utils.toCssRgba colorBackground)
    , Html.Attributes.style "-webkit-appearance" "none"
    , Html.Attributes.style "-moz-appearance" "none"
    , Html.Attributes.style "border-radius" "5px"
    , Html.Attributes.style "cursor" "pointer"
    , Html.Attributes.style "outline" "none"
    , Html.Attributes.class "drop-down"
    , Html.Attributes.style "transition" (R10.Transition.parseCharacteristics ratio "color .2s ease-out, background-color .2s ease-out")
    ]


getDropDownStyle : Float -> Int -> Color -> Color -> Type -> List (Html.Attribute msg)
getDropDownStyle ratio fontSize colorFont colorBackground dropDownType =
    case dropDownType of
        BorderLess ->
            -- Set margin left for alignment by compensating the spacing gap of padding left
            commonStyle ratio fontSize colorFont colorBackground
                ++ [ Html.Attributes.style "border" "none"
                   , Html.Attributes.style "margin-left" "-8px"
                   ]


{-| The dropdown.
-}
view :
    List (Attribute (R10.Context.ContextInternal z) msg)
    ->
        { a
            | colorBackground : Color
            , colorFont : Color
            , currentValue : String
            , inputHandler : String -> msg
            , optionList : List Option
            , fontSize : Int
        }
    -> Type
    -> Element (R10.Context.ContextInternal z) msg
view attrs args dropDownType =
    withContext <|
        \c ->
            el
                attrs
                (html <|
                    Html.select
                        ([ Html.Events.on "change" (Json.Decode.map args.inputHandler Html.Events.targetValue)
                         , Html.Attributes.value args.currentValue
                         ]
                            ++ getDropDownStyle c.contextR10.debugger_transitionSpeed args.fontSize args.colorFont args.colorBackground dropDownType
                        )
                        (List.map (renderHtmlOption args.currentValue) args.optionList)
                )



-- Public interface
-- Facade based on `view` to construct different appearance of drop down components.


{-| Slightly different version of the dropdown that has no borders.
-}
viewBorderLess :
    List (Attribute (R10.Context.ContextInternal z) msg)
    ->
        { a
            | colorBackground : Color
            , colorFont : Color
            , currentValue : String
            , inputHandler : String -> msg
            , optionList : List Option
            , fontSize : Int
        }
    -> Element (R10.Context.ContextInternal z) msg
viewBorderLess attrs args =
    view attrs args BorderLess



-- This is some extra CSS that you need to add to the page
-- if you use this module. The String argument is the `colorHover`


{-| -}
extraCss : Color -> String
extraCss colorHover =
    -- Remove the triangle button (select arrow) from IE11
    -- https://stackoverflow.com/questions/20163079/remove-select-arrow-on-ie
    """
select::-ms-expand {
    display: none;
}
.drop-down:hover, .drop-down:focus {
    background-color: """ ++ R10.Color.Utils.toCssRgba colorHover ++ """ !important;
}
"""
