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
import R10.Country exposing (Country)
import R10.FormComponents.Internal.IconButton
import R10.FormComponents.Internal.Phone.Common as Common
import R10.FormComponents.Internal.Phone.Update
import R10.FormComponents.Internal.Phone.Views
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.Validations
import R10.FormTypes



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
                (R10.Color.Utils.elementColorToColor <| R10.FormComponents.Internal.UI.Color.label palette)
                24
        , palette = palette
        , size = 24
        }



--helpers Public


update : Common.Msg -> Common.Model -> ( Common.Model, Cmd Common.Msg )
update =
    R10.FormComponents.Internal.Phone.Update.update


getFlagIcon : Int -> Maybe Country -> Element msg
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
        , text (R10.Country.toString country)
        , el [ alpha 0.5 ] <| text ("(" ++ R10.Country.toCountryTelCode country ++ ")")
        ]


getFlagButton : R10.FormTypes.Palette -> String -> msg -> Element msg
getFlagButton palette value msg =
    R10.FormComponents.Internal.IconButton.view []
        { msgOnClick = Just <| msg
        , icon =
            row [ width fill, centerY, centerX, moveLeft 2 ]
                [ value
                    |> R10.FormComponents.Internal.Phone.Update.extractCountry
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
                    (R10.Color.Utils.elementColorToColor <| R10.FormComponents.Internal.UI.Color.label palette)
                    16
                ]
        , palette = palette
        , size = 24
        }


countryOptions : List Country
countryOptions =
    R10.Country.list


view :
    List (Attribute msg)
    -> Common.Model
    ->
        { validation : R10.FormComponents.Internal.Validations.Validation
        , toMsg : Common.Msg -> msg
        , label : String
        , helperText : Maybe String
        , disabled : Bool
        , requiredLabel : Maybe String
        , style : R10.FormComponents.Internal.Style.Style
        , key : String
        , palette : R10.FormTypes.Palette
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
                            R10.FormComponents.Internal.Phone.Update.getMsgOnFlagClick model
                                { key = conf.key
                                , selectOptionHeight = 36
                                , maxDisplayCount = 5
                                }
                                countryOptions_
                        )
            , trailingIcon = Just <| defaultTrailingIcon { opened = model.opened, palette = conf.palette }
            }
    in
    R10.FormComponents.Internal.Phone.Views.view attrs model args
