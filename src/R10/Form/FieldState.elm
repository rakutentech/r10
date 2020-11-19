module R10.Form.FieldState exposing
    ( DictFieldState
    , FieldState
    , Validation(..)
    , Validation2(..)
    , ValidationOutcome(..)
    , decoderFieldState
    , encoderFieldState
    , encoderValidation
    , init
    , isValid
    )

import Dict
import R10.Form.FieldConf
import Json.Decode as D
import Json.Decode.Pipeline exposing (required)
import Json.Encode as E



-- ████████ ██    ██ ██████  ███████ ███████
--    ██     ██  ██  ██   ██ ██      ██
--    ██      ████   ██████  █████   ███████
--    ██       ██    ██      ██           ██
--    ██       ██    ██      ███████ ███████


type ValidationOutcome
    = MessageOk R10.Form.FieldConf.ValidationCode R10.Form.FieldConf.ValidationPayload
    | MessageErr R10.Form.FieldConf.ValidationCode R10.Form.FieldConf.ValidationPayload



-- TODO - Consolidate Validation2 and Validation


type Validation
    = NotYetValidated
    | Validated (List ValidationOutcome)


type Validation2
    = NotYetValidated2
    | Valid
    | NotValid


type alias FieldState =
    { lostFocusOneOrMoreTime : Bool
    , value : String
    , search : String
    , select : String
    , scroll : Float
    , dirty : Bool
    , disabled : Bool
    , validation : Validation
    , showPassword : Bool -- Used only for passwords
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
    , search = ""
    , select = ""
    , scroll = 0
    , dirty = False
    , disabled = False
    , validation = NotYetValidated
    }



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


isValid : Validation -> Validation2
isValid validation =
    case validation of
        NotYetValidated ->
            NotYetValidated2

        Validated listValidationMessage ->
            List.foldl
                (\validationMessage acc ->
                    case validationMessage of
                        MessageErr _ _ ->
                            NotValid

                        MessageOk _ _ ->
                            acc
                )
                Valid
                listValidationMessage



--
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
                , ( "showPassword", E.bool v_.showPassword )
                , ( "value", E.string v_.value )
                , ( "search", E.string v_.search )
                , ( "scroll", E.float v_.scroll )
                , ( "dirty", E.bool v_.dirty )
                , ( "disabled", E.bool v_.disabled )
                , ( "validation", encoderValidation v_.validation )
                ]
        )
        v


decoderFieldState : D.Decoder DictFieldState
decoderFieldState =
    D.dict
        (D.succeed FieldState
            |> required "lostFocusOneOrMoreTime" D.bool
            |> required "value" D.string
            |> required "search" D.string
            |> required "select" D.string
            |> required "scroll" D.float
            |> required "dirty" D.bool
            |> required "disabled" D.bool
            |> required "validation" decoderValidation
            |> required "showPassword" D.bool
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
