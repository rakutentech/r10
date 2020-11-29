module Pages.Form_Entities exposing
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
import Html
import Html.Attributes
import Markdown
import R10.Button
import R10.Card
import R10.Color
import R10.Color.AttrsBackground
import R10.Form
import R10.FormComponents
import R10.Language
import R10.Libu
import R10.Link
import R10.Mode
import R10.Theme


title : R10.Language.Translations
title =
    { key = "title"
    , en_us = "Form Entities"
    , ja_jp = "Form Entities"
    , zh_tw = "Form Entities"
    , es_es = "Form Entities"
    , fr_fr = "Form Entities"
    , de_de = "Form Entities"
    , it_it = "Form Entities"
    , nl_nl = "Form Entities"
    , pt_pt = "Form Entities"
    , nb_no = "Form Entities"
    , fi_fl = "Form Entities"
    , da_dk = "Form Entities"
    , sv_se = "Form Entities"
    }


type alias Model =
    { formState : R10.Form.State }


init : Model
init =
    { formState = R10.Form.initState }


type Msg
    = FormMsg R10.Form.Msg
    | DoNothing


update : Msg -> Model -> Model
update msg model =
    case msg of
        DoNothing ->
            model

        FormMsg formMsg ->
            let
                ( newFormState, _ ) =
                    R10.Form.update formMsg model.formState
            in
            { model | formState = newFormState }


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
    [ text "COMING SOON..." ]
