module Main exposing (main)

import Element exposing (..)
import Html
import R10.Form
import R10.FormTypes


formModel : R10.Form.Form
formModel =
    { conf =
        [ R10.Form.entity.field
            { id = "email"
            , idDom = Nothing
            , type_ = R10.FormTypes.TypeText R10.FormTypes.TextEmail
            , label = "Email"
            , helperText = Just "My first form"
            , requiredLabel = Nothing
            , validationSpecs = Nothing
            }
        ]
    , state = R10.Form.initState
    }


formMsgMapper : R10.Form.MsgMapper ()
formMsgMapper =
    \_ -> ()


main : Html.Html ()
main =
    layout [] <|
        column [ centerX, centerY ] <|
            R10.Form.view formModel formMsgMapper
