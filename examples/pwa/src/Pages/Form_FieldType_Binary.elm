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
import R10.Form
import R10.FormIntrospection
import R10.FormTypes
import R10.Paragraph
import R10.Theme


type alias Model =
    { messages : List String
    , value : Bool
    , label : String
    , focused : Bool
    , showPassword : Bool
    , valid : Maybe Bool
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
    , valid = Nothing
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


type Msg
    = OnChange Bool
    | OnFocus
    | OnLoseFocus
    | OnClick
      --
    | ChangeLabel String
    | RotateValidation
    | ToggleHelperShow
    | ToggleDisabled
    | ChangeHelperText String
    | RotateTextType


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

        ToggleDisabled ->
            ( { model | disabled = not model.disabled }, Cmd.none )

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


maybeBoolToString : Maybe Bool -> String
maybeBoolToString validation =
    case validation of
        Just bool ->
            if bool then
                "Just True"

            else
                "Just False"

        Nothing ->
            "Nothing"


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
    let
        palette : R10.FormTypes.Palette
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
            , valid = model.valid
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
                        , label = text <| maybeBoolToString model.valid
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
