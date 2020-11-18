module Pages.UIFormComponentsText exposing
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
import R10.Form
import R10.FormComponents.IconButton
import R10.FormComponents.Style
import R10.FormComponents.Text
import R10.FormComponents.UI.Color
import R10.FormComponents.UI.Palette
import R10.FormComponents.Validations
import R10.Language
import R10.Svg.IconsExtra


title : R10.Language.Translations
title =
    { key = "title"
    , en_us = "Forms - Text"
    , ja_jp = "Forms - Text"
    , zh_tw = "Forms - Text"
    , es_es = "Forms - Text"
    , fr_fr = "Forms - Text"
    , de_de = "Forms - Text"
    , it_it = "Forms - Text"
    , nl_nl = "Forms - Text"
    , pt_pt = "Forms - Text"
    , nb_no = "Forms - Text"
    , fi_fl = "Forms - Text"
    , da_dk = "Forms - Text"
    , sv_se = "Forms - Text"
    }


type alias Model =
    { messages : List String
    , value : String
    , label : String
    , focused : Bool
    , showPassword : Bool
    , leadingIcon : Maybe Icon
    , trailingIcon : Maybe Icon
    , validation : R10.FormComponents.Validations.Validation
    , helperText : String
    , helperShow : Bool
    , requiredText : String
    , requiredShow : Bool
    , disabled : Bool
    , textType : R10.FormComponents.Text.TextType
    }


textTypeToString : R10.FormComponents.Text.TextType -> String
textTypeToString textType =
    case textType of
        R10.FormComponents.Text.TextPasswordNew ->
            "TextPasswordNew"

        R10.FormComponents.Text.TextPasswordCurrent ->
            "TextPasswordCurrent"

        R10.FormComponents.Text.TextPlain ->
            "TextPlain"

        R10.FormComponents.Text.TextEmail ->
            "TextEmail"

        R10.FormComponents.Text.TextUsername ->
            "TextUsername"

        R10.FormComponents.Text.TextMultiline ->
            "TextMultiline"

        R10.FormComponents.Text.TextWithPattern pattern ->
            "TextWithPattern:" ++ pattern


iconToString : Maybe Icon -> String
iconToString icon =
    case icon of
        Just Play ->
            "Just Play"

        Just Pause ->
            "Just Pause"

        Nothing ->
            "Nothing"


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
    { messages = []
    , value = ""
    , label = "Label"
    , focused = False
    , helperShow = True
    , helperText = """Helper text ([Markdown](https://en.wikipedia.org/wiki/Markdown))"""
    , requiredShow = True
    , requiredText = "required_text"
    , disabled = False
    , showPassword = False
    , leadingIcon = Just Play
    , trailingIcon = Nothing
    , textType = R10.FormComponents.Text.TextPasswordNew
    , validation = R10.FormComponents.Validations.NotYetValidated
    }


type Msg
    = OnChange String
    | OnFocus
    | OnLoseFocus
      --
    | ChangeLabel String
    | RotateValidation
    | ToggleHelperShow
    | ToggleRequiredShow
    | ChangeRequiredText String
    | ToggleDisabled
    | ToggleShowPassword
    | ChangeHelperText String
    | RotateTextType
    | RotateLeadingIcon
    | RotateTrailingIcon
    | PlayPauseClick Icon


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


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        OnChange string ->
            ( { model | messages = ("OnChange \"" ++ string ++ "\"") :: model.messages, value = string }, Cmd.none )

        OnFocus ->
            ( { model | messages = "OnFocus" :: model.messages, focused = True }, Cmd.none )

        OnLoseFocus ->
            ( { model | messages = "OnLoseFocus" :: model.messages, focused = False }, Cmd.none )

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

        ToggleShowPassword ->
            ( { model | messages = "OnTogglePasswordShow" :: model.messages, showPassword = not model.showPassword }, Cmd.none )

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

        RotateTextType ->
            ( { model
                | textType =
                    case model.textType of
                        R10.FormComponents.Text.TextPasswordNew ->
                            R10.FormComponents.Text.TextPasswordCurrent

                        R10.FormComponents.Text.TextPasswordCurrent ->
                            R10.FormComponents.Text.TextEmail

                        R10.FormComponents.Text.TextEmail ->
                            R10.FormComponents.Text.TextPlain

                        R10.FormComponents.Text.TextPlain ->
                            R10.FormComponents.Text.TextUsername

                        R10.FormComponents.Text.TextUsername ->
                            R10.FormComponents.Text.TextMultiline

                        R10.FormComponents.Text.TextMultiline ->
                            R10.FormComponents.Text.TextPasswordNew

                        R10.FormComponents.Text.TextWithPattern pattern ->
                            R10.FormComponents.Text.TextWithPattern pattern
              }
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
            [ height
                (fill
                    |> minimum 200
                )
            , spacing 30
            ]
            [ R10.FormComponents.Text.view
                [ width (fill |> maximum 600)
                , centerY
                ]
                []
                -- Stuff that doesn't change during
                -- the life of the component
                --
                { label = model.label
                , helperText =
                    if model.helperShow then
                        Just model.helperText

                    else
                        Nothing
                , requiredLabel =
                    if model.requiredShow then
                        Just model.requiredText

                    else
                        Nothing
                , textType = model.textType
                , idDom = Nothing
                , style = R10.FormComponents.Style.Outlined
                , palette = palette

                -- Stuff that change during
                -- the life of the component
                --
                , value = model.value
                , focused = model.focused
                , validation = model.validation
                , disabled = model.disabled
                , showPassword = model.showPassword
                , leadingIcon = Maybe.map (toIconEl palette) model.leadingIcon
                , trailingIcon = Maybe.map (toIconEl palette) model.trailingIcon

                -- Messages
                --
                , msgOnChange = OnChange
                , msgOnFocus = OnFocus
                , msgOnLoseFocus = Just OnLoseFocus
                , msgOnTogglePasswordShow = Just ToggleShowPassword
                , msgOnEnter = Nothing
                }
            , R10.FormComponents.Text.view
                [ width (fill |> maximum 600)
                , centerY
                ]
                []
                -- Stuff that doesn't change during
                -- the life of the component
                --
                { label = model.label
                , helperText =
                    if model.helperShow then
                        Just model.helperText

                    else
                        Nothing
                , requiredLabel =
                    if model.requiredShow then
                        Just model.requiredText

                    else
                        Nothing
                , textType = model.textType
                , idDom = Nothing
                , style = R10.FormComponents.Style.Filled
                , palette = palette

                -- Stuff that change during
                -- the life of the component
                --
                , value = model.value
                , focused = model.focused
                , validation = model.validation
                , disabled = model.disabled
                , showPassword = model.showPassword
                , leadingIcon = Maybe.map (toIconEl palette) model.leadingIcon
                , trailingIcon = Maybe.map (toIconEl palette) model.trailingIcon

                -- Messages
                --
                , msgOnChange = OnChange
                , msgOnFocus = OnFocus
                , msgOnLoseFocus = Just OnLoseFocus
                , msgOnTogglePasswordShow = Just ToggleShowPassword
                , msgOnEnter = Nothing
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
                    [ text "    , textType = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just RotateTextType
                        , label = text <| textTypeToString model.textType
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
                        , onChange = OnChange
                        , placeholder = Nothing
                        , text = model.value
                        }
                    , text "\""
                    ]
                , row []
                    [ text "    , focused = "
                    , Input.button [ backgroundColor ]
                        { onPress =
                            Just <|
                                if model.focused then
                                    OnLoseFocus

                                else
                                    OnFocus
                        , label = text <| R10.Form.boolToString model.focused
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
                        , label = text <| R10.Form.boolToString model.disabled
                        }
                    ]
                , row []
                    [ text "    , showPassword = "
                    , Input.button [ backgroundColor ]
                        { onPress = Just ToggleShowPassword
                        , label = text <| R10.Form.boolToString model.showPassword
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
            , alignTop
            , spacing 30
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
