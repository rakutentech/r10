module R10.FormComponents.Internal.Single.Combobox exposing (view)

import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Events as Events
import Element.WithContext.Font as Font
import Element.WithContext.Input as Input
import Element.WithContext.Keyed as Keyed
import Html.Attributes
import Html.Events
import List.Extra
import R10.Color.Svg
import R10.Context exposing (..)
import R10.FormComponents.Internal.Single.Common
import R10.FormComponents.Internal.Single.Update
import R10.FormComponents.Internal.Text
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.Utils
import R10.FormComponents.Internal.Utils.FocusOut
import R10.FormTypes
import R10.Palette
import R10.Svg.Icons


viewSearchBox :
    R10.FormComponents.Internal.Single.Common.Model
    -> R10.FormComponents.Internal.Single.Common.Args z msg
    -> Element (R10.Context.ContextInternal z) msg
viewSearchBox model args =
    --
    -- This function is similar to R10.FormComponents.Internal.Phone.Combobox.viewSearchBox
    --
    if args.searchable then
        row
            [ Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
            , Border.color <| R10.FormComponents.Internal.UI.Color.borderA 0.3 args.palette
            , paddingXY 17 0
            , width fill
            ]
            [ withContext <|
                \c ->
                    Input.text
                        [ htmlAttribute <| Html.Attributes.id <| R10.FormComponents.Internal.Single.Common.singleSearchBoxId args.key
                        , Background.color <| R10.FormComponents.Internal.UI.Color.surface args.palette
                        , paddingEach { top = 16, bottom = 16, left = 10, right = 16 }
                        , Border.width 0
                        ]
                        { onChange = \string -> args.toMsg (R10.FormComponents.Internal.Single.Update.getMsgOnSearch args string)
                        , text = model.search
                        , placeholder = Nothing
                        , label = Input.labelLeft [ moveDown 3 ] <| R10.Svg.Icons.search [] (R10.Color.Svg.fontHighEmphasis c.contextR10.theme) 18
                        }
            ]

    else
        none


{-| returns value to be displayed in combobox input component
also returns flag is displayed value is actual value or just intermediate
-}
optionsLabelOrSearchValue :
    String
    -> List R10.FormComponents.Internal.Single.Common.FieldOption
    -> String
optionsLabelOrSearchValue value allFieldOptions =
    allFieldOptions
        |> List.Extra.find (\opt -> opt.value == value)
        |> Maybe.map .label
        |> Maybe.withDefault ""


getMsgOnInputClick : R10.FormComponents.Internal.Single.Common.Model -> R10.FormComponents.Internal.Single.Common.Args z msg -> List R10.FormComponents.Internal.Single.Common.FieldOption -> R10.FormComponents.Internal.Single.Common.Msg
getMsgOnInputClick model args filteredOptions =
    let
        selectedOptionIndex : Int
        selectedOptionIndex =
            R10.FormComponents.Internal.Single.Update.getOptionIndex filteredOptions model.value
                |> Maybe.withDefault -1

        selectedY : Float
        selectedY =
            R10.FormComponents.Internal.Single.Update.getOptionY model.scroll args selectedOptionIndex (List.length filteredOptions)
    in
    R10.FormComponents.Internal.Single.Common.OnInputClick { key = args.key, selectedY = selectedY }


viewComboboxDropdown : R10.FormComponents.Internal.Single.Common.Model -> R10.FormComponents.Internal.Single.Common.Args z msg -> Bool -> List R10.FormComponents.Internal.Single.Common.FieldOption -> Element (R10.Context.ContextInternal z) msg
viewComboboxDropdown model args opened filteredOptions =
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
            toFloat (R10.FormComponents.Internal.Single.Update.dropdownHingeHeight + max 0 visibleFrom * args.selectOptionHeight)

        visibleOptions : List ( String, Element (R10.Context.ContextInternal z) msg )
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
    if not opened then
        none

    else
        column
            [ width fill
            , clip
            , moveDown 60
            , htmlAttribute <| Html.Attributes.tabindex -1
            , Background.color <| R10.FormComponents.Internal.UI.Color.surface args.palette
            , Border.color <| R10.FormComponents.Internal.UI.Color.borderA 0.5 args.palette
            , Border.width 1
            , htmlAttribute <| Html.Attributes.style "z-index" "1"
            , Border.rounded 8
            , Border.shadow
                { color = R10.FormComponents.Internal.UI.Color.onSurfaceA 0.3 args.palette
                , offset = ( 0, 0 )
                , blur = 10
                , size = 3
                }
            ]
            [ viewSearchBox model args
            , el
                [ width fill
                , height <| px <| R10.FormComponents.Internal.Single.Update.getDropdownHeight args optionsCount

                -- Fixed the content box displayed height is fit to content bug in Safari
                --
                , htmlAttribute <| Html.Attributes.style "min-height" "unset"
                , htmlAttribute <| Html.Attributes.style "overscroll-behavior" "contain"
                , htmlAttribute <| R10.FormComponents.Internal.UI.onScroll <| (args.toMsg << R10.FormComponents.Internal.Single.Common.OnScroll)
                , Font.color <| R10.FormComponents.Internal.UI.Color.font args.palette
                , Background.color <| R10.FormComponents.Internal.UI.Color.surface args.palette
                , htmlAttribute <| Html.Attributes.id <| R10.FormComponents.Internal.Single.Common.dropdownContentId <| args.key
                , scrollbarX
                , inFront <| Keyed.column [ width <| fill, moveDown visibleMoveDown ] visibleOptions
                ]
              <|
                el [ height <| px contentHeight, width fill ] none
            ]


comboboxOptionNoResults : { a | palette : R10.Palette.Palette, selectOptionHeight : Int } -> Element (R10.Context.ContextInternal z) msg
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


viewComboboxOption : String -> String -> R10.FormComponents.Internal.Single.Common.Args z msg -> R10.FormComponents.Internal.Single.Common.FieldOption -> Element (R10.Context.ContextInternal z) msg
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
                R10.FormComponents.Internal.UI.Color.primaryVariantA 0.15 args.palette

            else if isActiveValue then
                R10.FormComponents.Internal.UI.Color.primaryVariantA 0.09 args.palette

            else if isSelected_ then
                R10.FormComponents.Internal.UI.Color.onSurfaceA 0.09 args.palette

            else
                R10.FormComponents.Internal.UI.Color.onSurfaceA 0 args.palette

        getShadowColor : Color
        getShadowColor =
            if isActiveValue then
                R10.FormComponents.Internal.UI.Color.primaryVariantA 0.1 args.palette

            else
                R10.FormComponents.Internal.UI.Color.onSurfaceA 0.1 args.palette
    in
    el
        [ width fill
        , height <| px args.selectOptionHeight
        , Background.color <| getBackgroundColor
        , mouseOver
            [ Border.innerShadow { offset = ( 0, 0 ), size = 40, blur = 0, color = getShadowColor } ]
        ]
    <|
        args.viewOptionEl opt


view :
    List (Attribute (R10.Context.ContextInternal z) msg)
    -> R10.FormComponents.Internal.Single.Common.Model
    -> R10.FormComponents.Internal.Single.Common.Args z msg
    -> Element (R10.Context.ContextInternal z) msg
view attrs model args =
    let
        filteredFieldOption : List R10.FormComponents.Internal.Single.Common.FieldOption
        filteredFieldOption =
            R10.FormComponents.Internal.Single.Common.filterBySearch model.search args

        displayValue : String
        displayValue =
            optionsLabelOrSearchValue model.value args.fieldOptions

        focusOnSearchBox : Bool
        focusOnSearchBox =
            model.opened && args.searchable

        textArgs : R10.FormComponents.Internal.Text.Args z msg
        textArgs =
            { disabled = args.disabled
            , maybeValid = args.maybeValid
            , focused = model.focused
            , label = args.label
            , msgOnChange = args.toMsg << always R10.FormComponents.Internal.Single.Common.NoOp
            , msgOnFocus = args.toMsg <| R10.FormComponents.Internal.Single.Common.OnFocus
            , msgOnLoseFocus = Nothing
            , msgOnEnter = Nothing
            , msgOnKeyDown = Nothing
            , msgOnTogglePasswordShow = Nothing
            , palette = args.palette
            , style = args.style
            , showPassword = False
            , textType = R10.FormTypes.TextPlain
            , fieldType = Nothing
            , leadingIcon = args.leadingIcon
            , trailingIcon = args.trailingIcon
            , value = displayValue
            , helperText = args.helperText
            , requiredLabel = args.requiredLabel
            , idDom = Nothing
            , autocomplete = Nothing
            , floatingLabelAlwaysUp = False
            , placeholder = Nothing
            }

        inputAttrs : List (Attribute (R10.Context.ContextInternal z) msg)
        inputAttrs =
            [ Events.onClick <| args.toMsg <| getMsgOnInputClick model args filteredFieldOption
            , htmlAttribute <| Html.Attributes.attribute "readonly" "true"
            ]
    in
    R10.FormComponents.Internal.Text.view
        [ htmlAttribute <| Html.Attributes.id <| R10.FormComponents.Internal.Single.Common.dropdownContainerId <| args.key
        , htmlAttribute <| Html.Attributes.tabindex -1
        , htmlAttribute <|
            Html.Events.on "focusout"
                (R10.FormComponents.Internal.Utils.FocusOut.onFocusOut (R10.FormComponents.Internal.Single.Common.dropdownContainerId args.key) <|
                    args.toMsg <|
                        R10.FormComponents.Internal.Single.Common.OnLoseFocus model.value
                )
        , htmlAttribute <|
            R10.FormComponents.Internal.UI.onKeyPressBatch <|
                [ ( R10.FormComponents.Internal.UI.keyCode.down
                  , R10.FormComponents.Internal.Single.Common.OnArrowDown
                        { key = args.key
                        , selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , filteredFieldOption = filteredFieldOption
                        }
                        |> args.toMsg
                  )
                , ( R10.FormComponents.Internal.UI.keyCode.up
                  , R10.FormComponents.Internal.Single.Common.OnArrowUp
                        { key = args.key
                        , selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , filteredFieldOption = filteredFieldOption
                        }
                        |> args.toMsg
                  )
                ]
                    ++ (if not focusOnSearchBox then
                            -- we need to avoid Del and Backspace listening when user focused on search box
                            -- since otherwise it would default behavior of removing char from input
                            [ ( R10.FormComponents.Internal.UI.keyCode.del
                              , R10.FormComponents.Internal.Single.Common.OnDelBackspace
                                    |> args.toMsg
                              )
                            , ( R10.FormComponents.Internal.UI.keyCode.backspace
                              , R10.FormComponents.Internal.Single.Common.OnDelBackspace
                                    |> args.toMsg
                              )
                            ]

                        else
                            []
                       )
                    ++ (if model.opened then
                            [ ( R10.FormComponents.Internal.UI.keyCode.esc
                              , args.toMsg R10.FormComponents.Internal.Single.Common.OnEsc
                              )
                            , ( R10.FormComponents.Internal.UI.keyCode.enter
                              , args.toMsg <|
                                    R10.FormComponents.Internal.Single.Common.OnOptionSelect <|
                                        R10.FormComponents.Internal.Single.Common.getSelectedOrFirst filteredFieldOption model.value model.select
                              )
                            ]

                        else
                            []
                       )
        , inFront <| viewComboboxDropdown model args model.opened filteredFieldOption
        ]
        (inputAttrs ++ attrs)
        textArgs
