module R10.Form exposing
    ( view, viewWithOptions, viewWithPalette
    , Maker, MakerArgs, Model, Options
    )

{-| This is what you need to add a form in your page.

@docs view, viewWithOptions, viewWithPalette

@docs Maker, MakerArgs, Model, Options

-}

import Element
import R10.Form.Conf
import R10.Form.FieldConf
import R10.Form.Key
import R10.Form.MakerForView
import R10.Form.Msg
import R10.Form.State
import R10.Form.ValidationCode
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
