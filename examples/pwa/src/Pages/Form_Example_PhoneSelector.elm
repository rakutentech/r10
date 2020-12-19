module Pages.Form_Example_PhoneSelector exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Element exposing (..)
import R10.Form
import R10.FormTypes
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


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
    let
        palette : R10.FormTypes.Palette
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
