module R10.Form.Element exposing (checkbox)

import Element exposing (..)
import Form
import R10.Form.Conf
import R10.Form.FieldConf
import R10.Form.Msg
import R10.Form.State
import R10.FormComponents.UI.Palette


checkbox : R10.FormComponents.UI.Palette.Palette -> R10.Form.State.State -> (R10.Form.Msg.Msg -> msg) -> Int -> List (Element msg)
checkbox palette state msgTransformer index =
    let
        initFieldConf : R10.Form.FieldConf.FieldConf
        initFieldConf =
            R10.Form.FieldConf.init
    in
    R10.Form.viewWithPalette
        { conf =
            [ R10.Form.Conf.EntityField
                { initFieldConf
                    | id = String.fromInt index
                    , type_ = R10.Form.FieldConf.TypeBinary R10.Form.FieldConf.BinaryCheckbox
                }
            ]
        , state = state
        }
        msgTransformer
        palette
