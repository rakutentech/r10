module R10.Form exposing
    ( view, viewWithOptions, viewWithPalette
    , Options, defaultTranslator
    , Maker, MakerArgs
    , Model, Conf
    , State, initState, stateToString, stringToState
    , extraCss
    , Entity, EntityId, TextConf, entity, stringToConf, confToString, initConf
    , FieldConf, TypeSingle, single, fieldType, text, validationIcon, validation, binary, initFieldConf
    , update, shouldShowTheValidationOverview, allValidationKeysMaker, entitiesWithErrors, runOnlyExistingValidations, submittable, isFormSubmittableAndSubmitted
    , Msg, msg
    , keyToString
    , getFieldValueAsBool
    , commonValidation
    , FieldState, Validation, ValidationSpecs, boolToString, getField, isChangingValues, setFieldValue, stringToBool, validate
    , Palette, style, label, onClickWithStopPropagation, viewIconButton, viewSingleCustom, defaultSearchFn, SingleModel, SingleMsg, initSingle, typeSingle, normalizeString, insertBold, defaultToOptionEl, defaultTrailingIcon, SingleType, SingleFieldOption, singleMsg, Style
    )

{-| Use this stuff if you need to add a form in your page.


# Views

@docs view, viewWithOptions, viewWithPalette


# View Options

@docs Options, defaultTranslator


# Maker

@docs Maker, MakerArgs


# Model

@docs Model, Conf


# State

@docs State, initState, stateToString, stringToState


# Extra CSS

@docs extraCss


# Form related stuff

@docs Entity, EntityId, TextConf, entity, stringToConf, confToString, initConf


# Fields related stuff

@docs FieldConf, TypeSingle, single, fieldType, text, validationIcon, validation, binary, initFieldConf

@docs update, shouldShowTheValidationOverview, allValidationKeysMaker, entitiesWithErrors, runOnlyExistingValidations, submittable, isFormSubmittableAndSubmitted

@docs Msg, msg

@docs keyToString

@docs getFieldValueAsBool

@docs commonValidation

@docs FieldState, Validation, ValidationSpecs, boolToString, getField, isChangingValues, setFieldValue, stringToBool, validate

@docs Palette, style, label, onClickWithStopPropagation, viewIconButton, viewSingleCustom, defaultSearchFn, SingleModel, SingleMsg, initSingle, typeSingle, normalizeString, insertBold, defaultToOptionEl, defaultTrailingIcon, SingleType, SingleFieldOption, singleMsg, Style

-}

import Dict
import Element exposing (..)
import Json.Decode
import R10.Form.Conf
import R10.Form.FieldConf
import R10.Form.FieldState
import R10.Form.Helpers
import R10.Form.Key
import R10.Form.MakerForView
import R10.Form.Msg
import R10.Form.Shared
import R10.Form.State
import R10.Form.Update
import R10.Form.Validation
import R10.Form.ValidationCode
import R10.FormComponents.IconButton
import R10.FormComponents.Single
import R10.FormComponents.Single.Common
import R10.FormComponents.Style
import R10.FormComponents.UI
import R10.FormComponents.UI.Color
import R10.FormComponents.UI.Palette
import R10.FormComponents.Validations


{-| -}
type alias MakerArgs =
    { key : Key
    , formState : State
    , translator : ValidationCode -> String
    , style : Style
    , palette : Palette
    }


type alias ValidationCode =
    R10.Form.FieldConf.ValidationCode


{-| -}
type alias Maker =
    MakerArgs
    -> List R10.Form.Conf.Entity
    -> List (Element R10.Form.Msg.Msg)


{-| `style` can be

    * style.filled
    * style.outlined

`palette` is

    type alias Palette =
        { primary : Color
        , primaryVariant : Color
        , success : Color
        , error : Color

        -- Text Colors
        --
        , onSurface : Color
        , onPrimary : Color

        -- Background Colors
        --
        , surface : Color
        , background : Color
        }

See <https://material.io/design/color/dark-theme.html#properties> for more details.

If you want to use the default palette, just pass `Nothing`

-}
type alias Options =
    { maker : Maybe Maker
    , translator : Maybe (ValidationCode -> String)
    , style : Style
    , palette : Maybe Palette
    }


{-| This is the simplest no-configuration version of the view. Just pass
-}
view : Model -> (Msg -> msg) -> List (Element msg)
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
viewWithPalette : Model -> (Msg -> msg) -> Palette -> List (Element msg)
viewWithPalette form msgMapper palette =
    viewWithOptions form
        msgMapper
        { maker = Nothing
        , translator = Nothing
        , style = style.outlined
        , palette = Just palette
        }


{-| Use this version for a full control.
-}
viewWithOptions : Model -> (R10.Form.Msg.Msg -> msg) -> Options -> List (Element msg)
viewWithOptions form msgMapper args =
    List.map
        (map msgMapper)
        (Maybe.withDefault R10.Form.MakerForView.maker
            args.maker
            { key = R10.Form.Key.empty
            , formState = form.state
            , translator = Maybe.withDefault defaultTranslator args.translator
            , style = args.style
            , palette = Maybe.withDefault R10.FormComponents.UI.Palette.light args.palette
            }
            form.conf
        )


{-| -}
defaultTranslator : ValidationCode -> String
defaultTranslator =
    R10.Form.ValidationCode.translator



-- EXPOSING STUFF FROM R10.Form.MakerForView


{-| -}
extraCss : Maybe Palette -> String
extraCss =
    R10.Form.MakerForView.extraCss



-- EXPOSING STUFF FROM R10.Form.Conf


{-| -}
type alias Conf =
    R10.Form.Conf.Conf


{-| -}
type alias Entity =
    R10.Form.Conf.Entity


{-| -}
type alias EntityId =
    R10.Form.Conf.EntityId


{-| -}
type alias TextConf =
    R10.Form.Conf.TextConf


{-| -}
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
    { normal = R10.Form.Conf.EntityNormal
    , wrappable = R10.Form.Conf.EntityWrappable
    , withBorder = R10.Form.Conf.EntityWithBorder
    , withTabs = R10.Form.Conf.EntityWithTabs
    , multi = R10.Form.Conf.EntityMulti
    , field = R10.Form.Conf.EntityField
    , title = R10.Form.Conf.EntityTitle
    , subTitle = R10.Form.Conf.EntitySubTitle
    }


{-| -}
initConf : List Entity
initConf =
    R10.Form.Conf.init


{-| -}
stringToConf : String -> Result Json.Decode.Error Conf
stringToConf =
    R10.Form.Conf.fromString


{-| -}
confToString : Conf -> String
confToString =
    R10.Form.Conf.toString



-- EXPOSING STUFF FROM R10.Form.FieldConf


{-| -}
type alias FieldConf =
    R10.Form.FieldConf.FieldConf


{-| -}
type alias TypeSingle =
    R10.Form.FieldConf.TypeSingle


{-| -}
type alias FieldType =
    R10.Form.FieldConf.FieldType


{-| -}
type alias TypeBinary =
    R10.Form.FieldConf.TypeBinary


{-| -}
type alias TypeMulti =
    R10.Form.FieldConf.TypeMulti


{-| -}
type alias TypeText =
    R10.Form.FieldConf.TypeText


{-| -}
type alias FieldOption =
    R10.Form.FieldConf.FieldOption


{-| -}
type alias ValidationIcon =
    R10.Form.FieldConf.ValidationIcon


{-| -}
type alias Validation =
    R10.Form.FieldConf.Validation


{-| -}
type alias ValidationMessage =
    R10.Form.FieldConf.ValidationMessage


{-| -}
type alias ValidationSpecs =
    R10.Form.FieldConf.ValidationSpecs


{-| -}
fieldType :
    { text : TypeText -> FieldType
    , single : TypeSingle -> List FieldOption -> FieldType
    , multi : TypeMulti -> List FieldOption -> FieldType
    , binary : TypeBinary -> FieldType
    }
fieldType =
    { text = R10.Form.FieldConf.TypeText
    , single = R10.Form.FieldConf.TypeSingle
    , multi = R10.Form.FieldConf.TypeMulti
    , binary = R10.Form.FieldConf.TypeBinary
    }


{-| -}
single :
    { combobox : TypeSingle
    , radio : TypeSingle
    }
single =
    { combobox = R10.Form.FieldConf.SingleCombobox
    , radio = R10.Form.FieldConf.SingleRadio
    }


{-| -}
text :
    { plain : TypeText
    , email : TypeText
    , username : TypeText
    , passwordNew : TypeText
    , passwordCurrent : TypeText
    , multiline : TypeText
    , withPattern : String -> TypeText
    }
text =
    { plain = R10.Form.FieldConf.TextPlain
    , email = R10.Form.FieldConf.TextEmail
    , username = R10.Form.FieldConf.TextUsername
    , passwordNew = R10.Form.FieldConf.TextPasswordNew
    , passwordCurrent = R10.Form.FieldConf.TextPasswordCurrent
    , multiline = R10.Form.FieldConf.TextMultiline
    , withPattern = R10.Form.FieldConf.TextWithPattern
    }


{-| -}
validationIcon :
    { clearOrCheck : ValidationIcon
    , errorOrCheck : ValidationIcon
    , noIcon : ValidationIcon
    }
validationIcon =
    { noIcon = R10.Form.FieldConf.NoIcon
    , clearOrCheck = R10.Form.FieldConf.ClearOrCheck -- clear aka cross
    , errorOrCheck = R10.Form.FieldConf.ErrorOrCheck -- "!" in circle, just like Google's
    }


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
    }
validation =
    { noValidation = R10.Form.FieldConf.NoValidation
    , withMsg = R10.Form.FieldConf.WithMsg
    , dependant = R10.Form.FieldConf.Dependant
    , oneOf = R10.Form.FieldConf.OneOf
    , allOf = R10.Form.FieldConf.AllOf
    , equal = R10.Form.FieldConf.Equal
    , required = R10.Form.FieldConf.Required
    , minLength = R10.Form.FieldConf.MinLength
    , maxLength = R10.Form.FieldConf.MaxLength
    , regex = R10.Form.FieldConf.Regex
    }


{-| -}
binary :
    { checkbox : TypeBinary
    , switch : TypeBinary
    }
binary =
    { checkbox = R10.Form.FieldConf.BinaryCheckbox
    , switch = R10.Form.FieldConf.BinarySwitch
    }


{-| -}
initFieldConf : R10.Form.FieldConf.FieldConf
initFieldConf =
    R10.Form.FieldConf.init



-- EXPOSING STUFF FROM R10.Form.FieldState


{-| -}
type alias FieldState =
    R10.Form.FieldState.FieldState



-- EXPOSING STUFF FROM R10.Form.State


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
    R10.Form.State.State


{-| -}
initState : State
initState =
    R10.Form.State.init


{-| This can be useful to store the state of a form to the Local Storage, for example. Then, using `stringToState` is possible to restore all the values of a form or keep the form sync'ed on different tabs.
-}
stateToString : R10.Form.State.State -> String
stateToString =
    R10.Form.State.toString


{-| -}
stringToState : String -> Result Json.Decode.Error R10.Form.State.State
stringToState =
    R10.Form.State.fromString



-- EXPOSING STUFF FROM R10.Form.Update


{-| -}
update : Msg -> State -> ( State, Cmd Msg )
update =
    R10.Form.Update.update


{-| -}
shouldShowTheValidationOverview : R10.Form.State.State -> Bool
shouldShowTheValidationOverview =
    R10.Form.Update.shouldShowTheValidationOverview


{-| -}
allValidationKeysMaker : Conf -> State -> List ( Key, Maybe ValidationSpecs )
allValidationKeysMaker =
    R10.Form.Update.allValidationKeysMaker


{-| -}
entitiesWithErrors : List ( Key, Maybe ValidationSpecs ) -> Dict.Dict KeyAsString FieldState -> List ( Key, Maybe ValidationSpecs )
entitiesWithErrors =
    R10.Form.Update.entitiesWithErrors


{-| -}
runOnlyExistingValidations : List ( Key, Maybe ValidationSpecs ) -> State -> Dict.Dict KeyAsString FieldState -> Dict.Dict KeyAsString FieldState
runOnlyExistingValidations =
    R10.Form.Update.runOnlyExistingValidations


{-| -}
submittable : Conf -> State -> Bool
submittable =
    R10.Form.Update.submittable


{-| -}
isFormSubmittableAndSubmitted : Conf -> State -> Msg -> Bool
isFormSubmittableAndSubmitted =
    R10.Form.Update.isFormSubmittableAndSubmitted



-- EXPOSING STUFF FROM R10.Form.Msg


{-| -}
type alias Msg =
    R10.Form.Msg.Msg


{-| -}
msg : { submit : Conf -> Msg }
msg =
    { submit = R10.Form.Msg.Submit }



-- EXPOSING STUFF FROM R10.Form.Shared


{-| A form is defined by the **configuration** (`R10.Form.Conf`) that contain data about the input fields, radio buttons, etc. and the **state** (`R10.Form.State`), containing instead all the values and other parameters that change during the life of the form.

    type alias Model =
        { conf : R10.Form.Conf
        , state : R10.Form.State
        }

-}
type alias Model =
    R10.Form.Shared.Model



-- EXPOSING STUFF FROM R10.Form.Key


{-| -}
type alias Key =
    R10.Form.Key.Key


{-| -}
type alias KeyAsString =
    R10.Form.Key.KeyAsString


{-| -}
keyToString : Key -> KeyAsString
keyToString =
    R10.Form.Key.toString



-- EXPOSING STUFF FROM R10.Form.Helpers


{-| -}
getFieldValueAsBool : KeyAsString -> State -> Maybe Bool
getFieldValueAsBool =
    R10.Form.Helpers.getFieldValueAsBool


{-| -}
stringToBool : String -> Bool
stringToBool =
    R10.Form.Helpers.stringToBool


{-| -}
boolToString : Bool -> String
boolToString =
    R10.Form.Helpers.boolToString



-- EXPOSING STUFF FROM R10.Form.Validation


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
    R10.Form.Validation.commonValidation


{-| -}
setFieldValue : KeyAsString -> String -> State -> State
setFieldValue =
    R10.Form.Helpers.setFieldValue


{-| -}
getField : KeyAsString -> State -> Maybe FieldState
getField =
    R10.Form.Helpers.getField


{-| -}
validate : Key -> Maybe ValidationSpecs -> State -> FieldState -> FieldState
validate =
    R10.Form.Validation.validate


{-| -}
isChangingValues : Msg -> Bool
isChangingValues =
    R10.Form.Msg.isChangingValues



-- IMPORTING STUFF FROM FormComponents


{-| -}
type alias Palette =
    R10.FormComponents.UI.Palette.Palette


{-| -}
type alias Style =
    R10.FormComponents.Style.Style


{-| -}
type alias SingleModel =
    R10.FormComponents.Single.Common.Model


{-| -}
type alias SingleMsg =
    R10.FormComponents.Single.Common.Msg


{-| -}
type alias SingleType =
    R10.FormComponents.Single.Common.TypeSingle


{-| -}
type alias SingleFieldOption =
    R10.FormComponents.Single.Common.FieldOption


{-| -}
type alias Validation2 =
    R10.FormComponents.Validations.Validation


{-| -}
style :
    { filled : Style
    , outlined : Style
    }
style =
    { filled = R10.FormComponents.Style.Filled
    , outlined = R10.FormComponents.Style.Outlined
    }


{-| -}
label : Palette -> Color
label =
    R10.FormComponents.UI.Color.label


{-| -}
onClickWithStopPropagation : msg -> Attribute msg
onClickWithStopPropagation =
    R10.FormComponents.UI.onClickWithStopPropagation


{-| -}
viewIconButton :
    List (Element.Attribute msg)
    ->
        { icon : Element msg
        , msgOnClick : Maybe msg
        , palette : Palette
        , size : Int
        }
    -> Element msg
viewIconButton =
    R10.FormComponents.IconButton.view


{-| -}
viewSingleCustom :
    List (Element.Attribute msg)
    -> SingleModel
    ->
        { disabled : Bool
        , fieldOptions : List SingleFieldOption
        , helperText : Maybe String
        , key : String
        , label : String
        , leadingIcon : Maybe (Element.Element msg)
        , maxDisplayCount : Int
        , palette : Palette
        , requiredLabel : Maybe String
        , searchFn : String -> SingleFieldOption -> Bool
        , selectOptionHeight : Int
        , singleType : SingleType
        , style : Style
        , toMsg : SingleMsg -> msg
        , toOptionEl : SingleFieldOption -> Element msg
        , trailingIcon : Maybe (Element.Element msg)
        , validation : Validation2
        }
    -> Element msg
viewSingleCustom =
    R10.FormComponents.Single.viewCustom


{-| -}
defaultSearchFn : String -> SingleFieldOption -> Bool
defaultSearchFn =
    R10.FormComponents.Single.defaultSearchFn


{-| -}
initSingle : SingleModel
initSingle =
    R10.FormComponents.Single.Common.init


{-| -}
typeSingle :
    { combobox : SingleType
    , radio : SingleType
    }
typeSingle =
    { radio = R10.FormComponents.Single.Common.SingleRadio
    , combobox = R10.FormComponents.Single.Common.SingleCombobox
    }



--
-- updateSingle : SingleMsg -> SingleModel -> ( SingleModel, Cmd SingleMsg )
-- updateSingle =
--     R10.FormComponents.Single.update
--


{-| -}
normalizeString : String -> String
normalizeString =
    R10.FormComponents.Single.normalizeString


{-| -}
insertBold : List Int -> String -> String
insertBold =
    R10.FormComponents.Single.insertBold


{-| -}
defaultToOptionEl :
    { a | msgOnSelect : String -> msg, search : String }
    -> SingleFieldOption
    -> Element msg
defaultToOptionEl =
    R10.FormComponents.Single.defaultToOptionEl


{-| -}
defaultTrailingIcon :
    { a | opened : Bool, palette : Palette }
    -> Element msg
defaultTrailingIcon =
    R10.FormComponents.Single.defaultTrailingIcon


{-| -}
singleMsg : { onOptionSelect : String -> SingleMsg }
singleMsg =
    { onOptionSelect = R10.FormComponents.Single.Common.OnOptionSelect }
