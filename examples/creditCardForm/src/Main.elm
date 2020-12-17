module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html
import Html.Attributes
import R10.Button
import R10.Card
import R10.Color
import R10.Color.AttrsBackground
import R10.Color.Svg
import R10.FontSize
import R10.Form
import R10.Form.Internal.Key
import R10.FormTypes
import R10.Language
import R10.Libu
import R10.Mode
import R10.Paragraph
import R10.Svg.Logos
import R10.Svg.LogosExtra
import R10.Theme



--
-- https://r10-form1.surge.sh/
--


theme : R10.Theme.Theme
theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.primary.pink
    }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { form : R10.Form.Form }


type Msg
    = MsgForm R10.Form.Msg


init : Model
init =
    { form =
        { conf =
            [ R10.Form.entity.field
                { id = "cardNumber"
                , idDom = Nothing
                , type_ = R10.FormTypes.TypeText (R10.FormTypes.TextWithPattern "____ ____ ____ ____")
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
                , type_ = R10.FormTypes.TypeText R10.FormTypes.TextPlain
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
            , R10.Form.entity.field
                { id = "expires"
                , idDom = Nothing
                , type_ = R10.FormTypes.TypeText (R10.FormTypes.TextWithPattern "MM/YY")
                , label = "Expires (MM/YY)"
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
                , type_ = R10.FormTypes.TypeText (R10.FormTypes.TextWithPattern "___")
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
        , state = R10.Form.initState
        }
    }


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


viewCreditCard : R10.Form.State -> Element msg
viewCreditCard formState =
    let
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
        , Border.width 1
        , Border.color <| rgba 0 0 0 0.3
        , Background.image backgroundImage
        , clip
        ]
        [ row [ width fill ]
            [ image [ height <| px 50, alignTop ]
                { description = "Sim Contacts", src = simContacts }
            , image [ height <| px logo.height, alignRight, alignTop ]
                { description = "Visa Logo", src = logo.src }
            ]
        , column [ spacing 5, alignBottom ]
            [ embossedValue formState [ Font.size 22 ] "cardNumber" "1234 5678 9012 3456" ]
        , row [ width fill ]
            [ column [ spacing 5 ]
                [ textCreditCard [] "CARD HOLDER"
                , embossedValue formState [] "cardHolder" "FULL NAME"
                ]
            , column [ spacing 5, alignRight ]
                [ textCreditCard [] "EXPIRES"
                , embossedValue formState [ alignRight ] "expires" "MM/YY"
                ]
            ]
        ]


view : Model -> Html.Html Msg
view model =
    layoutWith
        { options =
            [ focusStyle
                { borderColor = Nothing
                , backgroundColor = Nothing
                , shadow = Nothing
                }
            ]
        }
        [ R10.Color.AttrsBackground.background theme, padding 20, R10.FontSize.normal ]
        (column
            (R10.Card.high theme
                ++ [ centerX
                   , centerY
                   , width (fill |> maximum 460)
                   , height shrink
                   , spacing 30
                   ]
            )
            [ R10.Svg.Logos.rakuten [] (R10.Color.Svg.logo theme) 32
            , viewCreditCard model.form.state
            , column [ spacing 20, width fill ] <|
                R10.Form.viewWithOptions model.form
                    MsgForm
                    { maker = Nothing
                    , translator = Nothing
                    , style = R10.Form.style.filled
                    , palette = Just <| R10.Form.themeToPalette theme
                    }
            , Element.map MsgForm <|
                R10.Button.primary []
                    { label = text "Submit"
                    , libu = R10.Libu.Bu <| Just <| R10.Form.msg.submit model.form.conf
                    , theme = theme
                    }
            ]
        )



-- VIEW HELPERS


logoCreaditCard : R10.Form.State -> { height : number, src : String }
logoCreaditCard formState =
    let
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
    -- Just "(required)"
    Nothing


textCreditCard : List (Attribute msg) -> String -> Element msg
textCreditCard attrs string =
    el
        ([ Font.size 13
         , Font.glow (rgba 0 0 0 0.7) 6
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
        shadow x y color =
            String.join ""
                [ String.fromInt x
                , "px "
                , String.fromInt y
                , "px "
                , "1px "
                , color
                ]

        shodowCSS =
            String.join
                ", "
                [ shadow 0 1 "rgba(255, 255, 200, 1)"
                , shadow 1 0 "rgba(200, 200, 200, 0.8)"
                , shadow 0 -1 "rgba(0, 0, 255, 0.8)"
                , shadow -1 0 "rgba(255, 0, 0, 1)"
                ]
    in
    el
        ([ htmlAttribute <| Html.Attributes.style "letter-spacing" "0px"
         , htmlAttribute <| Html.Attributes.style "text-shadow" shodowCSS

         -- https://github.com/opensourcedesign/fonts/issues/8
         -- https://tsukurimashou.osdn.jp/ocr.pdf
         -- https://github.com/opensourcedesign/fonts/tree/master/OCR
         , Font.family [ Font.typeface "OCRA", Font.sansSerif ]
         , Font.size 18
         , Font.color <| rgba 0.8 0.8 0.8 0
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
        color1 =
            "fff"

        color2 =
            "fff"
    in
    "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' style='filter: drop-shadow( 3px 3px 2px rgba(0, 0, 0, .5))' viewBox='0 0 1050 374'%3E%3Cpath fill='%23" ++ color1 ++ "' d='M433 320h-80L402 6h84zM727 13c-16-6-41-13-73-13-80 0-136 43-136 104-1 45 40 70 71 85s42 25 42 39c-1 21-26 30-49 30-32 0-50-5-76-16l-11-5-11 70c19 9 54 16 90 17 85 0 141-42 141-107 1-36-21-63-68-86-28-14-45-24-45-38s14-27 46-27c27-1 46 5 61 12l7 3 11-68zM835 208l32-88 11-30 5 27 19 91h-67zM935 6h-63c-19 0-34 5-42 26L709 319h85l17-47h104l10 47h75L935 6zM285 6l-80 213-8-43C182 126 136 72 85 45l72 274h86L370 6h-85z'/%3E%3Cpath fill='%23" ++ color2 ++ "' d='M132 6H1l-1 6c102 26 169 89 197 164L168 32c-4-20-19-26-36-26z'/%3E%3C/svg%3E"


logoMasterCard : String
logoMasterCard =
    let
        color =
            "fff"
    in
    "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' style='filter: drop-shadow( 3px 3px 2px rgba(0, 0, 0, .5))' viewBox='0 0 1050 826'%3E%3Cpath fill='%23" ++ color ++ "' d='M182 774v-51c0-20-12-33-33-33-10 0-21 4-29 15-6-10-14-15-27-15-9 0-17 3-24 12v-10H51v82h18v-45c0-15 7-22 19-22s18 8 18 22v45h18v-45c0-15 9-22 20-22 12 0 18 8 18 22v45h20zm267-82h-29v-25h-18v25h-17v16h17v38c0 19 7 30 28 30 8 0 16-3 22-6l-5-15c-5 3-11 4-15 4-9 0-12-5-12-14v-37h29v-16zm153-2c-11 0-17 5-22 12v-10h-18v82h18v-46c0-14 6-22 17-22l12 2 5-17-12-1zm-231 9c-9-6-21-9-34-9-20 0-34 10-34 27 0 13 10 21 28 24l9 1c9 1 15 4 15 8 0 6-7 11-19 11s-22-5-28-9l-8 14c9 7 22 10 35 10 24 0 38-11 38-27 0-14-12-22-29-25h-8c-8-1-14-3-14-8 0-6 6-10 15-10 11 0 21 5 26 7l8-14zm479-9c-11 0-17 5-22 12v-10h-18v82h18v-46c0-14 6-22 18-22l11 2 5-17-12-1zm-230 43c0 25 17 43 44 43 12 0 20-3 29-9l-9-15c-7 5-14 8-21 8-15 0-25-11-25-27 0-15 10-26 25-27 7 0 14 3 21 8l9-14c-9-7-17-10-29-10-27 0-44 18-44 43zm166 0v-41h-18v10c-6-8-14-12-26-12-23 0-41 18-41 43s18 43 41 43c13 0 21-4 26-12v10h18v-41zm-66 0c0-15 10-27 25-27s25 12 25 27-10 27-25 27c-15-1-25-12-25-27zm-215-43c-24 0-41 17-41 43s17 43 42 43c12 0 24-3 33-11l-9-13c-6 5-15 9-24 9-11 0-22-6-24-20h60v-7c1-27-14-44-37-44zm0 16c11 0 19 6 20 19h-43c2-11 10-19 23-19zm447 27v-74h-18v43c-6-8-15-12-26-12-23 0-41 18-41 43s18 43 41 43c12 0 21-4 26-12v10h18v-41zm-66 0c0-15 9-27 25-27 14 0 25 12 25 27s-11 27-25 27c-16-1-25-12-25-27zm-603 0v-41h-18v10c-6-8-14-12-26-12-23 0-41 18-41 43s18 43 41 43c13 0 21-4 26-12v10h18v-41zm-67 0c0-15 10-27 25-27s25 12 25 27-10 27-25 27c-15-1-25-12-25-27z'/%3E%3Cpath fill='%23ff5f00' d='M363 70h270v485H363z' class='st1'/%3E%3Cpath fill='%23eb001b' d='M382 309c0-99 46-186 118-243a309 309 0 100 486 309 309 0 01-118-243z' class='st2'/%3E%3Cpath fill='%23f79e1b' d='M1000 309a309 309 0 01-500 243 310 310 0 000-486 309 309 0 01500 243z' class='st3'/%3E%3C/svg%3E"


logoAmericanExpress : String
logoAmericanExpress =
    let
        color =
            -- "0277a6"
            "fff"
    in
    "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' style='filter: drop-shadow( 3px 3px 2px rgba(0, 0, 0, .5))' viewBox='0 0 460 174'%3E%3Cpath fill='none' d='M-1-1h442v156H-1z'/%3E%3Cg%3E%3Cg fill='%23" ++ color ++ "'%3E%3Cpath d='M38.7 38.3H54l-7.7-19.5zM120 103.7v9h25.8v9.7H120v10.5h28.5l13.3-14.6-12.6-14.6zM321 18.8l-8.4 19.5h16zM194.4 138.4V98.8l-18 19.5zM228.5 110c-.7-4.2-3.5-6.3-7.6-6.3h-14.6v12.5h15.3c4.1 0 7-2.1 7-6.3zM277.2 114.8c1.4-.7 2-2.8 2-4.9.8-2.7-.6-4.1-2-4.8-1.4-.7-3.5-.7-5.6-.7h-13.9v11.1h14c2 0 4 0 5.5-.7z'/%3E%3Cpath d='M377.3.8V9L373.1.8h-32.6V9L336.3.8h-44.5c-7.7 0-14 1.4-19.5 4.1V.8H241v4.1A20 20 0 00227.8.8h-112L108.3 18 100.6.8H65V9L61.6.8H31L17.1 33.4 1.1 69l-.3.7H37l.3-.7 4.2-10.4h9l4.2 11.1H95V61.3l3.5 8.3h20.1l3.5-8.3V69.6h96.7v-18h1.4c1.4 0 1.4 0 1.4 2V69h50v-4.2c4.2 2.1 10.4 4.2 18.8 4.2h20.9l4.1-11.1h9.8l4.1 11.1h40.4V58.5l6.2 10.4h32.7V.8h-31.3zM141.6 59.2h-11.1V21l-.7 1.5-16.2 36.7h-10.2L86.6 20.9v38.3H63l-4.9-10.5H34.5l-4.9 10.5H17.4L38 10.5h17.4l19.4 46.6V10.5h18.5l.3.7 8.8 19 6.3 14.4.2-.7 14-33.4h18.7v48.7zm48-38.3h-27.2v9H189v9.8h-26.5v9.7h27.2V60h-39V10.5h39v10.4zm49.6 18l.7.8c1.3 1.8 2.4 4.4 2.5 8.2v11.3H232v-5.6c0-2.8 0-7-2.1-9.7-.7-.7-1.3-1.1-2-1.4-1-.7-3-.7-6.3-.7H209v17.4h-11.8V10.5h26.4c6.3 0 10.5 0 14 2 3.4 2.1 5.4 5.5 5.5 10.9-.2 7.4-5 11.5-8.3 12.8 0 0 2.3.5 4.4 2.7zm23.4 20.3h-11.8V10.5h11.8v48.7zm135.6 0h-15.3l-22.3-36.9v36.9H337l-4.2-10.5h-24.3L304.3 60H291c-5.6 0-12.5-1.4-16.7-5.6-4.2-4.2-6.3-9.7-6.3-18.8 0-7 1.4-13.9 6.3-19.4 3.5-4.2 9.7-5.6 17.4-5.6h11.1v10.4h-11.1c-4.2 0-6.3.7-9 2.8-2.1 2.1-3.5 6.3-3.5 11.1 0 5.6.7 9 3.4 11.9 2.1 2 5 2.7 8.4 2.7h4.9l16-38.2h17.3l19.5 46.6V11.2h17.4l20.1 34v-34h11.9v48z'/%3E%3Cpath d='M229.2 30.8c.3-.2.4-.5.6-.8.6-1 1.3-2.8 1-5.2l-.2-.7V24c-.3-1.2-1.2-2-2-2.4-1.5-.7-3.6-.7-5.7-.7H209v11.2h14c2 0 4.1 0 5.5-.7l.6-.5.1-.1zM439.2 128.7c0-4.9-1.4-9.7-3.5-13.2V82.2h-33.5c-4.3 0-9.6 4-9.6 4v-4h-32c-4.8 0-11.1 1.3-13.9 4v-4h-57v4c-4.2-3.4-11.8-4-15.3-4h-37.6v4c-3.4-3.4-11.8-4-16-4h-41.7l-9.7 10.3-9-10.4H97.7v70.2H159l10-10 8.7 10H216.7v-15.9h3.5c4.8 0 11 0 16-2.1V153h31.2v-18h1.4c2.1 0 2.1 0 2.1 2v16h94.6c6.2 0 12.5-1.3 16-4.1v4.1h29.9c6.2 0 12.5-.7 16.7-3.4a23.4 23.4 0 0011-18.8v-.7-1.4zm-219-4.2h-14v18.1h-22.8l-13.3-15.3-.7-.7-15.3 16h-44.5V94h45.2l12.3 13.6 2.6 2.8.4-.4 14.6-16h36.9c7.1 0 15.1 1.8 18.1 9 .4 1.5.6 3.1.6 5 0 13.9-9.7 16.6-20.1 16.6zm69.5-.7c1.4 2.1 2 5 2 9v9.8H280v-6.2c0-2.8 0-7.7-2.1-9.8-1.4-2-4.2-2-8.4-2H257v18h-11.8V93.2h26.4c5.6 0 10.4 0 14 2.1 3.4 2.1 6.2 5.6 6.2 11.2 0 7.6-4.9 11.8-8.4 13.2 3.5 1.4 5.6 2.7 6.3 4.1zm48-20.1h-27.1v9H337v9.7h-26.4v9.8h27v10.4h-38.9V93.2h39v10.5zm29.2 39h-22.3v-10.5H367c2 0 3.5 0 4.8-1.4.7-.7 1.4-2 1.4-3.5 0-1.4-.7-2.8-1.4-3.5-.7-.7-2-1.3-4.1-1.3-11.2-.7-24.4 0-24.4-15.3 0-7 4.2-14.6 16.7-14.6h23v11.8h-21.6c-2 0-3.5 0-4.9.7-1.3.7-1.3 2-1.3 3.4 0 2.1 1.3 2.8 2.7 3.5 1.4.7 2.8.7 4.2.7h6.3c6.2 0 10.4 1.4 13.2 4.2 2 2 3.5 5.6 3.5 10.4 0 10.4-6.3 15.3-18.1 15.3zm59.8-5c-2.8 2.8-7.7 5-14.6 5h-22.3v-10.5h22.3c2 0 3.5 0 4.8-1.4.7-.7 1.4-2 1.4-3.5 0-1.4-.7-2.8-1.4-3.5-.7-.7-2-1.3-4.1-1.3-11.2-.7-24.4 0-24.4-15.3 0-6.7 3.8-12.6 13.1-14.4a26 26 0 013.6-.2h23v11.8H406.5c-2 0-3.5 0-4.9.7-.7.7-1.3 2-1.3 3.4 0 2.1.6 2.8 2.7 3.5 1.4.7 2.8.7 4.2.7h6.3c3 0 5.3.4 7.4 1.1a15 15 0 019.7 11c.2.8.2 1.6.2 2.5 0 4.2-1.3 7.7-4.1 10.4z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E"


simContacts : String
simContacts =
    "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 364 296'%3E%3Cpath fill='none' d='M-1-1h366v298H-1z'/%3E%3Cg%3E%3Cpath fill='%23ffcc3b' d='M362 46v203c0 25-20 45-45 45H47c-25 0-46-20-46-45V46C1 21 22 1 47 1h270c25 0 45 20 45 45zm0 0'/%3E%3Cpath fill='%23ffcc3b' d='M362 46v203c0 25-20 45-45 45H47c-25 0-46-20-46-45V46C1 21 22 1 47 1h270c25 0 45 20 45 45zm0 0'/%3E%3Cpath fill='%23ffd876' d='M124 173v-51c0-12-10-21-21-21H1v93h102c11 0 21-9 21-21zm0 0M240 122v51c0 12 9 21 21 21h101v-93H261c-12 0-21 9-21 21zm0 0'/%3E%3Cpath fill='%23efb525' d='M147 1v19l-2 3a74 74 0 00-43 67v3H1v16h102c7 0 13 6 13 13v51c0 8-6 13-13 13H1v16h101v3c0 29 17 56 43 67l2 3v19h16v-19c0-7-5-14-11-17-21-9-35-30-35-53v-7c9-5 14-14 14-25v-51c0-11-5-20-14-25v-7c0-23 14-44 35-53 6-3 11-10 11-17V1h-16zm0 0M201 1v19c0 7 4 14 11 17 21 9 35 30 35 53v7c-9 5-15 14-15 25v51c0 11 6 20 15 25v7c0 23-14 44-35 53-7 3-11 10-11 17v19h16v-19c0-1 0-2 2-3 26-11 43-38 43-67v-3h100v-16H261c-7 0-13-5-13-13v-51c0-7 6-13 13-13h101V93H262v-3c0-29-17-56-43-67-2-1-2-2-2-3V1h-16zm0 0'/%3E%3C/g%3E%3C/svg%3E"


backgroundImage : String
backgroundImage =
    "data:image/jpeg;base64,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"
