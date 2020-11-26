module Pages.UIFormIntroduction exposing
    ( Model
    , Msg
    , init
    , title
    , update
    , view
    )

import Array
import Dict
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes
import Json.Decode
import Json.Encode
import Markdown
import R10.Button
import R10.Card
import R10.Color.AttrsBackground
import R10.Form
import R10.Language
import R10.Libu
import R10.Theme


title : R10.Language.Translations
title =
    { key = "title"
    , en_us = "Forms"
    , ja_jp = "Forms"
    , zh_tw = "Forms"
    , es_es = "Forms"
    , fr_fr = "Forms"
    , de_de = "Forms"
    , it_it = "Forms"
    , nl_nl = "Forms"
    , pt_pt = "Forms"
    , nb_no = "Forms"
    , fi_fl = "Forms"
    , da_dk = "Forms"
    , sv_se = "Forms"
    }


formQuantity : Int
formQuantity =
    Array.length formsInit


type alias Model =
    { forms : Array.Array R10.Form.Form
    , messagesWhileLoadingLocalStorage : List String
    , buffersConf : Array.Array String
    , buffersConfErrors : Array.Array String
    , buffersState : Array.Array String
    , buffersStateErrors : Array.Array String
    }


init : { localStorage : Dict.Dict String String } -> Model
init shared =
    let
        paramsDict =
            shared.localStorage

        ( formsState, messagesWhileLoadingLocalStorage, _ ) =
            List.foldl
                (\_ ( formState_, messagesWhileLoadingLocalStorage_, index ) ->
                    let
                        ( state, message ) =
                            getFormState index paramsDict
                    in
                    ( state :: formState_, message :: messagesWhileLoadingLocalStorage_, index + 1 )
                )
                ( [], [], 0 )
                (List.repeat formQuantity ())

        formState =
            Array.fromList <|
                List.reverse formsState

        initHelper index =
            { conf = Maybe.withDefault R10.Form.initConf <| Maybe.map .conf <| Array.get index formsInit
            , state = Maybe.withDefault R10.Form.initState <| Array.get index formState
            }
    in
    { forms =
        Array.fromList <|
            repeatForAllForms <|
                \index -> initHelper index
    , messagesWhileLoadingLocalStorage = messagesWhileLoadingLocalStorage
    , buffersConf =
        Array.fromList <|
            repeatForAllForms <|
                \index ->
                    R10.Form.confToString (Maybe.withDefault R10.Form.initConf <| Maybe.map .conf <| Array.get index formsInit)
    , buffersState =
        Array.fromList <|
            repeatForAllForms <|
                \index ->
                    R10.Form.stateToString (Maybe.withDefault R10.Form.initState <| Array.get index formState)
    , buffersConfErrors = Array.fromList <| repeatForAllForms <| \_ -> ""
    , buffersStateErrors = Array.fromList <| repeatForAllForms <| \_ -> ""
    }


type Msg
    = DoNothing
    | Reset Int
    | ResetAll
    | MsgForm Int R10.Form.Msg
    | ChangeConf Int String
    | ChangeState Int String


getFormState : Int -> Dict.Dict String String -> ( R10.Form.State, String )
getFormState index paramsDict =
    case Dict.get (formName index) paramsDict of
        Just state ->
            case R10.Form.stringToState state of
                Err error ->
                    ( R10.Form.initState, formName index ++ " error: " ++ Json.Decode.errorToString error )

                Ok formState_ ->
                    ( formState_, formName index ++ " recovered from local storage" )

        Nothing ->
            ( R10.Form.initState, formName index ++ " not found in the local storage" )


fieldConfInit : R10.Form.FieldConf
fieldConfInit =
    R10.Form.initFieldConf


formsInit : Array.Array { title : String, code : String, conf : List R10.Form.Entity }
formsInit =
    Array.fromList
        [ { title = "A simple text field"
          , conf =
                [ R10.Form.entity.field fieldConfInit ]
          , code = """[ R10.Form.entity.field fieldConfInit ]"""
          }
        , { title = "An email input field with validation"
          , conf =
                [ R10.Form.entity.field
                    { id = "email"
                    , idDom = Nothing
                    , type_ = R10.Form.fieldType.text R10.Form.text.email
                    , label = "Email"
                    , helperText = Just "Go to [example.com](http://example.com)"
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
                ]
          , code = """[ R10.Form.entity.field
    { id = "email"
    , type_ = R10.Form.fieldType.text R10.Form.text.email
    , label = "Email"
    , helperText = Just "Helper text"
    , required = True
    , minLength = Just 5
    , maxLength = Just 50
    , regexValidations = R10.Form.Validation.commonValidation.email
    }
]"""
          }
        , { title = "Two fields - multiple instances"
          , conf =
                [ R10.Form.entity.multi "Two fields - multiple instances"
                    [ R10.Form.entity.field
                        { id = "email"
                        , idDom = Nothing
                        , type_ = R10.Form.fieldType.text R10.Form.text.email
                        , label = "Email"
                        , helperText = Just "Helper text"
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
                        { fieldConfInit
                            | id = "password"
                            , label = "Password"
                            , type_ = R10.Form.fieldType.text R10.Form.text.passwordNew
                        }
                    ]
                ]
          , code = """[ R10.Form.entity.multi ""
    [ R10.Form.entity.field
        { id = "email"
        , type_ = R10.Form.fieldType.text R10.Form.text.email
        , label = "Email"
        , helperText = Just "Helper text"
        , required = True
        , minLength = Just 5
        , maxLength = Just 50
        , regexValidations = R10.Form.Validation.commonValidation.email
        }
    , R10.Form.entity.field
        { fieldConfInit
            | id = "password"
            , label = "Password"
            , type_ = R10.Form.fieldType.text R10.Form.text.passwordNew
        }
    ]
]"""
          }
        , { title = "Radio buttons"
          , conf =
                [ R10.Form.entity.field
                    { fieldConfInit
                        | id = "countryCodeAndRegion"
                        , type_ =
                            R10.Form.fieldType.single R10.Form.single.radio
                                [ { value = "Japan", label = "Japan" }
                                , { value = "United States", label = "United States" }
                                , { value = "Taiwan", label = "Taiwan" }
                                ]
                        , label = "Country code and region"
                        , helperText = Just "Used, among other things, to set the prefix of the telephone number"
                    }
                , R10.Form.entity.field
                    { fieldConfInit
                        | id = "countryCodeAndRegion"
                        , type_ =
                            R10.Form.fieldType.single R10.Form.single.combobox
                                [ { value = "Japan", label = "Japan" }
                                , { value = "United States", label = "United States" }
                                , { value = "Taiwan", label = "Taiwan" }
                                ]
                        , label = "Country code and region"
                        , helperText = Just "Used, among other things, to set the prefix of the telephone number"
                    }
                ]
          , code = """[ R10.Form.entity.field
  { fieldConfInit
      | id = "countryCodeAndRegion"
      , type_ =
          R10.Form.fieldType.single R10.Form.single.radio
              [ { value = "Japan", label = "Japan" }
              , { value = "United States", label = "United States" }
              , { value = "Taiwan", label = "Taiwan" }
              ]
      , label = "Country code and region"
      , helperText = Just "Used, among other things, to set the prefix of the telephone number"
  }
, R10.Form.entity.field
  { fieldConfInit
      | id = "countryCodeAndRegion"
      , type_ =
          R10.Form.fieldType.single R10.Form.single.combobox
              [ { value = "Japan", label = "Japan" }
              , { value = "United States", label = "United States" }
              , { value = "Taiwan", label = "Taiwan" }
              ]
      , label = "Country code and region"
      , helperText = Just "Used, among other things, to set the prefix of the telephone number"
  }
]
"""
          }
        , { title = "Checkboxes"
          , conf =
                [ R10.Form.entity.withBorder ""
                    [ R10.Form.entity.subTitle "" { title = "Social Providers", helperText = Just "Select all social networks that you would like to activate", validationSpecs = Nothing }
                    , R10.Form.entity.field { fieldConfInit | id = "socialProfileMicrosoft", label = "Microsoft (Internal)", type_ = R10.Form.fieldType.binary R10.Form.binary.checkbox }
                    , R10.Form.entity.field { fieldConfInit | id = "socialProfileFacebook", label = "Facebook", type_ = R10.Form.fieldType.binary R10.Form.binary.switch }
                    , R10.Form.entity.field { fieldConfInit | id = "socialProfileGoogle", label = "Google", type_ = R10.Form.fieldType.binary R10.Form.binary.checkbox }
                    , R10.Form.entity.field { fieldConfInit | id = "socialProfilePChome", label = "PChome", type_ = R10.Form.fieldType.binary R10.Form.binary.checkbox }
                    ]
                ]
          , code = """[ R10.Form.entity.withBorder ""
    [ R10.Form.entity.subTitle { title = "Social Providers", helperText = Just "Select all social networks that you would like to activate" }
    , R10.Form.entity.field { fieldConfInit | id = "socialProfileMicrosoft", label = "Microsoft (Internal)", type_ = R10.Form.fieldType.binary R10.Form.binary.checkbox }
    , R10.Form.entity.field { fieldConfInit | id = "socialProfileFacebook", label = "Facebook", type_ = R10.Form.fieldType.binary R10.Form.binary.checkbox }
    , R10.Form.entity.field { fieldConfInit | id = "socialProfileGoogle", label = "Google", type_ = R10.Form.fieldType.binary R10.Form.binary.checkbox }
    , R10.Form.entity.field { fieldConfInit | id = "socialProfilePChome", label = "PChome", type_ = R10.Form.fieldType.binary R10.Form.binary.checkbox }
    ]
]"""
          }
        , { title = "Tabs"
          , conf =
                [ R10.Form.entity.withTabs ""
                    [ ( "string"
                      , R10.Form.entity.field
                            { fieldConfInit
                                | id = "email"
                                , label = "Email"
                            }
                      )
                    , ( "string"
                      , R10.Form.entity.field
                            { fieldConfInit
                                | id = "password"
                                , label = "Password"
                                , type_ = R10.Form.fieldType.text R10.Form.text.passwordNew
                            }
                      )
                    ]
                ]
          , code = """[ R10.Form.entity.withTabs ""
    [ R10.Form.entity.field
        { fieldConfInit
            | id = "email"
            , label = "Email"
        }
    , R10.Form.entity.field
        { fieldConfInit
            | id = "password"
            , label = "Password"
            , type_ = R10.Form.fieldType.text R10.Form.text.passwordNew
        }
    ]
]
"""
          }
        ]


repeatForAllForms : (Int -> b) -> List b
repeatForAllForms f =
    List.indexedMap
        (\index _ ->
            f index
        )
        (List.repeat formQuantity ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoNothing ->
            ( model, Cmd.none )

        ChangeState index string ->
            let
                form =
                    getForm index model.forms

                ( newState, newError ) =
                    case R10.Form.stringToState string of
                        Ok state ->
                            ( state, "" )

                        Err err ->
                            ( form.state, Json.Decode.errorToString err )
            in
            ( { model
                | forms = Array.set index { form | state = newState } model.forms
                , buffersState = Array.set index string model.buffersState
                , buffersStateErrors = Array.set index newError model.buffersStateErrors
              }
            , Cmd.none
            )

        ChangeConf index string ->
            let
                form =
                    getForm index model.forms

                formState =
                    form.state

                ( newFormConf, newError ) =
                    case R10.Form.stringToConf string of
                        Ok conf ->
                            ( conf, "" )

                        Err err ->
                            ( form.conf, Json.Decode.errorToString err )

                allKeys =
                    R10.Form.allValidationKeysMaker newFormConf form.state

                -- Re-running existing validations because if the validations rules
                -- changed in the configuration would only be picked up after changing
                -- a related input field.
                newFieldsState =
                    R10.Form.runOnlyExistingValidations allKeys form.state form.state.fieldsState
            in
            ( { model
                | forms =
                    Array.set index
                        { form
                            | conf = newFormConf
                            , state = { formState | fieldsState = newFieldsState }
                        }
                        model.forms
                , buffersConf = Array.set index string model.buffersConf
                , buffersConfErrors = Array.set index newError model.buffersConfErrors
              }
            , Cmd.none
            )

        Reset index ->
            let
                newForm =
                    { conf = .conf (getForm index model.forms)
                    , state = R10.Form.initState
                    }

                initStateAsString =
                    R10.Form.stateToString R10.Form.initState
            in
            ( { model
                | forms = Array.set index newForm model.forms
                , buffersState = Array.set index initStateAsString model.buffersState
                , buffersStateErrors = Array.set index "" model.buffersStateErrors
              }
            , Cmd.none
              --, Ports.writeLocalStorage ( formName index, "" )
            )

        ResetAll ->
            let
                initStateAsString =
                    R10.Form.stateToString R10.Form.initState
            in
            ( { model
                | forms =
                    Array.fromList <|
                        repeatForAllForms <|
                            \index ->
                                { conf = .conf (getForm index model.forms)
                                , state = R10.Form.initState
                                }
                , buffersState = Array.fromList <| repeatForAllForms <| \_ -> initStateAsString
                , buffersStateErrors = Array.fromList <| repeatForAllForms <| \_ -> ""
              }
            , Cmd.none
              --, Cmd.batch <|
              --    repeatForAllForms <|
              --        \index ->
              --            Ports.writeLocalStorage ( formName index, "" )
            )

        MsgForm index formMsg ->
            let
                form =
                    getForm index model.forms

                ( newState, formCmd ) =
                    R10.Form.update formMsg form.state
            in
            ( { model
                | forms = Array.set index { form | state = newState } model.forms
                , buffersState = Array.set index (R10.Form.stateToString newState) model.buffersState
                , buffersStateErrors = Array.set index "" model.buffersStateErrors
              }
            , Cmd.map (MsgForm index) formCmd
              --, Ports.writeLocalStorage ( formName index, R10.Form.stateToString newState )
            )


workAroundMultiLine :
    List (Attribute msg)
    ->
        { label : Input.Label msg
        , onChange : String -> msg
        , placeholder : Maybe (Input.Placeholder msg)
        , spellcheck : Bool
        , text : String
        }
    -> Element msg
workAroundMultiLine attribs mlspec =
    -- As per https://github.com/mdgriffith/elm-ui/issues/5#issuecomment-474581136
    Input.multiline (htmlAttribute (Html.Attributes.property "value" (Json.Encode.string mlspec.text)) :: attribs) mlspec


getForm :
    Int
    -> Array.Array { conf : List a, state : R10.Form.State }
    -> { conf : List a, state : R10.Form.State }
getForm index forms_ =
    Maybe.withDefault { conf = [], state = R10.Form.initState } <| Array.get index forms_


getFormInit : Int -> { code : String, conf : List R10.Form.Entity, title : String }
getFormInit index =
    Maybe.withDefault { title = "", code = "", conf = [] } <| Array.get index formsInit


formName : Int -> String
formName index =
    "Form " ++ String.fromInt (index + 1)


secondaryTitle : List (Attr decorative msg)
secondaryTitle =
    [ Font.size 18 ]


viewRow : Int -> Model -> R10.Theme.Theme -> List (Element Msg)
viewRow index model theme =
    let
        multilineAttrs =
            [ width fill
            , height fill
            , alignTop
            , Border.width 1
            , Font.size 13
            , R10.Color.AttrsBackground.surface2dp theme

            -- , Border.color <| rgba 0 0 0 0.1
            , padding 5
            , htmlAttribute <| Html.Attributes.style "white-space" "nowrap"
            , htmlAttribute <| Html.Attributes.style "font-family" "monospace"
            ]

        formDesc =
            getFormInit index

        msgTransformer =
            MsgForm index

        form =
            getForm index model.forms
    in
    [ el secondaryTitle <| text formDesc.title
    , row [ width fill, spacing 20 ]
        [ column (R10.Card.noShadow theme ++ [ R10.Color.AttrsBackground.surface2dp theme, spacing 20, height fill ])
            [ paragraph secondaryTitle [ text <| formName index ]
            , column [ width fill, spacing 20 ] <|
                (R10.Form.viewWithPalette form msgTransformer (R10.Form.themeToPalette theme)
                    ++ [ if R10.Form.shouldShowTheValidationOverview form.state then
                            let
                                allKeys_ =
                                    R10.Form.allValidationKeysMaker form.conf form.state

                                allErrors =
                                    R10.Form.entitiesWithErrors allKeys_ form.state.fieldsState
                            in
                            if List.length allErrors > 0 then
                                column [ spacing 10 ] <|
                                    [ paragraph [] [ text "Errors in the form:" ] ]
                                        ++ List.map
                                            (\( key, _ ) ->
                                                paragraph [ Font.color <| rgb 1 0 0 ] [ text <| R10.Form.keyToString key ]
                                            )
                                            allErrors

                            else
                                paragraph [] [ text "The form is good to go!" ]

                         else
                            none
                       ]
                    ++ [ row [ spacing 15 ]
                            [ R10.Button.primary []
                                { label = text "Submit"
                                , libu = R10.Libu.Bu <| Just <| MsgForm index <| R10.Form.msg.submit form.conf
                                , theme = theme
                                }
                            , R10.Button.primary []
                                { label = text "Reset"
                                , libu = R10.Libu.Bu <| Just <| Reset index
                                , theme = theme
                                }
                            ]
                       ]
                )
            ]
        , column (R10.Card.noShadow theme ++ [ R10.Color.AttrsBackground.surface2dp theme, spacing 20, height fill ])
            [ paragraph secondaryTitle [ text <| formName index ++ " state Json - editable" ]
            , Input.multiline
                multilineAttrs
                { onChange = ChangeState index
                , text = Maybe.withDefault "" <| Array.get index model.buffersState
                , placeholder = Nothing
                , label = Input.labelHidden ""
                , spellcheck = False
                }
            , viewError index model.buffersStateErrors
            ]
        ]
    , row [ width fill, spacing 20 ]
        [ column (R10.Card.noShadow theme ++ [ R10.Color.AttrsBackground.surface2dp theme, spacing 20, height fill ])
            [ paragraph secondaryTitle [ text <| formName index ++ " configuration Elm - read only" ]
            , Input.multiline
                (multilineAttrs ++ [ Background.color <| rgba 0 0 0 0.1 ])
                { onChange = \_ -> DoNothing
                , text = .code <| getFormInit index
                , placeholder = Nothing
                , label = Input.labelHidden ""
                , spellcheck = False
                }
            ]
        , column (R10.Card.noShadow theme ++ [ R10.Color.AttrsBackground.surface2dp theme, spacing 20, height fill ])
            [ paragraph secondaryTitle [ text <| formName index ++ " configuration Json - editable" ]
            , workAroundMultiLine
                multilineAttrs
                { onChange = ChangeConf index
                , text = Maybe.withDefault "" <| Array.get index model.buffersConf
                , placeholder = Nothing
                , label = Input.labelHidden ""
                , spellcheck = False
                }
            , viewError index model.buffersConfErrors
            ]
        ]
    ]


viewError : Int -> Array.Array String -> Element msg
viewError index errors =
    let
        error =
            Maybe.withDefault "" <| Array.get index errors
    in
    if error == "" then
        none

    else
        el [ Font.color <| rgb 0.8 0 0 ] <|
            text <|
                reformatError error


reformatError : String -> String
reformatError error =
    error
        |> String.replace "\\n" "\n"
        |> String.replace "\\\"" "\""


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
    [ column
        []
        [ paragraph [] [ html <| Markdown.toHtml [ Html.Attributes.class "markdown" ] """

We use a library to build forms that take care of the most tedious work for us.

## Characteristics (need to be updated)

* Use an indipendend library of Form Components (`elm-form-components`)
* Both the state and the configuration of the form are seriazible into Json. This can be used to save the state to local storage or to receive the configuraiton from the server, for example.
* The form is based on a recursive structure that allows infinite configurations
* Even if the form is recursive, the state is saved in a flat structure for easy parsing and transformation
* Several "makers" functions can be used to generate the form in different styles
* The library can be used with the "makers" to generate the form or without it, generating the form manually

## Basics

Forms are based on two parts, a configuration and a state:

        type alias Model =
            { conf : R10.Form.Conf.Conf
            , state : R10.Form.State
            }

These parts also contains field state and configuration for a total of four things:

* Form Configuration
* Field Configuration
* Form State
* Field State

## Form Configuration

Configuration contains all the static stuff that describe a form and doesn't change while a user is editing it.

The configuration is just a list of entities:

        type alias Conf = List Entity

where `Entity` is a recursive basic block of the form. `Entity` can be an input field or a container for multiple input fields. It can also be a separator, like a title or a sub-title.

        type Entity
            = EntityNormal EntityId (List Entity)
            | EntityWrappable EntityId (List Entity)
            | R10.Form.entity.withBorder EntityId (List Entity)
            | R10.Form.entity.withTabs EntityId (List Entity)
            | R10.Form.entity.multi EntityId (List Entity)
            | EntityTitle TextSection
            | R10.Form.entity.subTitle TextSection
            | R10.Form.entity.field R10.Form.FieldConf.FieldConf

The form is like a tree where leafs are the actually input fields.

![alt text](/images/form-tree.png "Form Tree")

## Field Configuration

The field configuration contain all static data that describe an input field:

        type alias FieldConf =
            { id : String
            , type_ : FieldType
            , label : String
            , helperText : Maybe String
            , required : Bool
            , minLength : Maybe Int
            , maxLength : Maybe Int
            , regexValidations : List RegexValidation
            }

## Form State

The form state contain all data that is changing, both at the form level and at the fields level

        type alias State =
            { fieldState : Dict.Dict String R10.Form.FieldState.FieldState
            , quantities : Quantities
            , activeTabs : ActiveTabs
            , focused : Maybe String
            , removed : Set.Set String
            , qtySubmitAttempted : QtySubmitAttempted
            }

In details

* `fieldState` is a dictionary where: the key is a special value generated by the library containing information about the position of the input field in the tree and the value is the field state.
* `quantities` keep the count of how many quantity a __multiplicable__ entity has been multiplied
* `activeTabs` is used to rememebr which tab is active when `R10.Form.entity.withTabs` is used
* `focuesed` store the key of the input field that has the focus
* `removed` keep track of all items that have been removed from an __multiplicable__ entity
* `qtySubmitAttempted` counts home many time a form has been submitted. If zero, the from has never been submitted

## Field State

Field state contain data that can change in an input field

        type alias FieldState =
            { lostFocusOneOrMoreTime : Bool
            , value : String
            , dirty : Bool -- Updated but not used
            , disabled : Bool
            , validation : Validation
            , showPassword : Bool -- Used only for passwords
            }

## FieldType

Field types are grouped in 4 categories:

        type FieldType
            = R10.Form.fieldType.text TypeText
            | TypeSingle TypeSingle (List FieldOption)
            | TypeMulti TypeMulti (List FieldOption)
            | TypeBinary TypeBinary

* `TypeText` is for types where the user is typing some text. Subtypes belonging to this category are:

        type TypeText
            = TextPlain
            | R10.Form.text.email
            | TextUsername
            | TextPasswordNew
            | TextPasswordCurrent
            | TextMultiline

* `TypeSingle` is for types that allow a single choice. Subtypes are:

        type TypeSingle
            = SingleRadio
            | SingleCombobox

* `TypeMulti` is for types that allow multiple choices (not to be confused with multiline input text). Subtypes are:

        type TypeMulti
            = MultiCombobox -- TODO

* `TypeBinary` is for type that allow two choices. Subtypes are:

        type TypeBinary
            = BinaryCheckbox
            | BinarySwitch -- TODO


## Key

Keys are used to indetify nodes in the tree (and consequently, input fields). They are stored as a list of `EntityId` that are strings:

        type Key = Key (List String)

The are converted to string just joining all the element of the list and using a separator, usually "/".

## The Form Architecture

The library provide a built in system to manage message and state changes. So, to add a form into a page is enough to create one message. You can see details in [this page](/ui-form-examples-3)

## Makers

"Makers" are script that take the form configuration and transorm it in something lese, called `Outcome`.

### Maker.elm

This maker generate `Element R10.Form.Msg` that is a nested view structure to display the form on the screen

### MakerForValidationKeys.elm

This maker generate `( R10.Form.Key.Key, R10.Form.FieldConf.ValidationSpecs )` that is a flat list of all keys and validation configuration of entities.

### MakerForValues.elm

This maker generate `Form.StateForValues.Entity` that is a shallow (but not flat) structure that contain all the values of the form. This structure could be close to a graphQL structure. Could also generate type (String, Bool, Int,etc.) accordingly if needed.

# Examples

See below few example of forms.

Both `FormState` and `FormConf` have decoder and encoders so you can edit their JSON version below and see the result in realtime.

 """ ] ]
    ]
        ++ [ R10.Button.primary [ width shrink ]
                { label = text "Reset all forms state"
                , libu = R10.Libu.Bu <| Just ResetAll
                , theme = theme
                }
           ]
        ++ [ el [] <| text "Loading forms state from Local Storage..." ]
        ++ [ column [ paddingXY 40 0, spacing 10 ] <| List.map (\error -> el [] <| text <| reformatError error) (List.reverse model.messagesWhileLoadingLocalStorage) ]
        ++ (List.concat <| repeatForAllForms <| \index -> viewRow index model theme)
