module R10.FormComponents.Single.Combobox exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Keyed as Keyed
import Html.Attributes
import Html.Events
import List.Extra
import R10.FormComponents.Single.Common as Common
import R10.FormComponents.Single.Update
import R10.FormComponents.Style
import R10.FormComponents.Text
import R10.FormComponents.UI
import R10.FormComponents.UI.Color
import R10.FormComponents.Utils
import R10.FormComponents.Utils.FocusOut
import R10.FormComponents.Validations
import R10.FormTypes


filterBySearch : String -> Common.Args msg -> List Common.FieldOption
filterBySearch search { searchFn, fieldOptions } =
    if
        String.isEmpty search
            || Common.isAnyOptionLabelMatched { value = search, fieldOptions = fieldOptions }
    then
        fieldOptions

    else
        fieldOptions
            |> List.filter (searchFn search)


{-| returns value to be displayed in combobox input component
also returns flag is displayed value is actual value or just intermediate
-}
optionsLabelOrSearchValue :
    String
    -> String
    -> List Common.FieldOption
    -> { displayValue : String, isActualValueDisplayed : Bool }
optionsLabelOrSearchValue search value fieldOptions =
    if String.isEmpty search then
        fieldOptions
            |> List.Extra.find (\opt -> opt.value == value)
            |> Maybe.map .label
            |> Maybe.map (\label -> { displayValue = label, isActualValueDisplayed = True })
            |> Maybe.withDefault { displayValue = search, isActualValueDisplayed = False }

    else
        { displayValue = search, isActualValueDisplayed = False }


getMsgOnInputClick : Common.Model -> Common.Args msg -> List Common.FieldOption -> Common.Msg
getMsgOnInputClick model args filteredOptions =
    let
        selectedOptionIndex : Int
        selectedOptionIndex =
            R10.FormComponents.Single.Update.getOptionIndex filteredOptions model.value
                |> Maybe.withDefault -1

        selectedY : Float
        selectedY =
            R10.FormComponents.Single.Update.getOptionY model.scroll args selectedOptionIndex (List.length filteredOptions)
    in
    Common.OnInputClick selectedY


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
            toFloat (R10.FormComponents.Single.Update.dropdownHingeHeight + max 0 visibleFrom * args.selectOptionHeight)

        visibleOptions : List ( String, Element msg )
        visibleOptions =
            if List.length filteredOptions > 0 then
                filteredOptions
                    |> R10.FormComponents.Utils.listSlice visibleFrom visibleTo
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
    el
        [ width fill
        , height <| px <| R10.FormComponents.Single.Update.getDropdownHeight args optionsCount
        , htmlAttribute <| Html.Attributes.style "z-index" "1"
        , htmlAttribute <| Html.Attributes.tabindex 0
        , htmlAttribute <| Html.Attributes.style "overscroll-behavior" "contain"
        , htmlAttribute <| R10.FormComponents.UI.onScroll <| (args.toMsg << Common.OnScroll)
        , htmlAttribute <| Html.Attributes.id <| Common.dropdownContentId <| args.key
        , Font.color <| R10.FormComponents.UI.Color.font args.palette
        , Background.color <| R10.FormComponents.UI.Color.surface args.palette
        , paddingXY 0 R10.FormComponents.Single.Update.dropdownHingeHeight
        , scrollbarX
        , Border.rounded
            (case args.style of
                R10.FormComponents.Style.Filled ->
                    0

                R10.FormComponents.Style.Outlined ->
                    8
            )
        , Border.shadow
            { color = R10.FormComponents.UI.Color.onSurfaceA 0.1 args.palette
            , offset = ( 0, 0 )
            , blur = 3
            , size = 1
            }
        , moveDown 52
        , inFront <| Keyed.column [ width <| fill, moveDown visibleMoveDown ] visibleOptions
        ]
    <|
        el [ height <| px contentHeight, width fill ] none


comboboxOptionNoResults : { a | palette : R10.FormTypes.Palette, selectOptionHeight : Int } -> Element msg
comboboxOptionNoResults { palette, selectOptionHeight } =
    el
        [ width fill
        , height <| px selectOptionHeight
        , paddingEach { top = 0, right = 0, bottom = 0, left = 12 }
        , Font.color <| R10.FormComponents.UI.Color.onSurfaceA 0.5 palette
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
                R10.FormComponents.UI.Color.primaryVariantA 0.13 args.palette

            else if isActiveValue then
                R10.FormComponents.UI.Color.primaryVariantA 0.07 args.palette

            else if isSelected_ then
                R10.FormComponents.UI.Color.onSurfaceA 0.07 args.palette

            else
                R10.FormComponents.UI.Color.onSurfaceA 0 args.palette

        getShadowColor : Color
        getShadowColor =
            if isActiveValue then
                R10.FormComponents.UI.Color.primaryVariantA 0.1 args.palette

            else
                R10.FormComponents.UI.Color.onSurfaceA 0.05 args.palette
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
    -- todo add selected validation
    let
        filteredOptions : List Common.FieldOption
        filteredOptions =
            filterBySearch model.search args

        { displayValue, isActualValueDisplayed } =
            optionsLabelOrSearchValue model.search model.value args.fieldOptions

        textArgs :
            { disabled : Bool
            , focused : Bool
            , helperText : Maybe String
            , idDom : Maybe String
            , label : String
            , leadingIcon : Maybe (Element msg)
            , msgOnChange : String -> msg
            , msgOnEnter : Maybe msg
            , msgOnFocus : msg
            , msgOnLoseFocus : Maybe msg
            , msgOnTogglePasswordShow : Maybe a
            , palette : R10.FormTypes.Palette
            , requiredLabel : Maybe String
            , showPassword : Bool
            , style : R10.FormComponents.Style.Style
            , textType : R10.FormTypes.TypeText
            , trailingIcon : Maybe (Element msg)
            , validation : R10.FormComponents.Validations.Validation
            , value : String
            }
        textArgs =
            { disabled = args.disabled
            , focused = model.focused
            , label = args.label
            , msgOnChange = args.toMsg << Common.OnSearch args.fieldOptions
            , msgOnFocus = args.toMsg <| Common.OnFocus model.value
            , msgOnLoseFocus = Nothing
            , msgOnEnter = Nothing
            , msgOnTogglePasswordShow = Nothing --todo
            , palette = args.palette
            , style = args.style
            , showPassword = False
            , textType = R10.FormTypes.TextPlain
            , leadingIcon = args.leadingIcon
            , trailingIcon = args.trailingIcon
            , value = displayValue
            , validation = args.validation
            , helperText = args.helperText
            , requiredLabel = args.requiredLabel
            , idDom = Just <| Common.selectId args.key
            }

        inputAttrs : List (Attribute msg)
        inputAttrs =
            [ Events.onClick <| args.toMsg <| getMsgOnInputClick model args filteredOptions
            ]
                ++ (if isActualValueDisplayed then
                        []

                    else
                        [ Font.color <| R10.FormComponents.UI.Color.fontA 0.6 args.palette ]
                   )
    in
    R10.FormComponents.Text.view
        ([ htmlAttribute <|
            Html.Events.on "focusout"
                (R10.FormComponents.Utils.FocusOut.onFocusOut (Common.dropdownContentId args.key) <|
                    args.toMsg <|
                        Common.OnLoseFocus model.value
                )
         , htmlAttribute <|
            R10.FormComponents.UI.onKeyPressBatch <|
                [ ( R10.FormComponents.UI.keyCode.down
                  , Common.OnArrowDown
                        { selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , fieldOptions = args.fieldOptions
                        }
                        |> args.toMsg
                  )
                , ( R10.FormComponents.UI.keyCode.up
                  , Common.OnArrowUp
                        { selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , fieldOptions = args.fieldOptions
                        }
                        |> args.toMsg
                  )
                ]
                    ++ (if model.opened then
                            [ ( R10.FormComponents.UI.keyCode.esc
                              , args.toMsg Common.OnEsc
                              )
                            , ( R10.FormComponents.UI.keyCode.enter
                              , args.toMsg <|
                                    Common.OnOptionSelect <|
                                        Common.getSelectedOrFirst filteredOptions model.value model.select
                              )
                            ]

                        else
                            []
                       )
         ]
            ++ (if model.opened then
                    [ inFront <| viewComboboxDropdown model args filteredOptions ]

                else
                    []
               )
        )
        (inputAttrs ++ attrs)
        textArgs
