module Pages.Form_FieldType_Text exposing
    ( Icon
    , Model
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
import R10.FormDebug
import R10.FormTypes
import R10.Paragraph
import R10.Svg.IconsExtra
import R10.Theme


type alias Model =
    { messages : List String
    , value : String
    , label : String
    , focused : Bool
    , showPassword : Bool
    , leadingIcon : Maybe Icon
    , trailingIcon : Maybe Icon
    , valid : Maybe Bool
    , helperText : String
    , helperShow : Bool
    , requiredText : String
    , requiredShow : Bool
    , disabled : Bool
    , style : R10.Form.Style
    , textType : R10.FormTypes.TypeText
    }


init : Model
init =
    { messages = []
    , value = ""
    , label = "Label"
    , focused = False
    , showPassword = False
    , leadingIcon = Nothing
    , trailingIcon = Nothing
    , valid = Nothing
    , helperText = """Helper text ([Markdown](https://en.wikipedia.org/wiki/Markdown))"""
    , helperShow = True
    , requiredText = "(Required)"
    , requiredShow = True
    , disabled = False
    , style = R10.Form.style.outlined
    , textType = R10.FormTypes.TextPasswordNew
    }


textTypeToString : R10.FormTypes.TypeText -> String
textTypeToString textType =
    .string (R10.FormDebug.textTypeMetaData textType)


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
    = OnChange String
    | OnFocus
    | OnLoseFocus
    | OnEnter
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


valids :
    { n1 : Maybe Bool
    , n2 : Maybe Bool
    , n3 : Maybe Bool
    }
valids =
    { n1 = Nothing
    , n2 = Just True
    , n3 = Just False
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

        OnEnter ->
            ( { model
                | messages = "OnEnter" :: model.messages
                , value =
                    model.value
                        ++ (if model.textType == R10.FormTypes.TextMultiline then
                                "\n"

                            else
                                ""
                           )
              }
            , Cmd.none
            )

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
                | valid =
                    if model.valid == valids.n1 then
                        valids.n2

                    else if model.valid == valids.n2 then
                        valids.n3

                    else
                        valids.n1
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
                nextIcon : Maybe Icon
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
                    .next (R10.FormDebug.textTypeMetaData model.textType)
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
        palette : R10.FormTypes.Palette
        palette =
            R10.Form.themeToPalette theme
    in
    [ R10.Paragraph.normal []
        [ text "Input field of type "
        , el [ Font.bold ] <| text "Text"
        , text " includes these sub-types:"
        ]
    , column [ spacing 5, paddingEach { top = 0, right = 0, bottom = 0, left = 20 } ]
        [ paragraph [] [ text "◆ Plain" ]
        , paragraph [] [ text "◆ Password New" ]
        , paragraph [] [ text "◆ Password Current" ]
        , paragraph [] [ text "◆ Email" ]
        , paragraph [] [ text "◆ Username" ]
        , paragraph [] [ text "◆ Multiline" ]
        , paragraph [] [ text "◆ With Pattern" ]
        ]
    , R10.Paragraph.normal []
        [ text "Here you can simulate all the possible states of the component "
        , el [ Font.bold ] <| text "R10.Form.viewText"
        , text ". You can click on all "
        , el [ attrYellowBackground, padding 4 ] <| text "yellow areas"
        , text " below to change the state in real time. The messages on the right are all the messages that are fired by the component.\n"
        ]
    , R10.Paragraph.small []
        [ text "Note: Usually you don't need to call "
        , el [ Font.bold ] <| text "R10.Form.viewText"
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
        R10.Form.viewText
            [ spacing 10 ]
            []
            -- Stuff that usually doesn't change
            -- during the life of the component
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
            , style = model.style
            , palette = palette

            -- Stuff that usually change
            -- during the life of the component
            --
            , value = model.value
            , focused = model.focused
            , valid = model.valid
            , disabled = model.disabled
            , showPassword = model.showPassword
            , leadingIcon = Maybe.map (toIconEl theme palette) model.leadingIcon
            , trailingIcon = Maybe.map (toIconEl theme palette) model.trailingIcon

            -- Messages
            --
            , msgOnChange = OnChange
            , msgOnFocus = OnFocus
            , msgOnLoseFocus = Just OnLoseFocus
            , msgOnTogglePasswordShow = Just ToggleShowPassword
            , msgOnEnter = Just OnEnter
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
                [ text "R10.Form.viewText :"
                , text "    List (Attribute msg)"
                , text "    -> List (Attribute msg)"
                , text "    -> R10.Form.ArgsText msg"
                , text "    -> Element msg"
                , text "R10.Form.viewText [] []"
                , text " "
                , text "    -- Stuff that usually doesn't change"
                , text "    -- during the life of the component"
                , text " "
                , rowLabel model
                , rowHelperText model
                , rowRequiredLabel model
                , rowTextType model
                , rowStyle model
                , text "    , idDom = Nothing"
                , text "    , palette = palette"
                , text " "
                , text "    -- Stuff that usually change"
                , text "    -- during the life of the component"
                , text " "
                , rowValue model
                , rowFocused model
                , rowValidation model
                , rowDisable model
                , rowShowPassword model
                , rowLeadingIcon model
                , rowTrailingIcon model
                , text " "
                , text "    -- Messages"
                , text " "
                , text "    , msgOnChange = msgOnChange"
                , text "    , msgOnFocus = msgOnFocus"
                , text "    , msgOnLoseFocus = msgOnLoseFocus"
                , text "    , msgOnTogglePasswordShow = msgOnTogglePasswordShow"
                , text "    , msgOnEnter = msgOnEnter"
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


rowLabel : { a | label : String } -> Element Msg
rowLabel model =
    row []
        [ text "    { label = \""
        , Input.text attrsYellowBackground
            { label = Input.labelHidden ""
            , onChange = ChangeLabel
            , placeholder = Nothing
            , text = model.label
            }
        , text "\""
        ]


rowHelperText : { a | helperShow : Bool, helperText : String } -> Element Msg
rowHelperText model =
    row []
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


rowRequiredLabel : { a | requiredShow : Bool, requiredText : String } -> Element Msg
rowRequiredLabel model =
    row []
        [ text "    , requiredLabel = "
        , Input.button [ attrYellowBackground ]
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
                , Input.text attrsYellowBackground
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


rowTextType : { a | textType : R10.FormTypes.TypeText } -> Element Msg
rowTextType model =
    row []
        [ text "    , textType = "
        , Input.button [ attrYellowBackground ]
            { onPress = Just RotateTextType
            , label = text <| textTypeToString model.textType
            }
        ]


rowStyle : { a | style : R10.Form.Style } -> Element Msg
rowStyle model =
    row []
        [ text "    , style = "
        , Input.button [ attrYellowBackground ]
            { onPress = Just RotateStyle
            , label = text <| styleToString model.style
            }
        ]


rowValue : { a | value : String } -> Element Msg
rowValue model =
    row []
        [ text "    , value = \""
        , Input.text attrsYellowBackground
            { label = Input.labelHidden ""
            , onChange = OnChange
            , placeholder = Nothing
            , text = model.value
            }
        , text "\""
        ]


rowFocused : { a | focused : Bool } -> Element Msg
rowFocused model =
    row []
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


maybeBoolToString : Maybe Bool -> String
maybeBoolToString valid =
    case valid of
        Just bool ->
            if bool then
                "Just True"

            else
                "Just False"

        Nothing ->
            "Nothing"


rowValidation : { a | valid : Maybe Bool } -> Element Msg
rowValidation model =
    row []
        [ text "    , valid = "
        , Input.button [ attrYellowBackground ]
            { onPress = Just RotateValidation
            , label = text <| maybeBoolToString model.valid
            }
        ]


rowDisable : { a | disabled : Bool } -> Element Msg
rowDisable model =
    row []
        [ text "    , disabled = "
        , Input.button [ attrYellowBackground ]
            { onPress = Just ToggleDisabled
            , label = text <| R10.Form.boolToString model.disabled
            }
        ]


rowShowPassword : { a | showPassword : Bool } -> Element Msg
rowShowPassword model =
    row []
        [ text "    , showPassword = "
        , Input.button [ attrYellowBackground ]
            { onPress = Just ToggleShowPassword
            , label = text <| R10.Form.boolToString model.showPassword
            }
        ]


rowLeadingIcon : { a | leadingIcon : Maybe Icon } -> Element Msg
rowLeadingIcon model =
    row []
        [ text "    , leadingIcon = "
        , Input.button [ attrYellowBackground ]
            { onPress = Just RotateLeadingIcon
            , label = text <| iconToString model.leadingIcon
            }
        ]


rowTrailingIcon : { a | trailingIcon : Maybe Icon } -> Element Msg
rowTrailingIcon model =
    row []
        [ text "    , trailingIcon = "
        , Input.button [ attrYellowBackground ]
            { onPress = Just RotateTrailingIcon
            , label = text <| iconToString model.trailingIcon
            }
        ]
