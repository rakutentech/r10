module FormComponents.Phone exposing
    ( countryOptions
    , defaultTrailingIcon
    , extraCss
    , view
    )

import Element exposing (..)
import Element.Events as Events
import Element.Font as Font
import FormComponents.IconButton
import FormComponents.Phone.Common as Common
import FormComponents.Phone.Country exposing (Country)
import FormComponents.Phone.Update
import FormComponents.Phone.Views
import FormComponents.Style
import FormComponents.UI
import FormComponents.UI.Color
import FormComponents.UI.Palette
import FormComponents.Validations
import Html.Attributes



-- todo implement disabled style
-- todo implement custom logic for Radio (remove Input.Radio due to lack of customization. eg cannot apply disabled style)
-- About best UX for Radio Buttons:
-- https://uxplanet.org/radio-buttons-ux-design-588e5c0a50dc
-- constants


extraCss : String
extraCss =
    ""


defaultTrailingIcon : { a | opened : Bool, palette : FormComponents.UI.Palette.Palette } -> Element msg
defaultTrailingIcon { opened, palette } =
    FormComponents.IconButton.view []
        { msgOnClick = Nothing
        , icon =
            el
                [ rotate <|
                    degrees
                        (if opened then
                            180

                         else
                            0
                        )
                , htmlAttribute <| Html.Attributes.style "transition" "all 0.13s"
                ]
            <|
                html <|
                    FormComponents.UI.icons.combobox_arrow_
                        (FormComponents.UI.Color.label palette |> FormComponents.UI.Color.toCssString)
                        24
        , palette = palette
        , size = 24
        }



--helpers Public


update : Common.Msg -> Common.Model -> ( Common.Model, Cmd Common.Msg )
update =
    FormComponents.Phone.Update.update


getFlagIcon : Int -> Maybe Country -> Element msg
getFlagIcon size maybeCountry =
    el
        [ Font.size size ]
    <|
        text
            (case maybeCountry of
                Just country ->
                    FormComponents.Phone.Country.toFlag country

                Nothing ->
                    FormComponents.Phone.Country.emptyFlag
            )


viewOptionEl :
    { a
        | search : String
        , msgOnSelect : Country -> msg
    }
    -> Country
    -> Element msg
viewOptionEl { search, msgOnSelect } country =
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
        , text (FormComponents.Phone.Country.toString country)
        , el [ alpha 0.5 ] <| text ("(" ++ FormComponents.Phone.Country.toCountryCode country ++ ")")
        ]


getFlagButton : FormComponents.UI.Palette.Palette -> String -> msg -> Element msg
getFlagButton palette value msg =
    FormComponents.IconButton.view []
        { msgOnClick = Just <| msg
        , icon =
            row [ width fill, centerY, centerX, moveLeft 2 ]
                [ value
                    |> FormComponents.Phone.Update.extractCountry
                    |> getFlagIcon 20
                    |> el
                        [ width fill
                        , centerY
                        , centerX
                        , moveDown 2
                        ]
                , FormComponents.UI.icons.combobox_arrow_
                    (FormComponents.UI.Color.label palette |> FormComponents.UI.Color.toCssString)
                    16
                    |> html
                    |> el
                        [ width fill
                        , moveLeft 1
                        , centerY
                        , centerX
                        ]
                ]
        , palette = palette
        , size = 24
        }


countryOptions : List Country
countryOptions =
    FormComponents.Phone.Country.list


view :
    List (Attribute msg)
    -> Common.Model
    ->
        { validation : FormComponents.Validations.Validation
        , toMsg : Common.Msg -> msg
        , label : String
        , helperText : Maybe String
        , disabled : Bool
        , requiredLabel : Maybe String
        , style : FormComponents.Style.Style
        , key : String
        , palette : FormComponents.UI.Palette.Palette
        , countryOptions : Maybe (List Country)
        }
    -> Element msg
view attrs model conf =
    let
        countryOptions_ =
            conf.countryOptions |> Maybe.withDefault countryOptions

        args : Common.Args msg
        args =
            { validation = conf.validation
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
                    , fieldOptions = countryOptions_
                    , msgOnSelect = Common.OnOptionSelect >> conf.toMsg
                    }
            , selectOptionHeight = 36
            , maxDisplayCount = 5
            , leadingIcon =
                Just <|
                    getFlagButton
                        conf.palette
                        model.value
                        (conf.toMsg <|
                            FormComponents.Phone.Update.getMsgOnFlagClick model
                                { key = conf.key
                                , selectOptionHeight = 36
                                , maxDisplayCount = 5
                                }
                                countryOptions_
                        )
            , trailingIcon = Just <| defaultTrailingIcon { opened = model.opened, palette = conf.palette }
            }
    in
    FormComponents.Phone.Views.view attrs model args
