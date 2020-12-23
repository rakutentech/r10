module Pages.Form_States exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import R10.Form
import R10.FormTypes
import R10.Theme


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


maybeBoolToString : Maybe Bool -> String
maybeBoolToString valid =
    case valid of
        Just bool ->
            if bool then
                "Just True"

            else
                "Just False"

        Nothing ->
            "Nothing"


viewChecboxTable : R10.Theme.Theme -> List (Element Msg)
viewChecboxTable theme =
    let
        attrs : List (Attribute msg)
        attrs =
            [ Border.color <| rgba 0 0 0 0.1 ]

        attrsTable : List (Attribute msg)
        attrsTable =
            attrs
                ++ [ Border.widthEach { bottom = 0, left = 1, right = 0, top = 1 }
                   ]

        attrsCell : List (Attribute msg)
        attrsCell =
            attrs
                ++ [ Border.widthEach { bottom = 1, left = 0, right = 1, top = 0 }
                   , width <| px 150
                   , height fill
                   , padding 10
                   , Font.center
                   ]

        attrsCellHeader : List (Attribute msg)
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
                    disabled : List Bool
                    disabled =
                        [ True, False ]

                    focused : List Bool
                    focused =
                        [ True, False ]

                    value : List Bool
                    value =
                        [ True, False ]

                    validation : List (Maybe Bool)
                    validation =
                        [ Nothing
                        , Just True
                        , Just False
                        ]

                    result : List (List (List (List (Element Msg))))
                    result =
                        List.map
                            (\focused_ ->
                                List.map
                                    (\value_ ->
                                        List.map
                                            (\valid_ ->
                                                List.map
                                                    (\disabled_ ->
                                                        row []
                                                            [ el attrsCell <|
                                                                el [ centerX ] <|
                                                                    R10.Form.viewBinary []
                                                                        { label = "Label"
                                                                        , value = value_
                                                                        , focused = focused_
                                                                        , valid = valid_
                                                                        , disabled = disabled_

                                                                        --
                                                                        , msgOnChange = \_ -> DoNothing
                                                                        , msgOnClick = DoNothing
                                                                        , msgOnFocus = DoNothing
                                                                        , msgOnLoseFocus = DoNothing
                                                                        , helperText = Nothing
                                                                        , palette = R10.Form.themeToPalette theme

                                                                        --
                                                                        , typeBinary = R10.FormTypes.BinaryCheckbox
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
        attrs : List (Attribute msg)
        attrs =
            [ Border.color <| rgba 0 0 0 0.1 ]

        attrsTable : List (Attribute msg)
        attrsTable =
            attrs
                ++ [ Border.widthEach { bottom = 0, left = 1, right = 0, top = 1 }
                   , width fill
                   ]

        attrsRow : List (Attribute msg)
        attrsRow =
            attrs
                ++ [ width fill
                   ]

        attrsElCell : Int -> List (Attribute msg)
        attrsElCell portion =
            attrs
                ++ [ Border.widthEach { bottom = 1, left = 0, right = 1, top = 0 }
                   , width <| fillPortion portion
                   , height fill
                   , padding 10
                   , centerX
                   , centerY
                   ]

        attrsElCellHeader : Int -> List (Attribute msg)
        attrsElCellHeader portion =
            attrsElCell portion
                ++ [ Font.bold
                   , Background.color <| rgba 0 0 0 0.1
                   ]

        attrsPropCell : List (Attribute msg)
        attrsPropCell =
            attrs
                ++ [ Border.widthEach { bottom = 1, left = 0, right = 1, top = 0 }
                   , width <| px 90
                   , height fill
                   , paddingXY 0 10
                   , Font.center
                   ]

        attrsPropCellHeader : List (Attribute msg)
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
                    disabled : List Bool
                    disabled =
                        [ True, False ]

                    focused : List Bool
                    focused =
                        [ True, False ]

                    value : List Bool
                    value =
                        [ True, False ]

                    validation : List (Maybe Bool)
                    validation =
                        [ Nothing
                        , Just True
                        , Just False
                        ]

                    result : List (List (List (List (Element Msg))))
                    result =
                        List.map
                            (\focused_ ->
                                List.map
                                    (\value_ ->
                                        List.map
                                            (\valid_ ->
                                                List.map
                                                    (\disabled_ ->
                                                        row attrsRow
                                                            [ el (attrsElCell 2) <|
                                                                R10.Form.viewText []
                                                                    []
                                                                    { value =
                                                                        if value_ then
                                                                            "Value"

                                                                        else
                                                                            ""
                                                                    , focused = focused_
                                                                    , valid = valid_
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
                                                                    , textType = R10.FormTypes.TextPlain
                                                                    , disabled = disabled_
                                                                    , idDom = Nothing
                                                                    , requiredLabel = Just "(Required)"
                                                                    , style = R10.Form.style.filled
                                                                    , palette = R10.Form.themeToPalette theme
                                                                    }
                                                            , el (attrsElCell 2) <|
                                                                R10.Form.viewText []
                                                                    []
                                                                    { value =
                                                                        if value_ then
                                                                            "Value"

                                                                        else
                                                                            ""
                                                                    , focused = focused_
                                                                    , valid = valid_
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
                                                                    , textType = R10.FormTypes.TextPlain
                                                                    , disabled = disabled_
                                                                    , idDom = Nothing
                                                                    , requiredLabel = Just "(Required)"
                                                                    , style = R10.Form.style.outlined
                                                                    , palette = R10.Form.themeToPalette theme
                                                                    }
                                                            , el (attrsElCell 1) <|
                                                                R10.Form.viewBinary []
                                                                    { label = "Label"
                                                                    , value = value_
                                                                    , focused = focused_
                                                                    , valid = valid_
                                                                    , disabled = disabled_

                                                                    --
                                                                    , msgOnChange = \_ -> DoNothing
                                                                    , msgOnClick = DoNothing
                                                                    , msgOnFocus = DoNothing
                                                                    , msgOnLoseFocus = DoNothing
                                                                    , helperText = Nothing
                                                                    , palette = R10.Form.themeToPalette theme

                                                                    --
                                                                    , typeBinary = R10.FormTypes.BinarySwitch
                                                                    }
                                                            , el (attrsElCell 1) <|
                                                                R10.Form.viewBinary []
                                                                    { label = "Label"
                                                                    , value = value_
                                                                    , focused = focused_
                                                                    , valid = valid_
                                                                    , disabled = disabled_

                                                                    --
                                                                    , msgOnChange = \_ -> DoNothing
                                                                    , msgOnClick = DoNothing
                                                                    , msgOnFocus = DoNothing
                                                                    , msgOnLoseFocus = DoNothing
                                                                    , helperText = Nothing
                                                                    , palette = R10.Form.themeToPalette theme

                                                                    --
                                                                    , typeBinary = R10.FormTypes.BinaryCheckbox
                                                                    }
                                                            , el attrsPropCell <| text <| R10.Form.boolToString focused_
                                                            , el attrsPropCell <| text <| R10.Form.boolToString value_
                                                            , el attrsPropCell <| text <| maybeBoolToString valid_
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
        attrs : List (Attribute msg)
        attrs =
            [ Border.color <| rgba 0 0 0 0.1 ]

        attrsTable : List (Attribute msg)
        attrsTable =
            attrs
                ++ [ Border.widthEach { bottom = 0, left = 1, right = 0, top = 1 }
                   ]

        attrsCell : List (Attribute msg)
        attrsCell =
            attrs
                ++ [ Border.widthEach { bottom = 1, left = 0, right = 1, top = 0 }
                   , width <| px 150
                   , height fill
                   , padding 10
                   , Font.center
                   ]

        attrsCellHeader : List (Attribute msg)
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
                    focused : List Bool
                    focused =
                        [ True, False ]

                    validation : List (Maybe Bool)
                    validation =
                        [ Nothing
                        , Just True
                        , Just False
                        ]

                    displayValidation : List Bool
                    displayValidation =
                        [ True, False ]

                    disabled : List Bool
                    disabled =
                        [ True, False ]

                    result : List (List (List (List (Element Msg))))
                    result =
                        List.map
                            (\focused_ ->
                                List.map
                                    (\valid_ ->
                                        List.map
                                            (\displayValidation_ ->
                                                List.map
                                                    (\disabled_ ->
                                                        row []
                                                            [ el (attrsCell ++ [ width <| px 250, Font.alignLeft ]) <|
                                                                R10.Form.viewText []
                                                                    []
                                                                    { value = "Value"
                                                                    , focused = focused_
                                                                    , valid = valid_
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
                                                                    , textType = R10.FormTypes.TextPasswordNew
                                                                    , disabled = disabled_
                                                                    , idDom = Nothing
                                                                    , requiredLabel = Just "(Required)"
                                                                    , style = R10.Form.style.filled
                                                                    , palette = R10.Form.themeToPalette theme
                                                                    }
                                                            , el (attrsCell ++ [ width <| px 250, Font.alignLeft ]) <|
                                                                R10.Form.viewText []
                                                                    []
                                                                    { value = "Value"
                                                                    , focused = focused_
                                                                    , valid = valid_
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
                                                                    , textType = R10.FormTypes.TextPasswordNew
                                                                    , disabled = disabled_
                                                                    , idDom = Nothing
                                                                    , requiredLabel = Just "(Required)"
                                                                    , style = R10.Form.style.outlined
                                                                    , palette = R10.Form.themeToPalette theme
                                                                    }
                                                            , el attrsCell <| text <| R10.Form.boolToString focused_
                                                            , el attrsCell <| text <| maybeBoolToString valid_
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
view _ theme =
    [ column
        [ width fill
        ]
        [ el [] <| text "Form Components"
        , column [] <| viewJoinedTable theme
        , column [] <| viewTextTable theme
        , column [] <| viewChecboxTable theme
        ]
    ]
