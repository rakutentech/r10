module R10.Form.Internal.FieldState exposing
    ( DictFieldState
    , FieldState
    , Validation(..)
    , ValidationOutcome(..)
    , decoderFieldState
    , encoderFieldState
    , encoderValidation
    , init
    , isValid
    )

import Dict
import Json.Decode as D
import Json.Decode.Pipeline
import Json.Encode as E
import R10.Form.Internal.FieldConf



-- ████████ ██    ██ ██████  ███████ ███████
--    ██     ██  ██  ██   ██ ██      ██
--    ██      ████   ██████  █████   ███████
--    ██       ██    ██      ██           ██
--    ██       ██    ██      ███████ ███████


type Validation
    = NotYetValidated
    | Validated (List ValidationOutcome)


type ValidationOutcome
    = MessageOk R10.Form.Internal.FieldConf.ValidationCode R10.Form.Internal.FieldConf.ValidationPayload
    | MessageErr R10.Form.Internal.FieldConf.ValidationCode R10.Form.Internal.FieldConf.ValidationPayload


type alias FieldState =
    { lostFocusOneOrMoreTime : Bool
    , value : String
    , valueWhenFocused : String
    , search : String
    , select : String
    , scroll : Float
    , dirty : Bool
    , disabled : Bool
    , validation : Validation
    , showPassword : Bool -- Used only for passwords
    , over : Maybe String -- Used only for radio
    }


type alias DictFieldState =
    Dict.Dict String FieldState



-- ██ ███    ██ ██ ████████
-- ██ ████   ██ ██    ██
-- ██ ██ ██  ██ ██    ██
-- ██ ██  ██ ██ ██    ██
-- ██ ██   ████ ██    ██


init : FieldState
init =
    { lostFocusOneOrMoreTime = False
    , showPassword = False
    , value = ""
    , valueWhenFocused = ""
    , search = ""
    , select = ""
    , scroll = 0
    , dirty = False
    , disabled = False
    , validation = NotYetValidated
    , over = Nothing
    }



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████
--
--
-- xxxx : Validation -> Bool
-- xxxx validation =
--     case validation of
--         NotYetValidated ->
--             False
--
--         Validated listValidationMessage ->
--             not (isValid listValidationMessage)
--
--


isValid : List ValidationOutcome -> Bool
isValid listValidationMessage =
    List.foldl
        (\validationMessage acc ->
            case validationMessage of
                MessageErr _ _ ->
                    False

                MessageOk _ _ ->
                    acc
        )
        True
        listValidationMessage



-- ███████ ███    ██  ██████  ██████  ██████  ███████ ██████
-- ██      ████   ██ ██      ██    ██ ██   ██ ██      ██   ██
-- █████   ██ ██  ██ ██      ██    ██ ██   ██ █████   ██████
-- ██      ██  ██ ██ ██      ██    ██ ██   ██ ██      ██   ██
-- ███████ ██   ████  ██████  ██████  ██████  ███████ ██   ██
--
-- ██████  ███████  ██████  ██████  ██████  ███████ ██████
-- ██   ██ ██      ██      ██    ██ ██   ██ ██      ██   ██
-- ██   ██ █████   ██      ██    ██ ██   ██ █████   ██████
-- ██   ██ ██      ██      ██    ██ ██   ██ ██      ██   ██
-- ██████  ███████  ██████  ██████  ██████  ███████ ██   ██
--


encoderFieldState : Dict.Dict String FieldState -> E.Value
encoderFieldState v =
    E.dict identity
        (\v_ ->
            E.object
                [ ( "lostFocusOneOrMoreTime", E.bool v_.lostFocusOneOrMoreTime )
                , ( "value", E.string v_.value )
                , ( "valueWhenFocused", E.string v_.value )
                , ( "search", E.string v_.search )
                , ( "select", E.string v_.search )
                , ( "scroll", E.float v_.scroll )
                , ( "dirty", E.bool v_.dirty )
                , ( "disabled", E.bool v_.disabled )
                , ( "validation", encoderValidation v_.validation )
                , ( "showPassword", E.bool v_.showPassword )
                ]
        )
        v


decoderFieldState : D.Decoder DictFieldState
decoderFieldState =
    D.dict
        (D.succeed FieldState
            |> Json.Decode.Pipeline.required "lostFocusOneOrMoreTime" D.bool
            |> Json.Decode.Pipeline.required "value" D.string
            |> Json.Decode.Pipeline.required "valueWhenFocused" D.string
            |> Json.Decode.Pipeline.required "search" D.string
            |> Json.Decode.Pipeline.required "select" D.string
            |> Json.Decode.Pipeline.required "scroll" D.float
            |> Json.Decode.Pipeline.required "dirty" D.bool
            |> Json.Decode.Pipeline.required "disabled" D.bool
            |> Json.Decode.Pipeline.required "validation" decoderValidation
            |> Json.Decode.Pipeline.required "showPassword" D.bool
            |> Json.Decode.Pipeline.required "over" (D.nullable D.string)
        )


encoderValidation : Validation -> E.Value
encoderValidation fieldType =
    case fieldType of
        NotYetValidated ->
            -- We attach an empty list to "NotYetValidated" but it is just for
            -- consistency... we will ignore it during the decoding
            E.object [ ( "NotYetValidated", E.list encoderValidationOutcome [] ) ]

        Validated listValidationOutcome ->
            E.object [ ( "Validated", E.list encoderValidationOutcome listValidationOutcome ) ]


decoderValidation : D.Decoder Validation
decoderValidation =
    D.oneOf
        [ D.map (\_ -> NotYetValidated) (D.field "NotYetValidated" (D.list decoderValidationOutcome))
        , D.map Validated (D.field "Validated" (D.list decoderValidationOutcome))
        ]


encoderValidationOutcome : ValidationOutcome -> E.Value
encoderValidationOutcome validationMessage =
    case validationMessage of
        MessageOk validationCode payload ->
            E.object [ ( "MessageOk", E.string validationCode ), ( "payload", E.list E.string payload ) ]

        MessageErr validationCode payload ->
            E.object [ ( "MessageErr", E.string validationCode ), ( "payload", E.list E.string payload ) ]


decoderValidationOutcome : D.Decoder ValidationOutcome
decoderValidationOutcome =
    D.oneOf
        [ D.map2 MessageOk (D.field "MessageOk" D.string) (D.field "payload" (D.list D.string))
        , D.map2 MessageErr (D.field "MessageErr" D.string) (D.field "payload" (D.list D.string))
        ]
