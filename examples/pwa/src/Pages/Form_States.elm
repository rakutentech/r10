module Pages.Form_States exposing
    ( Model
    , Msg
    , init
    , title
    , update
    , view
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import R10.Form
import R10.FormComponents
import R10.FormComponents.Binary
import R10.FormComponents.Text
import R10.FormComponents.Validations
import R10.Language
import R10.Theme


title : R10.Language.Translations
title =
    { key = "title"
    , en_us = "Form States"
    , ja_jp = "Form States"
    , zh_tw = "Form States"
    , es_es = "Form States"
    , fr_fr = "Form States"
    , de_de = "Form States"
    , it_it = "Form States"
    , nl_nl = "Form States"
    , pt_pt = "Form States"
    , nb_no = "Form States"
    , fi_fl = "Form States"
    , da_dk = "Form States"
    , sv_se = "Form States"
    }


type alias Model =
    {}


type Msg
    = DoNothing


update : Msg -> Model -> ( Model, Cmd msg )
update _ model =
    ( model, Cmd.none )


init : Model
init =
    {}


validationToStr : R10.FormComponents.Validations.Validation -> String
validationToStr validation =
    case validation of
        R10.FormComponents.Validations.NotYetValidated ->
            "Nothing"

        R10.FormComponents.Validations.Validated msgList ->
            if
                List.all
                    (\msg ->
                        case msg of
                            R10.FormComponents.Validations.MessageOk _ ->
                                True

                            R10.FormComponents.Validations.MessageErr _ ->
                                False
                    )
                    msgList
            then
                "Valid"

            else
                "Invalid"


viewChecboxTable : R10.Theme.Theme -> List (Element Msg)
viewChecboxTable theme =
    let
        attrs =
            [ Border.color <| rgba 0 0 0 0.1 ]

        attrsTable =
            attrs
                ++ [ Border.widthEach { bottom = 0, left = 1, right = 0, top = 1 }
                   ]

        attrsCell =
            attrs
                ++ [ Border.widthEach { bottom = 1, left = 0, right = 1, top = 0 }
                   , width <| px 150
                   , height fill
                   , padding 10
                   , Font.center
                   ]

        attrsCellHeader =
            attrsCell
                ++ [ Font.bold
                   , Background.color <| rgba 0 0 0 0.1
                   ]
    in
    [ el [] <| text "Checkbox - Component definition"
    , el [ Font.family [ Font.monospace ] ] <|
        text """FormComponents.Binary.view :
    List (Attribute msg)
    ->
        { label : String
        , value : Bool
        , focused : Bool
        , valid : Maybe Bool
        , displayValidation : Bool

        --
        , msgOnChange : Bool -> msg
        , msgOnFocus : msg
        , msgOnLoseFocus : msg
        , msgOnClick : msg
        }
    -> Element msg
"""
    , el [] <| text "Checkbox - Possible states"
    , column
        attrsTable
        (row []
            [ el attrsCellHeader <| text "Checkbox"
            , el attrsCellHeader <| text "Focused"
            , el attrsCellHeader <| text "Value"
            , el attrsCellHeader <| text "Validation"
            , el attrsCellHeader <| text "Disabled"
            ]
            :: (let
                    disabled =
                        [ True, False ]

                    focused =
                        [ True, False ]

                    value =
                        [ True, False ]

                    validation =
                        [ R10.FormComponents.Validations.NotYetValidated
                        , R10.FormComponents.Validations.Validated
                            [ R10.FormComponents.Validations.MessageOk "Succeeded 1"
                            , R10.FormComponents.Validations.MessageOk "Succeeded 2"
                            ]
                        , R10.FormComponents.Validations.Validated
                            [ R10.FormComponents.Validations.MessageErr "Failed"
                            , R10.FormComponents.Validations.MessageOk "Succeded"
                            ]
                        ]

                    result =
                        List.map
                            (\focused_ ->
                                List.map
                                    (\value_ ->
                                        List.map
                                            (\validation_ ->
                                                List.map
                                                    (\disabled_ ->
                                                        row []
                                                            [ el attrsCell <|
                                                                el [ centerX ] <|
                                                                    R10.FormComponents.Binary.view []
                                                                        { label = "Label"
                                                                        , value = value_
                                                                        , focused = focused_
                                                                        , validation = validation_
                                                                        , disabled = disabled_

                                                                        --
                                                                        , msgOnChange = \_ -> DoNothing
                                                                        , msgOnClick = DoNothing
                                                                        , msgOnFocus = DoNothing
                                                                        , msgOnLoseFocus = DoNothing
                                                                        , helperText = Nothing
                                                                        , palette = R10.Form.themeToPalette theme

                                                                        --
                                                                        , typeBinary = R10.FormComponents.Binary.BinaryCheckbox
                                                                        }
                                                            , el attrsCell <| text <| R10.Form.boolToString focused_
                                                            , el attrsCell <| text <| R10.Form.boolToString value_
                                                            , el attrsCell <| text <| "..."
                                                            , el attrsCell <| text <| R10.Form.boolToString disabled_
                                                            ]
                                                    )
                                                    disabled
                                            )
                                            validation
                                    )
                                    value
                            )
                            focused
                in
                List.concat <| List.concat <| List.concat result
               )
        )
    ]


viewJoinedTable : R10.Theme.Theme -> List (Element Msg)
viewJoinedTable theme =
    let
        attrs =
            [ Border.color <| rgba 0 0 0 0.1 ]

        attrsTable =
            attrs
                ++ [ Border.widthEach { bottom = 0, left = 1, right = 0, top = 1 }
                   , width fill
                   ]

        attrsRow =
            attrs
                ++ [ width fill
                   ]

        attrsElCell portion =
            attrs
                ++ [ Border.widthEach { bottom = 1, left = 0, right = 1, top = 0 }
                   , width <| fillPortion portion
                   , height fill
                   , padding 10
                   , centerX
                   , centerY
                   ]

        attrsElCellHeader portion =
            attrsElCell portion
                ++ [ Font.bold
                   , Background.color <| rgba 0 0 0 0.1
                   ]

        attrsPropCell =
            attrs
                ++ [ Border.widthEach { bottom = 1, left = 0, right = 1, top = 0 }
                   , width <| px 90
                   , height fill
                   , paddingXY 0 10
                   , Font.center
                   ]

        attrsPropCellHeader =
            attrsPropCell
                ++ [ Font.bold
                   , Background.color <| rgba 0 0 0 0.1
                   ]
    in
    [ el [] <| text "Collection of Elements and Possible states"
    , column
        attrsTable
        (row attrsRow
            [ el (attrsElCellHeader 2) <| text "Text (filled)"
            , el (attrsElCellHeader 2) <| text "Text (outlined)"
            , el (attrsElCellHeader 1) <| text "Checkbox"
            , el (attrsElCellHeader 1) <| text "Switch"
            , el attrsPropCellHeader <| text "Focused"
            , el attrsPropCellHeader <| text "Value"
            , el attrsPropCellHeader <| text "Validation"
            , el attrsPropCellHeader <| text "Disabled"
            ]
            :: (let
                    disabled =
                        [ True, False ]

                    focused =
                        [ True, False ]

                    value =
                        [ True, False ]

                    validation =
                        [ R10.FormComponents.Validations.NotYetValidated
                        , R10.FormComponents.Validations.Validated
                            [ R10.FormComponents.Validations.MessageOk "Succeeded 1"
                            , R10.FormComponents.Validations.MessageOk "Succeeded 2"
                            ]
                        , R10.FormComponents.Validations.Validated
                            [ R10.FormComponents.Validations.MessageErr "Failed"
                            , R10.FormComponents.Validations.MessageOk "Succeed"
                            ]
                        ]

                    result =
                        List.map
                            (\focused_ ->
                                List.map
                                    (\value_ ->
                                        List.map
                                            (\validation_ ->
                                                List.map
                                                    (\disabled_ ->
                                                        row attrsRow
                                                            [ el (attrsElCell 2) <|
                                                                R10.FormComponents.Text.view []
                                                                    []
                                                                    { value =
                                                                        if value_ then
                                                                            "Value"

                                                                        else
                                                                            ""
                                                                    , focused = focused_
                                                                    , validation = validation_
                                                                    , showPassword = False
                                                                    , leadingIcon = Nothing
                                                                    , trailingIcon = Nothing

                                                                    --
                                                                    , msgOnChange = \_ -> DoNothing
                                                                    , msgOnFocus = DoNothing
                                                                    , msgOnLoseFocus = Just DoNothing
                                                                    , msgOnTogglePasswordShow = Just DoNothing
                                                                    , msgOnEnter = Nothing

                                                                    --
                                                                    , label = "Label"
                                                                    , helperText = Just "Helper Text"
                                                                    , textType = R10.FormComponents.Text.TextPlain
                                                                    , disabled = disabled_
                                                                    , idDom = Nothing
                                                                    , requiredLabel = Just "(Required)"
                                                                    , style = R10.FormComponents.style.filled
                                                                    , palette = R10.Form.themeToPalette theme
                                                                    }
                                                            , el (attrsElCell 2) <|
                                                                R10.FormComponents.Text.view []
                                                                    []
                                                                    { value =
                                                                        if value_ then
                                                                            "Value"

                                                                        else
                                                                            ""
                                                                    , focused = focused_
                                                                    , validation = validation_
                                                                    , showPassword = False
                                                                    , leadingIcon = Nothing
                                                                    , trailingIcon = Nothing

                                                                    --
                                                                    , msgOnChange = \_ -> DoNothing
                                                                    , msgOnFocus = DoNothing
                                                                    , msgOnLoseFocus = Just DoNothing
                                                                    , msgOnTogglePasswordShow = Just DoNothing
                                                                    , msgOnEnter = Nothing

                                                                    --
                                                                    , label = "Label"
                                                                    , helperText = Just "Helper Text"
                                                                    , textType = R10.FormComponents.Text.TextPlain
                                                                    , disabled = disabled_
                                                                    , idDom = Nothing
                                                                    , requiredLabel = Just "(Required)"
                                                                    , style = R10.FormComponents.style.outlined
                                                                    , palette = R10.Form.themeToPalette theme
                                                                    }
                                                            , el (attrsElCell 1) <|
                                                                R10.FormComponents.Binary.view []
                                                                    { label = "Label"
                                                                    , value = value_
                                                                    , focused = focused_
                                                                    , validation = validation_
                                                                    , disabled = disabled_

                                                                    --
                                                                    , msgOnChange = \_ -> DoNothing
                                                                    , msgOnClick = DoNothing
                                                                    , msgOnFocus = DoNothing
                                                                    , msgOnLoseFocus = DoNothing
                                                                    , helperText = Nothing
                                                                    , palette = R10.Form.themeToPalette theme

                                                                    --
                                                                    , typeBinary = R10.FormComponents.Binary.BinarySwitch
                                                                    }
                                                            , el (attrsElCell 1) <|
                                                                R10.FormComponents.Binary.view []
                                                                    { label = "Label"
                                                                    , value = value_
                                                                    , focused = focused_
                                                                    , validation = validation_
                                                                    , disabled = disabled_

                                                                    --
                                                                    , msgOnChange = \_ -> DoNothing
                                                                    , msgOnClick = DoNothing
                                                                    , msgOnFocus = DoNothing
                                                                    , msgOnLoseFocus = DoNothing
                                                                    , helperText = Nothing
                                                                    , palette = R10.Form.themeToPalette theme

                                                                    --
                                                                    , typeBinary = R10.FormComponents.Binary.BinaryCheckbox
                                                                    }
                                                            , el attrsPropCell <| text <| R10.Form.boolToString focused_
                                                            , el attrsPropCell <| text <| R10.Form.boolToString value_
                                                            , el attrsPropCell <| text <| validationToStr validation_
                                                            , el attrsPropCell <| text <| R10.Form.boolToString disabled_
                                                            ]
                                                    )
                                                    disabled
                                            )
                                            validation
                                    )
                                    value
                            )
                            focused
                in
                List.concat <| List.concat <| List.concat result
               )
        )
    ]


viewTextTable : R10.Theme.Theme -> List (Element Msg)
viewTextTable theme =
    let
        attrs =
            [ Border.color <| rgba 0 0 0 0.1 ]

        attrsTable =
            attrs
                ++ [ Border.widthEach { bottom = 0, left = 1, right = 0, top = 1 }
                   ]

        attrsCell =
            attrs
                ++ [ Border.widthEach { bottom = 1, left = 0, right = 1, top = 0 }
                   , width <| px 150
                   , height fill
                   , padding 10
                   , Font.center
                   ]

        attrsCellHeader =
            attrsCell
                ++ [ Font.bold
                   , Background.color <| rgba 0 0 0 0.1
                   ]
    in
    [ el [] <| text "Text field - Component definition"
    , el [ Font.family [ Font.monospace ] ] <|
        text """FormComponents.Binary.view :
    List (Attribute msg)
    ->
        { label : String
        , value : String
        , focused : Bool
        , valid : Maybe Bool
        , displayValidation : Bool

        --
        , msgOnChange : String -> msg
        , msgOnFocus : msg
        , msgOnLoseFocus : msg
        , msgOnTogglePasswordShow : msg

        --
        , requiredLabel : Bool
        , helperText : Maybe String
        , textType : TextType
        , disabled : Bool
        }
    -> Element msg"""
    , el [] <| text "Text field - Possible states"
    , column
        attrsTable
        (row []
            [ el (attrsCellHeader ++ [ width <| px 250 ]) <| text "Text field Filled"
            , el (attrsCellHeader ++ [ width <| px 250 ]) <| text "Text field Outlined"
            , el attrsCellHeader <| text "Focused"
            , el attrsCellHeader <| text "Validation"
            , el attrsCellHeader <| text "Display Validation"
            , el attrsCellHeader <| text "Disabled"
            ]
            :: (let
                    focused =
                        [ True, False ]

                    validation =
                        [ R10.FormComponents.Validations.NotYetValidated
                        , R10.FormComponents.Validations.Validated
                            [ R10.FormComponents.Validations.MessageOk "Succeeded 1"
                            , R10.FormComponents.Validations.MessageOk "Succeeded 2"
                            ]
                        , R10.FormComponents.Validations.Validated
                            [ R10.FormComponents.Validations.MessageErr "Failed"
                            , R10.FormComponents.Validations.MessageOk "Succeeded"
                            ]
                        ]

                    displayValidation =
                        [ True, False ]

                    disabled =
                        [ True, False ]

                    result =
                        List.map
                            (\focused_ ->
                                List.map
                                    (\validation_ ->
                                        List.map
                                            (\displayValidation_ ->
                                                List.map
                                                    (\disabled_ ->
                                                        row []
                                                            [ el (attrsCell ++ [ width <| px 250, Font.alignLeft ]) <|
                                                                R10.FormComponents.Text.view []
                                                                    []
                                                                    { value = "Value"
                                                                    , focused = focused_
                                                                    , validation = validation_
                                                                    , showPassword = False
                                                                    , leadingIcon = Nothing
                                                                    , trailingIcon = Nothing

                                                                    --
                                                                    , msgOnChange = \_ -> DoNothing
                                                                    , msgOnFocus = DoNothing
                                                                    , msgOnLoseFocus = Just DoNothing
                                                                    , msgOnTogglePasswordShow = Just DoNothing
                                                                    , msgOnEnter = Nothing

                                                                    --
                                                                    , label = "Label"
                                                                    , helperText = Just "Helper Text"
                                                                    , textType = R10.FormComponents.Text.TextPasswordNew
                                                                    , disabled = disabled_
                                                                    , idDom = Nothing
                                                                    , requiredLabel = Just "(Required)"
                                                                    , style = R10.FormComponents.style.filled
                                                                    , palette = R10.Form.themeToPalette theme
                                                                    }
                                                            , el (attrsCell ++ [ width <| px 250, Font.alignLeft ]) <|
                                                                R10.FormComponents.Text.view []
                                                                    []
                                                                    { value = "Value"
                                                                    , focused = focused_
                                                                    , validation = validation_
                                                                    , showPassword = False
                                                                    , leadingIcon = Nothing
                                                                    , trailingIcon = Nothing

                                                                    --
                                                                    , msgOnChange = \_ -> DoNothing
                                                                    , msgOnFocus = DoNothing
                                                                    , msgOnLoseFocus = Just DoNothing
                                                                    , msgOnTogglePasswordShow = Just DoNothing
                                                                    , msgOnEnter = Nothing

                                                                    --
                                                                    , label = "Label"
                                                                    , helperText = Just "Helper Text"
                                                                    , textType = R10.FormComponents.Text.TextPasswordNew
                                                                    , disabled = disabled_
                                                                    , idDom = Nothing
                                                                    , requiredLabel = Just "(Required)"
                                                                    , style = R10.FormComponents.style.outlined
                                                                    , palette = R10.Form.themeToPalette theme
                                                                    }
                                                            , el attrsCell <| text <| R10.Form.boolToString focused_
                                                            , el attrsCell <| text <| validationToStr validation_
                                                            , el attrsCell <| text <| R10.Form.boolToString displayValidation_
                                                            , el attrsCell <| text <| R10.Form.boolToString disabled_
                                                            ]
                                                    )
                                                    disabled
                                            )
                                            displayValidation
                                    )
                                    validation
                            )
                            focused
                in
                List.concat <| List.concat <| List.concat result
               )
        )
    ]


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
    [ column
        [ width fill
        ]
        [ el [] <| text "Form Components"
        , column [] <| viewJoinedTable theme
        , column [] <| viewTextTable theme
        , column [] <| viewChecboxTable theme
        ]
    ]
