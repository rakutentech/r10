module Pages.UIFormBoilerplate exposing
    ( Model
    , Msg
    , init
    , title
    , update
    , view
    )

import Element exposing (..)
import Html.Attributes
import Markdown
import Pages.Shared.Utils
import R10.Button
import R10.Color.Primary
import R10.Form
import R10.Form.Conf exposing (..)
import R10.Form.FieldConf exposing (..)
import R10.Form.Msg
import R10.Form.State
import R10.Form.Update
import R10.Form.Validation
import R10.Language
import R10.Libu
import R10.Mode
import R10.Theme


title : R10.Language.Translations
title =
    { key = "title"
    , en_us = "Forms - Boilerplate"
    , ja_jp = "Forms - Boilerplate"
    , zh_tw = "Forms - Boilerplate"
    , es_es = "Forms - Boilerplate"
    , fr_fr = "Forms - Boilerplate"
    , de_de = "Forms - Boilerplate"
    , it_it = "Forms - Boilerplate"
    , nl_nl = "Forms - Boilerplate"
    , pt_pt = "Forms - Boilerplate"
    , nb_no = "Forms - Boilerplate"
    , fi_fl = "Forms - Boilerplate"
    , da_dk = "Forms - Boilerplate"
    , sv_se = "Forms - Boilerplate"
    }


theme : R10.Theme.Theme
theme =
    R10.Theme.fromFlags
        { mode = R10.Mode.Light
        , primaryColor = R10.Color.Primary.Green
        }


type alias Model =
    { form : R10.Form.Model }


init : Model
init =
    { form =
        { conf =
            [ EntityField
                { id = "email"
                , idDom = Nothing
                , type_ = TypeText TextEmail
                , label = "Email"
                , helperText = Just "Helper text for Email"
                , requiredLabel = Just "(required)"
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = False
                        , hidePassedValidationStyle = False
                        , validationIcon = NoIcon
                        , validation =
                            AllOf
                                [ R10.Form.Validation.commonValidation.email
                                , MinLength 5
                                , MaxLength 50
                                , Required
                                ]
                        }
                }
            , EntityField
                { id = "password"
                , idDom = Nothing
                , type_ = TypeText TextPasswordNew
                , label = "Password"
                , helperText = Just "Helper text for Password"
                , requiredLabel = Just "(required)"
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = True
                        , hidePassedValidationStyle = False
                        , validationIcon = NoIcon
                        , validation =
                            AllOf
                                [ R10.Form.Validation.commonValidation.password
                                , MinLength 5
                                , MaxLength 50
                                , Required
                                ]
                        }
                }
            , EntityField
                { id = "password_repeat"
                , idDom = Nothing
                , type_ = TypeText TextPasswordNew
                , label = "Repeat Password"
                , helperText = Just "Helper text for Repeat  Password"
                , requiredLabel = Just "(required)"
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = True
                        , hidePassedValidationStyle = False
                        , validationIcon = NoIcon
                        , validation =
                            AllOf
                                [ R10.Form.Validation.commonValidation.password
                                , MinLength 5
                                , MaxLength 50
                                , Required
                                , WithMsg { ok = "Passwords are the same", err = "Passwords are not the same" } <| Dependant "password" Equal
                                ]
                        }
                }
            ]
        , state = R10.Form.State.init
        }
    }


type Msg
    = MsgForm R10.Form.Msg.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        MsgForm formMsg ->
            let
                form =
                    model.form

                ( newFormState_, _ ) =
                    R10.Form.Update.update formMsg form.state
            in
            { model | form = { form | state = newFormState_ } }


view : Model -> List (Element Msg)
view model =
    let
        viewForm =
            R10.Form.viewWithPalette
                model.form
                MsgForm
                Pages.Shared.Utils.toFormPalette

        viewCTA =
            Element.map MsgForm <|
                R10.Button.primary []
                    { label = text "Submit"
                    , libu = R10.Libu.Bu <| Just <| R10.Form.Msg.Submit model.form.conf
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
    { form : R10.Form.Model }


init : a -> b -> ( Model, Cmd msg1, Cmd msg2 )
init _ _ =
    ( { form =
            { conf =
                [ EntityField
                    { id = "email"
                    , type_ = TypeText TextEmail
                    , label = "Email"
                    , helperText = Just "Helper text for Email"
                    , required = True
                    , minLength = Just 5
                    , maxLength = Just 50
                    , regexValidations = R10.Form.Validation.commonValidation.email
                    }
                , EntityField
                    { id = "password"
                    , type_ = TypeText TextPasswordNew
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
    = MsgForm R10.Form.Msg.Msg




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
            ( { model | form = { form | state = R10.Form.Update.update formMsg form.state } }, Cmd.none, Cmd.none )


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
