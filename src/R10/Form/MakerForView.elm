module R10.Form.MakerForView exposing
    ( MakerArgs
    , Outcome
    , extraCss
    , maker
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import R10.Form.Conf
import R10.Form.Converter exposing (fromFormValidationIconToComponentValidationIcon)
import R10.Form.Dict
import R10.Form.FieldConf exposing (ValidationIcon(..))
import R10.Form.FieldState
import R10.Form.Helpers
import R10.Form.Key
import R10.Form.Msg
import R10.Form.State
import R10.FormComponents.Binary
import R10.FormComponents.ExtraCss
import R10.FormComponents.Single
import R10.FormComponents.Style
import R10.FormComponents.Text
import R10.FormComponents.UI
import R10.FormComponents.UI.Color
import R10.FormComponents.UI.Palette
import R10.FormComponents.Validations



--  ██████  ██    ██ ████████  ██████  ██████  ███    ███ ███████
-- ██    ██ ██    ██    ██    ██      ██    ██ ████  ████ ██
-- ██    ██ ██    ██    ██    ██      ██    ██ ██ ████ ██ █████
-- ██    ██ ██    ██    ██    ██      ██    ██ ██  ██  ██ ██
--  ██████   ██████     ██     ██████  ██████  ██      ██ ███████


type alias Outcome =
    Element R10.Form.Msg.Msg



-- ██   ██ ███████ ██      ██████  ███████ ██████  ███████
-- ██   ██ ██      ██      ██   ██ ██      ██   ██ ██
-- ███████ █████   ██      ██████  █████   ██████  ███████
-- ██   ██ ██      ██      ██      ██      ██   ██      ██
-- ██   ██ ███████ ███████ ██      ███████ ██   ██ ███████


type alias ArgsForFields =
    { fieldConf : R10.Form.FieldConf.FieldConf
    , fieldState : R10.Form.FieldState.FieldState
    , focused : Bool
    , active : Bool
    , key : R10.Form.Key.Key
    , translator : R10.Form.FieldConf.ValidationCode -> String
    , style : R10.FormComponents.Style.Style
    , palette : R10.FormComponents.UI.Palette.Palette
    }


paddingGeneric : Attribute msg
paddingGeneric =
    paddingXY 20 25


spacingGeneric : Attribute msg
spacingGeneric =
    spacingXY 15 25


extraCss : Maybe R10.FormComponents.UI.Palette.Palette -> String
extraCss maybePalette =
    let
        palette : R10.FormComponents.UI.Palette.Palette
        palette =
            Maybe.withDefault R10.FormComponents.UI.Palette.light maybePalette
    in
    R10.FormComponents.ExtraCss.extraCss palette


isFocused : R10.Form.Key.Key -> Maybe String -> Bool
isFocused key focused =
    case focused of
        Just focused_x ->
            focused_x == R10.Form.Key.toString key

        Nothing ->
            False


isActive : R10.Form.Key.Key -> Maybe String -> Bool
isActive key active =
    case active of
        Just active_x ->
            active_x == R10.Form.Key.toString key

        Nothing ->
            False


tabAttrs : R10.FormComponents.UI.Palette.Palette -> List (Attr () msg)
tabAttrs palette =
    [ Font.color <| R10.FormComponents.UI.Color.onSurface palette
    , Border.widthEach { bottom = 0, left = 1, right = 1, top = 1 }
    , Border.color <| R10.FormComponents.UI.Color.container palette
    , Border.roundEach { topLeft = 10, topRight = 10, bottomLeft = 0, bottomRight = 0 }
    , paddingXY 20 6
    ]


getEntityKey : MakerArgs -> R10.Form.Conf.Entity -> R10.Form.Key.Key
getEntityKey args entity =
    let
        id : String
        id =
            case entity of
                R10.Form.Conf.EntityWrappable entityId _ ->
                    entityId

                R10.Form.Conf.EntityWithBorder entityId _ ->
                    entityId

                R10.Form.Conf.EntityNormal entityId _ ->
                    entityId

                R10.Form.Conf.EntityWithTabs entityId _ ->
                    entityId

                R10.Form.Conf.EntityMulti entityId _ ->
                    entityId

                R10.Form.Conf.EntityField fieldConf ->
                    fieldConf.id

                R10.Form.Conf.EntityTitle entityId _ ->
                    entityId

                R10.Form.Conf.EntitySubTitle entityId _ ->
                    entityId
    in
    R10.Form.Key.composeKey args.key id


getFieldConfig : R10.Form.Conf.Entity -> R10.Form.FieldConf.FieldConf
getFieldConfig entity =
    case entity of
        R10.Form.Conf.EntityField fieldConf ->
            fieldConf

        _ ->
            R10.Form.FieldConf.init



-- ██ ███    ██ ██████  ██    ██ ████████     ████████ ███████ ██   ██ ████████
-- ██ ████   ██ ██   ██ ██    ██    ██           ██    ██       ██ ██     ██
-- ██ ██ ██  ██ ██████  ██    ██    ██           ██    █████     ███      ██
-- ██ ██  ██ ██ ██      ██    ██    ██           ██    ██       ██ ██     ██
-- ██ ██   ████ ██       ██████     ██           ██    ███████ ██   ██    ██


viewText :
    ArgsForFields
    -> R10.Form.FieldConf.TypeText
    -> R10.Form.Conf.Conf
    -> Element R10.Form.Msg.Msg
viewText args textType formConf =
    R10.FormComponents.Text.view
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
            R10.Form.Converter.fromFieldStateValidationToComponentValidation
                args.fieldConf.validationSpecs
                args.fieldState.validation
                args.translator
        , showPassword = args.fieldState.showPassword
        , leadingIcon = Nothing
        , trailingIcon = Nothing

        -- Messages
        , msgOnChange = R10.Form.Msg.ChangeValue args.key args.fieldConf formConf
        , msgOnFocus = R10.Form.Msg.GetFocus args.key
        , msgOnLoseFocus = Just <| R10.Form.Msg.LoseFocus args.key args.fieldConf
        , msgOnTogglePasswordShow = Just <| R10.Form.Msg.TogglePasswordShow args.key
        , msgOnEnter = Just <| R10.Form.Msg.Submit formConf

        -- Stuff that doesn't change
        , label = args.fieldConf.label
        , helperText = args.fieldConf.helperText
        , disabled = args.fieldState.disabled
        , idDom = args.fieldConf.idDom
        , style = args.style
        , requiredLabel = args.fieldConf.requiredLabel
        , palette = args.palette

        -- Specific
        , textType = R10.Form.Converter.textTypeFromFieldConfToComponent textType
        }



--  ██████ ██   ██ ███████  ██████ ██   ██ ██████   ██████  ██   ██
-- ██      ██   ██ ██      ██      ██  ██  ██   ██ ██    ██  ██ ██
-- ██      ███████ █████   ██      █████   ██████  ██    ██   ███
-- ██      ██   ██ ██      ██      ██  ██  ██   ██ ██    ██  ██ ██
--  ██████ ██   ██ ███████  ██████ ██   ██ ██████   ██████  ██   ██


viewBinary :
    ArgsForFields
    -> R10.Form.FieldConf.TypeBinary
    -> R10.Form.Conf.Conf
    -> Element R10.Form.Msg.Msg
viewBinary args typeBinary formConf =
    let
        value : Bool
        value =
            R10.Form.Helpers.stringToBool args.fieldState.value

        msgOnClick : R10.Form.Msg.Msg
        msgOnClick =
            R10.Form.Msg.ChangeValue args.key args.fieldConf formConf (R10.Form.Helpers.boolToString <| not value)
    in
    R10.FormComponents.Binary.view
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
            R10.Form.Converter.fromFieldStateValidationToComponentValidation
                args.fieldConf.validationSpecs
                args.fieldState.validation
                args.translator

        -- Messages
        , msgOnChange = \_ -> msgOnClick
        , msgOnFocus = R10.Form.Msg.GetFocus args.key
        , msgOnLoseFocus = R10.Form.Msg.LoseFocus args.key args.fieldConf
        , msgOnClick = msgOnClick

        -- Stuff that doesn't change
        , label = args.fieldConf.label
        , disabled = args.fieldState.disabled
        , helperText = args.fieldConf.helperText
        , palette = args.palette

        -- Specific stuff
        , typeBinary = R10.Form.Converter.binaryTypeFromFieldConfToComponent typeBinary
        }



-- ██████   █████  ██████  ██  ██████
-- ██   ██ ██   ██ ██   ██ ██ ██    ██
-- ██████  ███████ ██   ██ ██ ██    ██
-- ██   ██ ██   ██ ██   ██ ██ ██    ██
-- ██   ██ ██   ██ ██████  ██  ██████


viewSingleSelection :
    ArgsForFields
    -> R10.Form.FieldConf.TypeSingle
    -> List R10.Form.FieldConf.FieldOption
    -> R10.Form.Conf.Conf
    -> Element.Element R10.Form.Msg.Msg
viewSingleSelection args singleType fieldOptions formConf =
    R10.FormComponents.Single.view
        [ width
            (fill
                |> minimum 300
                |> maximum 900
            )
        ]
        -- Stuff that change
        { value = args.fieldState.value
        , search = args.fieldState.search
        , scroll = args.fieldState.scroll
        , focused = args.focused
        , opened = args.active
        }
        { validation =
            R10.Form.Converter.fromFieldStateValidationToComponentValidation
                args.fieldConf.validationSpecs
                args.fieldState.validation
                args.translator

        -- Message mapper
        , toMsg = R10.Form.Msg.OnSingleMsg args.key args.fieldConf formConf

        -- Stuff that doesn't change
        , label = args.fieldConf.label
        , helperText = args.fieldConf.helperText
        , disabled = args.fieldState.disabled
        , requiredLabel = args.fieldConf.requiredLabel
        , style = args.style
        , key = R10.Form.Key.toString args.key
        , palette = args.palette

        -- Specific
        , singleType = R10.Form.Converter.singleTypeFromFieldConfToComponent singleType
        , fieldOptions = fieldOptions
        }



-- ██    ██ ██ ███████ ██     ██     ███████ ███    ██ ████████ ██ ████████ ██ ███████ ███████
-- ██    ██ ██ ██      ██     ██     ██      ████   ██    ██    ██    ██    ██ ██      ██
-- ██    ██ ██ █████   ██  █  ██     █████   ██ ██  ██    ██    ██    ██    ██ █████   ███████
--  ██  ██  ██ ██      ██ ███ ██     ██      ██  ██ ██    ██    ██    ██    ██ ██           ██
--   ████   ██ ███████  ███ ███      ███████ ██   ████    ██    ██    ██    ██ ███████ ███████


viewEntityNormal :
    MakerArgs
    -> List R10.Form.Conf.Entity
    -> List Outcome
viewEntityNormal args entities =
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
            maker args entities
    ]


viewEntityWrappable :
    MakerArgs
    -> List R10.Form.Conf.Entity
    -> List Outcome
viewEntityWrappable args entities =
    [ wrappedRow
        [ alignTop
        , width fill
        , height fill
        , spacingGeneric
        ]
      <|
        maker args entities
    ]


viewEntityWithBorder :
    MakerArgs
    -> List R10.Form.Conf.Entity
    -> List Outcome
viewEntityWithBorder args entities =
    [ el
        ([ alignTop
         , width fill
         , height fill
         ]
            ++ R10.FormComponents.UI.borderEntityWithBorder args.palette
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
            maker args entities
    ]


viewEntityWithTabs :
    MakerArgs
    -> List R10.Form.Conf.Entity
    -> List Outcome
viewEntityWithTabs args entities =
    let
        firstEntity : Maybe R10.Form.Conf.Entity
        firstEntity =
            List.head entities

        selectedEntity : Maybe R10.Form.Conf.Entity
        selectedEntity =
            case R10.Form.Dict.get args.key args.formState.activeTabs of
                Just key_ ->
                    case List.head <| R10.Form.Conf.filter key_ entities of
                        Just entity_ ->
                            Just entity_

                        Nothing ->
                            firstEntity

                Nothing ->
                    firstEntity
    in
    case selectedEntity of
        Just outerEntity ->
            [ row
                [ spacing 3
                , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
                , Border.color <| R10.FormComponents.UI.Color.container args.palette
                , width fill
                ]
              <|
                List.map
                    (\innerEntity ->
                        Input.button
                            (tabAttrs args.palette
                                ++ (if R10.Form.Conf.getId outerEntity == R10.Form.Conf.getId innerEntity then
                                        [ Background.color <| R10.FormComponents.UI.Color.surface args.palette
                                        , Font.color <| R10.FormComponents.UI.Color.label args.palette
                                        , moveDown 1
                                        ]

                                    else
                                        [ Background.color <| rgba 0 0 0 0.3
                                        , Font.color <| R10.FormComponents.UI.Color.surface args.palette
                                        ]
                                   )
                            )
                            { label = text (R10.Form.Conf.getId innerEntity)
                            , onPress = Just <| R10.Form.Msg.ChangeTab args.key (R10.Form.Conf.getId innerEntity)
                            }
                    )
                    entities
            ]
                ++ maker
                    { args | key = R10.Form.Key.composeKey args.key (R10.Form.Conf.getId outerEntity) }
                    [ outerEntity ]

        Nothing ->
            []


viewEntityMultiHelper :
    MakerArgs
    -> Int
    -> Int
    -> R10.Form.Key.Key
    -> List R10.Form.Conf.Entity
    -> List (Element R10.Form.Msg.Msg)
viewEntityMultiHelper args quantity index newKey entities =
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
                , color = R10.FormComponents.UI.Color.labelA a args.palette
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
            , Border.color <| R10.FormComponents.UI.Color.containerA 0.5 args.palette
            , mouseOver <| [ Border.color <| R10.FormComponents.UI.Color.containerA 1 args.palette ]
            , focused <| [ alpha 1, shadow 1 1, Border.color <| R10.FormComponents.UI.Color.containerA 1 args.palette ]
            ]

        plusColor : Color
        plusColor =
            R10.FormComponents.UI.Color.label args.palette

        removeColor : Color
        removeColor =
            R10.FormComponents.UI.Color.label args.palette

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

        buttonToAddEntity : Element R10.Form.Msg.Msg
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
                , onPress = Just <| R10.Form.Msg.AddEntity args.key
                }

        buttonToRemoveEntity : R10.Form.Key.Key -> Element R10.Form.Msg.Msg
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
                , onPress = Just <| R10.Form.Msg.RemoveEntity key_
                }
    in
    [ row [ spacing 10, width fill ]
        [ if quantity - 1 == index then
            buttonToAddEntity

          else
            buttonToRemoveEntity newKey
        , column [ width fill, spacingGeneric ] <| maker { args | key = newKey } entities
        ]
    ]


viewEntityMulti :
    MakerArgs
    -> List R10.Form.Conf.Entity
    -> List Outcome
viewEntityMulti args entities =
    let
        activeKeys : List R10.Form.Key.Key
        activeKeys =
            R10.Form.Helpers.getMultiActiveKeys args.key args.formState

        quantity : Int
        quantity =
            List.length activeKeys
    in
    activeKeys
        |> List.indexedMap
            (\index newKey ->
                viewEntityMultiHelper args quantity index newKey entities
            )
        |> List.concat
        |> column [ spacing 10, width fill ]
        |> List.singleton


viewEntityField :
    MakerArgs
    -> R10.Form.FieldConf.FieldConf
    -> R10.Form.Conf.Conf
    -> List Outcome
viewEntityField args fieldConf formConf =
    let
        newKey : R10.Form.Key.Key
        newKey =
            R10.Form.Key.composeKey args.key fieldConf.id

        fieldState : R10.Form.FieldState.FieldState
        fieldState =
            Maybe.withDefault R10.Form.FieldState.init <|
                R10.Form.Dict.get newKey args.formState.fieldsState

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

        field : Element R10.Form.Msg.Msg
        field =
            case fieldConf.type_ of
                R10.Form.FieldConf.TypeText typeText ->
                    viewText args2 typeText formConf

                R10.Form.FieldConf.TypeBinary typeBinary ->
                    viewBinary args2 typeBinary formConf

                R10.Form.FieldConf.TypeSingle typeSingle options ->
                    viewSingleSelection args2 typeSingle options formConf

                R10.Form.FieldConf.TypeMulti _ _ ->
                    text "TODO"
    in
    [ field ]


viewEntityTitle :
    R10.FormComponents.UI.Palette.Palette
    -> R10.Form.Conf.TextConf
    -> List Outcome
viewEntityTitle palette titleConf =
    [ column
        [ spacing 12
        , paddingEach { top = 40, right = 0, bottom = 0, left = 0 }
        , width fill
        ]
        [ paragraph [ R10.FormComponents.UI.fontSizeTitle ] [ text titleConf.title ]
        , R10.FormComponents.UI.viewHelperText palette [] titleConf.helperText
        ]
    ]


viewEntitySubTitle :
    R10.FormComponents.UI.Palette.Palette
    -> R10.Form.Conf.TextConf
    -> List Outcome
viewEntitySubTitle palette titleConf =
    [ column
        [ spacing R10.FormComponents.UI.genericSpacing
        , width fill
        ]
        [ paragraph [ R10.FormComponents.UI.fontSizeSubTitle ] [ text titleConf.title ]
        , R10.FormComponents.UI.viewHelperText palette [ alpha 0.5, Font.size 14, paddingEach { top = R10.FormComponents.UI.genericSpacing, right = 0, bottom = 0, left = 0 } ] titleConf.helperText
        ]
    ]


viewWithValidationMessage : MakerArgs -> R10.Form.Conf.Entity -> List (Element msg) -> List (Element msg)
viewWithValidationMessage args entity listEl =
    let
        validationIcon : R10.FormComponents.Validations.ValidationIcon
        validationIcon =
            getFieldConfig entity
                |> .validationSpecs
                |> Maybe.map .validationIcon
                |> Maybe.withDefault NoIcon
                |> fromFormValidationIconToComponentValidationIcon
    in
    [ column [ width fill, height fill ] <|
        listEl
            ++ [ R10.FormComponents.Validations.viewValidation args.palette validationIcon <|
                    R10.Form.Converter.fromFieldStateValidationToComponentValidation
                        (getFieldConfig entity |> .validationSpecs)
                        (R10.Form.Dict.get (getEntityKey args entity) args.formState.fieldsState
                            |> Maybe.withDefault R10.Form.FieldState.init
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
    { key : R10.Form.Key.Key
    , formState : R10.Form.State.State
    , translator : R10.Form.FieldConf.ValidationCode -> String
    , style : R10.FormComponents.Style.Style
    , palette : R10.FormComponents.UI.Palette.Palette
    }


maker :
    MakerArgs
    -> R10.Form.Conf.Conf
    -> List Outcome
maker args formConf =
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
                R10.Form.Conf.EntityWrappable _ entities ->
                    viewEntityWrappable args entities

                R10.Form.Conf.EntityWithBorder _ entities ->
                    viewEntityWithBorder args entities

                R10.Form.Conf.EntityNormal _ entities ->
                    viewEntityNormal args entities

                R10.Form.Conf.EntityWithTabs _ entities ->
                    viewEntityWithTabs args entities

                R10.Form.Conf.EntityMulti entityId entities ->
                    viewEntityMulti { args | key = R10.Form.Key.composeKey args.key entityId } entities

                R10.Form.Conf.EntityField fieldConf ->
                    viewEntityField args fieldConf formConf

                R10.Form.Conf.EntityTitle _ titleConf ->
                    viewEntityTitle args.palette titleConf

                R10.Form.Conf.EntitySubTitle _ titleConf ->
                    viewEntitySubTitle args.palette titleConf
            )
                |> viewWithValidationMessage args entity
        )
        formConf
        |> List.concat
