module R10.Form exposing
    ( view, viewWithTheme, viewWithPalette, viewWithOptions
    , Form, Conf, Entity, entity
    , MsgMapper
    , Options
    , Maker, MakerArgs, maker
    , validate, validation, Validation, ValidationCode, ValidationSpecs, ValidationComponent, ValidationMessage, validateDirtyFormFields, validateEntireForm, validationMessage, validationToString, shouldShowTheValidationOverview, allValidationKeysMaker, runOnlyExistingValidations, commonValidation, clearFieldValidation, componentValidation, initValidationSpecs, isExistingFormFieldsValid, setFieldValidationError, entitiesValidationOutcomes, isRegexValidation
    , PhoneModel, PhoneMsg, phoneView, phoneUpdate, phoneInit
    , SingleModel, SingleMsg, SingleFieldOption, defaultSearchFn, initSingle, normalizeString, insertBold, defaultToOptionEl, defaultTrailingIcon, singleMsg, updateSingle, viewSingle, viewSingleCustom
    , Translator, defaultTranslator, validationCodes
    , style
    , State, initState, stateToString, stringToState
    , extraCss
    , EntityId, TextConf, stringToConf, confToString, initConf
    , FieldConf, initFieldConf
    , update, entitiesWithErrors, submittable, isFormSubmittableAndSubmitted
    , Msg, msg
    , keyToString
    , getFieldValueAsBool
    , FieldState, boolToString, getField, isChangingValues, setFieldValue, stringToBool
    , label, onClickWithStopPropagation, viewIconButton, Style
    , Key, KeyAsString, viewBinary, button, colorToCssString, composeKey, elementMarkdown, emptyKey, entitiesToString, extraCssComponents, getActiveTab, getFieldValue, getMultiActiveKeys, headId, initFieldState, listToKey, onFocusOut, setActiveTab, setFieldDisabled, setMultiplicableQuantities, stringToKey, viewButton, viewText, themeToPalette, ArgsText, onLoseFocus, fieldConfigConcatMap, onValueChange
    )

{-| Useful things to build a form .


# Views

There are four functions to render a form, each with a different degree of customization. They are order from the simplest (less customizable) to the most complex (more customizable).

@docs view, viewWithTheme, viewWithPalette, viewWithOptions


# Form, Conf, State, Entity

@docs Form, Conf, Entity, entity


# MsgMapper

This function is to convert specific form messages (`Msg`) into generic messages (`msg`). Tipically you would define this function like this in your application:

    type Msg
        = MsgForm R10.Form.Internal.Msg

`MsgForm` can now be used as `MsgMapper` that convert `R10.Form.Internal.Msg` into `Msg`.

For a code example have a look at this [simple form](https://github.com/rakutentech/r10/blob/master/examples/simpleForm/src/Main.elm).

@docs MsgMapper


# Views' Options

These are the options that you can use with `viewWithOptions`.

@docs Options


# Maker

@docs Maker, MakerArgs, maker


# Validation

@docs validate, validation, Validation, ValidationCode, ValidationSpecs, ValidationComponent, ValidationMessage, validateDirtyFormFields, validateEntireForm, validationMessage, validationToString, shouldShowTheValidationOverview, allValidationKeysMaker, runOnlyExistingValidations, commonValidation, clearFieldValidation, componentValidation, initValidationSpecs, isExistingFormFieldsValid, setFieldValidationError, entitiesValidationOutcomes, isRegexValidation


# Phone

@docs PhoneModel, PhoneMsg, phoneView, phoneUpdate, phoneInit


# Single Field

@docs SingleModel, SingleMsg, SingleFieldOption, defaultSearchFn, initSingle, normalizeString, insertBold, defaultToOptionEl, defaultTrailingIcon, singleMsg, updateSingle, viewSingle, viewSingleCustom


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
              , "All the validations have failed"
              )
            ]
            |> Dict.get validationCode
            |> Maybe.withDefault validationCode

@docs Translator, defaultTranslator, validationCodes


# Style

@docs style


# State

@docs State, initState, stateToString, stringToState


# Extra CSS

@docs extraCss


# Form related stuff

@docs EntityId, TextConf, stringToConf, confToString, initConf


# Fields related stuff

@docs FieldConf, initFieldConf

@docs update, entitiesWithErrors, submittable, isFormSubmittableAndSubmitted

@docs Msg, msg

@docs keyToString

@docs getFieldValueAsBool

@docs FieldState, boolToString, getField, isChangingValues, setFieldValue, stringToBool

@docs label, onClickWithStopPropagation, viewIconButton, Style

@docs Key, KeyAsString, viewBinary, button, colorToCssString, composeKey, elementMarkdown, emptyKey, entitiesToString, extraCssComponents, getActiveTab, getFieldValue, getMultiActiveKeys, headId, initFieldState, listToKey, onFocusOut, setActiveTab, setFieldDisabled, setMultiplicableQuantities, stringToKey, viewButton, viewText, themeToPalette, ArgsText, onLoseFocus, fieldConfigConcatMap, onValueChange

-}

import Dict
import Element exposing (..)
import Json.Decode
import R10.Country
import R10.Form.Internal.Conf
import R10.Form.Internal.Converter
import R10.Form.Internal.Dict
import R10.Form.Internal.FieldConf
import R10.Form.Internal.FieldState
import R10.Form.Internal.Helpers
import R10.Form.Internal.Key
import R10.Form.Internal.MakerForValues
import R10.Form.Internal.MakerForView
import R10.Form.Internal.Msg
import R10.Form.Internal.Shared
import R10.Form.Internal.State
import R10.Form.Internal.StateForValues
import R10.Form.Internal.Translator
import R10.Form.Internal.Update
import R10.Form.Internal.Validation
import R10.FormComponents.Internal.Binary
import R10.FormComponents.Internal.Button
import R10.FormComponents.Internal.ExtraCss
import R10.FormComponents.Internal.IconButton
import R10.FormComponents.Internal.Phone
import R10.FormComponents.Internal.Phone.Common
import R10.FormComponents.Internal.Phone.Update
import R10.FormComponents.Internal.Single
import R10.FormComponents.Internal.Single.Common
import R10.FormComponents.Internal.Single.Update
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.Text
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.UI.Palette
import R10.FormComponents.Internal.Utils
import R10.FormComponents.Internal.Utils.FocusOut
import R10.FormComponents.Internal.Validations
import R10.FormTypes
import R10.SimpleMarkdown
import R10.Theme


{-| -}
type alias MakerArgs =
    { key : Key
    , formState : State
    , translator : Translator
    , style : Style
    , palette : R10.FormTypes.Palette
    }


{-| -}
type alias Maker =
    MakerArgs -> List Entity -> List (Element Msg)


{-| -}
type alias MsgMapper msg =
    Msg -> msg


{-| This is the simplest way to render a form, as you can see in this minimalistic example:

    module Main exposing (main)

    import Element exposing (..)
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
view : Form -> MsgMapper msg -> List (Element msg)
view form msgMapper =
    viewWithOptions form
        msgMapper
        { maker = Nothing
        , translator = Nothing
        , style = style.outlined
        , palette = Nothing
        }


{-| Use this version if you have a specific palette that you want to use.
-}
viewWithPalette : Form -> MsgMapper msg -> R10.FormTypes.Palette -> List (Element msg)
viewWithPalette form msgMapper palette =
    viewWithOptions form
        msgMapper
        { maker = Nothing
        , translator = Nothing
        , style = style.outlined
        , palette = Just palette
        }


{-| Use this version if you have `R10.Theme.Theme`.
-}
viewWithTheme : Form -> MsgMapper msg -> R10.Theme.Theme -> List (Element msg)
viewWithTheme form msgMapper theme =
    let
        palette =
            themeToPalette theme
    in
    viewWithOptions form
        msgMapper
        { maker = Nothing
        , translator = Nothing
        , style = style.outlined
        , palette = Just palette
        }


{-| -}
type alias Options =
    { maker : Maybe Maker
    , translator : Maybe Translator
    , style : Style
    , palette : Maybe R10.FormTypes.Palette
    }


{-| Use this version for full control.
-}
viewWithOptions : Form -> MsgMapper msg -> Options -> List (Element msg)
viewWithOptions form msgMapper args =
    let
        maker_ :
            R10.Form.Internal.MakerForView.MakerArgs
            -> Conf
            -> List R10.Form.Internal.MakerForView.Outcome
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
            , palette = Maybe.withDefault R10.FormComponents.Internal.UI.Palette.light args.palette
            }
            form.conf
        )


{-| -}
themeToPalette : R10.Theme.Theme -> R10.FormTypes.Palette
themeToPalette =
    R10.FormComponents.Internal.UI.Palette.fromTheme



-- EXPOSING STUFF FROM R10.Form.Internal.MakerForView


{-| -}
extraCss : Maybe R10.FormTypes.Palette -> String
extraCss =
    R10.Form.Internal.MakerForView.extraCss



-- EXPOSING STUFF FROM R10.Form.Internal.Conf


{-| `Conf` is simply defined as a `List Entity`.
-}
type alias Conf =
    R10.Form.Internal.Conf.Conf


{-| A form is made of multiple **entities**. An example of entity is an input field, a title, a subtitle, etc.
-}
type alias Entity =
    R10.Form.Internal.Conf.Entity


{-| -}
type alias EntityId =
    R10.Form.Internal.Conf.EntityId


{-| -}
type alias TextConf =
    R10.Form.Internal.Conf.TextConf


{-| These are the constructors for entities
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


{-| -}
initConf : List Entity
initConf =
    R10.Form.Internal.Conf.init


{-| -}
stringToConf : String -> Result Json.Decode.Error Conf
stringToConf =
    R10.Form.Internal.Conf.fromString


{-| -}
confToString : Conf -> String
confToString =
    R10.Form.Internal.Conf.toString



-- EXPOSING STUFF FROM R10.Form.Internal.FieldConf


{-| -}
type alias FieldConf =
    R10.Form.Internal.FieldConf.FieldConf


{-| -}
initFieldConf : FieldConf
initFieldConf =
    R10.Form.Internal.FieldConf.init



-- EXPOSING STUFF FROM R10.Form.Internal.FieldState


{-| -}
type alias FieldState =
    R10.Form.Internal.FieldState.FieldState



-- EXPOSING STUFF FROM R10.Form.Internal.State


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


{-| This can be useful to store the state of a form to the Local Storage, for example. Then, using `stringToState` is possible to restore all the values of a form or keep the form sync'ed on different tabs.
-}
stateToString : State -> String
stateToString =
    R10.Form.Internal.State.toString


{-| -}
stringToState : String -> Result Json.Decode.Error State
stringToState =
    R10.Form.Internal.State.fromString



-- EXPOSING STUFF FROM R10.Form.Internal.Update


{-| -}
update : Msg -> State -> ( State, Cmd Msg )
update =
    R10.Form.Internal.Update.update


{-| -}
fieldConfigConcatMap : (FieldConf -> List FieldConf) -> Conf -> Conf
fieldConfigConcatMap =
    R10.Form.Internal.Conf.fieldConfigConcatMap


{-| -}
submittable : Form -> Bool
submittable =
    R10.Form.Internal.Update.submittable


{-| -}
isFormSubmittableAndSubmitted : Form -> Msg -> Bool
isFormSubmittableAndSubmitted =
    R10.Form.Internal.Update.isFormSubmittableAndSubmitted



-- EXPOSING STUFF FROM R10.Form.Internal.Msg


{-| -}
type alias Msg =
    R10.Form.Internal.Msg.Msg


{-| -}
msg : { submit : Conf -> Msg }
msg =
    { submit = R10.Form.Internal.Msg.Submit }



-- EXPOSING STUFF FROM R10.Form.Internal.Shared


{-| A form is defined by the **configuration** (`R10.Form.Conf`) that contain data about the input fields, radio buttons, etc. and the **state** (`R10.Form.State`), containing instead all the values and other parameters that change during the life of the form.

    type alias Form =
        { conf : R10.Form.Internal.Conf
        , state : R10.Form.Internal.State
        }

-}
type alias Form =
    R10.Form.Internal.Shared.Form



-- EXPOSING STUFF FROM R10.Form.Internal.Key


{-| -}
type alias Key =
    R10.Form.Internal.Key.Key


{-| -}
type alias KeyAsString =
    R10.Form.Internal.Key.KeyAsString


{-| -}
keyToString : Key -> KeyAsString
keyToString =
    R10.Form.Internal.Key.toString



-- EXPOSING STUFF FROM R10.Form.Internal.Helpers


{-| -}
getFieldValueAsBool : KeyAsString -> State -> Maybe Bool
getFieldValueAsBool =
    R10.Form.Internal.Helpers.getFieldValueAsBool


{-| -}
getFieldValue : KeyAsString -> State -> Maybe String
getFieldValue =
    R10.Form.Internal.Helpers.getFieldValue


{-| -}
stringToBool : String -> Bool
stringToBool =
    R10.Form.Internal.Helpers.stringToBool


{-| -}
boolToString : Bool -> String
boolToString =
    R10.Form.Internal.Helpers.boolToString


{-| -}
setFieldValue : KeyAsString -> String -> State -> State
setFieldValue =
    R10.Form.Internal.Helpers.setFieldValue


{-| -}
getField : KeyAsString -> State -> Maybe FieldState
getField =
    R10.Form.Internal.Helpers.getField


{-| -}
isChangingValues : Msg -> Bool
isChangingValues =
    R10.Form.Internal.Msg.isChangingValues



-- IMPORTING STUFF FROM FormComponents


{-| -}
type alias Style =
    R10.FormComponents.Internal.Style.Style


{-| -}
style : { filled : Style, outlined : Style }
style =
    { filled = R10.FormComponents.Internal.Style.Filled
    , outlined = R10.FormComponents.Internal.Style.Outlined
    }


{-| -}
label : R10.FormTypes.Palette -> Color
label =
    R10.FormComponents.Internal.UI.Color.label


{-| -}
onClickWithStopPropagation : msg -> Attribute msg
onClickWithStopPropagation =
    R10.FormComponents.Internal.UI.onClickWithStopPropagation


{-| -}
viewIconButton :
    List (Element.Attribute msg)
    ->
        { icon : Element msg
        , msgOnClick : Maybe msg
        , palette : R10.FormTypes.Palette
        , size : Int
        }
    -> Element msg
viewIconButton =
    R10.FormComponents.Internal.IconButton.view



-- NEW ADDITIONS AFTER SSP


{-| -}
getMultiActiveKeys : Key -> State -> List Key
getMultiActiveKeys =
    R10.Form.Internal.Helpers.getMultiActiveKeys


{-| -}
stringToKey : KeyAsString -> Key
stringToKey =
    R10.Form.Internal.Key.fromString


{-| -}
composeKey : Key -> String -> Key
composeKey =
    R10.Form.Internal.Key.composeKey


{-| -}
initFieldState : FieldState
initFieldState =
    R10.Form.Internal.FieldState.init


{-| -}
listToKey : List String -> Key
listToKey =
    R10.Form.Internal.Key.fromList


{-| -}
setMultiplicableQuantities : KeyAsString -> Int -> State -> State
setMultiplicableQuantities =
    R10.Form.Internal.Helpers.setMultiplicableQuantities


{-| -}
headId : Key -> Maybe String
headId =
    R10.Form.Internal.Key.headId


{-| -}
viewButton :
    List (Attribute msg)
    -> R10.FormComponents.Internal.Button.Args msg
    -> Element msg
viewButton =
    R10.FormComponents.Internal.Button.view


{-| -}
button :
    { contained : R10.FormComponents.Internal.Button.Button
    , outlined : R10.FormComponents.Internal.Button.Button
    , text : R10.FormComponents.Internal.Button.Button
    , icon : R10.FormComponents.Internal.Button.Button
    }
button =
    { outlined = R10.FormComponents.Internal.Button.Outlined
    , contained = R10.FormComponents.Internal.Button.Contained
    , text = R10.FormComponents.Internal.Button.Text
    , icon = R10.FormComponents.Internal.Button.Icon
    }


{-| -}
setFieldDisabled : KeyAsString -> Bool -> State -> State
setFieldDisabled =
    R10.Form.Internal.Helpers.setFieldDisabled


{-| -}
getActiveTab : KeyAsString -> State -> Maybe String
getActiveTab =
    R10.Form.Internal.Helpers.getActiveTab


{-| -}
setActiveTab : KeyAsString -> String -> State -> State
setActiveTab =
    R10.Form.Internal.Helpers.setActiveTab


{-| -}
colorToCssString : Color -> String
colorToCssString =
    R10.FormComponents.Internal.UI.Color.toCssString


{-| -}
elementMarkdown : String -> List (Element msg)
elementMarkdown =
    R10.SimpleMarkdown.elementMarkdown


{-| -}
onFocusOut : String -> msg -> Json.Decode.Decoder msg
onFocusOut =
    R10.FormComponents.Internal.Utils.FocusOut.onFocusOut


{-| -}
onLoseFocus : (Key -> FieldConf -> any) -> Msg -> Maybe any
onLoseFocus func msg_ =
    case msg_ of
        R10.Form.Internal.Msg.LoseFocus key conf ->
            Just (func key conf)

        _ ->
            Nothing


{-| -}
onValueChange : (Key -> FieldConf -> Conf -> String -> any) -> Msg -> Maybe any
onValueChange func msg_ =
    case msg_ of
        R10.Form.Internal.Msg.ChangeValue key fieldConf formConf value ->
            Just (func key fieldConf formConf value)

        _ ->
            Nothing


{-| -}
entitiesToString : List R10.Form.Internal.StateForValues.Entity -> String
entitiesToString =
    R10.Form.Internal.StateForValues.toString


{-| -}
maker : Key -> State -> Conf -> List R10.Form.Internal.StateForValues.Entity
maker =
    R10.Form.Internal.MakerForValues.maker


{-| -}
emptyKey : Key
emptyKey =
    R10.Form.Internal.Key.empty



--  ██████  ████████ ██   ██ ███████ ██████  ███████
-- ██    ██    ██    ██   ██ ██      ██   ██ ██
-- ██    ██    ██    ███████ █████   ██████  ███████
-- ██    ██    ██    ██   ██ ██      ██   ██      ██
--  ██████     ██    ██   ██ ███████ ██   ██ ███████


{-| -}
type alias ArgsText msg =
    R10.FormComponents.Internal.Text.Args msg


{-| -}
viewText : List (Attribute msg) -> List (Attribute msg) -> ArgsText msg -> Element msg
viewText =
    R10.FormComponents.Internal.Text.view


{-| -}
type alias ArgsBinary msg =
    R10.FormComponents.Internal.Binary.Args msg


{-| -}
viewBinary : List (Attribute msg) -> ArgsBinary msg -> Element msg
viewBinary =
    R10.FormComponents.Internal.Binary.view


{-| -}
extraCssComponents : R10.FormTypes.Palette -> String
extraCssComponents =
    R10.FormComponents.Internal.ExtraCss.extraCss



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
    , required : ValidationCode
    , empty : ValidationCode
    , requiredField : ValidationCode
    , somethingWrong : ValidationCode
    , valueInvalid : ValidationCode
    , allOf : ValidationCode
    , oneOf : ValidationCode
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
    -> Element msg
defaultToOptionEl =
    R10.FormComponents.Internal.Single.defaultViewOptionEl


{-| -}
defaultTrailingIcon :
    { a | opened : Bool, palette : R10.FormTypes.Palette }
    -> Element msg
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


{-| -}
type alias ArgsSingle msg =
    R10.FormComponents.Internal.Single.Args msg


{-| -}
viewSingle : List (Attribute msg) -> SingleModel -> ArgsSingle msg -> Element msg
viewSingle =
    R10.FormComponents.Internal.Single.view


{-| -}
type alias ArgsSingleCustom msg =
    R10.FormComponents.Internal.Single.ArgsCustom msg


{-| -}
viewSingleCustom : List (Element.Attribute msg) -> SingleModel -> ArgsSingleCustom msg -> Element msg
viewSingleCustom =
    R10.FormComponents.Internal.Single.viewCustom



-- ██    ██  █████  ██      ██ ██████   █████  ████████ ██  ██████  ███    ██
-- ██    ██ ██   ██ ██      ██ ██   ██ ██   ██    ██    ██ ██    ██ ████   ██
-- ██    ██ ███████ ██      ██ ██   ██ ███████    ██    ██ ██    ██ ██ ██  ██
--  ██  ██  ██   ██ ██      ██ ██   ██ ██   ██    ██    ██ ██    ██ ██  ██ ██
--   ████   ██   ██ ███████ ██ ██████  ██   ██    ██    ██  ██████  ██   ████


{-| -}
type alias Validation =
    R10.Form.Internal.FieldConf.Validation


{-| -}
type alias ValidationComponent =
    R10.FormComponents.Internal.Validations.Validation


{-| -}
type alias ValidationMessage =
    R10.Form.Internal.FieldConf.ValidationMessage


{-| -}
type alias ValidationSpecs =
    R10.Form.Internal.FieldConf.ValidationSpecs


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
validationToString : ValidationComponent -> String
validationToString =
    R10.FormComponents.Internal.Validations.validationToString


{-| -}
componentValidation :
    { notYetValidated : ValidationComponent
    , validated :
        List R10.FormComponents.Internal.Validations.ValidationMessage
        -> ValidationComponent
    }
componentValidation =
    { notYetValidated = R10.FormComponents.Internal.Validations.NotYetValidated
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
clearFieldValidation : KeyAsString -> State -> State
clearFieldValidation =
    R10.Form.Internal.Helpers.clearFieldValidation


{-| -}
initValidationSpecs : ValidationSpecs
initValidationSpecs =
    R10.Form.Internal.FieldConf.initValidationSpecs


{-| -}
setFieldValidationError : KeyAsString -> String -> State -> State
setFieldValidationError =
    R10.Form.Internal.Helpers.setFieldValidationError


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
validate : Key -> Maybe ValidationSpecs -> State -> FieldState -> FieldState
validate =
    R10.Form.Internal.Validation.validate


{-| -}
runOnlyExistingValidations :
    List ( Key, Maybe ValidationSpecs )
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
allValidationKeysMaker : Form -> List ( Key, Maybe ValidationSpecs )
allValidationKeysMaker =
    R10.Form.Internal.Update.allValidationKeysMaker


{-| -}
validateEntireForm : Form -> State
validateEntireForm =
    R10.Form.Internal.Update.validateEntireForm


{-| -}
validateDirtyFormFields : Form -> State
validateDirtyFormFields =
    R10.Form.Internal.Update.validateDirtyFormFields


{-| -}
isExistingFormFieldsValid : Form -> Bool
isExistingFormFieldsValid =
    R10.Form.Internal.Update.isExistingFormFieldsValid


{-| -}
entitiesWithErrors : Form -> List ( Key, Maybe ValidationSpecs )
entitiesWithErrors form =
    let
        allKeys : List ( Key, Maybe ValidationSpecs )
        allKeys =
            R10.Form.Internal.Update.allValidationKeysMaker form

        fieldsWithErrors_ : List ( Key, Maybe ValidationSpecs )
        fieldsWithErrors_ =
            R10.Form.Internal.Update.entitiesWithErrors allKeys form.state.fieldsState
    in
    fieldsWithErrors_


{-| -}
entitiesValidationOutcomes : Form -> Maybe Translator -> List ( Key, ValidationComponent )
entitiesValidationOutcomes =
    R10.FormComponents.Internal.Utils.entitiesValidationOutcomes



-- ██████  ██   ██  ██████  ███    ██ ███████
-- ██   ██ ██   ██ ██    ██ ████   ██ ██
-- ██████  ███████ ██    ██ ██ ██  ██ █████
-- ██      ██   ██ ██    ██ ██  ██ ██ ██
-- ██      ██   ██  ██████  ██   ████ ███████


{-| -}
type alias PhoneModel =
    R10.FormComponents.Internal.Phone.Common.Model


{-| -}
type alias PhoneMsg =
    R10.FormComponents.Internal.Phone.Common.Msg


{-| -}
phoneView :
    List (Attribute msg)
    -> PhoneModel
    ->
        { valid : Maybe Bool
        , toMsg : PhoneMsg -> msg
        , label : String
        , helperText : Maybe String
        , disabled : Bool
        , requiredLabel : Maybe String
        , style : Style
        , key : String
        , palette : R10.FormTypes.Palette
        , countryOptions : Maybe (List R10.Country.Country)
        }
    -> Element msg
phoneView =
    R10.FormComponents.Internal.Phone.view


{-| -}
phoneUpdate : PhoneMsg -> PhoneModel -> ( PhoneModel, Cmd PhoneMsg )
phoneUpdate =
    R10.FormComponents.Internal.Phone.Update.update


{-| -}
phoneInit : PhoneModel
phoneInit =
    R10.FormComponents.Internal.Phone.Common.init
