module Pages.Form_FieldType_Binary exposing
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
import Html.Attributes
import Markdown
import R10.Card
import R10.Color.Utils
import R10.Form
import R10.FormComponents
import R10.FormComponents.Single.Common
import R10.Language
import R10.Svg.IconsExtra
import R10.Theme


title : R10.Language.Translations
title =
    { key = "title"
    , en_us = "Form Field Type - Binary"
    , ja_jp = "Form Field Type - Binary"
    , zh_tw = "Form Field Type - Binary"
    , es_es = "Form Field Type - Binary"
    , fr_fr = "Form Field Type - Binary"
    , de_de = "Form Field Type - Binary"
    , it_it = "Form Field Type - Binary"
    , nl_nl = "Form Field Type - Binary"
    , pt_pt = "Form Field Type - Binary"
    , nb_no = "Form Field Type - Binary"
    , fi_fl = "Form Field Type - Binary"
    , da_dk = "Form Field Type - Binary"
    , sv_se = "Form Field Type - Binary"
    }


type alias Model =
    { singleModel : R10.Form.SingleModel
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
    , type_ : R10.Form.SingleType
    , validation : R10.Form.Validation2
    , fieldOptions : List R10.Form.SingleFieldOption
    }


typeToString : R10.Form.SingleType -> String
typeToString textType =
    case textType of
        R10.FormComponents.Single.Common.SingleCombobox ->
            "R10.Form.single.combobox"

        R10.FormComponents.Single.Common.SingleRadio ->
            "R10.Form.single.radio"


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


toIconEl : R10.Form.Palette -> Icon -> Element Msg
toIconEl palette leadingIcon =
    case leadingIcon of
        Play ->
            R10.Form.viewIconButton []
                { msgOnClick = Just <| PlayPauseClick Play
                , icon = R10.Svg.IconsExtra.play [] (R10.FormComponents.label palette |> R10.Color.Utils.elementColorToColor) 24
                , palette = palette
                , size = 24
                }

        Pause ->
            R10.Form.viewIconButton []
                { msgOnClick = Just <| PlayPauseClick Pause
                , icon = R10.Svg.IconsExtra.pause [] (R10.FormComponents.label palette |> R10.Color.Utils.elementColorToColor) 30
                , palette = palette
                , size = 30
                }


init : Model
init =
    { singleModel = R10.Form.initSingle
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
    , type_ = R10.Form.typeSingle.combobox
    , validation = R10.Form.componentValidation.notYetValidated
    , fieldOptions = generateFieldOptions 10
    }


type Msg
    = -- component MSGs
      NoOp
    | OnSingleMsg R10.Form.SingleMsg
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
    { n1 : R10.Form.Validation2
    , n2 : R10.Form.Validation2
    , n3 : R10.Form.Validation2
    , n4 : R10.Form.Validation2
    }
validations =
    { n1 = R10.Form.componentValidation.notYetValidated
    , n2 = R10.Form.componentValidation.validated []
    , n3 = R10.Form.componentValidation.validated [ R10.Form.validationMessage.ok "Yeah!" ]
    , n4 = R10.Form.componentValidation.validated [ R10.Form.validationMessage.ok "Yeah!", R10.Form.validationMessage.error "Nope" ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( { model | messages = "NoOp (after focus)" :: model.messages }, Cmd.none )

        OnSingleMsg singleMsg ->
            let
                ( singleModel, singleCmd ) =
                    R10.Form.updateSingle singleMsg model.singleModel
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


view : a -> b -> List (Element msg)
view _ _ =
    [ text "COMING SOON..." ]


viewOLD : Model -> R10.Theme.Theme -> List (Element Msg)
viewOLD model theme =
    let
        attrs =
            [ padding 0
            , Border.width 0
            , backgroundColor
            ]

        backgroundColor =
            Background.color <| rgba 0.9 1 0.2 0.7

        palette =
            R10.Form.themeToPalette theme
    in
    [ column
        (R10.Card.normal theme ++ [ spacing 10 ])
        [ paragraph [] [ html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """
Here you can simulate all the possible states of the component "Text". You can click on all yellow areas below to change the state in real time.

The messages on the right are all the messages that are fired by the component.
""" ] ]
    , column [ spacing 20, width fill ]
        [ row
            (R10.Card.normal theme ++ [ spacing 20 ])
            [ R10.Form.viewSingleCustom
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
                , style = R10.Form.style.outlined
                , key = ""
                , palette = palette
                , singleType = model.type_
                , fieldOptions = model.fieldOptions
                , searchFn = R10.Form.defaultSearchFn
                , toOptionEl =
                    R10.Form.defaultToOptionEl
                        { search = model.singleModel.search
                        , msgOnSelect = R10.Form.singleMsg.onOptionSelect >> OnSingleMsg
                        }
                , selectOptionHeight = model.selectOptionHeight
                , maxDisplayCount = model.maxDisplayCount
                , leadingIcon = model.leadingIcon |> Maybe.map (toIconEl palette)
                , trailingIcon =
                    model.trailingIcon
                        |> Maybe.map (toIconEl palette)
                        |> Maybe.withDefault
                            (R10.Form.defaultTrailingIcon
                                { opened = model.singleModel.opened
                                , palette = palette
                                }
                            )
                        |> Just
                }
            , R10.Form.viewSingleCustom
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
                , style = R10.Form.style.filled
                , key = ""
                , palette = palette
                , singleType = model.type_
                , fieldOptions = model.fieldOptions
                , searchFn = R10.Form.defaultSearchFn
                , toOptionEl =
                    R10.Form.defaultToOptionEl
                        { search = model.singleModel.search
                        , msgOnSelect = R10.Form.singleMsg.onOptionSelect >> OnSingleMsg
                        }
                , selectOptionHeight = model.selectOptionHeight
                , maxDisplayCount = model.maxDisplayCount
                , leadingIcon = model.leadingIcon |> Maybe.map (toIconEl palette)
                , trailingIcon =
                    model.trailingIcon
                        |> Maybe.map (toIconEl palette)
                        |> Maybe.withDefault
                            (R10.Form.defaultTrailingIcon
                                { opened = model.singleModel.opened
                                , palette = palette
                                }
                            )
                        |> Just
                }
            ]
        ]
    , row
        [ spacing 20
        , width fill
        , centerX
        ]
        [ column
            (R10.Card.normal theme
                ++ [ padding 20
                   , spacing 5
                   , width fill
                   ]
            )
            [ column
                [ Font.family [ Font.monospace ]
                , spacing 5
                ]
                [ text "R10.Form.viewText [] []"
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
                    [ text "    , select = \""
                    , Input.text attrs
                        { label = Input.labelHidden ""
                        , onChange = SetValue
                        , placeholder = Nothing
                        , text = model.singleModel.select
                        }
                    , text "\""
                    ]
                , row []
                    [ text "    , search = \""
                    , Input.text attrs
                        { label = Input.labelHidden ""
                        , onChange = SetValue
                        , placeholder = Nothing
                        , text = model.singleModel.search
                        }
                    , text "\""
                    ]
                , row []
                    [ text "    , focused = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just RotateFocused
                        , label = text <| R10.Form.boolToString model.singleModel.focused
                        }
                    ]
                , row []
                    [ text "    , opened = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just RotateOpened
                        , label = text <| R10.Form.boolToString model.singleModel.opened
                        }
                    ]
                , row []
                    [ text "    , validation = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just RotateValidation
                        , label = text <| R10.Form.validationToString model.validation
                        }
                    ]
                , row []
                    [ text "    , disabled = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just ToggleDisabled
                        , label = text <| R10.Form.boolToString model.disabled
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
            (R10.Card.normal theme
                ++ [ padding 20
                   , spacing 5
                   , width fill
                   ]
            )
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
