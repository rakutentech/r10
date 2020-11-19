module R10.FormComponents exposing (Palette, style, label, onClickWithStopPropagation, viewIconButton, viewSingleCustom, defaultSearchFn, SingleModel, SingleMsg, initSingle, typeSingle, normalizeString, insertBold, defaultToOptionEl, defaultTrailingIcon, SingleType, SingleFieldOption, singleMsg, Style)

{-| This is what you need to add a form in your page.

@docs Palette, style, label, onClickWithStopPropagation, viewIconButton, viewSingleCustom, defaultSearchFn, SingleModel, SingleMsg, initSingle, typeSingle, normalizeString, insertBold, defaultToOptionEl, defaultTrailingIcon, SingleType, SingleFieldOption, singleMsg, Style

-}

import Element exposing (..)
import R10.FormComponents.IconButton
import R10.FormComponents.Single
import R10.FormComponents.Single.Common
import R10.FormComponents.Style
import R10.FormComponents.UI
import R10.FormComponents.UI.Color
import R10.FormComponents.UI.Palette
import R10.FormComponents.Validations


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
type alias Validation =
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
        , validation : Validation
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
