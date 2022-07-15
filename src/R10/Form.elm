module R10.Form exposing
    ( Form
    , view, viewWithTheme, viewWithPalette, viewWithOptions, Options
    , Msg, MsgMapper
    , isChangingValues, isFormSubmittable, isFormSubmittableAndSubmitted, msg
    , State, initState, initStateWithDefaults, stateToString, stringToState
    , update
    , Conf, initConf, confToString, stringToConf, changeFieldConf
    , Entity, entity, EntityId, TextConf
    , FieldConf, initFieldConf, FieldState, initFieldState
    , Key, KeyAsString, keyToString, stringToKey, composeKey, listToKey, headId, emptyKey
    , updateField, getField, getFieldValue, getFieldValueIgnoringPath, getFieldValueAsBool, getActiveTab, getMultiActiveKeys
    , setFieldValue, setActiveTab, setMultiplicableQuantities, setFieldDisabled
    , stringToBool, boolToString, commonRegularExpression, msgToValue, stateToValue
    , viewIconButton, ArgsIconButton, viewButton, ArgsButton, viewText, processValue, TextArgs, ArgsText, viewBinary, ArgsBinary
    , Style, style, defaultStyle, styleToString, stringToStyle
    , Button, button
    , themeToPalette, label, extraCssComponents, extraCss, colorToCssString
    , onClickWithStopPropagation, onFocusOut, onLoseFocus, onValueChange, onOptionSelect
    , elementMarkdown
    , Translator, defaultTranslator, validationCodes
    , SingleModel, SingleMsg, SingleFieldOption, defaultSearchFn, initSingle, normalizeString, insertBold, defaultToOptionEl, defaultTrailingIcon, singleMsg, updateSingle
    , viewSingle, ArgsSingle, viewSingleCustom, ArgsSingleCustom
    , validate, validation, Validation, ValidationCode, ValidationSpecs, ValidationForView, ValidationMessage, validateDirtyFormFields, validateEntireForm, validationMessage, validationToString, shouldShowTheValidationOverview, allValidationKeysMaker, runOnlyExistingValidations, commonValidation, clearFieldValidation, componentValidation, initValidationSpecs, isExistingFormFieldsValid, setFieldValidationError, entitiesValidationOutcomes, isRegexValidation, entitiesWithErrors
    , fieldConfigConcatMap, fieldConfigMap
    , handleWithPatternChange, errorsFromApiToValidationForView, validationForViewToErrorMessages
    )

{-| Useful things to build a form.


# Form

A form is defined by the **configuration** (`R10.Form.Conf`) that contain data about the input fields, radio buttons, etc. and the **state** (`R10.Form.State`), containing instead all the values and other parameters that change during the life of the form.

    type alias Form =
        { conf : R10.Form.Conf
        , state : R10.Form.State
        }

@docs Form


# Views

There are four functions to render a `Form`, each with a different degree of customization. They are order from the simplest (less customizable) to the most complex (more customizable).

@docs view, viewWithTheme, viewWithPalette, viewWithOptions, Options


# Messages

@docs Msg, MsgMapper


## Messages helpers

@docs isChangingValues, isFormSubmittable, isFormSubmittableAndSubmitted, msg


# State

`State` is the equivalent of the `Model` in a TEA structure.

It contains the values and the other things that ususally change while the user is interacting with the form.

@docs State, initState, initStateWithDefaults, stateToString, stringToState


# Update

This is the `update` function to wire the form in your existing `TEA` structure.

It consider the `State` of the form as the `Model` in a standard `TEA` structure, as usually is the `State` that change while the user interact with the form.

But, differently from the standard `TEA`, the view function of this form library also require the configuration of the form.

This means that if you want to go crazy and also change the configuration, you can do it. For example you could change the validations on the flight while user is changing a value. Or you can add new input fields, etc. See [`fieldConfigConcatMap`](#fieldConfigConcatMap) for this type of usage.

@docs update


# Configuration and Entities


## Configuration

@docs Conf, initConf, confToString, stringToConf, changeFieldConf


## Entities

@docs Entity, entity, EntityId, TextConf


# Fields Configuration and State

Singular fields, similarly to forms, have their own Configuration and State.

@docs FieldConf, initFieldConf, FieldState, initFieldState


# Key

@docs Key, KeyAsString, keyToString, stringToKey, composeKey, listToKey, headId, emptyKey


# Helpers

**Get**

@docs updateField, getField, getFieldValue, getFieldValueIgnoringPath, getFieldValueAsBool, getActiveTab, getMultiActiveKeys

**Set**

@docs setFieldValue, setActiveTab, setMultiplicableQuantities, setFieldDisabled

**Others**

@docs stringToBool, boolToString, commonRegularExpression, msgToValue, stateToValue


# Form Components

@docs viewIconButton, ArgsIconButton, viewButton, ArgsButton, viewText, processValue, TextArgs, ArgsText, viewBinary, ArgsBinary


# Style

@docs Style, style, defaultStyle, styleToString, stringToStyle


# Button

@docs Button, button


# CSS, Colors Palette

@docs themeToPalette, label, extraCssComponents, extraCss, colorToCssString


# Events

@docs onClickWithStopPropagation, onFocusOut, onLoseFocus, onValueChange, onOptionSelect


# Markdown

@docs elementMarkdown


# Translator

If you want to personalise the translations or you want to translate them in different languages, you can do so defining a function like

    translator : Key -> ValidationCode -> String
    translator key validationCode =
        Dict.fromList
            [ ( validationCodes.emailFormatInvalid
              , "Invalid email format"
              )
            , ( validationCodes.emailFormatValid
              , "Valid email format"
              )
            ...
            , ( validationCodes.oneOf
              , "All of the validations have failed"
              )
            ]
            |> Dict.get validationCode
            |> Maybe.withDefault validationCode

@docs Translator, defaultTranslator, validationCodes


# Single Field

@docs SingleModel, SingleMsg, SingleFieldOption, defaultSearchFn, initSingle, normalizeString, insertBold, defaultToOptionEl, defaultTrailingIcon, singleMsg, updateSingle


### Views

@docs viewSingle, ArgsSingle, viewSingleCustom, ArgsSingleCustom


# Validation

@docs validate, validation, Validation, ValidationCode, ValidationSpecs, ValidationForView, ValidationMessage, validateDirtyFormFields, validateEntireForm, validationMessage, validationToString, shouldShowTheValidationOverview, allValidationKeysMaker, runOnlyExistingValidations, commonValidation, clearFieldValidation, componentValidation, initValidationSpecs, isExistingFormFieldsValid, setFieldValidationError, entitiesValidationOutcomes, isRegexValidation, entitiesWithErrors


# Advanced usage

@docs fieldConfigConcatMap, fieldConfigMap


# Others

@docs handleWithPatternChange, errorsFromApiToValidationForView, validationForViewToErrorMessages

-}

import Dict
import Element.WithContext exposing (..)
import Json.Decode
import Json.Encode
import R10.Context exposing (..)
import R10.Country
import R10.Form.Internal.Conf
import R10.Form.Internal.FieldConf
import R10.Form.Internal.FieldState
import R10.Form.Internal.Helpers
import R10.Form.Internal.Key
import R10.Form.Internal.MakerForInitializationWithDefaults
import R10.Form.Internal.MakerForView
import R10.Form.Internal.Msg
import R10.Form.Internal.Shared
import R10.Form.Internal.State
import R10.Form.Internal.Translator
import R10.Form.Internal.Update
import R10.Form.Internal.Validation
import R10.FormComponents.Internal.Binary
import R10.FormComponents.Internal.Button
import R10.FormComponents.Internal.ExtraCss
import R10.FormComponents.Internal.IconButton
import R10.FormComponents.Internal.Single
import R10.FormComponents.Internal.Single.Common
import R10.FormComponents.Internal.Single.Update
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.Text
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.Utils
import R10.FormComponents.Internal.Utils.FocusOut
import R10.FormComponents.Internal.Validations
import R10.FormTypes
import R10.Palette
import R10.SimpleMarkdown
import R10.Theme



-- ███████  ██████  ██████  ███    ███
-- ██      ██    ██ ██   ██ ████  ████
-- █████   ██    ██ ██████  ██ ████ ██
-- ██      ██    ██ ██   ██ ██  ██  ██
-- ██       ██████  ██   ██ ██      ██


{-| -}
type alias Form =
    R10.Form.Internal.Shared.Form



-- ██    ██ ██ ███████ ██     ██ ███████
-- ██    ██ ██ ██      ██     ██ ██
-- ██    ██ ██ █████   ██  █  ██ ███████
--  ██  ██  ██ ██      ██ ███ ██      ██
--   ████   ██ ███████  ███ ███  ███████


{-| This is the simplest way to render a form, as you can see in this minimalistic example:

    module Main exposing (main)

    import Element.WithContext exposing (..)
    import Html
    import R10.Form
    import R10.FormTypes

    formModel : R10.Form.Form
    formModel =
        { conf =
            [ R10.Form.entity.field
                { id = "email"
                , idDom = Nothing
                , type_ = R10.FormTypes.TypeText R10.FormTypes.TextEmail
                , label = "Email"
                , helperText = Just "My first form"
                , requiredLabel = Nothing
                , validationSpecs = Nothing
                }
            ]
        , state = R10.Form.initState
        }

    formMsgMapper : R10.Form.MsgMapper ()
    formMsgMapper =
        \_ -> ()

    main : Html.Html ()
    main =
        layout [] <|
            column [ centerX, centerY ] <|
                R10.Form.view formModel formMsgMapper

Note that the form of this example is not active because it is just rendering the view but it is not wired to The Elm Architecture. If interested, look at the code of an [active form example](https://github.com/rakutentech/r10/blob/master/examples/simpleForm/src/Main.elm).

-}
view : Form -> MsgMapper msg -> List (Element (R10.Context.ContextInternal z) msg)
view form msgMapper =
    viewWithOptions form
        msgMapper
        { maker = Nothing
        , translator = Nothing
        , style = defaultStyle
        , palette = Nothing
        }


{-| Use this version if you have a specific palette that you want to use.
-}
viewWithPalette : Form -> MsgMapper msg -> R10.Palette.Palette -> List (Element (R10.Context.ContextInternal z) msg)
viewWithPalette form msgMapper palette =
    viewWithOptions form
        msgMapper
        { maker = Nothing
        , translator = Nothing
        , style = defaultStyle
        , palette = Just palette
        }


{-| Use this version if you have `R10.Theme.Theme`.
-}
viewWithTheme : Form -> MsgMapper msg -> R10.Theme.Theme -> List (Element (R10.Context.ContextInternal z) msg)
viewWithTheme form msgMapper theme =
    let
        palette =
            themeToPalette theme
    in
    viewWithOptions form
        msgMapper
        { maker = Nothing
        , translator = Nothing
        , style = defaultStyle
        , palette = Just palette
        }


{-| Use this version for full control.
-}
viewWithOptions : Form -> MsgMapper msg -> Options z -> List (Element (R10.Context.ContextInternal z) msg)
viewWithOptions form msgMapper args =
    let
        maker_ :
            R10.Form.Internal.MakerForView.MakerArgs
            -> Conf
            -> List (R10.Form.Internal.MakerForView.Outcome z)
        maker_ =
            Maybe.withDefault R10.Form.Internal.MakerForView.maker
                args.maker
    in
    List.map
        (map msgMapper)
        -- maker :
        --     MakerArgs
        --     -> Conf
        --     -> List Outcome
        (maker_
            { key = R10.Form.Internal.Key.empty
            , formState = form.state
            , translator = Maybe.withDefault defaultTranslator args.translator
            , style = args.style
            , palette = Maybe.withDefault R10.Palette.light args.palette
            }
            form.conf
        )


{-| These are the options that you can use with `viewWithOptions`.
-}
type alias Options z =
    { maker :
        Maybe
            ({ key : Key
             , formState : State
             , translator : Translator
             , style : Style
             , palette : R10.Palette.Palette
             }
             -> Conf
             -> List (Element (R10.Context.ContextInternal z) Msg)
            )
    , translator : Maybe Translator
    , style : Style
    , palette : Maybe R10.Palette.Palette
    }



-- ███    ███ ███████ ███████ ███████  █████   ██████  ███████ ███████
-- ████  ████ ██      ██      ██      ██   ██ ██       ██      ██
-- ██ ████ ██ █████   ███████ ███████ ███████ ██   ███ █████   ███████
-- ██  ██  ██ ██           ██      ██ ██   ██ ██    ██ ██           ██
-- ██      ██ ███████ ███████ ███████ ██   ██  ██████  ███████ ███████


{-| -}
type alias Msg =
    R10.Form.Internal.Msg.Msg


{-| This function required by all views is used to convert specific form messages (`Msg`) into generic messages (`msg`). Tipically you would define this function like this in your application:

    type Msg
        = MsgForm R10.Form.Internal.Msg

`MsgForm` can now be used as `MsgMapper` that convert `R10.Form.Internal.Msg` into `Msg`.

For a code example have a look at this [simple form](https://github.com/rakutentech/r10/blob/master/examples/simpleForm/src/Main.elm).

-}
type alias MsgMapper msg =
    Msg -> msg



-- MESSAGES HELPERS


{-| Return true if the message can potentially change some value
-}
isChangingValues : Msg -> Bool
isChangingValues =
    R10.Form.Internal.Msg.isChangingValues


{-| This function can be used to do some processing before the form get submitted.

It returns `True` when the form is submittable and the message is `Submit`. To be used in the `update` function.

-}
isFormSubmittableAndSubmitted : Form -> Msg -> Bool
isFormSubmittableAndSubmitted =
    R10.Form.Internal.Update.isFormSubmittableAndSubmitted


{-| -}
msg :
    { submit : Conf -> Msg
    , getFocus : Key -> FieldConf -> Msg
    }
msg =
    { submit = R10.Form.Internal.Msg.Submit
    , getFocus = R10.Form.Internal.Msg.GetFocus
    }


{-| -}
msgToValue : Msg -> Maybe String
msgToValue =
    R10.Form.Internal.Msg.toValue



-- ███████ ████████  █████  ████████ ███████
-- ██         ██    ██   ██    ██    ██
-- ███████    ██    ███████    ██    █████
--      ██    ██    ██   ██    ██    ██
-- ███████    ██    ██   ██    ██    ███████


{-| The state is defined as

    type alias State =
        { fieldsState : Dict KeyAsString FieldState
        , multiplicableQuantities : Dict KeyAsString Int
        , activeTabs : Dict KeyAsString String
        , focused : Maybe KeyAsString
        , active : Maybe KeyAsString
        , removed : Set KeyAsString
        , qtySubmitAttempted : QtySubmitAttempted
        , changesSinceLastSubmissions : Bool
        }

Where:

  - `fieldState` is a dictionary containing the states of all fields.
  - `multiplicableQuantities` is a dictionary containin the quantity of a _multiplicable_ field. A _multiplicable_ field is a field that the user can clone to add extra information.
  - `activeTabs` describe which tab is active in case tabs are used to group objects of the form.
  - `focused` is the focused element of the form at the present moment.
  - `active`... what is `active`?
  - `removed` contains _multiplicable_ input fields that have been removed by the user.
  - `qtySubmitAttempted` is the number of times that the user tried to submit the form.
  - `changesSinceLastSubmissions` is `True` if the user changed something after the last for submission.

-}
type alias State =
    R10.Form.Internal.State.State


{-| -}
initState : State
initState =
    R10.Form.Internal.State.init


{-| -}
initStateWithDefaults : Conf -> Maybe R10.Country.Country -> State
initStateWithDefaults =
    R10.Form.Internal.MakerForInitializationWithDefaults.initWithDefaults


{-| This can be useful to store the state of a form to the Local Storage, for example. Then, using `stringToState` is possible to restore all the values of a form or keep the form sync'ed on different tabs.
-}
stateToString : State -> String
stateToString =
    R10.Form.Internal.State.toString


{-| -}
stateToValue : State -> Json.Encode.Value
stateToValue =
    R10.Form.Internal.State.encoder


{-| -}
stringToState : String -> Result Json.Decode.Error State
stringToState =
    R10.Form.Internal.State.fromString



-- ██    ██ ██████  ██████   █████  ████████ ███████
-- ██    ██ ██   ██ ██   ██ ██   ██    ██    ██
-- ██    ██ ██████  ██   ██ ███████    ██    █████
-- ██    ██ ██      ██   ██ ██   ██    ██    ██
--  ██████  ██      ██████  ██   ██    ██    ███████


{-| -}
update : (String -> String -> String) -> Msg -> State -> ( State, Cmd Msg )
update =
    R10.Form.Internal.Update.update



--  ██████  ██████  ███    ██ ███████ ██  ██████  ██    ██ ██████   █████  ████████ ██  ██████  ███    ██      █████  ███    ██ ██████      ███████ ███    ██ ████████ ██ ████████ ██ ███████ ███████
-- ██      ██    ██ ████   ██ ██      ██ ██       ██    ██ ██   ██ ██   ██    ██    ██ ██    ██ ████   ██     ██   ██ ████   ██ ██   ██     ██      ████   ██    ██    ██    ██    ██ ██      ██
-- ██      ██    ██ ██ ██  ██ █████   ██ ██   ███ ██    ██ ██████  ███████    ██    ██ ██    ██ ██ ██  ██     ███████ ██ ██  ██ ██   ██     █████   ██ ██  ██    ██    ██    ██    ██ █████   ███████
-- ██      ██    ██ ██  ██ ██ ██      ██ ██    ██ ██    ██ ██   ██ ██   ██    ██    ██ ██    ██ ██  ██ ██     ██   ██ ██  ██ ██ ██   ██     ██      ██  ██ ██    ██    ██    ██    ██ ██           ██
--  ██████  ██████  ██   ████ ██      ██  ██████   ██████  ██   ██ ██   ██    ██    ██  ██████  ██   ████     ██   ██ ██   ████ ██████      ███████ ██   ████    ██    ██    ██    ██ ███████ ███████


{-| The configuration of a form (`Conf`) is simply defined as a list of entities (`List Entity`).
-}
type alias Conf =
    R10.Form.Internal.Conf.Conf


{-| -}
initConf : Conf
initConf =
    R10.Form.Internal.Conf.init


{-| -}
confToString : Conf -> String
confToString =
    R10.Form.Internal.Conf.toString


{-| -}
stringToConf : String -> Result Json.Decode.Error Conf
stringToConf =
    R10.Form.Internal.Conf.fromString


{-| -}
changeFieldConf : (FieldConf -> FieldConf) -> Entity -> Entity
changeFieldConf =
    R10.Form.Internal.Conf.changeFieldConf



-- ███████ ███    ██ ████████ ██ ████████ ██ ███████ ███████
-- ██      ████   ██    ██    ██    ██    ██ ██      ██
-- █████   ██ ██  ██    ██    ██    ██    ██ █████   ███████
-- ██      ██  ██ ██    ██    ██    ██    ██ ██           ██
-- ███████ ██   ████    ██    ██    ██    ██ ███████ ███████


{-| A form is made of multiple **entities**. An example of entity is an input field, a title, a subtitle, etc.
-}
type alias Entity =
    R10.Form.Internal.Conf.Entity


{-| These are entities constructors
-}
entity :
    { field : FieldConf -> Entity
    , multi : EntityId -> List Entity -> Entity
    , normal : EntityId -> List Entity -> Entity
    , subTitle : EntityId -> TextConf -> Entity
    , title : EntityId -> TextConf -> Entity
    , withBorder : EntityId -> List Entity -> Entity
    , withTabs : EntityId -> List ( String, Entity ) -> Entity
    , wrappable : EntityId -> List Entity -> Entity
    }
entity =
    { normal = R10.Form.Internal.Conf.EntityNormal
    , wrappable = R10.Form.Internal.Conf.EntityWrappable
    , withBorder = R10.Form.Internal.Conf.EntityWithBorder
    , withTabs = R10.Form.Internal.Conf.EntityWithTabs
    , multi = R10.Form.Internal.Conf.EntityMulti
    , field = R10.Form.Internal.Conf.EntityField
    , title = R10.Form.Internal.Conf.EntityTitle
    , subTitle = R10.Form.Internal.Conf.EntitySubTitle
    }


{-|

    String

-}
type alias EntityId =
    R10.Form.Internal.Conf.EntityId


{-|

    type alias TextConf =
        { title : String
        , helperText : Maybe String
        , validationSpecs : Maybe ValidationSpecs
        }

-}
type alias TextConf =
    R10.Form.Internal.Conf.TextConf



-- ███████ ██ ███████ ██      ██████       ██████  ██████  ███    ██ ███████     ███████ ████████  █████  ████████ ███████
-- ██      ██ ██      ██      ██   ██     ██      ██    ██ ████   ██ ██          ██         ██    ██   ██    ██    ██
-- █████   ██ █████   ██      ██   ██     ██      ██    ██ ██ ██  ██ █████       ███████    ██    ███████    ██    █████
-- ██      ██ ██      ██      ██   ██     ██      ██    ██ ██  ██ ██ ██               ██    ██    ██   ██    ██    ██
-- ██      ██ ███████ ███████ ██████       ██████  ██████  ██   ████ ██          ███████    ██    ██   ██    ██    ███████


{-|

    type alias FieldConf =
        { id : FieldId
        , idDom : Maybe String
        , type_ : R10.FormTypes.FieldType
        , label : String
        , helperText : Maybe String
        , requiredLabel : Maybe String
        , validationSpecs : Maybe ValidationSpecs
        }

-}
type alias FieldConf =
    R10.Form.Internal.FieldConf.FieldConf


{-| -}
initFieldConf : FieldConf
initFieldConf =
    R10.Form.Internal.FieldConf.init


{-|

    type alias FieldState =
        { lostFocusOneOrMoreTime : Bool
        , value : String
        , search : String
        , select : String
        , scroll : Float
        , dirty : Bool
        , disabled : Bool
        , validation : Validation
        , showPassword : Bool -- Used only for passwords
        }

-}
type alias FieldState =
    R10.Form.Internal.FieldState.FieldState


{-| -}
initFieldState : FieldState
initFieldState =
    R10.Form.Internal.FieldState.init



-- ██   ██ ███████ ██    ██
-- ██  ██  ██       ██  ██
-- █████   █████     ████
-- ██  ██  ██         ██
-- ██   ██ ███████    ██


{-| `Key` is internally defined as a list of strings.

The form is rapresented internally as a tree and the `Key` is the path to reach a node.

-}
type alias Key =
    R10.Form.Internal.Key.Key


{-| -}
type alias KeyAsString =
    R10.Form.Internal.Key.KeyAsString


{-| -}
keyToString : Key -> KeyAsString
keyToString =
    R10.Form.Internal.Key.toString


{-| -}
stringToKey : KeyAsString -> Key
stringToKey =
    R10.Form.Internal.Key.fromString


{-| -}
composeKey : Key -> String -> Key
composeKey =
    R10.Form.Internal.Key.composeKey


{-| -}
listToKey : List String -> Key
listToKey =
    R10.Form.Internal.Key.fromList


{-| -}
headId : Key -> String
headId =
    R10.Form.Internal.Key.headId


{-| -}
emptyKey : Key
emptyKey =
    R10.Form.Internal.Key.empty



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████
--
-- UPDATE


{-| -}
updateField : KeyAsString -> (FieldState -> FieldState) -> State -> State
updateField =
    R10.Form.Internal.Helpers.updateField



-- GET


{-| -}
getField : KeyAsString -> State -> Maybe FieldState
getField =
    R10.Form.Internal.Helpers.getField


{-| -}
getFieldValue : KeyAsString -> State -> Maybe String
getFieldValue =
    R10.Form.Internal.Helpers.getFieldValue


{-| -}
getFieldValueIgnoringPath : KeyAsString -> State -> Maybe String
getFieldValueIgnoringPath =
    R10.Form.Internal.Helpers.getFieldValueIgnoringPath


{-| -}
getFieldValueAsBool : KeyAsString -> State -> Maybe Bool
getFieldValueAsBool =
    R10.Form.Internal.Helpers.getFieldValueAsBool


{-| -}
getActiveTab : KeyAsString -> State -> Maybe String
getActiveTab =
    R10.Form.Internal.Helpers.getActiveTab


{-| -}
getMultiActiveKeys : Key -> State -> List Key
getMultiActiveKeys =
    R10.Form.Internal.Helpers.getMultiActiveKeys



-- SET


{-| -}
setFieldValue : KeyAsString -> String -> State -> State
setFieldValue =
    R10.Form.Internal.Helpers.setFieldValue


{-| -}
setActiveTab : KeyAsString -> String -> State -> State
setActiveTab =
    R10.Form.Internal.Helpers.setActiveTab


{-| -}
setMultiplicableQuantities : KeyAsString -> Int -> State -> State
setMultiplicableQuantities =
    R10.Form.Internal.Helpers.setMultiplicableQuantities


{-| -}
setFieldDisabled : KeyAsString -> Bool -> State -> State
setFieldDisabled =
    R10.Form.Internal.Helpers.setFieldDisabled



-- OTHERS


{-| This function return `True` in one of these two cases

  - The form has never been submitted. This because we want to show an active "Submit" button to the user the first time they load the form.
  - The has been an attempt to submit the form that failed because some data didn't pass the validation. Then the data was fixed so the form can now be submitted.

This function is normally used to disble or not the submit button.

-}
isFormSubmittable : Form -> Bool
isFormSubmittable =
    R10.Form.Internal.Update.isFormSubmittable


{-| -}
stringToBool : String -> Bool
stringToBool =
    R10.Form.Internal.Helpers.stringToBool


{-| -}
boolToString : Bool -> String
boolToString =
    R10.Form.Internal.Helpers.boolToString



-- ███████  ██████  ██████  ███    ███      ██████  ██████  ███    ███ ██████   ██████  ███    ██ ███████ ███    ██ ████████ ███████
-- ██      ██    ██ ██   ██ ████  ████     ██      ██    ██ ████  ████ ██   ██ ██    ██ ████   ██ ██      ████   ██    ██    ██
-- █████   ██    ██ ██████  ██ ████ ██     ██      ██    ██ ██ ████ ██ ██████  ██    ██ ██ ██  ██ █████   ██ ██  ██    ██    ███████
-- ██      ██    ██ ██   ██ ██  ██  ██     ██      ██    ██ ██  ██  ██ ██      ██    ██ ██  ██ ██ ██      ██  ██ ██    ██         ██
-- ██       ██████  ██   ██ ██      ██      ██████  ██████  ██      ██ ██       ██████  ██   ████ ███████ ██   ████    ██    ███████


{-| -}
viewIconButton : List (Attribute (R10.Context.ContextInternal z) msg) -> ArgsIconButton z msg -> Element (R10.Context.ContextInternal z) msg
viewIconButton =
    R10.FormComponents.Internal.IconButton.view


{-| -}
type alias ArgsIconButton z msg =
    { icon : Element (R10.Context.ContextInternal z) msg
    , msgOnClick : Maybe msg
    , palette : R10.Palette.Palette
    , size : Int
    }


{-| -}
viewButton : List (Attribute (R10.Context.ContextInternal z) msg) -> ArgsButton z msg -> Element (R10.Context.ContextInternal z) msg
viewButton =
    R10.FormComponents.Internal.Button.view


{-| -}
type alias ArgsButton z msg =
    R10.FormComponents.Internal.Button.Args z msg


{-| -}
viewText :
    List (Attribute (R10.Context.ContextInternal z) msg)
    -> List (Attribute (R10.Context.ContextInternal z) msg)
    -> ArgsText z msg
    -> Element (R10.Context.ContextInternal z) msg
viewText =
    R10.FormComponents.Internal.Text.view


{-| -}
type alias ArgsText z msg =
    R10.FormComponents.Internal.Text.Args z msg


{-| -}
viewBinary : List (Attribute (R10.Context.ContextInternal z) msg) -> ArgsBinary msg -> Element (R10.Context.ContextInternal z) msg
viewBinary =
    R10.FormComponents.Internal.Binary.view


{-| -}
type alias ArgsBinary msg =
    R10.FormComponents.Internal.Binary.Args msg



-- ███████ ████████ ██    ██ ██      ███████
-- ██         ██     ██  ██  ██      ██
-- ███████    ██      ████   ██      █████
--      ██    ██       ██    ██      ██
-- ███████    ██       ██    ███████ ███████


{-| -}
type alias Style =
    R10.FormComponents.Internal.Style.Style


{-| -}
style : { fixedLabels : Style, floatingLabels : Style }
style =
    { fixedLabels = R10.FormComponents.Internal.Style.FixedLabels
    , floatingLabels = R10.FormComponents.Internal.Style.FloatingLabels
    }


{-| -}
stringToStyle : String -> Style
stringToStyle =
    R10.FormComponents.Internal.Style.fromString


{-| -}
styleToString : Style -> String
styleToString =
    R10.FormComponents.Internal.Style.toString


{-| -}
defaultStyle : Style
defaultStyle =
    R10.FormComponents.Internal.Style.default



-- ██████  ██    ██ ████████ ████████  ██████  ███    ██
-- ██   ██ ██    ██    ██       ██    ██    ██ ████   ██
-- ██████  ██    ██    ██       ██    ██    ██ ██ ██  ██
-- ██   ██ ██    ██    ██       ██    ██    ██ ██  ██ ██
-- ██████   ██████     ██       ██     ██████  ██   ████


{-| -}
type alias Button =
    R10.FormComponents.Internal.Button.Button


{-| -}
button :
    { contained : Button
    , outlined : Button
    , text : Button
    , icon : Button
    }
button =
    { outlined = R10.FormComponents.Internal.Button.Outlined
    , contained = R10.FormComponents.Internal.Button.Contained
    , text = R10.FormComponents.Internal.Button.Text
    , icon = R10.FormComponents.Internal.Button.Icon
    }



-- CSS COLORS PALETTE
--
--  ██████ ███████ ███████
-- ██      ██      ██
-- ██      ███████ ███████
-- ██           ██      ██
--  ██████ ███████ ███████


{-| -}
themeToPalette : R10.Theme.Theme -> R10.Palette.Palette
themeToPalette =
    R10.Palette.fromTheme


{-| -}
label : R10.Palette.Palette -> Color
label =
    R10.FormComponents.Internal.UI.Color.label


{-| -}
extraCssComponents : R10.Palette.Palette -> String
extraCssComponents =
    R10.FormComponents.Internal.ExtraCss.extraCss


{-| -}
extraCss : Maybe R10.Palette.Palette -> String
extraCss =
    R10.Form.Internal.MakerForView.extraCss


{-| -}
colorToCssString : Color -> String
colorToCssString =
    R10.FormComponents.Internal.UI.Color.toCssString



-- ███████ ██    ██ ███████ ███    ██ ████████ ███████
-- ██      ██    ██ ██      ████   ██    ██    ██
-- █████   ██    ██ █████   ██ ██  ██    ██    ███████
-- ██       ██  ██  ██      ██  ██ ██    ██         ██
-- ███████   ████   ███████ ██   ████    ██    ███████


{-| -}
onClickWithStopPropagation : msg -> Attribute (R10.Context.ContextInternal z) msg
onClickWithStopPropagation =
    R10.FormComponents.Internal.UI.onClickWithStopPropagation


{-| -}
onFocusOut : String -> msg -> Json.Decode.Decoder msg
onFocusOut =
    R10.FormComponents.Internal.Utils.FocusOut.onFocusOut


{-| -}
onLoseFocus : (Key -> FieldConf -> a) -> Msg -> Maybe a
onLoseFocus =
    R10.Form.Internal.Msg.onLoseFocus


{-| -}
onValueChange : (Key -> FieldConf -> Conf -> String -> a) -> Msg -> Maybe a
onValueChange =
    R10.Form.Internal.Msg.onValueChange


{-| -}
onOptionSelect : (Key -> FieldConf -> Conf -> String -> a) -> Msg -> Maybe a
onOptionSelect =
    R10.Form.Internal.Msg.onOptionSelect



-- ███    ███  █████  ██████  ██   ██ ██████   ██████  ██     ██ ███    ██
-- ████  ████ ██   ██ ██   ██ ██  ██  ██   ██ ██    ██ ██     ██ ████   ██
-- ██ ████ ██ ███████ ██████  █████   ██   ██ ██    ██ ██  █  ██ ██ ██  ██
-- ██  ██  ██ ██   ██ ██   ██ ██  ██  ██   ██ ██    ██ ██ ███ ██ ██  ██ ██
-- ██      ██ ██   ██ ██   ██ ██   ██ ██████   ██████   ███ ███  ██   ████


{-| -}
elementMarkdown : String -> List (Element (R10.Context.ContextInternal z) msg)
elementMarkdown =
    R10.SimpleMarkdown.elementMarkdown



-- ████████ ██████   █████  ███    ██ ███████ ██       █████  ████████  ██████  ██████
--    ██    ██   ██ ██   ██ ████   ██ ██      ██      ██   ██    ██    ██    ██ ██   ██
--    ██    ██████  ███████ ██ ██  ██ ███████ ██      ███████    ██    ██    ██ ██████
--    ██    ██   ██ ██   ██ ██  ██ ██      ██ ██      ██   ██    ██    ██    ██ ██   ██
--    ██    ██   ██ ██   ██ ██   ████ ███████ ███████ ██   ██    ██     ██████  ██   ██


{-| -}
type alias Translator =
    R10.Form.Internal.Translator.Translator


{-| -}
defaultTranslator : Translator
defaultTranslator =
    R10.Form.Internal.Translator.translator


{-| -}
validationCodes :
    { emailFormatInvalid : ValidationCode
    , emailFormatValid : ValidationCode
    , equalInvalid : ValidationCode
    , formatInvalid : ValidationCode
    , formatInvalidCharactersInvalid : ValidationCode
    , formatNoNumberInvalid : ValidationCode
    , formatNoSpecialCharactersInvalid : ValidationCode
    , formatNoUppercaseInvalid : ValidationCode
    , formatValid : ValidationCode
    , hexColorFormatInvalid : ValidationCode
    , jsonFormatInvalid : ValidationCode
    , lengthTooLargeInvalid : ValidationCode
    , lengthTooSmallInvalid : ValidationCode
    , lengthExactInvalid : ValidationCode
    , lengthValid : ValidationCode
    , required : ValidationCode
    , empty : ValidationCode
    , requiredField : ValidationCode
    , somethingWrong : ValidationCode
    , valueInvalid : ValidationCode
    , allOf : ValidationCode
    , oneOf : ValidationCode
    , mobileEmailFormatInvalid : ValidationCode
    , mobileEmailDomainInvalid : ValidationCode
    }
validationCodes =
    R10.Form.Internal.Translator.validationCodes



-- ███████ ██ ███    ██  ██████  ██      ███████
-- ██      ██ ████   ██ ██       ██      ██
-- ███████ ██ ██ ██  ██ ██   ███ ██      █████
--      ██ ██ ██  ██ ██ ██    ██ ██      ██
-- ███████ ██ ██   ████  ██████  ███████ ███████


{-| -}
type alias SingleModel =
    R10.FormComponents.Internal.Single.Common.Model


{-| -}
type alias SingleMsg =
    R10.FormComponents.Internal.Single.Common.Msg


{-| -}
type alias SingleFieldOption =
    R10.FormComponents.Internal.Single.Common.FieldOption


{-| -}
defaultSearchFn : String -> SingleFieldOption -> Bool
defaultSearchFn =
    R10.FormComponents.Internal.Single.defaultSearchFn


{-| -}
initSingle : SingleModel
initSingle =
    R10.FormComponents.Internal.Single.Common.init


{-| -}
normalizeString : String -> String
normalizeString =
    R10.FormComponents.Internal.Single.normalizeString


{-| -}
insertBold : List Int -> String -> String
insertBold =
    R10.FormComponents.Internal.Single.insertBold


{-| -}
defaultToOptionEl :
    { a | msgOnSelect : String -> msg, search : String }
    -> SingleFieldOption
    -> Element (R10.Context.ContextInternal z) msg
defaultToOptionEl =
    R10.FormComponents.Internal.Single.defaultViewOptionEl


{-| -}
defaultTrailingIcon :
    { a | opened : Bool, palette : R10.Palette.Palette }
    -> Element (R10.Context.ContextInternal z) msg
defaultTrailingIcon =
    R10.FormComponents.Internal.Single.defaultTrailingIcon


{-| -}
singleMsg : { onOptionSelect : String -> SingleMsg }
singleMsg =
    { onOptionSelect = R10.FormComponents.Internal.Single.Common.OnOptionSelect }


{-| -}
updateSingle : SingleMsg -> SingleModel -> ( SingleModel, Cmd SingleMsg )
updateSingle =
    R10.FormComponents.Internal.Single.Update.update



-- VIEWS


{-| -}
viewSingle : List (Attribute (R10.Context.ContextInternal z) msg) -> SingleModel -> ArgsSingle msg -> Element (R10.Context.ContextInternal z) msg
viewSingle =
    R10.FormComponents.Internal.Single.view


{-| -}
type alias ArgsSingle msg =
    R10.FormComponents.Internal.Single.Args msg


{-| -}
viewSingleCustom : List (Attribute (R10.Context.ContextInternal z) msg) -> SingleModel -> ArgsSingleCustom z msg -> Element (R10.Context.ContextInternal z) msg
viewSingleCustom =
    R10.FormComponents.Internal.Single.viewCustom


{-| -}
type alias ArgsSingleCustom z msg =
    R10.FormComponents.Internal.Single.ArgsCustom z msg



-- ██    ██  █████  ██      ██ ██████   █████  ████████ ██  ██████  ███    ██
-- ██    ██ ██   ██ ██      ██ ██   ██ ██   ██    ██    ██ ██    ██ ████   ██
-- ██    ██ ███████ ██      ██ ██   ██ ███████    ██    ██ ██    ██ ██ ██  ██
--  ██  ██  ██   ██ ██      ██ ██   ██ ██   ██    ██    ██ ██    ██ ██  ██ ██
--   ████   ██   ██ ███████ ██ ██████  ██   ██    ██    ██  ██████  ██   ████


{-| -}
type alias Validation =
    R10.Form.Internal.FieldConf.Validation


{-| -}
type alias ValidationForView =
    R10.FormComponents.Internal.Validations.ValidationForView


{-| -}
type alias ValidationMessage =
    R10.Form.Internal.FieldConf.ValidationMessage


{-| -}
type alias ValidationSpecs =
    R10.Form.Internal.FieldConf.ValidationSpecs


type alias Range =
    R10.Form.Internal.FieldConf.Range


{-| -}
validation :
    { allOf : List Validation -> Validation
    , dependant : KeyAsString -> Validation -> Validation
    , equal : KeyAsString -> Validation
    , maxLength : Int -> Validation
    , minLength : Int -> Validation
    , noValidation : Validation
    , oneOf : List Validation -> Validation
    , regex : String -> Validation
    , required : Validation
    , withMsg : ValidationMessage -> Validation -> Validation
    , empty : Validation
    , not : Validation -> Validation
    , dateRange : Range -> Validation
    }
validation =
    { noValidation = R10.Form.Internal.FieldConf.NoValidation
    , withMsg = R10.Form.Internal.FieldConf.WithMsg
    , dependant = R10.Form.Internal.FieldConf.Dependant
    , oneOf = R10.Form.Internal.FieldConf.OneOf
    , allOf = R10.Form.Internal.FieldConf.AllOf
    , equal = R10.Form.Internal.FieldConf.Equal
    , required = R10.Form.Internal.FieldConf.Required
    , minLength = R10.Form.Internal.FieldConf.MinLength
    , maxLength = R10.Form.Internal.FieldConf.MaxLength
    , regex = R10.Form.Internal.FieldConf.Regex
    , empty = R10.Form.Internal.FieldConf.Empty
    , not = R10.Form.Internal.FieldConf.Not
    , dateRange = R10.Form.Internal.FieldConf.DateRange
    }


{-| -}
isRegexValidation : Validation -> Bool
isRegexValidation validation_ =
    case validation_ of
        R10.Form.Internal.FieldConf.WithMsg _ validation__ ->
            isRegexValidation validation__

        R10.Form.Internal.FieldConf.Regex _ ->
            True

        _ ->
            False


{-| Just a `String`
-}
type alias ValidationCode =
    R10.Form.Internal.FieldConf.ValidationCode


{-| -}
validationToString : ValidationForView -> String
validationToString =
    R10.FormComponents.Internal.Validations.validationToString


{-| -}
componentValidation :
    { pretendIsNotYetValidated : ValidationForView
    , validated :
        List R10.FormComponents.Internal.Validations.ValidationMessage
        -> ValidationForView
    }
componentValidation =
    { pretendIsNotYetValidated = R10.FormComponents.Internal.Validations.PretendIsNotYetValidated
    , validated = R10.FormComponents.Internal.Validations.Validated
    }


{-| -}
validationMessage :
    { error : String -> R10.FormComponents.Internal.Validations.ValidationMessage
    , ok : String -> R10.FormComponents.Internal.Validations.ValidationMessage
    }
validationMessage =
    { ok = R10.FormComponents.Internal.Validations.MessageOk
    , error = R10.FormComponents.Internal.Validations.MessageErr
    }


{-| -}
initValidationSpecs : ValidationSpecs
initValidationSpecs =
    R10.Form.Internal.FieldConf.initValidationSpecs


{-| -}
commonValidation :
    { alphaNumericDash : Validation
    , alphaNumericDashSpace : Validation
    , email : Validation
    , hexColor : Validation
    , numeric : Validation
    , password : Validation
    , phoneNumber : Validation
    , url : Validation
    }
commonValidation =
    R10.Form.Internal.Validation.commonValidation


{-| -}
commonRegularExpression :
    { alpha : String
    , alphaNumeric : String
    , alphaNumericDash : String
    , alphaNumericDashSpace : String
    , phoneNumber : String
    , email : String
    , numeric : String
    , integer : String
    , decimal : String
    , url : String
    , hexColor : String
    }
commonRegularExpression =
    R10.Form.Internal.Validation.commonRegularExpression


{-| -}
clearFieldValidation : KeyAsString -> State -> State
clearFieldValidation =
    R10.Form.Internal.Helpers.clearFieldValidation


{-| -}
setFieldValidationError : KeyAsString -> String -> State -> State
setFieldValidationError =
    R10.Form.Internal.Helpers.setFieldValidationError


{-| -}
validate :
    { formStateBeforeValidationFixer : String -> String -> String
    , showAlsoPassedValidation : Bool
    , key : R10.Form.Internal.Key.Key
    , fieldType : R10.FormTypes.FieldType
    , maybeValidationSpec : Maybe R10.Form.Internal.FieldConf.ValidationSpecs
    , formState : R10.Form.Internal.State.State
    }
    -> FieldState
    -> FieldState
validate =
    R10.Form.Internal.Validation.validate


{-| -}
runOnlyExistingValidations :
    (String -> String -> String)
    -> List ( Key, R10.FormTypes.FieldType, Maybe ValidationSpecs )
    -> State
    -> Dict.Dict KeyAsString FieldState
    -> Dict.Dict KeyAsString FieldState
runOnlyExistingValidations =
    R10.Form.Internal.Update.runOnlyExistingValidations


{-| -}
shouldShowTheValidationOverview : State -> Bool
shouldShowTheValidationOverview =
    R10.Form.Internal.Update.shouldShowTheValidationOverview


{-| -}
allValidationKeysMaker : Form -> List ( Key, R10.FormTypes.FieldType, Maybe ValidationSpecs )
allValidationKeysMaker =
    R10.Form.Internal.Update.allValidationKeysMaker


{-| -}
validateEntireForm : (String -> String -> String) -> Form -> State
validateEntireForm =
    R10.Form.Internal.Update.validateEntireForm


{-| -}
validateDirtyFormFields : (String -> String -> String) -> Form -> State
validateDirtyFormFields =
    R10.Form.Internal.Update.validateDirtyFormFields


{-| -}
isExistingFormFieldsValid : Form -> Bool
isExistingFormFieldsValid =
    R10.Form.Internal.Update.isExistingFormFieldsValid


{-| -}
entitiesWithErrors : Form -> List ( Key, R10.FormTypes.FieldType, Maybe ValidationSpecs )
entitiesWithErrors =
    R10.FormComponents.Internal.Utils.entitiesWithErrors


{-| -}
entitiesValidationOutcomes : Form -> Maybe Translator -> List ( Key, R10.FormTypes.FieldType, ValidationForView )
entitiesValidationOutcomes =
    R10.FormComponents.Internal.Utils.entitiesValidationOutcomes


{-| -}
errorsFromApiToValidationForView :
    Translator
    -> List { a | field : String, reasonCode : String }
    -> List ( Key, ValidationForView )
errorsFromApiToValidationForView translator apiErrors =
    List.map
        (\apiError ->
            let
                key : Key
                key =
                    stringToKey apiError.field
            in
            ( key
            , R10.FormComponents.Internal.Validations.Validated
                [ R10.FormComponents.Internal.Validations.MessageErr <|
                    translator key apiError.reasonCode
                ]
            )
        )
        apiErrors


{-| -}
validationForViewToErrorMessages : List ( Key, ValidationForView ) -> List String
validationForViewToErrorMessages valiadtionsForView =
    List.concat <|
        List.filterMap
            (\( _, validation_ ) ->
                case validation_ of
                    R10.FormComponents.Internal.Validations.Validated validatedList ->
                        Just <|
                            List.filterMap
                                (\validated_ ->
                                    case validated_ of
                                        R10.FormComponents.Internal.Validations.MessageErr message ->
                                            Just message

                                        _ ->
                                            Nothing
                                )
                                validatedList

                    _ ->
                        Nothing
            )
            valiadtionsForView



--
-- -- ██████  ██   ██  ██████  ███    ██ ███████
-- -- ██   ██ ██   ██ ██    ██ ████   ██ ██
-- -- ██████  ███████ ██    ██ ██ ██  ██ █████
-- -- ██      ██   ██ ██    ██ ██  ██ ██ ██
-- -- ██      ██   ██  ██████  ██   ████ ███████
--
--
-- {-| -}
-- type alias PhoneModel =
--     R10.FormComponents.Internal.Phone.Common.Model
--
--
-- {-| -}
-- type alias MsgPhone =
--     R10.FormComponents.Internal.Phone.Common.Msg
--
--
-- {-| -}
-- phoneView :
--     List (Attribute (R10.Context.ContextInternal z) msg)
--     -> PhoneModel
--     ->
--         { maybeValid : Maybe Bool
--         , toMsg : MsgPhone -> msg
--         , label : String
--         , helperText : Maybe String
--         , disabled : Bool
--         , requiredLabel : Maybe String
--         , style : Style
--         , key : String
--         , palette : R10.Palette.Palette
--         , countryOptions : Maybe (List R10.Country.Country)
--         }
--     -> Element (R10.Context.ContextInternal z) msg
-- phoneView =
--     R10.FormComponents.Internal.Phone.view
--
--
-- {-| -}
-- updatePhone : MsgPhone -> PhoneModel -> ( PhoneModel, Cmd MsgPhone )
-- updatePhone =
--     R10.FormComponents.Internal.Phone.Update.update
--
--
-- {-| -}
-- phoneInit : PhoneModel
-- phoneInit =
--     R10.FormComponents.Internal.Phone.Common.init
--
--
--████████ ███████ ██   ██ ████████
--   ██    ██       ██ ██     ██
--   ██    █████     ███      ██
--   ██    ██       ██ ██     ██
--   ██    ███████ ██   ██    ██


{-| -}
type alias TextArgs z msg =
    R10.FormComponents.Internal.Text.Args z msg


{-| -}
processValue : { pattern : String, previousValue : String, value : String } -> String
processValue =
    R10.FormComponents.Internal.Text.processValue



--  █████  ██████  ██    ██  █████  ███    ██  ██████ ███████ ██████      ██    ██ ███████  █████   ██████  ███████
-- ██   ██ ██   ██ ██    ██ ██   ██ ████   ██ ██      ██      ██   ██     ██    ██ ██      ██   ██ ██       ██
-- ███████ ██   ██ ██    ██ ███████ ██ ██  ██ ██      █████   ██   ██     ██    ██ ███████ ███████ ██   ███ █████
-- ██   ██ ██   ██  ██  ██  ██   ██ ██  ██ ██ ██      ██      ██   ██     ██    ██      ██ ██   ██ ██    ██ ██
-- ██   ██ ██████    ████   ██   ██ ██   ████  ██████ ███████ ██████       ██████  ███████ ██   ██  ██████  ███████


{-| Utility that can be used to iterate through the entire form configuration and returns a list of results
-}
fieldConfigMap : (FieldConf -> a) -> Conf -> List a
fieldConfigMap =
    R10.Form.Internal.Conf.fieldConfigMap


{-| Utility that can be used to change the configuration of a form on the fly. It can be useful if certain state value of the form can influence some of the validation of the form itself.

For example a Japanese address field can require to have at least one digit in it (called "Banchi", a building number). But some address may be missing this number so we give the user to opt-out from a building number requirement if the click on a check box.

-}
fieldConfigConcatMap : (FieldConf -> List FieldConf) -> Conf -> Conf
fieldConfigConcatMap =
    R10.Form.Internal.Conf.fieldConfigConcatMap



--
--
--


{-| -}
handleWithPatternChange : { pattern : String, oldValue : String, newValue : String } -> String
handleWithPatternChange =
    R10.FormComponents.Internal.Text.handleWithPatternChange
