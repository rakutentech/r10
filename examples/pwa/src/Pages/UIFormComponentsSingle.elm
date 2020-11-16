module Pages.UIFormComponentsSingle exposing
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
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes
import Markdown
import Pages.Shared.Utils
import R10.Color.Utils
import R10.Form.Helpers
import R10.FormComponents.IconButton
import R10.FormComponents.Single
import R10.FormComponents.Single.Common
import R10.FormComponents.Style
import R10.FormComponents.UI.Color
import R10.FormComponents.UI.Palette
import R10.FormComponents.Validations
import R10.Language
import R10.Svg.IconsExtra


title : R10.Language.Translations
title =
    { key = "title"
    , en_us = "Forms - Single"
    , ja_jp = "Forms - Single"
    , zh_tw = "Forms - Single"
    , es_es = "Forms - Single"
    , fr_fr = "Forms - Single"
    , de_de = "Forms - Single"
    , it_it = "Forms - Single"
    , nl_nl = "Forms - Single"
    , pt_pt = "Forms - Single"
    , nb_no = "Forms - Single"
    , fi_fl = "Forms - Single"
    , da_dk = "Forms - Single"
    , sv_se = "Forms - Single"
    }


type alias Model =
    { singleModel : R10.FormComponents.Single.Common.Model
    , disabled : Bool
    , helperShow : Bool
    , helperText : String
    , requiredShow : Bool
    , requiredText : String
    , label : String
    , leadingIcon : Maybe Icon
    , messages : List String
    , selectOptionHeight : Int
    , maxDisplayCount : Int
    , trailingIcon : Maybe Icon
    , type_ : R10.FormComponents.Single.Common.TypeSingle
    , validation : R10.FormComponents.Validations.Validation
    , fieldOptions : List R10.FormComponents.Single.Common.FieldOption
    }


typeToString : R10.FormComponents.Single.Common.TypeSingle -> String
typeToString textType =
    case textType of
        R10.FormComponents.Single.Common.SingleCombobox ->
            "SingleCombobox"

        R10.FormComponents.Single.Common.SingleRadio ->
            "SingleRadio"


iconToString : Maybe Icon -> String
iconToString icon =
    case icon of
        Just Play ->
            "Just Play"

        Just Pause ->
            "Just Pause"

        Nothing ->
            "Nothing"


generateFieldOptions : Int -> List { label : String, value : String }
generateFieldOptions count =
    if count == 0 then
        []

    else
        List.range 0 (count - 1)
            |> List.map
                (\index ->
                    { label = "label #" ++ String.fromInt index
                    , value = "value #" ++ String.fromInt index
                    }
                )


type Icon
    = Play
    | Pause


toIconEl : R10.FormComponents.UI.Palette.Palette -> Icon -> Element Msg
toIconEl palette leadingIcon =
    case leadingIcon of
        Play ->
            R10.FormComponents.IconButton.view []
                { msgOnClick = Just <| PlayPauseClick Play
                , icon = R10.Svg.IconsExtra.play [] (R10.FormComponents.UI.Color.label palette |> R10.Color.Utils.elementColorToColor) 24
                , palette = palette
                , size = 24
                }

        Pause ->
            R10.FormComponents.IconButton.view []
                { msgOnClick = Just <| PlayPauseClick Pause
                , icon = R10.Svg.IconsExtra.pause [] (R10.FormComponents.UI.Color.label palette |> R10.Color.Utils.elementColorToColor) 30
                , palette = palette
                , size = 30
                }


init : Model
init =
    { singleModel = R10.FormComponents.Single.Common.init
    , disabled = False
    , helperShow = True
    , helperText = """Helper text ([Markdown](https://en.wikipedia.org/wiki/Markdown))"""
    , label = "Label"
    , leadingIcon = Just Play
    , messages = []
    , requiredShow = True
    , requiredText = "required_text"
    , selectOptionHeight = 36
    , maxDisplayCount = 5
    , trailingIcon = Nothing
    , type_ = R10.FormComponents.Single.Common.SingleCombobox
    , validation = R10.FormComponents.Validations.NotYetValidated
    , fieldOptions = generateFieldOptions 4
    }


type Msg
    = -- component MSGs
      NoOp
    | OnSingleMsg R10.FormComponents.Single.Common.Msg
      -- page MSGs
    | ChangeFieldOptionLen String
    | ChangeHelperText String
    | ChangeLabel String
    | ChangeRequiredText String
    | PlayPauseClick Icon
    | RotateLeadingIcon
    | RotateOpened
    | RotateFocused
    | SetValue String
    | ChangeSelectOptionHeight String
    | ChangeMaxDisplayCount String
    | RotateTrailingIcon
    | RotateType
    | RotateValidation
    | ToggleDisabled
    | ToggleHelperShow
    | ToggleRequiredShow


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
        NoOp ->
            ( { model | messages = "NoOp (after focus)" :: model.messages }, Cmd.none )

        OnSingleMsg singleMsg ->
            let
                ( singleModel, singleCmd ) =
                    R10.FormComponents.Single.update singleMsg model.singleModel
            in
            ( { model | singleModel = singleModel }, Cmd.map OnSingleMsg singleCmd )

        ChangeLabel string ->
            ( { model | label = string }, Cmd.none )

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

        ToggleHelperShow ->
            ( { model | helperShow = not model.helperShow }, Cmd.none )

        ChangeHelperText string ->
            ( { model | helperText = string }, Cmd.none )

        ToggleRequiredShow ->
            ( { model | requiredShow = not model.requiredShow }, Cmd.none )

        ChangeRequiredText string ->
            ( { model | requiredText = string }, Cmd.none )

        ToggleDisabled ->
            ( { model | disabled = not model.disabled }, Cmd.none )

        RotateLeadingIcon ->
            ( { model
                | leadingIcon =
                    case model.leadingIcon of
                        Just Play ->
                            Just Pause

                        Just Pause ->
                            Nothing

                        Nothing ->
                            Just Play
              }
            , Cmd.none
            )

        ChangeFieldOptionLen string ->
            ( case String.toInt string of
                Just int ->
                    { model | fieldOptions = generateFieldOptions int }

                Nothing ->
                    model
            , Cmd.none
            )

        ChangeSelectOptionHeight string ->
            ( case String.toInt string of
                Just int ->
                    { model | selectOptionHeight = int }

                Nothing ->
                    model
            , Cmd.none
            )

        ChangeMaxDisplayCount string ->
            ( case String.toInt string of
                Just int ->
                    { model | maxDisplayCount = int }

                Nothing ->
                    model
            , Cmd.none
            )

        RotateTrailingIcon ->
            ( { model
                | trailingIcon =
                    case model.trailingIcon of
                        Just Play ->
                            Just Pause

                        Just Pause ->
                            Nothing

                        Nothing ->
                            Just Play
              }
            , Cmd.none
            )

        PlayPauseClick icon ->
            let
                nextIcon =
                    case icon of
                        Play ->
                            Just Pause

                        Pause ->
                            Just Play
            in
            ( { model | trailingIcon = nextIcon, leadingIcon = nextIcon }
            , Cmd.none
            )

        RotateType ->
            ( { model
                | type_ =
                    case model.type_ of
                        R10.FormComponents.Single.Common.SingleCombobox ->
                            R10.FormComponents.Single.Common.SingleRadio

                        R10.FormComponents.Single.Common.SingleRadio ->
                            R10.FormComponents.Single.Common.SingleCombobox
              }
            , Cmd.none
            )

        RotateOpened ->
            let
                singleModel =
                    model.singleModel
            in
            ( { model | singleModel = { singleModel | opened = not singleModel.opened } }
            , Cmd.none
            )

        RotateFocused ->
            let
                singleModel =
                    model.singleModel
            in
            ( { model | singleModel = { singleModel | focused = not singleModel.focused } }
            , Cmd.none
            )

        SetValue string ->
            let
                singleModel =
                    model.singleModel
            in
            ( { model | singleModel = { singleModel | value = string } }
            , Cmd.none
            )


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
    [ column
        []
        [ paragraph [] [ html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """
Here you can simulate all the possible states of the component "Text". You can click on all yellow areas below to change the state in real time.

The messages on the right are all the messages that are fired by the component.
""" ] ]
    , column [ width fill ]
        [ row
            [ spacing 50 ]
            [ R10.FormComponents.Single.viewCustom
                []
                model.singleModel
                { validation = model.validation
                , toMsg = OnSingleMsg
                , label = model.label
                , helperText =
                    if model.helperShow then
                        Just model.helperText

                    else
                        Nothing
                , disabled = model.disabled
                , requiredLabel =
                    if model.requiredShow then
                        Just model.requiredText

                    else
                        Nothing
                , style = R10.FormComponents.Style.Outlined
                , key = ""
                , palette = palette
                , singleType = model.type_
                , fieldOptions = model.fieldOptions
                , searchFn = R10.FormComponents.Single.defaultSearchFn
                , toOptionEl =
                    R10.FormComponents.Single.defaultToOptionEl
                        { search = model.singleModel.search
                        , msgOnSelect = R10.FormComponents.Single.Common.OnOptionSelect >> OnSingleMsg
                        }
                , selectOptionHeight = model.selectOptionHeight
                , maxDisplayCount = model.maxDisplayCount
                , leadingIcon = model.leadingIcon |> Maybe.map (toIconEl palette)
                , trailingIcon =
                    model.trailingIcon
                        |> Maybe.map (toIconEl palette)
                        |> Maybe.withDefault
                            (R10.FormComponents.Single.defaultTrailingIcon
                                { opened = model.singleModel.opened
                                , palette = palette
                                }
                            )
                        |> Just
                }
            , R10.FormComponents.Single.viewCustom
                []
                model.singleModel
                { validation = model.validation
                , toMsg = OnSingleMsg
                , label = model.label
                , helperText =
                    if model.helperShow then
                        Just model.helperText

                    else
                        Nothing
                , disabled = model.disabled
                , requiredLabel =
                    if model.requiredShow then
                        Just model.requiredText

                    else
                        Nothing
                , style = R10.FormComponents.Style.Filled
                , key = ""
                , palette = palette
                , singleType = model.type_
                , fieldOptions = model.fieldOptions
                , searchFn = R10.FormComponents.Single.defaultSearchFn
                , toOptionEl =
                    R10.FormComponents.Single.defaultToOptionEl
                        { search = model.singleModel.search
                        , msgOnSelect = R10.FormComponents.Single.Common.OnOptionSelect >> OnSingleMsg
                        }
                , selectOptionHeight = model.selectOptionHeight
                , maxDisplayCount = model.maxDisplayCount
                , leadingIcon = model.leadingIcon |> Maybe.map (toIconEl palette)
                , trailingIcon =
                    model.trailingIcon
                        |> Maybe.map (toIconEl palette)
                        |> Maybe.withDefault
                            (R10.FormComponents.Single.defaultTrailingIcon
                                { opened = model.singleModel.opened
                                , palette = palette
                                }
                            )
                        |> Just
                }
            ]
        ]
    , row
        [ width fill
        , centerX
        ]
        [ column
            [ width fill
            ]
            [ column
                [ Font.family [ Font.monospace ]
                , spacing 5
                ]
                [ text "FormComponents.Text.view [] []"
                , text " "
                , text "    -- Stuff that doesn't change during"
                , text "    -- the life of the component"
                , text " "
                , row []
                    [ text "    { label = \""
                    , Input.text attrs
                        { label = Input.labelHidden ""
                        , onChange = ChangeLabel
                        , placeholder = Nothing
                        , text = model.label
                        }
                    , text "\""
                    ]
                , row []
                    [ text "    , helperText = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just ToggleHelperShow
                        , label =
                            text <|
                                if model.helperShow then
                                    "Just"

                                else
                                    "Nothing"
                        }
                    , if model.helperShow then
                        row [ width fill ]
                            [ text " \""
                            , Input.text attrs
                                { label = Input.labelHidden ""
                                , onChange = ChangeHelperText
                                , placeholder = Nothing
                                , text = model.helperText
                                }
                            , text "\""
                            ]

                      else
                        none
                    ]
                , row []
                    [ text "    , requiredLabel = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just ToggleRequiredShow
                        , label =
                            text <|
                                if model.requiredShow then
                                    "Just"

                                else
                                    "Nothing"
                        }
                    , if model.requiredShow then
                        row [ width fill ]
                            [ text " \""
                            , Input.text attrs
                                { label = Input.labelHidden ""
                                , onChange = ChangeRequiredText
                                , placeholder = Nothing
                                , text = model.requiredText
                                }
                            , text "\""
                            ]

                      else
                        none
                    ]
                , row []
                    [ text "    , field option number = "
                    , row [ width fill ]
                        [ text " \""
                        , Input.text attrs
                            { label = Input.labelHidden ""
                            , onChange = ChangeFieldOptionLen
                            , placeholder = Nothing
                            , text = String.fromInt <| List.length <| model.fieldOptions
                            }
                        , text "\""
                        ]
                    ]
                , row []
                    [ text "    , selectOptionHeight = "
                    , row [ width fill ]
                        [ text " \""
                        , Input.text attrs
                            { label = Input.labelHidden ""
                            , onChange = ChangeSelectOptionHeight
                            , placeholder = Nothing
                            , text = String.fromInt <| model.selectOptionHeight
                            }
                        , text "\""
                        ]
                    ]
                , row []
                    [ text "    , maxDisplayCount = "
                    , row [ width fill ]
                        [ text " \""
                        , Input.text attrs
                            { label = Input.labelHidden ""
                            , onChange = ChangeMaxDisplayCount
                            , placeholder = Nothing
                            , text = String.fromInt <| model.maxDisplayCount
                            }
                        , text "\""
                        ]
                    ]
                , row []
                    [ text "    , textType = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just RotateType
                        , label = text <| typeToString model.type_
                        }
                    ]
                , row []
                    [ text "    , leadingIcon = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just RotateLeadingIcon
                        , label = text <| iconToString model.leadingIcon
                        }
                    ]
                , row []
                    [ text "    , trailingIcon = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just RotateTrailingIcon
                        , label = text <| iconToString model.trailingIcon
                        }
                    ]
                , text " "
                , text "    -- Stuff that change during"
                , text "    -- the life of the component"
                , text " "
                , row []
                    [ text "    , value = \""
                    , Input.text attrs
                        { label = Input.labelHidden ""
                        , onChange = SetValue
                        , placeholder = Nothing
                        , text = model.singleModel.value
                        }
                    , text "\""
                    ]
                , row []
                    [ text "    , focused = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just RotateFocused
                        , label = text <| R10.Form.Helpers.boolToString model.singleModel.focused
                        }
                    ]
                , row []
                    [ text "    , opened = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just RotateOpened
                        , label = text <| R10.Form.Helpers.boolToString model.singleModel.opened
                        }
                    ]
                , row []
                    [ text "    , validation = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just RotateValidation
                        , label = text <| R10.FormComponents.Validations.validationToString model.validation
                        }
                    ]
                , row []
                    [ text "    , disabled = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just ToggleDisabled
                        , label = text <| R10.Form.Helpers.boolToString model.disabled
                        }
                    ]
                , text " "
                , text "    -- Messages"
                , text " "
                , text "    , msgOnChange = msgOnChange"
                , text "    , msgOnFocus = msgOnFocus"
                , text "    , msgOnLoseFocus = msgOnLoseFocus"
                , text "    , msgOnTogglePasswordShow = msgOnTogglePasswordShow"
                , text "    }"
                ]
            ]
        , column
            [ width fill
            ]
            [ text <| "Messages"
            , column
                [ Font.family [ Font.monospace ]
                , spacing 5
                ]
              <|
                List.indexedMap (\index message -> text <| String.fromInt (List.length model.messages - index) ++ " " ++ message) model.messages
            ]
        ]
    ]
