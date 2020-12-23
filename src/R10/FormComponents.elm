module R10.FormComponents exposing (style, label, onClickWithStopPropagation, viewIconButton, viewSingleCustom, defaultSearchFn, SingleModel, SingleMsg, initSingle, normalizeString, insertBold, defaultToOptionEl, defaultTrailingIcon, SingleFieldOption, singleMsg, Style)

{-| This is what you need to add a form in your page.

@docs style, label, onClickWithStopPropagation, viewIconButton, viewSingleCustom, defaultSearchFn, SingleModel, SingleMsg, initSingle, normalizeString, insertBold, defaultToOptionEl, defaultTrailingIcon, SingleFieldOption, singleMsg, Style

-}

import Element exposing (..)
import R10.FormComponents.Internal.IconButton
import R10.FormComponents.Internal.Single
import R10.FormComponents.Internal.Single.Common
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.Validations
import R10.FormTypes


{-| -}
type alias Style =
    R10.FormComponents.Internal.Style.Style


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
type alias Validation =
    R10.FormComponents.Internal.Validations.Validation


{-| -}
style :
    { filled : Style
    , outlined : Style
    }
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


{-| -}
viewSingleCustom :
    List (Element.Attribute msg)
    -> SingleModel
    -> R10.FormComponents.Internal.Single.ArgsCustom msg
    -> Element msg
viewSingleCustom =
    R10.FormComponents.Internal.Single.viewCustom


{-| -}
defaultSearchFn : String -> SingleFieldOption -> Bool
defaultSearchFn =
    R10.FormComponents.Internal.Single.defaultSearchFn


{-| -}
initSingle : SingleModel
initSingle =
    R10.FormComponents.Internal.Single.Common.init



--
-- updateSingle : SingleMsg -> SingleModel -> ( SingleModel, Cmd SingleMsg )
-- updateSingle =
--     R10.FormComponents.Internal.Single.update
--


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
    R10.FormComponents.Internal.Single.defaultToOptionEl


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
