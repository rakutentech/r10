module R10.FormComponents.Internal.Phone exposing
    ( countryOptions
    , defaultTrailingIcon
    , extraCss
    , view
    )

import Element exposing (..)
import Element.Events as Events
import Element.Font as Font
import Html.Attributes
import R10.Color.Utils
import R10.Country
import R10.FormComponents.Internal.IconButton
import R10.FormComponents.Internal.Phone.Common
import R10.FormComponents.Internal.Phone.Update
import R10.FormComponents.Internal.Phone.Views
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.Utils
import R10.FormTypes
import R10.SimpleMarkdown
import String.Extra



-- todo implement disabled style
-- todo implement custom logic for Radio (remove Input.Radio due to lack of customization. eg cannot apply disabled style)
-- About best UX for Radio Buttons:
-- https://uxplanet.org/radio-buttons-ux-design-588e5c0a50dc
-- constants


extraCss : String
extraCss =
    ""


defaultTrailingIcon : { a | opened : Bool, palette : R10.FormTypes.Palette } -> Element msg
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
                , htmlAttribute <| Html.Attributes.style "transition" "all 0.13s"
                ]
                (R10.FormComponents.Internal.UI.Color.label palette)
                24
        , palette = palette
        , size = 24
        }



--helpers Public


update : R10.FormComponents.Internal.Phone.Common.Msg -> R10.FormComponents.Internal.Phone.Common.Model -> ( R10.FormComponents.Internal.Phone.Common.Model, Cmd R10.FormComponents.Internal.Phone.Common.Msg )
update =
    R10.FormComponents.Internal.Phone.Update.update


getFlagIcon : Int -> Maybe R10.Country.Country -> Element msg
getFlagIcon size maybeCountry =
    el
        [ Font.size size ]
    <|
        text
            (case maybeCountry of
                Just country ->
                    R10.Country.toFlag country

                Nothing ->
                    R10.Country.emptyFlag
            )


insertBold : List Int -> String -> String
insertBold indexes string =
    string
        |> R10.FormComponents.Internal.Utils.stringInsertAtMulti "**" indexes
        |> String.Extra.surround "**"


viewOptionEl :
    { a
        | search : String
        , msgOnSelect : R10.Country.Country -> msg
    }
    -> R10.Country.Country
    -> Element msg
viewOptionEl { search, msgOnSelect } country =
    let
        label =
            R10.Country.toString country

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
        [ getFlagIcon 24 <| Just country
        , row [] (withBold |> R10.SimpleMarkdown.elementMarkdown)
        , el [ alpha 0.5 ] <| text ("(" ++ R10.Country.toCountryTelCode country ++ ")")
        ]


getFlagButton :
    { palette : R10.FormTypes.Palette
    , disabled : Bool
    , toMsg : R10.FormComponents.Internal.Phone.Common.Msg -> msg
    , key : String
    , filteredCountryOptions : List R10.Country.Country
    , model : R10.FormComponents.Internal.Phone.Common.Model
    }
    -> Element msg
getFlagButton { palette, disabled, toMsg, key, filteredCountryOptions, model } =
    R10.FormComponents.Internal.IconButton.view []
        { msgOnClick =
            if disabled then
                Nothing

            else
                Just <|
                    toMsg <|
                        R10.FormComponents.Internal.Phone.Update.getMsgOnFlagClick model
                            { key = key
                            , selectOptionHeight = 36
                            , maxDisplayCount = 5
                            }
                            filteredCountryOptions
        , icon =
            row [ width fill, centerY, centerX, moveLeft 2 ]
                [ model.countryValue
                    |> getFlagIcon 20
                    |> el
                        [ width fill
                        , centerY
                        , centerX
                        , moveDown 2
                        ]
                , R10.FormComponents.Internal.UI.icons.combobox_arrow
                    [ width fill
                    , moveLeft 1
                    , centerY
                    , centerX
                    ]
                    (R10.FormComponents.Internal.UI.Color.label palette)
                    16
                ]
        , palette = palette
        , size = 24
        }


countryOptions : List R10.Country.Country
countryOptions =
    R10.Country.list


view :
    List (Attribute msg)
    -> R10.FormComponents.Internal.Phone.Common.Model
    ->
        { valid : Maybe Bool
        , toMsg : R10.FormComponents.Internal.Phone.Common.Msg -> msg
        , label : String
        , helperText : Maybe String
        , disabled : Bool
        , requiredLabel : Maybe String
        , style : R10.FormComponents.Internal.Style.Style
        , key : String
        , palette : R10.FormTypes.Palette
        , countryOptions : Maybe (List R10.Country.Country)
        }
    -> Element msg
view attrs model conf =
    let
        countryOptions_ : List R10.Country.Country
        countryOptions_ =
            conf.countryOptions
                |> Maybe.withDefault countryOptions

        filteredCountryOptions : List R10.Country.Country
        filteredCountryOptions =
            countryOptions_
                |> R10.FormComponents.Internal.Phone.Common.filterBySearch model.search

        args : R10.FormComponents.Internal.Phone.Common.Args msg
        args =
            { valid = conf.valid
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
                    , msgOnSelect = R10.FormComponents.Internal.Phone.Common.OnOptionSelect >> conf.toMsg
                    }
            , selectOptionHeight = 36
            , maxDisplayCount = 5
            , leadingIcon =
                Just <|
                    getFlagButton
                        { palette = conf.palette
                        , disabled = conf.disabled
                        , toMsg = conf.toMsg
                        , key = conf.key
                        , filteredCountryOptions = filteredCountryOptions
                        , model = model
                        }
            , trailingIcon = Just <| defaultTrailingIcon { opened = model.opened, palette = conf.palette }
            }
    in
    R10.FormComponents.Internal.Phone.Views.view attrs model args
