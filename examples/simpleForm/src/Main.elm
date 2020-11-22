module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Font as Font
import Html
import R10.Button
import R10.Card
import R10.Color
import R10.Color.AttrsBackground
import R10.Color.Svg
import R10.FontSize
import R10.Form
import R10.Language
import R10.Libu
import R10.Mode
import R10.Paragraph
import R10.Svg.Logos
import R10.Svg.LogosExtra
import R10.Theme


theme : R10.Theme.Theme
theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.primary.blueSky
    }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { form : R10.Form.Form }


type Msg
    = MsgForm R10.Form.Msg


init : Model
init =
    { form =
        { conf =
            [ R10.Form.entity.field
                { id = "email"
                , idDom = Nothing
                , type_ = R10.Form.fieldType.text R10.Form.text.email
                , label = "Email"
                , helperText = Just "Helper text for Email"
                , requiredLabel = Just "(required)"
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = False
                        , hidePassedValidationStyle = False
                        , validationIcon = R10.Form.validationIcon.noIcon
                        , validation =
                            [ R10.Form.commonValidation.email
                            , R10.Form.validation.minLength 5
                            , R10.Form.validation.maxLength 50
                            , R10.Form.validation.required
                            ]
                        }
                }
            , R10.Form.entity.field
                { id = "password"
                , idDom = Nothing
                , type_ = R10.Form.fieldType.text R10.Form.text.passwordNew
                , label = "Password"
                , helperText = Just "Helper text for Password"
                , requiredLabel = Just "(required)"
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = True
                        , hidePassedValidationStyle = False
                        , validationIcon = R10.Form.validationIcon.noIcon
                        , validation =
                            [ R10.Form.commonValidation.password
                            , R10.Form.validation.minLength 8
                            , R10.Form.validation.required
                            ]
                        }
                }
            , R10.Form.entity.field
                { id = "password_repeat"
                , idDom = Nothing
                , type_ = R10.Form.fieldType.text R10.Form.text.passwordNew
                , label = "Repeat Password"
                , helperText = Just "Helper text for Repeat  Password"
                , requiredLabel = Just "(required)"
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = True
                        , hidePassedValidationStyle = False
                        , validationIcon = R10.Form.validationIcon.noIcon
                        , validation =
                            [ R10.Form.validation.withMsg
                                { ok = "Passwords are the same"
                                , err = "Passwords are not the same"
                                }
                              <|
                                R10.Form.validation.dependant "password" (R10.Form.validation.equal "password_repeat")
                            ]
                        }
                }
            ]
        , state = R10.Form.initState
        }
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        MsgForm msgForm ->
            let
                form : R10.Form.Form
                form =
                    model.form

                newForm : R10.Form.Form
                newForm =
                    { form
                        | state =
                            form.state
                                |> R10.Form.update msgForm
                                |> Tuple.first
                    }
            in
            { model | form = newForm }


view : Model -> Html.Html Msg
view model =
    layoutWith
        { options =
            [ focusStyle
                { borderColor = Nothing
                , backgroundColor = Nothing
                , shadow = Nothing
                }
            ]
        }
        [ R10.Color.AttrsBackground.underModal theme, padding 20, R10.FontSize.normal ]
        (column
            (R10.Card.high theme
                ++ [ centerX
                   , centerY
                   , width (fill |> maximum 360)
                   , height shrink
                   , spacing 30
                   ]
            )
            [ R10.Svg.LogosExtra.r10 [ centerX ] (R10.Color.Svg.logo theme) 32
            , R10.Paragraph.normalMarkdown [ Font.center ] theme "This is an example of a form made with [Elm](https://elm-lang.org/), [elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) and [R10](https://package.elm-lang.org/packages/rakutentech/r10/latest/) ([Source code](https://github.com/rakutentech/r10/blob/master/examples/simpleForm/src/Main.elm))."
            , column [ spacing 20 ] <| R10.Form.viewWithTheme model.form MsgForm theme
            , Element.map MsgForm <|
                R10.Button.primary []
                    { label = text "Sign In"
                    , libu = R10.Libu.Bu <| Just <| R10.Form.msg.submit model.form.conf
                    , theme = theme
                    }
            ]
        )
