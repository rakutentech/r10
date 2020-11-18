module R10.Form exposing
    ( view, viewWithOptions, viewWithPalette
    , Maker, MakerArgs, Model, Options
    , extraCss
    , Conf, Entity, EntityId, TextConf, entity, stringToConf, confToString, initConf
    , FieldConf, TypeSingle, single, fieldType, text, validationIcon, validation, binary, initFieldConf
    , State, initState, stateToString, stringToState
    )

{-| Use this stuff if you need to add a form in your page.

@docs view, viewWithOptions, viewWithPalette

@docs Maker, MakerArgs, Model, Options

@docs extraCss


# Form related stuff

@docs Conf, Entity, EntityId, TextConf, entity, stringToConf, confToString, initConf


# Fields related stuff

@docs FieldConf, TypeSingle, single, fieldType, text, validationIcon, validation, binary, initFieldConf


# State related stuff

@docs State, initState, stateToString, stringToState

-}

import Element
import Json.Decode
import R10.Form.Conf
import R10.Form.FieldConf
import R10.Form.Key
import R10.Form.MakerForView
import R10.Form.Msg
import R10.Form.State
import R10.Form.ValidationCode
import R10.FormComponents
import R10.FormComponents.Style
import R10.FormComponents.UI.Palette


{-| Forms are composed of two parts: a configuration and a state.
-}
type alias Model =
    { conf : R10.Form.Conf.Conf
    , state : R10.Form.State.State
    }


{-| -}
type alias MakerArgs =
    { key : R10.Form.Key.Key
    , formState : R10.Form.State.State
    , translator : R10.Form.FieldConf.ValidationCode -> String
    , style : R10.FormComponents.Style.Style
    , palette : R10.FormComponents.UI.Palette.Palette
    }


{-| -}
type alias Maker =
    MakerArgs
    -> List R10.Form.Conf.Entity
    -> List (Element.Element R10.Form.Msg.Msg)


{-| -}
type alias Options =
    { maker : Maybe Maker
    , translator : Maybe (R10.Form.FieldConf.ValidationCode -> String)
    , style : R10.FormComponents.Style.Style
    , palette : Maybe R10.FormComponents.UI.Palette.Palette
    }


{-| This is the no-configuration version.
-}
view : Model -> (R10.Form.Msg.Msg -> msg) -> List (Element.Element msg)
view form msgMapper =
    viewWithOptions form
        msgMapper
        { maker = Nothing
        , translator = Nothing
        , style = R10.FormComponents.Style.Outlined
        , palette = Nothing
        }


{-| Use this version if you have a specific palette that you want to use.
-}
viewWithPalette : Model -> (R10.Form.Msg.Msg -> msg) -> R10.FormComponents.UI.Palette.Palette -> List (Element.Element msg)
viewWithPalette form msgMapper palette =
    viewWithOptions form
        msgMapper
        { maker = Nothing
        , translator = Nothing
        , style = R10.FormComponents.Style.Outlined
        , palette = Just palette
        }


{-| Use this version for a full control.
-}
viewWithOptions : Model -> (R10.Form.Msg.Msg -> msg) -> Options -> List (Element.Element msg)
viewWithOptions form msgMapper args =
    List.map
        (Element.map msgMapper)
        (Maybe.withDefault R10.Form.MakerForView.maker
            args.maker
            { key = R10.Form.Key.empty
            , formState = form.state
            , translator = Maybe.withDefault R10.Form.ValidationCode.translator args.translator
            , style = args.style
            , palette = Maybe.withDefault R10.FormComponents.UI.Palette.light args.palette
            }
            form.conf
        )



-- EXPOSING STUFF FROM R10.Form.MakerForView


extraCss : Maybe R10.FormComponents.Palette -> String
extraCss =
    R10.Form.MakerForView.extraCss



-- EXPOSING STUFF FROM R10.Form.Conf


type alias Conf =
    R10.Form.Conf.Conf


type alias Entity =
    R10.Form.Conf.Entity


type alias EntityId =
    R10.Form.Conf.EntityId


type alias TextConf =
    R10.Form.Conf.TextConf


entity :
    { field : FieldConf -> Entity
    , multi : EntityId -> List Entity -> Entity
    , normal : EntityId -> List Entity -> Entity
    , subTitle : EntityId -> TextConf -> Entity
    , title : EntityId -> TextConf -> Entity
    , withBorder : EntityId -> List Entity -> Entity
    , withTabs : EntityId -> List Entity -> Entity
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


initConf : List Entity
initConf =
    R10.Form.Conf.init


stringToConf : String -> Result Json.Decode.Error Conf
stringToConf =
    R10.Form.Conf.fromString


confToString : Conf -> String
confToString =
    R10.Form.Conf.toString



-- EXPOSING STUFF FROM R10.Form.FieldConf


type alias FieldConf =
    R10.Form.FieldConf.FieldConf


type alias TypeSingle =
    R10.Form.FieldConf.TypeSingle


type alias FieldType =
    R10.Form.FieldConf.FieldType


type alias TypeBinary =
    R10.Form.FieldConf.TypeBinary


type alias TypeMulti =
    R10.Form.FieldConf.TypeMulti


type alias TypeText =
    R10.Form.FieldConf.TypeText


type alias FieldOption =
    R10.Form.FieldConf.FieldOption


type alias ValidationIcon =
    R10.Form.FieldConf.ValidationIcon


type alias Validation =
    R10.Form.FieldConf.Validation


type alias ValidationMessage =
    R10.Form.FieldConf.ValidationMessage


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


single :
    { combobox : TypeSingle
    , radio : TypeSingle
    }
single =
    { combobox = R10.Form.FieldConf.SingleCombobox
    , radio = R10.Form.FieldConf.SingleRadio
    }


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


validation :
    { allOf : List Validation -> Validation
    , dependant : R10.Form.Key.KeyAsString -> Validation -> Validation
    , equal : Validation
    , maxLength : Int -> Validation
    , minLength : Int -> Validation
    , noValidatio : Validation
    , oneOf : List Validation -> Validation
    , regex : String -> Validation
    , required : Validation
    , withMsg : ValidationMessage -> Validation -> Validation
    }
validation =
    { noValidatio = R10.Form.FieldConf.NoValidation
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


binary :
    { checkbox : TypeBinary
    , switch : TypeBinary
    }
binary =
    { checkbox = R10.Form.FieldConf.BinaryCheckbox
    , switch = R10.Form.FieldConf.BinarySwitch
    }


initFieldConf : R10.Form.FieldConf.FieldConf
initFieldConf =
    R10.Form.FieldConf.init



-- EXPOSING STUFF FROM R10.Form.State


type alias State =
    R10.Form.State.State


initState : State
initState =
    R10.Form.State.init


stateToString : R10.Form.State.State -> String
stateToString =
    R10.Form.State.toString


stringToState : String -> Result Json.Decode.Error R10.Form.State.State
stringToState =
    R10.Form.State.fromString
