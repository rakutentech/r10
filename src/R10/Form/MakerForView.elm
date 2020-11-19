module Form.MakerForView exposing
    ( MakerArgs
    , Outcome
    , extraCss
    , maker
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Form.Conf
import Form.Converter exposing (fromFormValidationIconToComponentValidationIcon)
import Form.Dict
import Form.FieldConf exposing (ValidationIcon(..))
import Form.FieldState exposing (ValidationOutcome(..))
import Form.Helpers
import Form.Key
import Form.Msg
import Form.State
import Form.Update
import FormComponents.Binary
import FormComponents.ExtraCss
import FormComponents.Single
import FormComponents.Style
import FormComponents.Text
import FormComponents.UI
import FormComponents.UI.Color
import FormComponents.UI.Palette
import FormComponents.Validations
import Html.Attributes



--  ██████  ██    ██ ████████  ██████  ██████  ███    ███ ███████
-- ██    ██ ██    ██    ██    ██      ██    ██ ████  ████ ██
-- ██    ██ ██    ██    ██    ██      ██    ██ ██ ████ ██ █████
-- ██    ██ ██    ██    ██    ██      ██    ██ ██  ██  ██ ██
--  ██████   ██████     ██     ██████  ██████  ██      ██ ███████


type alias Outcome =
    Element Form.Msg.Msg



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


type alias ArgsForFields =
    { fieldConf : Form.FieldConf.FieldConf
    , fieldState : Form.FieldState.FieldState
    , focused : Bool
    , active : Bool
    , key : Form.Key.Key
    , translator : Form.FieldConf.ValidationCode -> String
    , style : FormComponents.Style.Style
    , palette : FormComponents.UI.Palette.Palette
    }


paddingGeneric : Attribute msg
paddingGeneric =
    paddingXY 20 25


spacingGeneric : Attribute msg
spacingGeneric =
    spacingXY 15 25


extraCss : Maybe FormComponents.UI.Palette.Palette -> String
extraCss maybePalette =
    let
        palette : FormComponents.UI.Palette.Palette
        palette =
            Maybe.withDefault FormComponents.UI.Palette.light maybePalette
    in
    FormComponents.ExtraCss.extraCss palette


isFocused : Form.Key.Key -> Maybe String -> Bool
isFocused key focused =
    case focused of
        Just focused_x ->
            focused_x == Form.Key.toString key

        Nothing ->
            False


isActive : Form.Key.Key -> Maybe String -> Bool
isActive key active =
    case active of
        Just active_x ->
            active_x == Form.Key.toString key

        Nothing ->
            False


getEntityKey : MakerArgs -> Form.Conf.Entity -> Form.Key.Key
getEntityKey args entity =
    let
        id : String
        id =
            case entity of
                Form.Conf.EntityWrappable entityId _ ->
                    entityId

                Form.Conf.EntityWithBorder entityId _ ->
                    entityId

                Form.Conf.EntityNormal entityId _ ->
                    entityId

                Form.Conf.EntityWithTabs entityId _ ->
                    entityId

                Form.Conf.EntityMulti entityId _ ->
                    entityId

                Form.Conf.EntityField fieldConf ->
                    fieldConf.id

                Form.Conf.EntityTitle entityId _ ->
                    entityId

                Form.Conf.EntitySubTitle entityId _ ->
                    entityId
    in
    Form.Key.composeKey args.key id


getFieldConfig : Form.Conf.Entity -> Form.FieldConf.FieldConf
getFieldConfig entity =
    case entity of
        Form.Conf.EntityField fieldConf ->
            fieldConf

        _ ->
            Form.FieldConf.init



-- ██ ███    ██ ██████  ██    ██ ████████     ████████ ███████ ██   ██ ████████
-- ██ ████   ██ ██   ██ ██    ██    ██           ██    ██       ██ ██     ██
-- ██ ██ ██  ██ ██████  ██    ██    ██           ██    █████     ███      ██
-- ██ ██  ██ ██ ██      ██    ██    ██           ██    ██       ██ ██     ██
-- ██ ██   ████ ██       ██████     ██           ██    ███████ ██   ██    ██


viewText :
    ArgsForFields
    -> Form.FieldConf.TypeText
    -> Form.Conf.Conf
    -> Element Form.Msg.Msg
viewText args textType formConf =
    FormComponents.Text.view
        [ width
            (fill
                |> minimum 300
                |> maximum 900
            )
        ]
        []
        -- Stuff that change
        { value = args.fieldState.value
        , focused = args.focused
        , validation =
            Form.Converter.fromFieldStateValidationToComponentValidation
                args.fieldConf.validationSpecs
                args.fieldState.validation
                args.translator
        , showPassword = args.fieldState.showPassword
        , leadingIcon = Nothing
        , trailingIcon = Nothing

        -- Messages
        , msgOnChange = Form.Msg.ChangeValue args.key args.fieldConf formConf
        , msgOnFocus = Form.Msg.GetFocus args.key
        , msgOnLoseFocus = Just <| Form.Msg.LoseFocus args.key args.fieldConf
        , msgOnTogglePasswordShow = Just <| Form.Msg.TogglePasswordShow args.key
        , msgOnEnter = Just <| Form.Msg.Submit formConf

        -- Stuff that doesn't change
        , label = args.fieldConf.label
        , helperText = args.fieldConf.helperText
        , disabled = args.fieldState.disabled
        , idDom = args.fieldConf.idDom
        , style = args.style
        , requiredLabel = args.fieldConf.requiredLabel
        , palette = args.palette

        -- Specific
        , textType = Form.Converter.textTypeFromFieldConfToComponent textType
        }



--  ██████ ██   ██ ███████  ██████ ██   ██ ██████   ██████  ██   ██
-- ██      ██   ██ ██      ██      ██  ██  ██   ██ ██    ██  ██ ██
-- ██      ███████ █████   ██      █████   ██████  ██    ██   ███
-- ██      ██   ██ ██      ██      ██  ██  ██   ██ ██    ██  ██ ██
--  ██████ ██   ██ ███████  ██████ ██   ██ ██████   ██████  ██   ██


viewBinary :
    ArgsForFields
    -> Form.FieldConf.TypeBinary
    -> Form.Conf.Conf
    -> Element Form.Msg.Msg
viewBinary args typeBinary formConf =
    let
        value : Bool
        value =
            Form.Helpers.stringToBool args.fieldState.value

        msgOnClick : Form.Msg.Msg
        msgOnClick =
            Form.Msg.ChangeValue args.key args.fieldConf formConf (Form.Helpers.boolToString <| not value)
    in
    FormComponents.Binary.view
        [ width
            (fill
                |> minimum 300
                |> maximum 900
            )
        ]
        -- Stuff that change
        { value = value
        , focused = args.focused
        , validation =
            Form.Converter.fromFieldStateValidationToComponentValidation
                args.fieldConf.validationSpecs
                args.fieldState.validation
                args.translator

        -- Messages
        , msgOnChange = \_ -> msgOnClick
        , msgOnFocus = Form.Msg.GetFocus args.key
        , msgOnLoseFocus = Form.Msg.LoseFocus args.key args.fieldConf
        , msgOnClick = msgOnClick

        -- Stuff that doesn't change
        , label = args.fieldConf.label
        , disabled = args.fieldState.disabled
        , helperText = args.fieldConf.helperText
        , palette = args.palette

        -- Specific stuff
        , typeBinary = Form.Converter.binaryTypeFromFieldConfToComponent typeBinary
        }



-- ██████   █████  ██████  ██  ██████
-- ██   ██ ██   ██ ██   ██ ██ ██    ██
-- ██████  ███████ ██   ██ ██ ██    ██
-- ██   ██ ██   ██ ██   ██ ██ ██    ██
-- ██   ██ ██   ██ ██████  ██  ██████


viewSingleSelection :
    ArgsForFields
    -> Form.FieldConf.TypeSingle
    -> List Form.FieldConf.FieldOption
    -> Form.Conf.Conf
    -> Element.Element Form.Msg.Msg
viewSingleSelection args singleType fieldOptions formConf =
    FormComponents.Single.view
        [ width
            (fill
                |> minimum 300
                |> maximum 900
            )
        ]
        -- Stuff that change
        { value = args.fieldState.value
        , search = args.fieldState.search
        , select = args.fieldState.select
        , scroll = args.fieldState.scroll
        , focused = args.focused
        , opened = args.active
        }
        { validation =
            Form.Converter.fromFieldStateValidationToComponentValidation
                args.fieldConf.validationSpecs
                args.fieldState.validation
                args.translator

        -- Message mapper
        , toMsg = Form.Msg.OnSingleMsg args.key args.fieldConf formConf

        -- Stuff that doesn't change
        , label = args.fieldConf.label
        , helperText = args.fieldConf.helperText
        , disabled = args.fieldState.disabled
        , requiredLabel = args.fieldConf.requiredLabel
        , style = args.style
        , key = Form.Key.toString args.key
        , palette = args.palette

        -- Specific
        , singleType = Form.Converter.singleTypeFromFieldConfToComponent singleType
        , fieldOptions = fieldOptions
        }



-- ██    ██ ██ ███████ ██     ██     ███████ ███    ██ ████████ ██ ████████ ██ ███████ ███████
-- ██    ██ ██ ██      ██     ██     ██      ████   ██    ██    ██    ██    ██ ██      ██
-- ██    ██ ██ █████   ██  █  ██     █████   ██ ██  ██    ██    ██    ██    ██ █████   ███████
--  ██  ██  ██ ██      ██ ███ ██     ██      ██  ██ ██    ██    ██    ██    ██ ██           ██
--   ████   ██ ███████  ███ ███      ███████ ██   ████    ██    ██    ██    ██ ███████ ███████


viewEntityNormal :
    MakerArgs
    -> List Form.Conf.Entity
    -> Form.Conf.Conf
    -> List Outcome
viewEntityNormal args entities formConf =
    [ el
        [ alignTop
        , width fill
        , height fill
        , spacingGeneric
        ]
      <|
        column
            -- This padding need to be nested, otherwise the fill doesn't
            -- get 50% of the space
            [ spacingGeneric
            , width fill
            ]
        <|
            maker_ args entities formConf
    ]


viewEntityWrappable :
    MakerArgs
    -> List Form.Conf.Entity
    -> Form.Conf.Conf
    -> List Outcome
viewEntityWrappable args entities formConf =
    [ wrappedRow
        [ alignTop
        , width fill
        , height fill
        , spacingGeneric
        ]
      <|
        maker_ args entities formConf
    ]


viewEntityWithBorder :
    MakerArgs
    -> List Form.Conf.Entity
    -> Form.Conf.Conf
    -> List Outcome
viewEntityWithBorder args entities formConf =
    [ el
        ([ alignTop
         , width fill
         , height fill
         ]
            ++ FormComponents.UI.borderEntityWithBorder args.palette
        )
      <|
        column
            -- This padding need to be nested, otherwise the fill doesn't
            -- get 50% of the space
            [ paddingGeneric
            , spacingGeneric
            , width fill
            ]
        <|
            maker_ args entities formConf
    ]


viewTab :
    MakerArgs
    -> Form.FieldState.FieldState
    ->
        { index : Int
        , selected : Bool
        , label : String
        , entity : Form.Conf.Entity
        }
    -> Element Form.Msg.Msg
viewTab args fieldState { index, selected, entity, label } =
    let
        valid : Bool
        valid =
            Form.Update.isExistingFormFieldsValid [ entity ] args.formState

        { opacity, clickOverlay } =
            if fieldState.disabled then
                { opacity = 0.5
                , clickOverlay = none
                }

            else
                { opacity = 1
                , clickOverlay =
                    el
                        [ Events.onClick <| Form.Msg.ChangeTab args.key (Form.Conf.getId entity)
                        , pointer
                        , width fill
                        , height fill
                        , htmlAttribute <| Html.Attributes.class <| "ripple"
                        , mouseOver [ Background.color <| FormComponents.UI.Color.mouseOverSurface args.palette ]
                        ]
                        none
                }

        { circleBackground, circleBorder, circleText, labelText } =
            if selected then
                { circleBackground = FormComponents.UI.Color.surfaceA opacity args.palette
                , circleBorder = FormComponents.UI.Color.primaryA opacity args.palette
                , circleText = FormComponents.UI.Color.primaryA opacity args.palette
                , labelText = FormComponents.UI.Color.primaryA opacity args.palette
                }

            else
                { circleBackground = FormComponents.UI.Color.surfaceA opacity args.palette
                , circleBorder = FormComponents.UI.Color.labelA opacity args.palette
                , circleText = FormComponents.UI.Color.labelA opacity args.palette
                , labelText = FormComponents.UI.Color.labelA opacity args.palette
                }
    in
    el
        [ paddingXY 8 0
        , inFront <| clickOverlay
        ]
    <|
        row
            [ Background.color <| FormComponents.UI.Color.surface args.palette
            , paddingXY 8 24
            , spacing 8
            , Font.color <| labelText
            ]
        <|
            [ el
                [ inFront <|
                    el
                        [ height fill
                        , Background.color <| FormComponents.UI.Color.surface args.palette
                        ]
                    <|
                        FormComponents.UI.showValidationIcon_
                            { maybeValid = Just valid
                            , displayValidation = True
                            , palette = args.palette
                            }
                , height <| px 24
                , width <| px 24
                , Border.rounded 24
                , Background.color circleBackground
                , Font.color circleText
                , Border.innerShadow
                    { offset = ( 0, 0 )
                    , size = 1
                    , blur = 0
                    , color = circleBorder
                    }
                ]
              <|
                el
                    [ centerY
                    , centerX
                    ]
                <|
                    text <|
                        String.fromInt (index + 1)
            , column [ width shrink ] <|
                [ text label
                , el
                    ([ Font.size 11
                     , clip
                     , Font.color <| FormComponents.UI.Color.error args.palette
                     , htmlAttribute <| Html.Attributes.style "transition" "all 0.15s ease-out"
                     ]
                        ++ (if valid then
                                [ width <| px 0
                                , height <| px 0
                                ]

                            else
                                [ width <| px 80
                                , height <| px 11
                                ]
                           )
                    )
                  <|
                    text "Validation error"
                ]
            ]


viewEntityWithTabs :
    MakerArgs
    -> List ( String, Form.Conf.Entity )
    -> Form.Conf.Conf
    -> List Outcome
viewEntityWithTabs args titleEntityList formConf =
    let
        paddingPx : number
        paddingPx =
            8

        firstEntity : Maybe ( String, Form.Conf.Entity )
        firstEntity =
            List.head titleEntityList

        maybeSelectedEntity : Maybe ( String, Form.Conf.Entity )
        maybeSelectedEntity =
            case Form.Dict.get args.key args.formState.activeTabs of
                Just key_ ->
                    case List.head <| List.filter (\( _, entity ) -> Form.Conf.getId entity == key_) titleEntityList of
                        Just entity_ ->
                            Just entity_

                        Nothing ->
                            firstEntity

                Nothing ->
                    firstEntity

        tabSpacer : Element msg
        tabSpacer =
            el [ width (fill |> maximum 40), height fill ] none

        emptyTab : Element msg
        emptyTab =
            el [ width fill, height fill, moveLeft paddingPx, Background.color <| rgb 1 1 1 ] none
    in
    case maybeSelectedEntity of
        Just ( _, selectedEntity ) ->
            [ el
                [ width fill
                , behindContent <|
                    el [ width fill, centerY, paddingXY paddingPx 0 ] <|
                        el
                            [ width fill
                            , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
                            , Border.color <| FormComponents.UI.Color.container args.palette
                            ]
                            none
                ]
              <|
                row
                    [ scrollbars
                    , width fill
                    ]
                <|
                    (\items -> items ++ [ emptyTab ]) <|
                        (List.concat <|
                            List.indexedMap
                                (\index ( label, entity ) ->
                                    let
                                        newKey : Form.Key.Key
                                        newKey =
                                            Form.Key.composeKey args.key (Form.Conf.getId entity)

                                        fieldState : Form.FieldState.FieldState
                                        fieldState =
                                            Maybe.withDefault Form.FieldState.init <|
                                                Form.Dict.get newKey args.formState.fieldsState
                                    in
                                    [ viewTab args
                                        fieldState
                                        { index = index
                                        , selected = Form.Conf.getId selectedEntity == Form.Conf.getId entity
                                        , label = label
                                        , entity = entity
                                        }
                                    ]
                                        ++ (if index + 1 /= List.length titleEntityList then
                                                [ tabSpacer ]

                                            else
                                                []
                                           )
                                )
                                titleEntityList
                        )
            ]
                ++ maker_ args [ selectedEntity ] formConf

        Nothing ->
            []


viewEntityMultiHelper :
    MakerArgs
    -> Int
    -> Int
    -> Form.Key.Key
    -> List Form.Conf.Entity
    -> Form.Conf.Conf
    -> List (Element Form.Msg.Msg)
viewEntityMultiHelper args quantity index newKey entities formConf =
    let
        iconSize : Int
        iconSize =
            18

        shadow : Float -> Float -> Attr decorative msg
        shadow size_ a =
            Border.shadow
                { offset = ( 0, 0 )
                , size = size_
                , blur = 0
                , color = FormComponents.UI.Color.labelA a args.palette
                }

        buttonAttrs : List (Attr () msg)
        buttonAttrs =
            [ Border.width 1
            , Border.rounded 5
            , htmlAttribute <| Html.Attributes.class <| "ripple"
            , htmlAttribute <| Html.Attributes.style "transition" "all 0.11s ease-out"
            , padding 8
            , width <| px 28
            , height fill
            , shadow 10 0
            , Border.color <| FormComponents.UI.Color.containerA 0.5 args.palette
            , mouseOver <| [ Border.color <| FormComponents.UI.Color.containerA 1 args.palette ]
            , focused <| [ alpha 1, shadow 1 1, Border.color <| FormComponents.UI.Color.containerA 1 args.palette ]
            ]

        plusColor : Color
        plusColor =
            FormComponents.UI.Color.label args.palette

        removeColor : Color
        removeColor =
            FormComponents.UI.Color.label args.palette

        iconCommonAttrs : Int -> Int -> Color -> Float -> List (Attribute msg)
        iconCommonAttrs widthPx heightPx color rotateDeg =
            [ htmlAttribute <| Html.Attributes.style "transition" "all 0.2s "
            , Border.rounded 2
            , centerX
            , centerY
            , width <| px widthPx
            , height <| px heightPx
            , Background.color color
            , rotate <| degrees rotateDeg
            ]

        buttonToAddEntity : Element Form.Msg.Msg
        buttonToAddEntity =
            Input.button buttonAttrs
                { label =
                    el
                        [ width <| px iconSize
                        , height <| px iconSize
                        , inFront <| el (iconCommonAttrs iconSize 2 plusColor 0) none
                        , inFront <| el (iconCommonAttrs 2 iconSize plusColor 0) none
                        ]
                    <|
                        none
                , onPress = Just <| Form.Msg.AddEntity args.key
                }

        buttonToRemoveEntity : Form.Key.Key -> Element Form.Msg.Msg
        buttonToRemoveEntity key_ =
            Input.button buttonAttrs
                { label =
                    el
                        [ width <| px iconSize
                        , height <| px iconSize
                        , htmlAttribute <| Html.Attributes.style "transition" "all 0.2s "
                        , inFront <| el (iconCommonAttrs iconSize 2 removeColor 45) none
                        , inFront <| el (iconCommonAttrs 2 iconSize removeColor -135) none
                        ]
                    <|
                        none
                , onPress = Just <| Form.Msg.RemoveEntity key_
                }
    in
    [ row [ spacing 10, width fill ]
        [ if quantity - 1 == index then
            buttonToAddEntity

          else
            buttonToRemoveEntity newKey
        , column [ width fill, spacingGeneric ] <| maker_ { args | key = newKey } entities formConf
        ]
    ]


viewEntityMulti :
    MakerArgs
    -> List Form.Conf.Entity
    -> Form.Conf.Conf
    -> List Outcome
viewEntityMulti args entities formConf =
    let
        activeKeys : List Form.Key.Key
        activeKeys =
            Form.Helpers.getMultiActiveKeys args.key args.formState

        quantity : Int
        quantity =
            List.length activeKeys
    in
    activeKeys
        |> List.indexedMap
            (\index newKey ->
                viewEntityMultiHelper args quantity index newKey entities formConf
            )
        |> List.concat
        |> column [ spacing 10, width fill ]
        |> List.singleton


viewEntityField :
    MakerArgs
    -> Form.FieldConf.FieldConf
    -> Form.Conf.Conf
    -> List Outcome
viewEntityField args fieldConf formConf =
    let
        newKey : Form.Key.Key
        newKey =
            Form.Key.composeKey args.key fieldConf.id

        fieldState : Form.FieldState.FieldState
        fieldState =
            Maybe.withDefault Form.FieldState.init <|
                Form.Dict.get newKey args.formState.fieldsState

        focused : Bool
        focused =
            isFocused newKey args.formState.focused

        active : Bool
        active =
            isActive newKey args.formState.active
    in
    --
    -- This is the function that render the "leaf" of the tree, some of
    -- the possible input field (text, password, checkboxes, etc...)
    --
    -- key       = the composed key that describe the position in the tree.
    --             The last section of the key contains the FieldId to lookup
    --             in the configurations.
    -- formState = the state of the entire form
    -- fieldType = type of field, for example: text, email, password, etc.
    --
    let
        args2 : ArgsForFields
        args2 =
            { key = newKey
            , focused = focused
            , active = active
            , fieldState = fieldState
            , fieldConf = fieldConf
            , translator = args.translator
            , style = args.style
            , palette = args.palette
            }

        field : Element Form.Msg.Msg
        field =
            case fieldConf.type_ of
                Form.FieldConf.TypeText typeText ->
                    viewText args2 typeText formConf

                Form.FieldConf.TypeBinary typeBinary ->
                    viewBinary args2 typeBinary formConf

                Form.FieldConf.TypeSingle typeSingle options ->
                    viewSingleSelection args2 typeSingle options formConf

                Form.FieldConf.TypeMulti _ _ ->
                    text "TODO"
    in
    [ field ]


viewEntityTitle :
    FormComponents.UI.Palette.Palette
    -> Form.Conf.TextConf
    -> List Outcome
viewEntityTitle palette titleConf =
    [ column
        [ spacing 12
        , paddingEach { top = 40, right = 0, bottom = 0, left = 0 }
        , width fill
        ]
        [ paragraph [ FormComponents.UI.fontSizeTitle ] [ text titleConf.title ]
        , FormComponents.UI.viewHelperText palette [] titleConf.helperText
        ]
    ]


viewEntitySubTitle :
    FormComponents.UI.Palette.Palette
    -> Form.Conf.TextConf
    -> List Outcome
viewEntitySubTitle palette titleConf =
    [ column
        [ spacing FormComponents.UI.genericSpacing
        , width fill
        ]
        [ paragraph [ FormComponents.UI.fontSizeSubTitle ] [ text titleConf.title ]
        , FormComponents.UI.viewHelperText palette [ alpha 0.5, Font.size 14, paddingEach { top = FormComponents.UI.genericSpacing, right = 0, bottom = 0, left = 0 } ] titleConf.helperText
        ]
    ]


viewWithValidationMessage : MakerArgs -> Form.Conf.Entity -> List (Element msg) -> List (Element msg)
viewWithValidationMessage args entity listEl =
    let
        validationIcon : FormComponents.Validations.ValidationIcon
        validationIcon =
            getFieldConfig entity
                |> .validationSpecs
                |> Maybe.map .validationIcon
                |> Maybe.withDefault NoIcon
                |> fromFormValidationIconToComponentValidationIcon
    in
    [ column [ width fill, height fill ] <|
        listEl
            ++ [ FormComponents.Validations.viewValidation args.palette validationIcon <|
                    Form.Converter.fromFieldStateValidationToComponentValidation
                        (getFieldConfig entity |> .validationSpecs)
                        (Form.Dict.get (getEntityKey args entity) args.formState.fieldsState
                            |> Maybe.withDefault Form.FieldState.init
                        ).validation
                        args.translator
               ]
    ]



-- ███    ███  █████  ██   ██ ███████ ██████
-- ████  ████ ██   ██ ██  ██  ██      ██   ██
-- ██ ████ ██ ███████ █████   █████   ██████
-- ██  ██  ██ ██   ██ ██  ██  ██      ██   ██
-- ██      ██ ██   ██ ██   ██ ███████ ██   ██


type alias MakerArgs =
    { key : Form.Key.Key
    , formState : Form.State.State
    , translator : Form.FieldConf.ValidationCode -> String
    , style : FormComponents.Style.Style
    , palette : FormComponents.UI.Palette.Palette
    }


maker :
    MakerArgs
    -> Form.Conf.Conf
    -> List Outcome
maker args formConf =
    maker_ args formConf formConf


maker_ :
    MakerArgs
    -> Form.Conf.Conf
    -> Form.Conf.Conf
    -> List Outcome
maker_ args branchConfig rootFormConf =
    --
    --     This is recursive
    --
    --   ┌─────> maker >─────┐
    --   │                   │
    --   └───────────────────┘
    --
    List.map
        (\entity ->
            (case entity of
                Form.Conf.EntityWrappable entityId entities ->
                    viewEntityWrappable { args | key = Form.Key.composeKey args.key entityId } entities rootFormConf

                Form.Conf.EntityWithBorder entityId entities ->
                    viewEntityWithBorder { args | key = Form.Key.composeKey args.key entityId } entities rootFormConf

                Form.Conf.EntityNormal entityId entities ->
                    viewEntityNormal { args | key = Form.Key.composeKey args.key entityId } entities rootFormConf

                Form.Conf.EntityWithTabs entityId titleEntityList ->
                    viewEntityWithTabs { args | key = Form.Key.composeKey args.key entityId } titleEntityList rootFormConf

                Form.Conf.EntityMulti entityId entities ->
                    viewEntityMulti { args | key = Form.Key.composeKey args.key entityId } entities rootFormConf

                Form.Conf.EntityField fieldConf ->
                    viewEntityField args fieldConf rootFormConf

                Form.Conf.EntityTitle _ titleConf ->
                    viewEntityTitle args.palette titleConf

                Form.Conf.EntitySubTitle _ titleConf ->
                    viewEntitySubTitle args.palette titleConf
            )
                |> viewWithValidationMessage args entity
        )
        branchConfig
        |> List.concat
