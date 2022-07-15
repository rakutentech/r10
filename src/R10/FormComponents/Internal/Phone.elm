module R10.FormComponents.Internal.Phone exposing
    ( countryOptions
    , defaultTrailingIcon
    , extraCss
    , view
    , viewOptionEl
    )

import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Events as Events
import Element.WithContext.Font as Font
import Element.WithContext.Input as Input
import Html.Attributes
import R10.Context exposing (..)
import R10.Country
import R10.FormComponents.Internal.IconButton
import R10.FormComponents.Internal.Phone.Combobox
import R10.FormComponents.Internal.Phone.Common
import R10.FormComponents.Internal.Phone.Update
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.Utils
import R10.Palette
import R10.SimpleMarkdown
import R10.Transition



-- todo implement disabled style
-- todo implement custom logic for Radio (remove Input.Radio due to lack of customization. eg cannot apply disabled style)
-- About best UX for Radio Buttons:
-- https://uxplanet.org/radio-buttons-ux-design-588e5c0a50dc
-- constants


extraCss : String
extraCss =
    ""


defaultTrailingIcon : { a | opened : Bool, palette : R10.Palette.Palette } -> Element (R10.Context.ContextInternal z) msg
defaultTrailingIcon { opened, palette } =
    R10.FormComponents.Internal.IconButton.view []
        { msgOnClick = Nothing
        , icon =
            R10.FormComponents.Internal.UI.icons.combobox_arrow
                [ rotate <|
                    degrees
                        (if opened then
                            180

                         else
                            0
                        )
                , R10.Transition.transition "all 0.13s"
                ]
                (R10.FormComponents.Internal.UI.Color.label palette)
                24
        , palette = palette
        , size = 24
        }



--helpers Public


insertBold : List Int -> String -> String
insertBold indexes string =
    string
        |> R10.FormComponents.Internal.Utils.stringInsertAtMulti "**" indexes


viewOptionEl :
    { a
        | search : String
        , msgOnSelect : R10.Country.Country -> msg
    }
    -> R10.Country.Country
    -> Element (R10.Context.ContextInternal z) msg
viewOptionEl { search, msgOnSelect } country =
    let
        label =
            R10.Country.toCountryNameWithAlias country

        insertPositions : List Int
        insertPositions =
            String.indexes (search |> R10.FormComponents.Internal.Phone.Common.normalizeString) (label |> R10.FormComponents.Internal.Phone.Common.normalizeString)
                |> List.concatMap (\idx -> [ idx, idx + String.length search ])

        withBold : String
        withBold =
            if List.isEmpty insertPositions then
                label

            else
                insertBold insertPositions label
    in
    row
        [ width fill
        , height fill
        , htmlAttribute <| Html.Attributes.style "z-index" "0"
        , Events.onClick <| msgOnSelect country
        , pointer
        , paddingXY 12 0
        , spacing 8

        -- gradient for label overflow
        , htmlAttribute <| Html.Attributes.style "mask-image" "linear-gradient(right, rgba(255,255,0,0), rgba(255,255,0, 1) 16px)"
        , htmlAttribute <| Html.Attributes.style "-webkit-mask-image" "-webkit-linear-gradient(right, rgba(255,255,0,0) 10px, rgba(255,255,0, 1) 16px)"
        ]
        [ R10.FormComponents.Internal.Utils.getFlagIcon
            (R10.FormComponents.Internal.Utils.maybeCountryCodeToString <| Just country)
        , row [] (withBold |> R10.SimpleMarkdown.elementMarkdown)
        , el [ alpha 0.5 ] <| text ("(" ++ R10.Country.toCountryTelCode country ++ ")")
        ]


getFlagButton :
    { palette : R10.Palette.Palette
    , disabled : Bool
    , toMsg : R10.FormComponents.Internal.Phone.Common.Msg -> msg
    , key : String
    , filteredFieldOption : List R10.Country.Country
    , model : R10.FormComponents.Internal.Phone.Common.Model
    , style : R10.FormComponents.Internal.Style.Style
    }
    -> Element (R10.Context.ContextInternal z) msg
getFlagButton { palette, disabled, toMsg, key, filteredFieldOption, model } =
    Input.button
        ([ R10.Transition.transition "all 0.2s"
         , paddingXY 10 5
         , Border.rounded 10
         , moveDown 3
         , moveRight 8
         ]
            ++ (if not disabled then
                    [ mouseOver [ Background.color <| R10.FormComponents.Internal.UI.Color.borderA 0.3 palette ]
                    , focused [ Background.color <| R10.FormComponents.Internal.UI.Color.borderA 0.3 palette ]
                    , htmlAttribute <|
                        R10.FormComponents.Internal.UI.onKeyPressBatch <|
                            [ ( R10.FormComponents.Internal.UI.keyCode.space
                              , toMsg <|
                                    R10.FormComponents.Internal.Phone.Update.getMsgOnInputClick model
                                        { key = key
                                        , selectOptionHeight = 36
                                        , maxDisplayCount = 5
                                        }
                                        filteredFieldOption
                              )
                            ]
                    ]

                else
                    [ htmlAttribute <| Html.Attributes.style "cursor" "default"
                    , htmlAttribute <| Html.Attributes.tabindex -1
                    ]
               )
        )
        { onPress =
            if disabled then
                Nothing

            else
                Just <|
                    toMsg <|
                        R10.FormComponents.Internal.Phone.Update.getMsgOnInputClick model
                            { key = key
                            , selectOptionHeight = 36
                            , maxDisplayCount = 5
                            }
                            filteredFieldOption
        , label =
            let
                maybeCountryValue : Maybe R10.Country.Country
                maybeCountryValue =
                    R10.Country.fromTelephoneAsString model.value
            in
            row
                [ spacing 7 ]
                [ el []
                    (R10.FormComponents.Internal.Utils.getFlagIcon
                        (R10.FormComponents.Internal.Utils.maybeCountryCodeToString maybeCountryValue)
                    )
                , text <| Maybe.withDefault "" (Maybe.map R10.Country.toCountryTelCode maybeCountryValue)
                , el
                    [ Font.size 11
                    , alpha 0.6
                    , R10.Transition.transition "all 0.2s"
                    , rotate
                        (if model.opened then
                            pi

                         else
                            0
                        )
                    ]
                  <|
                    text <|
                        if not disabled then
                            "▼"

                        else
                            ""
                ]
        }


countryOptions : List R10.Country.Country
countryOptions =
    R10.Country.list


view :
    List (Attribute (R10.Context.ContextInternal z) msg)
    -> R10.FormComponents.Internal.Phone.Common.Model
    ->
        { maybeValid : Maybe Bool
        , toMsg : R10.FormComponents.Internal.Phone.Common.Msg -> msg
        , label : String
        , helperText : Maybe String
        , disabled : Bool
        , requiredLabel : Maybe String
        , style : R10.FormComponents.Internal.Style.Style
        , key : String
        , palette : R10.Palette.Palette
        , countryOptions : Maybe (List R10.Country.Country)
        , disabledCountryChange : Bool
        }
    -> Element (R10.Context.ContextInternal z) msg
view attrs model conf =
    let
        countryOptions_ : List R10.Country.Country
        countryOptions_ =
            conf.countryOptions
                |> Maybe.withDefault countryOptions

        filteredFieldOption : List R10.Country.Country
        filteredFieldOption =
            countryOptions_
                |> R10.FormComponents.Internal.Phone.Common.filterBySearch model.search

        args : R10.FormComponents.Internal.Phone.Common.Args z msg
        args =
            { maybeValid = conf.maybeValid
            , toMsg = conf.toMsg
            , label = conf.label
            , helperText = conf.helperText
            , disabled = conf.disabled
            , requiredLabel = conf.requiredLabel
            , style = conf.style
            , key = conf.key
            , palette = conf.palette
            , countryOptions = countryOptions_
            , toOptionEl =
                viewOptionEl
                    { search = model.search
                    , msgOnSelect = R10.FormComponents.Internal.Phone.Common.OnOptionSelect conf.key >> conf.toMsg
                    }
            , selectOptionHeight = 36
            , maxDisplayCount = 5
            , leadingIcon =
                [ getFlagButton
                    { palette = conf.palette
                    , disabled = conf.disabled || conf.disabledCountryChange
                    , toMsg = conf.toMsg
                    , key = conf.key
                    , filteredFieldOption = filteredFieldOption
                    , model = model
                    , style = conf.style
                    }
                ]

            -- , trailingIcon = [ defaultTrailingIcon { opened = model.opened, palette = conf.palette } ]
            , trailingIcon = []
            , disabledCountryChange = conf.disabledCountryChange
            }
    in
    R10.FormComponents.Internal.Phone.Combobox.view attrs model args
