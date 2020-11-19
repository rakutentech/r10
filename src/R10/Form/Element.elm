module Form.Element exposing (checkbox)

import Element exposing (..)
import Form
import Form.Conf
import Form.FieldConf
import Form.Msg
import Form.State
import FormComponents.UI.Palette


checkbox : FormComponents.UI.Palette.Palette -> Form.State.State -> (Form.Msg.Msg -> msg) -> Int -> List (Element msg)
checkbox palette state msgTransformer index =
    let
        initFieldConf : Form.FieldConf.FieldConf
        initFieldConf =
            Form.FieldConf.init
    in
    Form.viewWithPalette
        { conf =
            [ Form.Conf.EntityField
                { initFieldConf
                    | id = String.fromInt index
                    , type_ = Form.FieldConf.TypeBinary Form.FieldConf.BinaryCheckbox
                }
            ]
        , state = state
        }
        msgTransformer
        palette
