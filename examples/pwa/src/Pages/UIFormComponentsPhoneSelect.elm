module Pages.UIFormComponentsPhoneSelect exposing
    ( Model
    , Msg
    , init
    , title
    , update
    , view
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Html exposing (Html)
import Html.Attributes
import Pages.Shared.Utils
import R10.FormComponents
import R10.FormComponents.Single.Common
import R10.FormComponents.Validations
import R10.Language
import R10.SimpleMarkdown


title : R10.Language.Translations
title =
    { key = "title"
    , en_us = "Forms - Phone Selector"
    , ja_jp = "Forms - Phone Selector"
    , zh_tw = "Forms - Phone Selector"
    , es_es = "Forms - Phone Selector"
    , fr_fr = "Forms - Phone Selector"
    , de_de = "Forms - Phone Selector"
    , it_it = "Forms - Phone Selector"
    , nl_nl = "Forms - Phone Selector"
    , pt_pt = "Forms - Phone Selector"
    , nb_no = "Forms - Phone Selector"
    , fi_fl = "Forms - Phone Selector"
    , da_dk = "Forms - Phone Selector"
    , sv_se = "Forms - Phone Selector"
    }


type alias Model =
    { singleModel : R10.FormComponents.SingleModel
    , disabled : Bool
    , messages : List String
    , validation : R10.FormComponents.Validations.Validation
    }


getFlagButton : R10.FormComponents.Palette -> String -> Element Msg
getFlagButton palette label =
    R10.FormComponents.viewIconButton []
        { msgOnClick = Just <| FlagClick
        , icon = getFlagIcon label
        , palette = palette
        , size = 24
        }


getFlagIcon : String -> Element msg
getFlagIcon label =
    if label == "" then
        el
            [ width <| px 24
            , height <| px 18
            , Border.width 1
            , Background.color <| rgb 0 0 0
            ]
            none

    else
        el
            [ width <| px 24
            , height <| px 18
            , Border.width 1
            ]
            none


fieldOptions : List { label : String, value : String }
fieldOptions =
    [ { label = "Japan(+1)"
      , value = "+1"
      }
    , { label = "USA(+2)"
      , value = "+2"
      }
    , { label = "China(+3)"
      , value = "+3"
      }
    , { label = "Taiwan(+4)"
      , value = "+4"
      }
    ]


viewOptionEl :
    a
    -> { c | msgOnOptionSelect : b -> msg, search : String }
    -> { d | label : String, value : b }
    -> Element msg
viewOptionEl _ { search, msgOnOptionSelect } { label, value } =
    let
        insertPositions =
            String.indexes
                (search |> R10.FormComponents.normalizeString)
                (label |> R10.FormComponents.normalizeString)
                |> List.concatMap (\idx -> [ idx, idx + String.length search ])

        withBold =
            if String.isEmpty search then
                label

            else
                R10.FormComponents.insertBold insertPositions label
    in
    row
        [ width fill
        , height fill
        , R10.FormComponents.onClickWithStopPropagation <| msgOnOptionSelect value
        , pointer
        , paddingEach { top = 0, right = 0, bottom = 0, left = 12 }
        , spacing 8

        -- gradient for label overflow
        , htmlAttribute <| Html.Attributes.style "mask-image" "linear-gradient(right, rgba(255,255,0,0), rgba(255,255,0, 1) 16px)"
        , htmlAttribute <| Html.Attributes.style "-webkit-mask-image" "-webkit-linear-gradient(right, rgba(255,255,0,0) 10px, rgba(255,255,0, 1) 16px)"
        ]
        ([ getFlagIcon label ]
            ++ (withBold |> R10.SimpleMarkdown.elementMarkdown)
        )


init : Model
init =
    { singleModel = R10.FormComponents.Single.Common.init
    , disabled = False
    , messages = []
    , validation = R10.FormComponents.Validations.NotYetValidated
    }


type Msg
    = OnSingleMsg R10.FormComponents.SingleMsg
    | FlagClick
    | OnOptionSelect String
    | RotateValidation
    | ToggleDisabled


validations :
    { n1 : R10.FormComponents.Validations.Validation
    , n2 : R10.FormComponents.Validations.Validation
    , n3 : R10.FormComponents.Validations.Validation
    , n4 : R10.FormComponents.Validations.Validation
    }
validations =
    { n1 = R10.FormComponents.Validations.NotYetValidated
    , n2 = R10.FormComponents.Validations.Validated []
    , n3 = R10.FormComponents.Validations.Validated [ R10.FormComponents.Validations.MessageOk "Yeah!" ]
    , n4 = R10.FormComponents.Validations.Validated [ R10.FormComponents.Validations.MessageOk "Yeah!", R10.FormComponents.Validations.MessageErr "Nope" ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnSingleMsg singleMsg ->
            let
                skipMsg =
                    case singleMsg of
                        R10.FormComponents.Single.Common.OnArrowUp _ _ ->
                            not model.singleModel.opened

                        R10.FormComponents.Single.Common.OnArrowDown _ _ ->
                            not model.singleModel.opened

                        R10.FormComponents.Single.Common.OnInputClick _ ->
                            True

                        _ ->
                            False
            in
            if skipMsg then
                ( model, Cmd.none )

            else
                let
                    ( selectState, selectCmd ) =
                        R10.FormComponents.updateSingle singleMsg model.singleModel
                in
                ( { model | singleModel = selectState }, Cmd.map OnSingleMsg selectCmd )

        OnOptionSelect value ->
            let
                singleModel =
                    model.singleModel
            in
            ( { model | singleModel = { singleModel | value = value } }, Cmd.none )

        FlagClick ->
            let
                selectState =
                    model.singleModel
            in
            ( { model | singleModel = { selectState | opened = not selectState.opened } }
            , Cmd.none
            )

        RotateValidation ->
            ( { model
                | validation =
                    if model.validation == validations.n1 then
                        validations.n2

                    else if model.validation == validations.n2 then
                        validations.n3

                    else if model.validation == validations.n3 then
                        validations.n4

                    else
                        validations.n1
              }
            , Cmd.none
            )

        ToggleDisabled ->
            ( { model | disabled = not model.disabled }, Cmd.none )


view : Model -> List (Element Msg)
view model =
    let
        attrs =
            [ padding 0
            , Border.width 0
            , backgroundColor
            ]

        backgroundColor =
            Background.color <| rgba 0.9 1 0.2 0.7

        palette =
            Pages.Shared.Utils.toFormPalette
    in
    [ row
        [ height (fill |> minimum 200)
        ]
        [ R10.FormComponents.viewSingleCustom
            []
            model.singleModel
            { validation = model.validation
            , toMsg = OnSingleMsg
            , label = "Code"
            , helperText = Nothing
            , disabled = model.disabled
            , requiredLabel = Nothing
            , style = R10.FormComponents.style.filled
            , key = ""
            , palette = palette
            , singleType = R10.FormComponents.typeSingle.combobox
            , fieldOptions = fieldOptions
            , searchFn = R10.FormComponents.defaultSearchFn
            , toOptionEl =
                viewOptionEl palette
                    { search = model.singleModel.search
                    , msgOnOptionSelect = OnOptionSelect
                    }
            , selectOptionHeight = 36
            , maxDisplayCount = 5
            , leadingIcon = Just <| getFlagButton palette model.singleModel.value
            , trailingIcon = Nothing
            }
        ]
    ]
