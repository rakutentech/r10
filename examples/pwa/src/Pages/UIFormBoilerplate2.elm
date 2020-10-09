module Pages.UIFormBoilerplate2 exposing
    ( Model
    , Msg
    , init
    , title
    , update
    , view
    )

import Dict
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Html.Attributes
import Markdown
import Pages.Shared.Utils
import R10.Color.Primary
import R10.Form.Element
import R10.Form.Helpers
import R10.Form.Msg
import R10.Form.State
import R10.Form.Update
import R10.Language
import R10.Mode
import R10.Theme


title : R10.Language.Translations
title =
    { key = "title"
    , en_us = "Forms - Boilerplate 2"
    , ja_jp = "Forms - Boilerplate 2"
    , zh_tw = "Forms - Boilerplate 2"
    , es_es = "Forms - Boilerplate 2"
    , fr_fr = "Forms - Boilerplate 2"
    , de_de = "Forms - Boilerplate 2"
    , it_it = "Forms - Boilerplate 2"
    , nl_nl = "Forms - Boilerplate 2"
    , pt_pt = "Forms - Boilerplate 2"
    , nb_no = "Forms - Boilerplate 2"
    , fi_fl = "Forms - Boilerplate 2"
    , da_dk = "Forms - Boilerplate 2"
    , sv_se = "Forms - Boilerplate 2"
    }


theme : R10.Theme.Theme
theme =
    R10.Theme.fromFlags
        { mode = R10.Mode.Light
        , primaryColor = R10.Color.Primary.Green
        }


type alias Model =
    { formState : R10.Form.State.State }


init : Model
init =
    { formState = R10.Form.State.init }


type Msg
    = MsgForm R10.Form.Msg.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgForm formMsg ->
            let
                ( newFormState_, formCmd ) =
                    R10.Form.Update.update formMsg model.formState
            in
            ( { model | formState = newFormState_ }
            , Cmd.map MsgForm formCmd
            )


type alias Operation =
    { operationName : String
    , operationDate : String
    }


operations : List Operation
operations =
    List.indexedMap
        (\index _ ->
            { operationName = "Operation " ++ String.fromInt (index + 1)
            , operationDate = "2020.02.02"
            }
        )
        (List.repeat 20 ())


operationsTable : R10.Form.State.State -> Element Msg
operationsTable formState =
    let
        cellAttrs =
            [ Border.widthEach { bottom = 1, left = 1, right = 0, top = 0 }
            , padding 10
            , height fill
            ]

        headerAttrs =
            [ Border.widthEach { bottom = 1, left = 1, right = 0, top = 0 }
            , Font.bold
            , padding 10
            , height fill
            , Font.center
            ]

        tableAttrs =
            [ Border.widthEach { bottom = 0, left = 0, right = 1, top = 1 }
            , width fill
            , alignTop
            ]
    in
    indexedTable
        tableAttrs
        { data = operations
        , columns =
            [ { header = el headerAttrs none
              , width = px 46
              , view =
                    \index _ ->
                        row cellAttrs <| R10.Form.Element.checkbox Pages.Shared.Utils.toFormPalette formState MsgForm index
              }
            , { header = el headerAttrs <| text "Name"
              , width = fill
              , view =
                    \_ person ->
                        el cellAttrs <| text person.operationName
              }
            , { header = el headerAttrs <| text "Date"
              , width = fill
              , view =
                    \_ person ->
                        el cellAttrs <| text person.operationDate
              }
            ]
        }


view : Model -> List (Element Msg)
view model =
    let
        checked =
            Dict.filter (\_ value -> R10.Form.Helpers.stringToBool value.value) model.formState.fieldsState
    in
    [ paragraph [] [ html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """
# Operations table example

This is an example of a form that is not completely generate by the Form library but only use single form component and spread them inside existing element, like the table in the example below.

### Boilerplate

* Store an instance of the form state in the model


```elm
    type alias Model =
        { formState : R10.Form.State.State }
```


* Initialize with default values


```elm
    initModel =
        { formState = R10.Form.State.init }
```

* 1 Message

```elm
    type Msg = MsgForm R10.Form.Msg.Msg
```

* 1 Update entry

```elm
    update msg model =
        case msg of
            MsgForm formMsg ->
                { model | formState = R10.Form.Update.update formMsg model.formState }
```

and this is all you need as boilerplate.

### Form elements generation

To generate checkboxes:

```
    R10.Form.Element.checkbox model.formState MsgForm 0
    R10.Form.Element.checkbox model.formState MsgForm 1
    R10.Form.Element.checkbox model.formState MsgForm 2
    R10.Form.Element.checkbox model.formState MsgForm 3
    etc...
```

### Retrieveing data

To get the list of touched indexes:

```elm
    Dict.keys model.formState.fieldState
```

To get the list of checked indexes:

```elm
    Dict.keys <| Dict.filter (\\_ v -> stringToBool v.value) model.formState.fieldState
```

### Working demo
""" ]
    , row [ width fill ]
        [ operationsTable model.formState
        , column [ width fill, alignTop, Font.family [ Font.monospace ] ]
            [ paragraph []
                [ text <| "Touched: [" ++ String.join ", " (Dict.keys model.formState.fieldsState) ++ "]" ]
            , text "\n"
            , paragraph []
                [ text <| "Checked: [" ++ String.join ", " (Dict.keys checked) ++ "]" ]
            ]
        ]
    ]
