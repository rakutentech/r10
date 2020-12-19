module Pages.Form_Entities exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Html.Attributes
import Markdown
import R10.Form
import R10.FormTypes
import R10.Paragraph
import R10.Theme


type alias Model =
    { formState : R10.Form.State }


init : Model
init =
    { formState = R10.Form.initState }


type Msg
    = FormMsg R10.Form.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        FormMsg formMsg ->
            let
                ( newFormState, _ ) =
                    R10.Form.update formMsg model.formState
            in
            { model | formState = newFormState }



--


inputFieldConf : Int -> R10.Form.Entity
inputFieldConf id =
    R10.Form.entity.field
        { id = "text" ++ String.fromInt id
        , idDom = Nothing
        , type_ = R10.FormTypes.inputField.textPlain
        , label = "Text " ++ String.fromInt id
        , helperText = Nothing
        , requiredLabel = Nothing
        , validationSpecs = Nothing
        }


entities : List R10.Form.Entity
entities =
    [ inputFieldConf 1, inputFieldConf 2, inputFieldConf 3 ]


entitiesForTabs : List ( String, R10.Form.Entity )
entitiesForTabs =
    [ ( "Tab 1", inputFieldConf 1 ), ( "Tab 2", inputFieldConf 2 ), ( "Tab 3", inputFieldConf 3 ) ]


helperForTitles : { helperText : Maybe a1, title : String, validationSpecs : Maybe a }
helperForTitles =
    { title = "Title", helperText = Nothing, validationSpecs = Nothing }


section : String -> R10.Form.Form -> R10.Theme.Theme -> List (Element Msg)
section entityAsString form theme =
    [ R10.Paragraph.xlarge [ Background.color <| rgba 1 1 0 0.5, padding 5 ] [ text entityAsString ]
    , row [ Border.width 5, Border.color <| rgba 0.95 0.95 0 1 ] <| R10.Form.viewWithTheme form FormMsg theme
    , row [ Border.width 5, Border.color <| rgba 0.95 0.95 0 1, width fill ] <| R10.Form.viewWithTheme form FormMsg theme
    ]


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
    let
        state : R10.Form.State
        state =
            model.formState
    in
    --
    -- Look at R10.FormComponents.Text.view line 385
    --
    []
        ++ [ paragraph [] [ html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """**Entities** are the constituent of the form configuration.
            
Each **entity** can represent an input field, a title, a sub-title or a list of other entities.
    
As list of other entities is used to represent some grouping. For example to add a border around certain number of input field that are somehow related.
        
There are 8 types of entity:
    
    1. R10.Form.entity.field
    2. R10.Form.entity.normal
    3. R10.Form.entity.wrappable 
    4. R10.Form.entity.withBorder
    5. R10.Form.entity.withTabs
    6. R10.Form.entity.multi
    7. R10.Form.entity.title
    8. R10.Form.entity.subTitle""" ] ]
        ++ section "R10.Form.entity.field" { conf = entities, state = state } theme
        ++ section "R10.Form.entity.normal" { conf = [ R10.Form.entity.normal "normal" entities ], state = state } theme
        ++ section "R10.Form.entity.wrappable" { conf = [ R10.Form.entity.wrappable "wrappable" entities ], state = state } theme
        ++ section "R10.Form.entity.withBorder" { conf = [ R10.Form.entity.withBorder "withBorder" entities ], state = state } theme
        ++ section "R10.Form.entity.withTabs" { conf = [ R10.Form.entity.withTabs "withTabs" entitiesForTabs ], state = state } theme
        ++ section "R10.Form.entity.multi" { conf = [ R10.Form.entity.multi "multi" entities ], state = state } theme
        ++ section "R10.Form.entity.title" { conf = [ R10.Form.entity.title "title" helperForTitles ], state = state } theme
        ++ section "R10.Form.entity.subTitle" { conf = [ R10.Form.entity.subTitle "subTitle" helperForTitles ], state = state } theme
