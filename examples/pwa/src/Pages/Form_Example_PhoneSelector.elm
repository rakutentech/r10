module Pages.Form_Example_PhoneSelector exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import R10.Form
import R10.Theme


type alias Model =
    { phone1 : R10.Form.PhoneModel
    , phone2 : R10.Form.PhoneModel
    , disabled : Bool
    , messages : List String
    , validation : R10.Form.Validation2
    }


init : Model
init =
    { phone1 = R10.Form.phoneInit
    , phone2 = R10.Form.phoneInit
    , disabled = False
    , messages = []
    , validation = R10.Form.componentValidation.notYetValidated
    }


type Msg
    = OnPhoneMsg1 R10.Form.PhoneMsg
    | OnPhoneMsg2 R10.Form.PhoneMsg
    | RotateValidation
    | ToggleDisabled


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
        OnPhoneMsg1 singleMsg ->
            let
                ( selectState, selectCmd ) =
                    R10.Form.phoneUpdate singleMsg model.phone1
            in
            ( { model | phone1 = selectState }, Cmd.map OnPhoneMsg1 selectCmd )

        OnPhoneMsg2 singleMsg ->
            let
                ( selectState, selectCmd ) =
                    R10.Form.phoneUpdate singleMsg model.phone2
            in
            ( { model | phone2 = selectState }, Cmd.map OnPhoneMsg2 selectCmd )

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

        ToggleDisabled ->
            ( { model | disabled = not model.disabled }, Cmd.none )


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
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
    [ row
        [ spacing 40, width fill, padding 40 ]
        [ R10.Form.phoneView
            []
            model.phone1
            { validation = model.validation
            , toMsg = OnPhoneMsg1
            , label = "Phone number"
            , helperText = Nothing
            , disabled = model.disabled
            , requiredLabel = Nothing
            , style = R10.Form.style.outlined
            , key = "field1"
            , palette = palette
            , countryOptions = Nothing
            }
        , R10.Form.phoneView
            []
            model.phone2
            { validation = model.validation
            , toMsg = OnPhoneMsg2
            , label = "Phone number"
            , helperText = Nothing
            , disabled = model.disabled
            , requiredLabel = Nothing
            , style = R10.Form.style.filled
            , key = "field2"
            , palette = palette
            , countryOptions = Nothing
            }
        ]
    ]
