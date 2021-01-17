module Main exposing (main)

import Browser
import Color.Manipulate
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Html
import Html.Attributes
import R10.Button
import R10.Card
import R10.Color
import R10.Color.AttrsBackground
import R10.Color.Svg
import R10.Color.Utils
import R10.Form
import R10.FormTypes
import R10.Libu
import R10.Mode
import R10.Svg.LogosExtra
import R10.Theme


type alias Model =
    { form : R10.Form.Form }


init : Model
init =
    { form =
        { conf =
            [ R10.Form.entity.field
                { id = "cardNumber"
                , idDom = Nothing
                , type_ = R10.FormTypes.inputField.textWithPattern "____ ____ ____ ____"
                , label = "Card Number"
                , helperText = Nothing
                , requiredLabel = requiredLabel
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = False
                        , hidePassedValidationStyle = False
                        , validationIcon = R10.FormTypes.NoIcon
                        , validation = [ R10.Form.validation.required ]
                        }
                }
            , R10.Form.entity.field
                { id = "cardHolder"
                , idDom = Nothing
                , type_ = R10.FormTypes.inputField.textPlain
                , label = "Card Holder"
                , helperText = Nothing
                , requiredLabel = requiredLabel
                , validationSpecs =
                    Just
                        { showPassedValidationMessages = False
                        , hidePassedValidationStyle = False
                        , validationIcon = R10.FormTypes.NoIcon
                        , validation =
                            [ R10.Form.validation.required ]
                        }
                }
            , R10.Form.entity.wrappable "wrappable"
                [ R10.Form.entity.field
                    { id = "expires"
                    , idDom = Nothing
                    , type_ = R10.FormTypes.inputField.textWithPattern "MM/YY"
                    , label = "Expires"
                    , helperText = Nothing
                    , requiredLabel = requiredLabel
                    , validationSpecs =
                        Just
                            { showPassedValidationMessages = False
                            , hidePassedValidationStyle = False
                            , validationIcon = R10.FormTypes.NoIcon
                            , validation = [ R10.Form.validation.required ]
                            }
                    }
                , R10.Form.entity.field
                    { id = "cvv"
                    , idDom = Nothing
                    , type_ = R10.FormTypes.inputField.textWithPattern "___"
                    , label = "CVV"
                    , helperText = Nothing
                    , requiredLabel = requiredLabel
                    , validationSpecs =
                        Just
                            { showPassedValidationMessages = False
                            , hidePassedValidationStyle = False
                            , validationIcon = R10.FormTypes.NoIcon
                            , validation = [ R10.Form.validation.required ]
                            }
                    }
                ]
            ]
        , state = R10.Form.initState
        }
    }


type Msg
    = MsgForm R10.Form.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        MsgForm msgForm ->
            let
                form : R10.Form.Form
                form =
                    model.form

                newForm : R10.Form.Form
                newForm =
                    { form
                        | state =
                            form.state
                                |> R10.Form.update msgForm
                                |> Tuple.first
                    }
            in
            { model | form = newForm }


viewCreditCard : R10.Theme.Theme -> R10.Form.State -> Element msg
viewCreditCard theme formState =
    let
        logo : { height : number, src : String }
        logo =
            logoCreaditCard formState
    in
    column
        [ width fill
        , height <| px 250
        , padding 20
        , spacing 30
        , Border.rounded 20
        , Border.shadow { offset = ( 0, 20 ), size = 0, blur = 40, color = rgba 0 0 0 0.2 }
        , htmlAttribute <|
            Html.Attributes.style "background"
                ("radial-gradient(at 70% 30%, "
                    ++ (R10.Color.Svg.primary theme
                            |> Color.Manipulate.scaleHsl
                                { saturationScale = -0.2
                                , lightnessScale = 0.4
                                , alphaScale = 0
                                }
                            |> R10.Color.Utils.toHex
                       )
                    ++ ", "
                    ++ (R10.Color.Svg.primary theme
                            |> Color.Manipulate.scaleHsl
                                { saturationScale = -0.3
                                , lightnessScale = 0
                                , alphaScale = 0
                                }
                            |> R10.Color.Utils.toHex
                       )
                    ++ ")"
                )
        , clip
        ]
        [ row [ width fill ]
            [ image [ height <| px 50, alignTop, moveDown 50, alpha 0.9 ]
                { description = "Sim Contacts", src = chip }
            , image [ height <| px logo.height, alignRight, alignTop ]
                { description = "Visa Logo", src = logo.src }
            ]
        , column [ spacing 5, alignBottom ]
            [ embossedValue formState [ Font.size 22 ] "cardNumber" "**** **** **** ****" ]
        , row [ width fill ]
            [ column [ spacing 5 ]
                [ textCreditCard [] "CARD HOLDER"
                , embossedValue formState [] "cardHolder" "FULL NAME"
                ]
            , column [ spacing 5, alignRight ]
                [ textCreditCard [] "EXPIRES"
                , embossedValue formState [ alignRight ] "wrappable/expires" "MM/YY"
                ]
            ]
        ]


view : R10.Theme.Theme -> Model -> Html.Html Msg
view theme model =
    layoutWith
        { options =
            [ focusStyle
                { borderColor = Nothing
                , backgroundColor = Nothing
                , shadow = Nothing
                }
            ]
        }
        [ R10.Color.AttrsBackground.background theme
        , padding 50
        ]
    <|
        column
            (R10.Card.high theme
                ++ [ centerX
                   , centerY
                   , width (fill |> maximum 460)
                   , height shrink
                   , spacing 30
                   , R10.Color.AttrsBackground.surface2dp theme
                   ]
            )
            [ R10.Svg.LogosExtra.r10 [ centerX ] (R10.Color.Svg.logo theme) 32
            , viewCreditCard theme model.form.state
            , column [ spacing 20, width fill ] <|
                R10.Form.viewWithOptions model.form
                    MsgForm
                    { maker = Nothing
                    , translator = Nothing
                    , style = R10.Form.style.outlined
                    , palette = Just <| R10.Form.themeToPalette theme
                    }
            , Element.map MsgForm <|
                R10.Button.primary []
                    { label = text "Submit"
                    , libu = R10.Libu.Bu <| Just <| R10.Form.msg.submit model.form.conf
                    , theme = theme
                    }
            ]



-- VIEW HELPERS


logoCreaditCard : R10.Form.State -> { height : number, src : String }
logoCreaditCard formState =
    let
        counter : Int
        counter =
            formState
                |> R10.Form.getFieldValue "cardNumber"
                |> Maybe.withDefault ""
                |> String.length
                |> modBy 3
    in
    case counter of
        0 ->
            { height = 40, src = logoVisa }

        1 ->
            { height = 80, src = logoMasterCard }

        _ ->
            { height = 60, src = logoAmericanExpress }


requiredLabel : Maybe String
requiredLabel =
    Nothing


textCreditCard : List (Attribute msg) -> String -> Element msg
textCreditCard attrs string =
    el
        ([ Font.size 13

         -- , Font.glow (rgba 0 0 0 0.7) 6
         , htmlAttribute <| Html.Attributes.style "letter-spacing" "2px"
         , Font.color <| rgba 1 1 1 0.8
         ]
            ++ attrs
        )
    <|
        text string


textEmbossedCreditCard : List (Attribute msg) -> String -> Element msg
textEmbossedCreditCard attrs string =
    let
        shadow : Int -> Int -> String -> String
        shadow x y color =
            String.join ""
                [ String.fromInt x
                , "px "
                , String.fromInt y
                , "px "
                , "1px "
                , color
                ]

        shodowCSS : String
        shodowCSS =
            String.join
                ", "
                [ shadow 0 1 "rgba(255, 255, 200, 1)"
                , shadow 1 0 "rgba(200, 200, 200, 0.8)"
                , shadow 0 -1 "rgba(0, 0, 255, 0.8)"
                , shadow -1 0 "rgba(120, 120, 120, 1)"
                ]
    in
    el
        ([ htmlAttribute <| Html.Attributes.style "letter-spacing" "4px"
         , htmlAttribute <| Html.Attributes.style "text-shadow" shodowCSS
         , Font.family [ Font.typeface "OCRA", Font.sansSerif ]
         , Font.size 18
         , Font.color <| rgba 0 0 0 0
         ]
            ++ attrs
        )
        (text string)


embossedValue : R10.Form.State -> List (Attribute msg) -> R10.Form.KeyAsString -> String -> Element msg
embossedValue formState attrs id default =
    let
        defaultIfEmpty : String -> String
        defaultIfEmpty string =
            if String.isEmpty string then
                default

            else
                string
    in
    textEmbossedCreditCard attrs <|
        (formState
            |> R10.Form.getFieldValue id
            |> Maybe.withDefault default
            |> defaultIfEmpty
            |> String.toUpper
        )


logoVisa : String
logoVisa =
    let
        -- Original colors: color1 = 00579f, color2= faa61a
        color1 : String
        color1 =
            "fff"

        color2 : String
        color2 =
            "fff"
    in
    "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' style='filter: drop-shadow( 3px 3px 2px rgba(0, 0, 0, .5))' viewBox='0 0 1050 374'%3E%3Cpath fill='%23" ++ color1 ++ "' d='M433 320h-80L402 6h84zM727 13c-16-6-41-13-73-13-80 0-136 43-136 104-1 45 40 70 71 85s42 25 42 39c-1 21-26 30-49 30-32 0-50-5-76-16l-11-5-11 70c19 9 54 16 90 17 85 0 141-42 141-107 1-36-21-63-68-86-28-14-45-24-45-38s14-27 46-27c27-1 46 5 61 12l7 3 11-68zM835 208l32-88 11-30 5 27 19 91h-67zM935 6h-63c-19 0-34 5-42 26L709 319h85l17-47h104l10 47h75L935 6zM285 6l-80 213-8-43C182 126 136 72 85 45l72 274h86L370 6h-85z'/%3E%3Cpath fill='%23" ++ color2 ++ "' d='M132 6H1l-1 6c102 26 169 89 197 164L168 32c-4-20-19-26-36-26z'/%3E%3C/svg%3E"


logoMasterCard : String
logoMasterCard =
    let
        color : String
        color =
            "fff"
    in
    "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' style='filter: drop-shadow( 3px 3px 2px rgba(0, 0, 0, .5))' viewBox='0 0 1050 826'%3E%3Cpath fill='%23" ++ color ++ "' d='M182 774v-51c0-20-12-33-33-33-10 0-21 4-29 15-6-10-14-15-27-15-9 0-17 3-24 12v-10H51v82h18v-45c0-15 7-22 19-22s18 8 18 22v45h18v-45c0-15 9-22 20-22 12 0 18 8 18 22v45h20zm267-82h-29v-25h-18v25h-17v16h17v38c0 19 7 30 28 30 8 0 16-3 22-6l-5-15c-5 3-11 4-15 4-9 0-12-5-12-14v-37h29v-16zm153-2c-11 0-17 5-22 12v-10h-18v82h18v-46c0-14 6-22 17-22l12 2 5-17-12-1zm-231 9c-9-6-21-9-34-9-20 0-34 10-34 27 0 13 10 21 28 24l9 1c9 1 15 4 15 8 0 6-7 11-19 11s-22-5-28-9l-8 14c9 7 22 10 35 10 24 0 38-11 38-27 0-14-12-22-29-25h-8c-8-1-14-3-14-8 0-6 6-10 15-10 11 0 21 5 26 7l8-14zm479-9c-11 0-17 5-22 12v-10h-18v82h18v-46c0-14 6-22 18-22l11 2 5-17-12-1zm-230 43c0 25 17 43 44 43 12 0 20-3 29-9l-9-15c-7 5-14 8-21 8-15 0-25-11-25-27 0-15 10-26 25-27 7 0 14 3 21 8l9-14c-9-7-17-10-29-10-27 0-44 18-44 43zm166 0v-41h-18v10c-6-8-14-12-26-12-23 0-41 18-41 43s18 43 41 43c13 0 21-4 26-12v10h18v-41zm-66 0c0-15 10-27 25-27s25 12 25 27-10 27-25 27c-15-1-25-12-25-27zm-215-43c-24 0-41 17-41 43s17 43 42 43c12 0 24-3 33-11l-9-13c-6 5-15 9-24 9-11 0-22-6-24-20h60v-7c1-27-14-44-37-44zm0 16c11 0 19 6 20 19h-43c2-11 10-19 23-19zm447 27v-74h-18v43c-6-8-15-12-26-12-23 0-41 18-41 43s18 43 41 43c12 0 21-4 26-12v10h18v-41zm-66 0c0-15 9-27 25-27 14 0 25 12 25 27s-11 27-25 27c-16-1-25-12-25-27zm-603 0v-41h-18v10c-6-8-14-12-26-12-23 0-41 18-41 43s18 43 41 43c13 0 21-4 26-12v10h18v-41zm-67 0c0-15 10-27 25-27s25 12 25 27-10 27-25 27c-15-1-25-12-25-27z'/%3E%3Cpath fill='%23ff5f00' d='M363 70h270v485H363z' class='st1'/%3E%3Cpath fill='%23eb001b' d='M382 309c0-99 46-186 118-243a309 309 0 100 486 309 309 0 01-118-243z' class='st2'/%3E%3Cpath fill='%23f79e1b' d='M1000 309a309 309 0 01-500 243 310 310 0 000-486 309 309 0 01500 243z' class='st3'/%3E%3C/svg%3E"


logoAmericanExpress : String
logoAmericanExpress =
    let
        color : String
        color =
            "fff"
    in
    "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' style='filter: drop-shadow( 3px 3px 2px rgba(0, 0, 0, .5))' viewBox='0 0 460 174'%3E%3Cpath fill='none' d='M-1-1h442v156H-1z'/%3E%3Cg%3E%3Cg fill='%23" ++ color ++ "'%3E%3Cpath d='M38.7 38.3H54l-7.7-19.5zM120 103.7v9h25.8v9.7H120v10.5h28.5l13.3-14.6-12.6-14.6zM321 18.8l-8.4 19.5h16zM194.4 138.4V98.8l-18 19.5zM228.5 110c-.7-4.2-3.5-6.3-7.6-6.3h-14.6v12.5h15.3c4.1 0 7-2.1 7-6.3zM277.2 114.8c1.4-.7 2-2.8 2-4.9.8-2.7-.6-4.1-2-4.8-1.4-.7-3.5-.7-5.6-.7h-13.9v11.1h14c2 0 4 0 5.5-.7z'/%3E%3Cpath d='M377.3.8V9L373.1.8h-32.6V9L336.3.8h-44.5c-7.7 0-14 1.4-19.5 4.1V.8H241v4.1A20 20 0 00227.8.8h-112L108.3 18 100.6.8H65V9L61.6.8H31L17.1 33.4 1.1 69l-.3.7H37l.3-.7 4.2-10.4h9l4.2 11.1H95V61.3l3.5 8.3h20.1l3.5-8.3V69.6h96.7v-18h1.4c1.4 0 1.4 0 1.4 2V69h50v-4.2c4.2 2.1 10.4 4.2 18.8 4.2h20.9l4.1-11.1h9.8l4.1 11.1h40.4V58.5l6.2 10.4h32.7V.8h-31.3zM141.6 59.2h-11.1V21l-.7 1.5-16.2 36.7h-10.2L86.6 20.9v38.3H63l-4.9-10.5H34.5l-4.9 10.5H17.4L38 10.5h17.4l19.4 46.6V10.5h18.5l.3.7 8.8 19 6.3 14.4.2-.7 14-33.4h18.7v48.7zm48-38.3h-27.2v9H189v9.8h-26.5v9.7h27.2V60h-39V10.5h39v10.4zm49.6 18l.7.8c1.3 1.8 2.4 4.4 2.5 8.2v11.3H232v-5.6c0-2.8 0-7-2.1-9.7-.7-.7-1.3-1.1-2-1.4-1-.7-3-.7-6.3-.7H209v17.4h-11.8V10.5h26.4c6.3 0 10.5 0 14 2 3.4 2.1 5.4 5.5 5.5 10.9-.2 7.4-5 11.5-8.3 12.8 0 0 2.3.5 4.4 2.7zm23.4 20.3h-11.8V10.5h11.8v48.7zm135.6 0h-15.3l-22.3-36.9v36.9H337l-4.2-10.5h-24.3L304.3 60H291c-5.6 0-12.5-1.4-16.7-5.6-4.2-4.2-6.3-9.7-6.3-18.8 0-7 1.4-13.9 6.3-19.4 3.5-4.2 9.7-5.6 17.4-5.6h11.1v10.4h-11.1c-4.2 0-6.3.7-9 2.8-2.1 2.1-3.5 6.3-3.5 11.1 0 5.6.7 9 3.4 11.9 2.1 2 5 2.7 8.4 2.7h4.9l16-38.2h17.3l19.5 46.6V11.2h17.4l20.1 34v-34h11.9v48z'/%3E%3Cpath d='M229.2 30.8c.3-.2.4-.5.6-.8.6-1 1.3-2.8 1-5.2l-.2-.7V24c-.3-1.2-1.2-2-2-2.4-1.5-.7-3.6-.7-5.7-.7H209v11.2h14c2 0 4.1 0 5.5-.7l.6-.5.1-.1zM439.2 128.7c0-4.9-1.4-9.7-3.5-13.2V82.2h-33.5c-4.3 0-9.6 4-9.6 4v-4h-32c-4.8 0-11.1 1.3-13.9 4v-4h-57v4c-4.2-3.4-11.8-4-15.3-4h-37.6v4c-3.4-3.4-11.8-4-16-4h-41.7l-9.7 10.3-9-10.4H97.7v70.2H159l10-10 8.7 10H216.7v-15.9h3.5c4.8 0 11 0 16-2.1V153h31.2v-18h1.4c2.1 0 2.1 0 2.1 2v16h94.6c6.2 0 12.5-1.3 16-4.1v4.1h29.9c6.2 0 12.5-.7 16.7-3.4a23.4 23.4 0 0011-18.8v-.7-1.4zm-219-4.2h-14v18.1h-22.8l-13.3-15.3-.7-.7-15.3 16h-44.5V94h45.2l12.3 13.6 2.6 2.8.4-.4 14.6-16h36.9c7.1 0 15.1 1.8 18.1 9 .4 1.5.6 3.1.6 5 0 13.9-9.7 16.6-20.1 16.6zm69.5-.7c1.4 2.1 2 5 2 9v9.8H280v-6.2c0-2.8 0-7.7-2.1-9.8-1.4-2-4.2-2-8.4-2H257v18h-11.8V93.2h26.4c5.6 0 10.4 0 14 2.1 3.4 2.1 6.2 5.6 6.2 11.2 0 7.6-4.9 11.8-8.4 13.2 3.5 1.4 5.6 2.7 6.3 4.1zm48-20.1h-27.1v9H337v9.7h-26.4v9.8h27v10.4h-38.9V93.2h39v10.5zm29.2 39h-22.3v-10.5H367c2 0 3.5 0 4.8-1.4.7-.7 1.4-2 1.4-3.5 0-1.4-.7-2.8-1.4-3.5-.7-.7-2-1.3-4.1-1.3-11.2-.7-24.4 0-24.4-15.3 0-7 4.2-14.6 16.7-14.6h23v11.8h-21.6c-2 0-3.5 0-4.9.7-1.3.7-1.3 2-1.3 3.4 0 2.1 1.3 2.8 2.7 3.5 1.4.7 2.8.7 4.2.7h6.3c6.2 0 10.4 1.4 13.2 4.2 2 2 3.5 5.6 3.5 10.4 0 10.4-6.3 15.3-18.1 15.3zm59.8-5c-2.8 2.8-7.7 5-14.6 5h-22.3v-10.5h22.3c2 0 3.5 0 4.8-1.4.7-.7 1.4-2 1.4-3.5 0-1.4-.7-2.8-1.4-3.5-.7-.7-2-1.3-4.1-1.3-11.2-.7-24.4 0-24.4-15.3 0-6.7 3.8-12.6 13.1-14.4a26 26 0 013.6-.2h23v11.8H406.5c-2 0-3.5 0-4.9.7-.7.7-1.3 2-1.3 3.4 0 2.1.6 2.8 2.7 3.5 1.4.7 2.8.7 4.2.7h6.3c3 0 5.3.4 7.4 1.1a15 15 0 019.7 11c.2.8.2 1.6.2 2.5 0 4.2-1.3 7.7-4.1 10.4z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E"


chip : String
chip =
    "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 93 71'%3E%3Cg filter='url(%23filter0_dd)' opacity='.9'%3E%3Crect width='87' height='64.6' x='3' y='3.1' fill='url(%23paint0_linear)' rx='9'/%3E%3Crect width='87' height='64.6' x='3' y='3.1' fill='url(%23paint1_linear)' rx='9'/%3E%3Crect width='85.5' height='63.1' x='3.8' y='3.9' stroke='url(%23paint2_radial)' stroke-width='1.5' rx='8.3'/%3E%3C/g%3E%3Cg opacity='.8'%3E%3Cg filter='url(%23filter1_d)'%3E%3Cpath fill='%23000' fill-opacity='.8' d='M58.5 24.2H90v1.5H58.5z'/%3E%3C/g%3E%3Cg filter='url(%23filter2_d)'%3E%3Cpath fill='%23000' fill-opacity='.8' d='M58.5 45.2H90v1.5H58.5z'/%3E%3C/g%3E%3Cg filter='url(%23filter3_d)'%3E%3Cpath fill='%23000' fill-opacity='.8' d='M3 24.2h31.5v1.5H3z'/%3E%3C/g%3E%3Cg filter='url(%23filter4_d)'%3E%3Cpath fill='%23000' fill-opacity='.8' d='M3 45.2h31.5v1.5H3z'/%3E%3C/g%3E%3Cg filter='url(%23filter5_d)'%3E%3Cpath stroke='%23000' stroke-opacity='.8' stroke-width='1.5' d='M35 47.9c2 9 6.3 15.3 11.5 15.3s9.6-6.4 11.5-15.5c.6-2.8-1.9-9-1.9-12.3 0-3.2 2.5-9.3 1.9-12.1C56.2 14 51.7 7.6 46.5 7.6S36.9 14 35 23.1C34.5 26 37 32 37 35.4c0 3.4-2.4 9.6-1.8 12.5z' clip-rule='evenodd'/%3E%3C/g%3E%3C/g%3E%3Cdefs%3E%3Cfilter id='filter0_dd' width='93' height='70.6' x='0' y='.1' color-interpolation-filters='sRGB' filterUnits='userSpaceOnUse'%3E%3CfeFlood flood-opacity='0' result='BackgroundImageFix'/%3E%3CfeColorMatrix in='SourceAlpha' values='0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0'/%3E%3CfeOffset dy='2'/%3E%3CfeColorMatrix values='0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0'/%3E%3CfeBlend in2='BackgroundImageFix' result='effect1_dropShadow'/%3E%3CfeColorMatrix in='SourceAlpha' values='0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0'/%3E%3CfeOffset/%3E%3CfeGaussianBlur stdDeviation='1.5'/%3E%3CfeColorMatrix values='0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0'/%3E%3CfeBlend in2='effect1_dropShadow' result='effect2_dropShadow'/%3E%3CfeBlend in='SourceGraphic' in2='effect2_dropShadow' result='shape'/%3E%3C/filter%3E%3Cfilter id='filter1_d' width='31.5' height='3.5' x='58.5' y='24.2' color-interpolation-filters='sRGB' filterUnits='userSpaceOnUse'%3E%3CfeFlood flood-opacity='0' result='BackgroundImageFix'/%3E%3CfeColorMatrix in='SourceAlpha' values='0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0'/%3E%3CfeOffset dy='2'/%3E%3CfeColorMatrix values='0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.5 0'/%3E%3CfeBlend in2='BackgroundImageFix' result='effect1_dropShadow'/%3E%3CfeBlend in='SourceGraphic' in2='effect1_dropShadow' result='shape'/%3E%3C/filter%3E%3Cfilter id='filter2_d' width='31.5' height='3.5' x='58.5' y='45.2' color-interpolation-filters='sRGB' filterUnits='userSpaceOnUse'%3E%3CfeFlood flood-opacity='0' result='BackgroundImageFix'/%3E%3CfeColorMatrix in='SourceAlpha' values='0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0'/%3E%3CfeOffset dy='2'/%3E%3CfeColorMatrix values='0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.5 0'/%3E%3CfeBlend in2='BackgroundImageFix' result='effect1_dropShadow'/%3E%3CfeBlend in='SourceGraphic' in2='effect1_dropShadow' result='shape'/%3E%3C/filter%3E%3Cfilter id='filter3_d' width='31.5' height='3.5' x='3' y='24.2' color-interpolation-filters='sRGB' filterUnits='userSpaceOnUse'%3E%3CfeFlood flood-opacity='0' result='BackgroundImageFix'/%3E%3CfeColorMatrix in='SourceAlpha' values='0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0'/%3E%3CfeOffset dy='2'/%3E%3CfeColorMatrix values='0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.5 0'/%3E%3CfeBlend in2='BackgroundImageFix' result='effect1_dropShadow'/%3E%3CfeBlend in='SourceGraphic' in2='effect1_dropShadow' result='shape'/%3E%3C/filter%3E%3Cfilter id='filter4_d' width='31.5' height='3.5' x='3' y='45.2' color-interpolation-filters='sRGB' filterUnits='userSpaceOnUse'%3E%3CfeFlood flood-opacity='0' result='BackgroundImageFix'/%3E%3CfeColorMatrix in='SourceAlpha' values='0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0'/%3E%3CfeOffset dy='2'/%3E%3CfeColorMatrix values='0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.5 0'/%3E%3CfeBlend in2='BackgroundImageFix' result='effect1_dropShadow'/%3E%3CfeBlend in='SourceGraphic' in2='effect1_dropShadow' result='shape'/%3E%3C/filter%3E%3Cfilter id='filter5_d' width='24.6' height='59.1' x='34.2' y='6.9' color-interpolation-filters='sRGB' filterUnits='userSpaceOnUse'%3E%3CfeFlood flood-opacity='0' result='BackgroundImageFix'/%3E%3CfeColorMatrix in='SourceAlpha' values='0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0'/%3E%3CfeOffset dy='2'/%3E%3CfeColorMatrix values='0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.6 0'/%3E%3CfeBlend in2='BackgroundImageFix' result='effect1_dropShadow'/%3E%3CfeBlend in='SourceGraphic' in2='effect1_dropShadow' result='shape'/%3E%3C/filter%3E%3ClinearGradient id='paint0_linear' x1='15.4' x2='-1' y1='-7.4' y2='60.1' gradientUnits='userSpaceOnUse'%3E%3Cstop stop-color='%23FFEA9E'/%3E%3Cstop offset='.5' stop-color='%23C19D39'/%3E%3Cstop offset='.6' stop-color='%23D09B21'/%3E%3Cstop offset='1' stop-color='%23ECCF6B'/%3E%3C/linearGradient%3E%3ClinearGradient id='paint1_linear' x1='19.5' x2='4.9' y1='-6.3' y2='60.6' gradientUnits='userSpaceOnUse'%3E%3Cstop stop-color='%23FFECC8'/%3E%3Cstop offset='1' stop-color='%23D0B978'/%3E%3C/linearGradient%3E%3CradialGradient id='paint2_radial' cx='0' cy='0' r='1' gradientTransform='matrix(-50.6658 53.89513 -33.28775 -31.2932 65 18.2)' gradientUnits='userSpaceOnUse'%3E%3Cstop stop-color='%23fff'/%3E%3Cstop stop-color='%23fff'/%3E%3Cstop stop-color='%23fff' stop-opacity='.9'/%3E%3Cstop offset='1' stop-color='%23fff' stop-opacity='0'/%3E%3C/radialGradient%3E%3C/defs%3E%3C/svg%3E"


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view =
            view
                { mode = R10.Mode.Light
                , primaryColor = R10.Color.primary.blueSky
                }
        , update = update
        }
