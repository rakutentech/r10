module R10.Form.Internal.TempSubmitButton exposing (button)

import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Element.WithContext.Input as Input
import R10.Context exposing (..)
import R10.Form
import R10.Form.Internal.Msg
import R10.Form.Internal.Update


button : R10.Form.Form -> (R10.Form.Internal.Msg.Msg -> msg) -> Element (R10.Context.ContextInternal z) msg
button form msgMapper =
    let
        submittable : Bool
        submittable =
            R10.Form.Internal.Update.isFormSubmittable form
    in
    map msgMapper <|
        Input.button
            [ padding 20
            , Border.rounded 6
            , Font.color <| rgb 1 1 1
            , Background.color <|
                if submittable then
                    rgb 0 0.5 0

                else
                    rgb 0.5 0 0
            ]
            { label = text "Submit"
            , onPress = Just <| R10.Form.Internal.Msg.Submit form.conf
            }
