module Pages.Form_FieldType_Binary exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import R10.Card
import R10.Color.AttrsBackground
import R10.Color.Svg
import R10.Form
import R10.FormComponents.Internal.Validations
import R10.FormIntrospection
import R10.FormTypes
import R10.Paragraph
import R10.Svg.IconsExtra
import R10.Theme


type alias Model =
    { messages : List String
    , value : Bool
    , label : String
    , focused : Bool
    , showPassword : Bool
    , leadingIcon : Maybe Icon
    , trailingIcon : Maybe Icon
    , validation : R10.Form.Validation2
    , helperText : String
    , helperShow : Bool
    , requiredText : String
    , requiredShow : Bool
    , disabled : Bool
    , style : R10.Form.Style
    , binaryType : R10.FormTypes.TypeBinary
    }


init : Model
init =
    { messages = []
    , value = False
    , label = "Label"
    , focused = False
    , showPassword = False
    , leadingIcon = Nothing
    , trailingIcon = Nothing
    , validation = R10.FormComponents.Internal.Validations.NotYetValidated
    , helperText = """Helper text ([Markdown](https://en.wikipedia.org/wiki/Markdown))"""
    , helperShow = True
    , requiredText = "(Required)"
    , requiredShow = True
    , disabled = False
    , style = R10.Form.style.outlined
    , binaryType = R10.FormTypes.BinarySwitch
    }


binaryTypeToString : R10.FormTypes.TypeBinary -> String
binaryTypeToString textType =
    .string (R10.FormIntrospection.binaryTypeMetaData textType)


styleToString : R10.Form.Style -> String
styleToString style =
    if style == R10.Form.style.outlined then
        "R10.Form.style.outlined"

    else
        "R10.Form.style.filled"


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


toIconEl : R10.Theme.Theme -> R10.FormTypes.Palette -> Icon -> Element Msg
toIconEl theme palette leadingIcon =
    case leadingIcon of
        Play ->
            R10.Form.viewIconButton []
                { msgOnClick = Just <| PlayPauseClick Play
                , icon = R10.Svg.IconsExtra.play [] (R10.Color.Svg.fontNormal theme) 24
                , palette = palette
                , size = 24
                }

        Pause ->
            R10.Form.viewIconButton []
                { msgOnClick = Just <| PlayPauseClick Pause
                , icon = R10.Svg.IconsExtra.pause [] (R10.Color.Svg.fontNormal theme) 30
                , palette = palette
                , size = 30
                }


type Msg
    = OnChange Bool
    | OnFocus
    | OnLoseFocus
    | OnClick
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
    | RotateStyle
    | RotateLeadingIcon
    | RotateTrailingIcon
    | PlayPauseClick Icon


validations :
    { n1 : R10.Form.Validation2
    , n2 : R10.Form.Validation2
    , n3 : R10.Form.Validation2
    , n4 : R10.Form.Validation2
    }
validations =
    { n1 = R10.FormComponents.Internal.Validations.NotYetValidated
    , n2 = R10.FormComponents.Internal.Validations.Validated []
    , n3 = R10.FormComponents.Internal.Validations.Validated [ R10.FormComponents.Internal.Validations.MessageOk "Yeah!" ]
    , n4 = R10.FormComponents.Internal.Validations.Validated [ R10.FormComponents.Internal.Validations.MessageOk "Yeah!", R10.FormComponents.Internal.Validations.MessageErr "Nope" ]
    }


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        OnChange bool ->
            ( { model | messages = ("OnChange \"" ++ R10.Form.boolToString bool ++ "\"") :: model.messages, value = bool }, Cmd.none )

        OnFocus ->
            ( { model | messages = "OnFocus" :: model.messages, focused = True }, Cmd.none )

        OnLoseFocus ->
            ( { model | messages = "OnLoseFocus" :: model.messages, focused = False }, Cmd.none )

        OnClick ->
            ( { model | messages = "OnClick" :: model.messages, value = not model.value }, Cmd.none )

        ChangeLabel string ->
            ( { model | label = string }, Cmd.none )

        RotateStyle ->
            ( { model
                | style =
                    if model.style == R10.Form.style.outlined then
                        R10.Form.style.filled

                    else
                        R10.Form.style.outlined
              }
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
                | binaryType =
                    .next (R10.FormIntrospection.binaryTypeMetaData model.binaryType)
              }
            , Cmd.none
            )


attrYellowBackground : Attr decorative msg
attrYellowBackground =
    Background.color <| rgba 0.9 1 0.2 0.7


attrsYellowBackground : List (Attribute msg)
attrsYellowBackground =
    [ padding 0
    , Border.width 0
    , attrYellowBackground
    ]


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
    let
        palette =
            R10.Form.themeToPalette theme
    in
    [ R10.Paragraph.normal []
        [ text "Input field of type "
        , el [ Font.bold ] <| text "Binary"
        , text " includes these sub-types:"
        ]
    , column [ spacing 5, paddingEach { top = 0, right = 0, bottom = 0, left = 20 } ]
        [ paragraph [] [ text "◆ Checkbox" ]
        , paragraph [] [ text "◆ Switch" ]
        ]
    , R10.Paragraph.normal []
        [ text "Here you can simulate all the possible states of the component "
        , el [ Font.bold ] <| text "R10.Form.viewBinary"
        , text ". You can click on all "
        , el [ attrYellowBackground, padding 4 ] <| text "yellow areas"
        , text " below to change the state in real time. The messages on the right are all the messages that are fired by the component.\n"
        ]
    , R10.Paragraph.small []
        [ text "Note: Usually you don't need to call "
        , el [ Font.bold ] <| text "R10.Form.viewBinary"
        , text " directly because it is going to be called by "
        , el [ Font.bold ] <| text "R10.Form.view"
        , text ". Only call this view for advanced usage of this library. This page is meant to be used to visually see all possible states on the Text Input field"
        ]
    , el
        (R10.Card.normal theme
            ++ [ R10.Color.AttrsBackground.surface2dp theme
               , width (fill |> maximum 500)
               , centerX
               ]
        )
      <|
        R10.Form.viewBinary
            [ spacing 10 ]
            --
            -- Stuff that usually doesn't change
            -- during the life of the component
            --
            { label = model.label
            , helperText =
                if model.helperShow then
                    Just model.helperText

                else
                    Nothing
            , typeBinary = model.binaryType
            , palette = palette

            -- Stuff that usually change
            -- during the life of the component
            --
            , value = model.value
            , focused = model.focused
            , validation = model.validation
            , disabled = model.disabled

            -- Messages
            --
            , msgOnChange = OnChange
            , msgOnFocus = OnFocus
            , msgOnLoseFocus = OnLoseFocus
            , msgOnClick = OnClick
            }
    , row
        [ spacing 20
        , width fill
        ]
        [ column [ spacing 10, width fill ]
            [ R10.Paragraph.small [ alpha 0.5 ] [ text "Elm code" ]
            , column
                (R10.Card.normal theme
                    ++ [ padding 20
                       , width fill
                       , R10.Color.AttrsBackground.surface2dp theme
                       , scrollbars
                       , height <| px 300
                       , Font.family [ Font.monospace ]
                       , Font.size 13
                       , spacing 5
                       ]
                )
                [ text "R10.Form.viewBinary :"
                , text "    List (Attribute msg)"
                , text "    -> R10.Form.ArgsBinary msg"
                , text "    -> Element msg"
                , text "R10.Form.viewBinary []"
                , text " "
                , text "    -- Stuff that usually doesn't change"
                , text "    -- during the life of the component"
                , text " "
                , row []
                    [ text "    { label = \""
                    , Input.text attrsYellowBackground
                        { label = Input.labelHidden ""
                        , onChange = ChangeLabel
                        , placeholder = Nothing
                        , text = model.label
                        }
                    , text "\""
                    ]
                , row []
                    [ text "    , helperText = "
                    , Input.button [ attrYellowBackground ]
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
                            , Input.text attrsYellowBackground
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
                    [ text "    , typeBinary = "
                    , Input.button [ attrYellowBackground ]
                        { onPress = Just RotateTextType
                        , label = text <| binaryTypeToString model.binaryType
                        }
                    ]
                , text "    , palette = palette"
                , text " "
                , text "    -- Stuff that usually change"
                , text "    -- during the life of the component"
                , text " "
                , row []
                    [ text "    , value = "
                    , Input.button [ attrYellowBackground ]
                        { onPress = Just OnClick
                        , label = text <| R10.Form.boolToString model.value
                        }
                    ]
                , row []
                    [ text "    , focused = "
                    , Input.button [ attrYellowBackground ]
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
                    , Input.button [ attrYellowBackground ]
                        { onPress = Just RotateValidation
                        , label = text <| R10.Form.validationToString model.validation
                        }
                    ]
                , row []
                    [ text "    , disabled = "
                    , Input.button [ attrYellowBackground ]
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
                , text "    , msgOnClick = msgOnClick"
                , text "    }"
                ]
            ]
        , column [ spacing 10, width fill ]
            [ R10.Paragraph.small [ alpha 0.5 ] [ text "Messages" ]
            , column
                (R10.Card.normal theme
                    ++ [ padding 20
                       , width fill
                       , R10.Color.AttrsBackground.surface2dp theme
                       , scrollbars
                       , height <| px 300
                       , Font.family [ Font.monospace ]
                       , Font.size 13
                       , spacing 5
                       ]
                )
              <|
                List.indexedMap (\index message -> text <| String.fromInt (List.length model.messages - index) ++ " " ++ message) model.messages
            ]
        ]
    ]
