module R10.Form.Internal.TempSubmitButton exposing (button)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import R10.Form
import R10.Form.Internal.Msg
import R10.Form.Internal.Update


button : R10.Form.Form -> (R10.Form.Internal.Msg.Msg -> msg) -> Element msg
button form msgMapper =
    let
        submittable : Bool
        submittable =
            R10.Form.Internal.Update.submittable form
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
