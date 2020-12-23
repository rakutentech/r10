module R10.FormComponents.Internal.Single.Combobox exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Keyed as Keyed
import Html.Attributes
import Html.Events
import List.Extra
import R10.FormComponents.Internal.Single.Common as Common
import R10.FormComponents.Internal.Single.Update as Update
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.Text
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.Utils
import R10.FormComponents.Internal.Utils.FocusOut
import R10.FormTypes


viewSearchBox : Common.Model -> Common.Args msg -> Element msg
viewSearchBox model args =
    R10.FormComponents.Internal.Text.viewInput
        [ htmlAttribute <| Html.Attributes.id <| Common.singleSearchBoxId args.key
        , Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
        , Border.rounded 0
        ]
        { disabled = args.disabled
        , focused = model.focused
        , label = args.label
        , msgOnChange = args.toMsg << Update.getMsgOnSearch args
        , msgOnFocus = args.toMsg <| Common.OnFocus model.value
        , msgOnLoseFocus = Nothing
        , msgOnEnter = Nothing
        , msgOnTogglePasswordShow = Nothing
        , palette = args.palette
        , style = args.style
        , showPassword = False
        , textType = R10.FormTypes.TextPlain
        , leadingIcon = Nothing
        , trailingIcon = Nothing
        , value = model.search
        , valid = args.valid
        , helperText = args.helperText
        , requiredLabel = args.requiredLabel
        }


{-| returns value to be displayed in combobox input component
also returns flag is displayed value is actual value or just intermediate
-}
optionsLabelOrSearchValue :
    String
    -> List Common.FieldOption
    -> String
optionsLabelOrSearchValue value filteredFieldOption =
    filteredFieldOption
        |> List.Extra.find (\opt -> opt.value == value)
        |> Maybe.map .label
        |> Maybe.withDefault ""


getMsgOnInputClick : Common.Model -> Common.Args msg -> List Common.FieldOption -> Common.Msg
getMsgOnInputClick model args filteredOptions =
    let
        selectedOptionIndex : Int
        selectedOptionIndex =
            Update.getOptionIndex filteredOptions model.value
                |> Maybe.withDefault -1

        selectedY : Float
        selectedY =
            Update.getOptionY model.scroll args selectedOptionIndex (List.length filteredOptions)
    in
    Common.OnInputClick { key = args.key, selectedY = selectedY }


viewComboboxDropdown : Common.Model -> Common.Args msg -> List Common.FieldOption -> Element msg
viewComboboxDropdown model args filteredOptions =
    let
        elementsScrolledFromTop : Int
        elementsScrolledFromTop =
            round model.scroll // args.selectOptionHeight

        --  dynamic viewport
        visibleCount : Int
        visibleCount =
            args.maxDisplayCount + 2

        visibleFrom : Int
        visibleFrom =
            elementsScrolledFromTop - 1

        visibleTo : Int
        visibleTo =
            visibleFrom + visibleCount

        visibleMoveDown : Float
        visibleMoveDown =
            toFloat (Update.dropdownHingeHeight + max 0 visibleFrom * args.selectOptionHeight)

        visibleOptions : List ( String, Element msg )
        visibleOptions =
            if List.length filteredOptions > 0 then
                filteredOptions
                    |> R10.FormComponents.Internal.Utils.listSlice visibleFrom visibleTo
                    |> List.map (\opt -> ( opt.value, viewComboboxOption model.value model.select args opt ))

            else
                [ ( "no_results", comboboxOptionNoResults args ) ]

        optionsCount : Int
        optionsCount =
            List.length filteredOptions

        contentHeight : Int
        contentHeight =
            args.selectOptionHeight * max optionsCount 1
    in
    column
        [ width fill
        , moveDown 52
        , Background.color <| R10.FormComponents.Internal.UI.Color.surface args.palette
        , htmlAttribute <| Html.Attributes.style "z-index" "1"
        , Border.rounded
            (case args.style of
                R10.FormComponents.Internal.Style.Filled ->
                    0

                R10.FormComponents.Internal.Style.Outlined ->
                    8
            )
        , Border.shadow
            { color = R10.FormComponents.Internal.UI.Color.onSurfaceA 0.1 args.palette
            , offset = ( 0, 0 )
            , blur = 3
            , size = 1
            }
        ]
        [ el
            [ height <| px 52
            , width fill
            ]
          <|
            viewSearchBox model args
        , el
            [ width fill
            , height <| px <| Update.getDropdownHeight args optionsCount
            , htmlAttribute <| Html.Attributes.style "overscroll-behavior" "contain"
            , htmlAttribute <| R10.FormComponents.Internal.UI.onScroll <| (args.toMsg << Common.OnScroll)
            , htmlAttribute <| Html.Attributes.id <| Common.dropdownContentId <| args.key
            , Font.color <| R10.FormComponents.Internal.UI.Color.font args.palette
            , Background.color <| R10.FormComponents.Internal.UI.Color.surface args.palette
            , paddingXY 0 Update.dropdownHingeHeight
            , scrollbarX
            , inFront <| Keyed.column [ width <| fill, moveDown visibleMoveDown ] visibleOptions
            ]
          <|
            el [ height <| px contentHeight, width fill ] none
        ]


comboboxOptionNoResults : { a | palette : R10.FormTypes.Palette, selectOptionHeight : Int } -> Element msg
comboboxOptionNoResults { palette, selectOptionHeight } =
    el
        [ width fill
        , height <| px selectOptionHeight
        , paddingEach { top = 0, right = 0, bottom = 0, left = 12 }
        , Font.color <| R10.FormComponents.Internal.UI.Color.onSurfaceA 0.5 palette
        ]
    <|
        el [ centerY ] <|
            text "No results"


viewComboboxOption : String -> String -> Common.Args msg -> Common.FieldOption -> Element msg
viewComboboxOption value select args opt =
    let
        isActiveValue : Bool
        isActiveValue =
            value == opt.value

        isSelected_ : Bool
        isSelected_ =
            select == opt.value

        getBackgroundColor : Color
        getBackgroundColor =
            if isActiveValue && isSelected_ then
                R10.FormComponents.Internal.UI.Color.primaryVariantA 0.13 args.palette

            else if isActiveValue then
                R10.FormComponents.Internal.UI.Color.primaryVariantA 0.07 args.palette

            else if isSelected_ then
                R10.FormComponents.Internal.UI.Color.onSurfaceA 0.07 args.palette

            else
                R10.FormComponents.Internal.UI.Color.onSurfaceA 0 args.palette

        getShadowColor : Color
        getShadowColor =
            if isActiveValue then
                R10.FormComponents.Internal.UI.Color.primaryVariantA 0.1 args.palette

            else
                R10.FormComponents.Internal.UI.Color.onSurfaceA 0.05 args.palette
    in
    el
        [ width fill
        , height <| px args.selectOptionHeight
        , Background.color <| getBackgroundColor
        , mouseOver
            [ Border.innerShadow { offset = ( 0, 0 ), size = 40, blur = 0, color = getShadowColor } ]
        ]
    <|
        args.toOptionEl opt


view : List (Attribute msg) -> Common.Model -> Common.Args msg -> Element msg
view attrs model args =
    let
        filteredFieldOption : List Common.FieldOption
        filteredFieldOption =
            Common.filterBySearch model.search args

        displayValue =
            optionsLabelOrSearchValue model.value filteredFieldOption

        textArgs : R10.FormComponents.Internal.Text.Args msg
        textArgs =
            { disabled = args.disabled
            , valid = args.valid
            , focused = model.focused
            , label = args.label
            , msgOnChange = args.toMsg << always Common.NoOp
            , msgOnFocus = args.toMsg <| Common.OnFocus model.value
            , msgOnLoseFocus = Nothing
            , msgOnEnter = Nothing
            , msgOnTogglePasswordShow = Nothing
            , palette = args.palette
            , style = args.style
            , showPassword = False
            , textType = R10.FormTypes.TextPlain
            , leadingIcon = args.leadingIcon
            , trailingIcon = args.trailingIcon
            , value = displayValue
            , helperText = args.helperText
            , requiredLabel = args.requiredLabel
            , idDom = Nothing
            }

        inputAttrs : List (Attribute msg)
        inputAttrs =
            [ Events.onClick <| args.toMsg <| getMsgOnInputClick model args filteredFieldOption
            , htmlAttribute <| Html.Attributes.attribute "readonly" "true"
            ]
    in
    R10.FormComponents.Internal.Text.view
        ([ htmlAttribute <| Html.Attributes.id <| Common.dropdownContainerId <| args.key
         , htmlAttribute <|
            Html.Events.on "focusout"
                (R10.FormComponents.Internal.Utils.FocusOut.onFocusOut (Common.dropdownContainerId args.key) <|
                    args.toMsg <|
                        Common.OnLoseFocus model.value
                )
         , htmlAttribute <|
            R10.FormComponents.Internal.UI.onKeyPressBatch <|
                [ ( R10.FormComponents.Internal.UI.keyCode.down
                  , Common.OnArrowDown
                        { key = args.key
                        , selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , filteredFieldOption = filteredFieldOption
                        }
                        |> args.toMsg
                  )
                , ( R10.FormComponents.Internal.UI.keyCode.up
                  , Common.OnArrowUp
                        { key = args.key
                        , selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , filteredFieldOption = filteredFieldOption
                        }
                        |> args.toMsg
                  )
                ]
                    ++ (if model.opened then
                            [ ( R10.FormComponents.Internal.UI.keyCode.esc
                              , args.toMsg Common.OnEsc
                              )
                            , ( R10.FormComponents.Internal.UI.keyCode.enter
                              , args.toMsg <|
                                    Common.OnOptionSelect <|
                                        Common.getSelectedOrFirst filteredFieldOption model.value model.select
                              )
                            ]

                        else
                            []
                       )
         ]
            ++ (if model.opened then
                    [ inFront <| viewComboboxDropdown model args filteredFieldOption ]

                else
                    []
               )
        )
        (inputAttrs ++ attrs)
        textArgs
