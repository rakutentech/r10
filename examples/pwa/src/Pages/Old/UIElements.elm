module Pages.UIElements exposing (Model, Msg, Params, page)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input
import Html.Attributes
import R10.Button
import R10.Color.Primary
import R10.Form
import R10.Form.Conf exposing (Entity(..))
import R10.Form.FieldConf exposing (FieldType(..), TypeBinary(..))
import R10.Form.Helpers
import R10.Form.Msg
import R10.Form.State
import R10.Form.Update
import R10.FormComponents.Button
import R10.FormComponents.Style
import R10.Mode
import R10.Theme


type alias Params =
    ()


title : String
title =
    "UI Elements"


type alias Model =
    { formState : R10.Form.State.State
    , theme : R10.Theme.Theme
    }


type Msg
    = ChangeTheme R10.Form.Msg.Msg
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ChangeTheme formMsg ->
            case formMsg of
                R10.Form.Msg.ChangeValue _ _ _ newVal ->
                    let
                        ( newFormState_, _ ) =
                            R10.Form.Update.update formMsg model.formState
                    in
                    ( { model
                        | formState = newFormState_
                        , theme =
                            let
                                theme =
                                    model.theme
                            in
                            case newVal |> R10.Form.Helpers.stringToBool of
                                True ->
                                    { theme | mode = R10.Mode.Dark }

                                False ->
                                    { theme | mode = R10.Mode.Light }
                      }
                    , Cmd.none
                    )

                _ ->
                    let
                        ( newFormState_, formCmd ) =
                            R10.Form.Update.update formMsg model.formState
                    in
                    ( { model | formState = newFormState_ }
                    , Cmd.map ChangeTheme formCmd
                    )


init : Model
init =
    { formState = R10.Form.State.init
    , theme =
        R10.Theme.fromFlags
            { mode = R10.Mode.Light
            , primaryColor = R10.Color.Primary.Green
            }
    }


colorChip :
    { backgroundColor : Element.Color, fontColor : Element.Color, colorName : String }
    -> Element msg
colorChip { backgroundColor, fontColor, colorName } =
    row [ paddingXY 16 12, width fill, height <| px 64, spacing 8 ]
        [ el [ Font.color fontColor, width fill ] <| text colorName
        , el
            [ Background.color backgroundColor
            , width fill
            , height fill
            , Border.width 1
            ]
            none
        ]


themeCard : { theme : R10.Theme.Theme, name : String } -> Element msg
themeCard { theme, name } =
    let
        default =
            { backgroundColor = R10.Color.background theme
            , fontColor = R10.Color.onSurface theme
            , colorName = ""
            }

        colors =
            [ { default | backgroundColor = R10.Color.primary theme, colorName = "primary" }
            , { default | backgroundColor = R10.Color.primaryVariant theme, colorName = "primaryVariant" }
            , { default | backgroundColor = R10.Color.surface theme, colorName = "surface" }
            , { default | backgroundColor = R10.Color.background theme, colorName = "background" }
            , { default | backgroundColor = R10.Color.onSurface theme, colorName = "onSurface" }
            , { default | backgroundColor = R10.Color.onPrimary theme, colorName = "onPrimary" }
            ]
    in
    column
        (R10.Card.normal theme ++ [ spacing 8 ])
    <|
        (el (R10.Attrs.secondaryTitle theme) <| text name)
            :: (colors |> List.map colorChip)


themesCard : R10.Color.Theme.Theme -> List (Element msg)
themesCard theme =
    let
        themes =
            [ { theme = R10.Color.Theme.DarkTheme, name = "Dark theme" }
            , { theme = R10.Color.Theme.LightTheme, name = "Light theme" }
            ]
    in
    [ el (R10.Attrs.secondaryTitle theme) <| text "Theme colors"
    , row [ R10.Spacing.normal, width fill ] (List.map themeCard themes)
    ]


fieldConfInit : R10.Form.FieldConf.FieldConf
fieldConfInit =
    R10.Form.FieldConf.init


view : Model -> Element Msg
view model =
    let
        -- TODO
        iconColor =
            Color.rgb 0 1 1
    in
    column [ width fill ]
        [ el [] <| text title
        , column
            [ R10.Spacing.large
            , width fill
            ]
          <|
            [ el (R10.Attrs.secondaryTitle model.theme) <| text "Theme"
            , wrappedRow
                (R10.Card.normal model.theme
                    ++ [ R10.Padding.large
                       , R10.Spacing.small
                       ]
                )
              <|
                R10.Form.viewWithPalette
                    { conf = [ EntityField { fieldConfInit | type_ = TypeBinary BinarySwitch, label = "Enable dark mode" } ]
                    , state = model.formState
                    }
                    ChangeTheme
                    (Pages.Shared.Utils.toFormPalette model.theme)
            , el (R10.Attrs.secondaryTitle model.theme) <| text "Icons"
            , wrappedRow (R10.Card.normal model.theme ++ [ R10.Padding.large, R10.Spacing.small ])
                [ el [ htmlAttribute <| Html.Attributes.title "grid" ] <| html <| R10.Icon.grid iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "notice_generic_l_" ] <| html <| R10.Icon.notice_generic_l_ iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "search_" ] <| html <| R10.Icon.search_ iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "play" ] <| html <| R10.Icon.play iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "pause" ] <| html <| R10.Icon.pause iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "close" ] <| html <| R10.Icon.close iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "love" ] <| html <| R10.Icon.love iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "respect" ] <| html <| R10.Icon.respect iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "organize" ] <| html <| R10.Icon.organize iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "customSupport" ] <| html <| R10.Icon.customSupport iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "card" ] <| html <| R10.Icon.card iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "highFive" ] <| html <| R10.Icon.highFive iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "moon" ] <| html <| R10.Icon.moon iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "paperPlane" ] <| html <| R10.Icon.paperPlane iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "internet" ] <| html <| R10.Icon.internet iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "email" ] <| html <| R10.Icon.email iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "waveHand" ] <| html <| R10.Icon.waveHand iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "training" ] <| html <| R10.Icon.training iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "startup" ] <| html <| R10.Icon.startup iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "fireworks" ] <| html <| R10.Icon.fireworks iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "alarmClock" ] <| html <| R10.Icon.alarmClock iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "conversation" ] <| html <| R10.Icon.conversation iconColor 30
                , el [ htmlAttribute <| Html.Attributes.title "sun" ] <| html <| R10.Icon.sun iconColor 30
                ]
            , el (R10.Attrs.secondaryTitle model.theme) <| text "Buttons"
            , row
                (R10.Card.normal model.theme ++ [ R10.Padding.large, R10.Spacing.normal ])
                [ Element.Input.button
                    (R10.Button.filled model.theme)
                    { onPress = Nothing, label = text "Button" }
                , Element.Input.button
                    (R10.Button.outlined model.theme)
                    { onPress = Nothing, label = text "Button" }
                ]
            , let
                attrs =
                    { type_ = R10.FormComponents.Button.Contained

                    --, icon = Just <| el [ Border.width 1, Border.rounded 20, width <| px 24, height <| px 24 ] none
                    , icon = Just <| html <| R10.Icon.play "black" 24
                    , text = "Text"
                    , onClick = NoOp
                    , palette = Pages.Shared.Utils.toFormPalette model.theme
                    , style = R10.FormComponents.Style.Outlined
                    , disabled = False
                    }
              in
              column
                (R10.Card.normal model.theme ++ [ R10.Padding.large, R10.Spacing.normal ])
                [ row [ spacing 8 ]
                    [ R10.FormComponents.Button.view []
                        { attrs | type_ = R10.FormComponents.Button.Contained }
                    , R10.FormComponents.Button.view []
                        { attrs | type_ = R10.FormComponents.Button.Outlined }
                    , R10.FormComponents.Button.view []
                        { attrs | type_ = R10.FormComponents.Button.Text }
                    , R10.FormComponents.Button.view []
                        { attrs | type_ = R10.FormComponents.Button.Icon }
                    ]
                , row [ spacing 8 ]
                    [ R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Contained
                            , style = R10.FormComponents.Style.Filled
                        }
                    , R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Outlined
                            , style = R10.FormComponents.Style.Filled
                        }
                    , R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Text
                            , style = R10.FormComponents.Style.Filled
                        }
                    , R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Icon
                            , style = R10.FormComponents.Style.Filled
                        }
                    , text "with style R10.FormComponents.Style.Filled"
                    ]
                , row [ spacing 8 ]
                    [ R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Contained
                            , disabled = True
                        }
                    , R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Outlined
                            , disabled = True
                        }
                    , R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Text
                            , disabled = True
                        }
                    , R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Icon
                            , disabled = True
                        }
                    , text "disabled"
                    ]
                , row [ spacing 8 ]
                    [ R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Contained
                            , icon = Nothing
                        }
                    , R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Outlined
                            , icon = Nothing
                        }
                    , R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Text
                            , icon = Nothing
                        }
                    , R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Icon
                            , icon = Nothing
                        }
                    , text "without icon"
                    ]
                , row [ spacing 8 ]
                    [ R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Contained
                            , text = ""
                        }
                    , R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Outlined
                            , text = ""
                        }
                    , R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Text
                            , text = ""
                        }
                    , R10.FormComponents.Button.view []
                        { attrs
                            | type_ = R10.FormComponents.Button.Icon
                            , text = ""
                        }
                    , text "without text"
                    ]
                ]
            , el (R10.Attrs.secondaryTitle model.theme) <| text "Typography"
            , column
                (R10.Card.normal model.theme ++ [ R10.Padding.large, R10.Spacing.normal ])
                [ el (R10.Attrs.appName model.theme ++ [ Background.color <| R10.Color.primary model.theme, Font.color <| R10.Color.onPrimary model.theme, R10.Padding.normal ]) <| text "Application Name"
                , el (R10.Attrs.headerMenu model.theme ++ [ Background.color <| R10.Color.primary model.theme, Font.color <| R10.Color.onPrimary model.theme, R10.Padding.normal ]) <| text "Header menu"
                , el [] <| text "Title"
                , el (R10.Attrs.secondaryTitle model.theme) <| text "Sub Title"
                , el [] <| text "Normal"
                ]
            , el (R10.Attrs.secondaryTitle model.theme) <| text "Font Sizes"
            , column
                (R10.Card.normal model.theme ++ [ R10.Padding.large, R10.Spacing.normal ])
                [ el [ R10.Font.xxxLarge ] <| text "XXX Large"
                , el [ R10.Font.xxLarge ] <| text "XX Large"
                , el [ R10.Font.xLarge ] <| text "X Large"
                , el [ R10.Font.large ] <| text "Large"
                , el [ R10.Font.medium ] <| text "Medium"
                , el [ R10.Font.small ] <| text "Small"
                , el [ R10.Font.xSmall ] <| text "X Small"
                , el [ R10.Font.xxSmall ] <| text "XX Small"
                ]
            ]
                ++ themesCard model.theme
        ]
