module Pages.Form_Boilerplate exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Element exposing (..)
import Html.Attributes
import Markdown
import R10.Button
import R10.Form
import R10.FormTypes
import R10.Libu
import R10.Theme


type alias Model =
    { form : R10.Form.Form }


init : Model
init =
    { form =
        { conf =
            [ R10.Form.entity.field
                { id = "email"
                , idDom = Nothing
                , type_ = R10.FormTypes.inputField.textEmail
                , label = "Email"
                , helperText = Just "Helper text for Email"
                , requiredLabel = Just "(required)"
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = False
                        , hidePassedValidationStyle = False
                        , validationIcon = R10.FormTypes.NoIcon
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
                , type_ = R10.FormTypes.inputField.textPasswordNew
                , label = "Password"
                , helperText = Just "Helper text for Password"
                , requiredLabel = Just "(required)"
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = True
                        , hidePassedValidationStyle = False
                        , validationIcon = R10.FormTypes.NoIcon
                        , validation =
                            [ R10.Form.commonValidation.password
                            , R10.Form.validation.minLength 5
                            , R10.Form.validation.maxLength 50
                            , R10.Form.validation.required
                            ]
                        }
                }
            , R10.Form.entity.field
                { id = "password_repeat"
                , idDom = Nothing
                , type_ = R10.FormTypes.inputField.textPasswordNew
                , label = "Repeat Password"
                , helperText = Just "Helper text for Repeat  Password"
                , requiredLabel = Just "(required)"
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = True
                        , hidePassedValidationStyle = False
                        , validationIcon = R10.FormTypes.NoIcon
                        , validation =
                            [ R10.Form.commonValidation.password
                            , R10.Form.validation.minLength 5
                            , R10.Form.validation.maxLength 50
                            , R10.Form.validation.required
                            , R10.Form.validation.withMsg
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


type Msg
    = MsgForm R10.Form.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        MsgForm formMsg ->
            let
                form : R10.Form.Form
                form =
                    model.form

                ( newFormState_, _ ) =
                    R10.Form.update formMsg form.state
            in
            { model | form = { form | state = newFormState_ } }


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
    let
        viewForm : List (Element Msg)
        viewForm =
            R10.Form.viewWithPalette
                model.form
                MsgForm
                (R10.Form.themeToPalette theme)

        viewCTA : Element Msg
        viewCTA =
            Element.map MsgForm <|
                R10.Button.primary [ width shrink ]
                    { label = text "Submit"
                    , libu = R10.Libu.Bu <| Just <| R10.Form.msg.submit model.form.conf
                    , theme = theme
                    }
    in
    [ paragraph [] [ html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """
# Code

Code to generate a form with two input fields as shown at the end of the page.
Note that in this example both the _State_ and the _Configuration_ of the form are stored in the form. Unless you need to change the configuration during the life of the form (unlikely) or unless you receive the configuration from a server, you can store only the _State_ into the model and hard code the _Configuration_ somewhere else in your code.

Consider also that changing the configuration does not re-run all validations.

```
type alias Model =
    { form : R10.Form.Form }


init : a -> b -> ( Model, Cmd msg1, Cmd msg2 )
init _ _ =
    ( { form =
            { conf =
                [ R10.Form.entity.field
                    { id = "email"
                    , type_ = TypeText TextEmail
                    , label = "Email"
                    , helperText = Just "Helper text for Email"
                    , required = True
                    , minLength = Just 5
                    , maxLength = Just 50
                    , regexValidations = R10.Form.Validation.commonValidation.email
                    }
                , R10.Form.entity.field
                    { id = "password"
                    , type_ = R10.FormTypes.inputField.textPasswordNew
                    , label = "Password"
                    , helperText = Just "Helper text for Password"
                    , required = True
                    , minLength = Just 8
                    , maxLength = Just 128
                    , regexValidations = R10.Form.Validation.commonValidation.password
                    }
                ]
            , state = R10.Form.State.init
            }
      }
    , Cmd.none
    , Cmd.none
    )


type Msg
    = MsgForm R10.Form.Msg




save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model| theme = shared.theme },Cmd.none )
update: Spa.Types.PageContext Generated.Routes.Route GlobalModel.Model -> Msg -> Model -> ( Model, Cmd Msg, Cmd GlobalMsg.Msg )
update { global } msg model =
    case msg of
        MsgForm formMsg ->
            let
                form =
                    model.form
            in
            ( { model | form = { form | state = R10.Form.update formMsg form.state } }, Cmd.none, Cmd.none )


view : Spa.Types.PageContext Generated.Routes.Route GlobalModel.Model -> Model -> Element Msg
view { global } model =
    let
        viewForm =
            R10.Form.view
                model.form
                MsgForm
                R10.Form.Maker.maker

        viewCTA =
            Element.map MsgForm <|
                Input.button
                    R10.Button.cta
                    { label = text "Submit"
                    , onPress = Just <| R10.Form.Msg.Submit model.form.conf
                    }
    in
    column
        [ spacing 30
        , width (fill |> maximum 500)
        , centerX
        ]
        (viewForm ++ [ viewCTA ])
```

# Result
""" ]
    , column
        [ spacing 30
        , width (fill |> maximum 500)
        ]
        (viewForm ++ [ viewCTA ])
    ]
