module Form.TempSubmitButton exposing (button)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Form
import Form.Msg
import Form.Update


button : Form.Model -> (Form.Msg.Msg -> msg) -> Element msg
button form msgMapper =
    let
        submittable : Bool
        submittable =
            Form.Update.submittable form
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
            , onPress = Just <| Form.Msg.Submit form.conf
            }
