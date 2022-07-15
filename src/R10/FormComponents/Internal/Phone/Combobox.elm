module R10.FormComponents.Internal.Phone.Combobox exposing (view)

import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Element.WithContext.Input as Input
import Element.WithContext.Keyed as Keyed
import Html.Attributes
import Html.Events
import R10.Color.Svg
import R10.Context exposing (..)
import R10.Country
import R10.Form.Internal.Shared
import R10.FormComponents.Internal.Phone.Common
import R10.FormComponents.Internal.Phone.Update
import R10.FormComponents.Internal.Text
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.Utils
import R10.FormComponents.Internal.Utils.FocusOut
import R10.FormTypes
import R10.Palette
import R10.Svg.Icons
import R10.Transition


viewSearchBox :
    R10.FormComponents.Internal.Phone.Common.Model
    -> R10.FormComponents.Internal.Phone.Common.Args z msg
    -> Element (R10.Context.ContextInternal z) msg
viewSearchBox model args =
    --
    -- This function is similar to R10.FormComponents.Internal.Single.Combobox.viewSearchBox
    --
    row
        [ Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
        , Border.color <| R10.FormComponents.Internal.UI.Color.borderA 0.3 args.palette
        , paddingXY 10 0
        , width fill
        ]
        [ withContext <|
            \c ->
                Input.text
                    [ htmlAttribute <| Html.Attributes.id <| R10.FormComponents.Internal.Phone.Common.dropdownSearchBoxId args.key
                    , Background.color <| R10.FormComponents.Internal.UI.Color.surface args.palette
                    , paddingEach { top = 16, bottom = 16, left = 8, right = 16 }
                    , Border.width 0
                    , htmlAttribute <|
                        R10.FormComponents.Internal.UI.onKeyPressBatch <|
                            [ ( R10.FormComponents.Internal.UI.keyCode.enter
                              , if String.isEmpty model.search then
                                    R10.FormComponents.Internal.Phone.Common.OnEsc args.key True |> args.toMsg

                                else
                                    R10.FormComponents.Internal.Phone.Common.NoOp |> args.toMsg
                              )
                            ]
                    ]
                    { onChange = \string -> args.toMsg (R10.FormComponents.Internal.Phone.Update.getMsgOnSearch args string)
                    , text = model.search
                    , placeholder = Nothing
                    , label = Input.labelLeft [ centerY, moveRight 5 ] <| R10.Svg.Icons.search [] (R10.Color.Svg.fontHighEmphasis c.contextR10.theme) 18
                    }
        , Input.button
            [ mouseOver [ Background.color <| R10.FormComponents.Internal.UI.Color.borderA 0.3 args.palette ]
            , R10.Transition.transition "all 0.2s"
            , padding 6
            , Border.rounded 20
            ]
            { onPress = Just <| args.toMsg <| R10.FormComponents.Internal.Phone.Common.OnEsc args.key False, label = withContext <| \c -> R10.Svg.Icons.x [] (R10.Color.Svg.fontHighEmphasis c.contextR10.theme) 18 }
        ]


viewComboboxDropdown : R10.FormComponents.Internal.Phone.Common.Model -> R10.FormComponents.Internal.Phone.Common.Args z msg -> Bool -> List R10.Country.Country -> Element (R10.Context.ContextInternal z) msg
viewComboboxDropdown model args opened filteredFieldOption =
    let
        elementsScrolledFromTop : Int
        elementsScrolledFromTop =
            round model.scroll // args.selectOptionHeight

        --  dynamic viewport
        visibleCount : Int
        visibleCount =
            args.maxDisplayCount * 3

        visibleFrom : Int
        visibleFrom =
            elementsScrolledFromTop - args.maxDisplayCount

        visibleTo : Int
        visibleTo =
            visibleFrom + visibleCount

        visibleMoveDown : Float
        visibleMoveDown =
            toFloat (R10.FormComponents.Internal.Phone.Update.dropdownHingeHeight + max 0 visibleFrom * args.selectOptionHeight)

        optionsCount : Int
        optionsCount =
            List.length filteredFieldOption

        visibleOptions : List ( String, Element (R10.Context.ContextInternal z) msg )
        visibleOptions =
            if optionsCount > 0 then
                let
                    maybeCountryValue : Maybe R10.Country.Country
                    maybeCountryValue =
                        R10.Country.fromTelephoneAsString model.value
                in
                filteredFieldOption
                    |> R10.FormComponents.Internal.Utils.listSlice visibleFrom visibleTo
                    |> List.map
                        (\country ->
                            ( R10.Country.toCountryNameWithAlias country
                            , viewComboboxOption maybeCountryValue model.select args country
                            )
                        )

            else
                [ ( "no_results", comboboxOptionNoResults args ) ]

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

            --
            -- The Email field has the zIndex: 1 attribute to resolve https://jira.rakuten-it.com/jira/browse/OMN-4832
            -- In the Safari, if the dropdown is top on the Email field, the input of the Email field will override the dropdown.
            -- So upper the zIndex of the dropdown to 2
            --
            , htmlAttribute <| Html.Attributes.style "z-index" "2"
            , Border.rounded 8
            , Border.shadow
                { color = R10.FormComponents.Internal.UI.Color.onSurfaceA 0.3 args.palette
                , offset = ( 0, 0 )
                , blur = 10
                , size = 3
                }
            , htmlAttribute <|
                Html.Events.on "focusout"
                    (R10.FormComponents.Internal.Utils.FocusOut.onFocusOut (R10.FormComponents.Internal.Phone.Common.dropdownContainerId args.key) <|
                        args.toMsg <|
                            R10.FormComponents.Internal.Phone.Common.OnEsc args.key False
                    )
            ]
            [ viewSearchBox model args
            , el
                [ width fill
                , height <| px <| R10.FormComponents.Internal.Phone.Update.getDropdownHeight args optionsCount
                , htmlAttribute <| Html.Attributes.style "overscroll-behavior" "contain"
                , htmlAttribute <| R10.FormComponents.Internal.UI.onScroll <| (args.toMsg << R10.FormComponents.Internal.Phone.Common.OnScroll)
                , Font.color <| R10.FormComponents.Internal.UI.Color.font args.palette
                , htmlAttribute <| Html.Attributes.id <| R10.FormComponents.Internal.Phone.Common.dropdownContentId <| args.key
                , scrollbarX
                , inFront <|
                    Keyed.column
                        [ width <| shrink
                        , moveDown visibleMoveDown
                        , htmlAttribute <| Html.Attributes.style "min-width" "100%"
                        ]
                        visibleOptions
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


viewComboboxOption : Maybe R10.Country.Country -> String -> R10.FormComponents.Internal.Phone.Common.Args z msg -> R10.Country.Country -> Element (R10.Context.ContextInternal z) msg
viewComboboxOption countryValue select args country =
    let
        isActiveValue : Bool
        isActiveValue =
            countryValue == Just country

        isSelected_ : Bool
        isSelected_ =
            R10.Country.fromString select == Just country

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
        args.toOptionEl country


view :
    List (Attribute (R10.Context.ContextInternal z) msg)
    -> R10.FormComponents.Internal.Phone.Common.Model
    -> R10.FormComponents.Internal.Phone.Common.Args z msg
    -> Element (R10.Context.ContextInternal z) msg
view attrs model args =
    -- todo add selected validation
    let
        filteredFieldOption : List R10.Country.Country
        filteredFieldOption =
            R10.FormComponents.Internal.Phone.Common.filterBySearch model.search args.countryOptions

        maybeCountry : Maybe R10.Country.Country
        maybeCountry =
            model.value
                |> R10.Country.fromTelephoneAsString

        maybeTelCode : String
        maybeTelCode =
            model.value
                |> R10.Country.fromTelephoneAsString
                |> Maybe.map R10.Country.toCountryTelCode
                |> Maybe.withDefault ""

        valueToShowOnTheScreen : String
        valueToShowOnTheScreen =
            String.replace maybeTelCode "" model.value

        textArgs : R10.FormComponents.Internal.Text.Args z msg
        textArgs =
            { disabled = args.disabled
            , focused = model.focused
            , label = args.label
            , msgOnChange =
                args.toMsg
                    << R10.FormComponents.Internal.Phone.Common.OnValueChange args.key
                        { selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , filteredFieldOption = filteredFieldOption
                        }
            , msgOnFocus = args.toMsg <| R10.FormComponents.Internal.Phone.Common.OnFocus model.value
            , msgOnLoseFocus = Nothing
            , msgOnEnter = Nothing
            , msgOnKeyDown = Nothing
            , msgOnTogglePasswordShow = Nothing --todo
            , palette = args.palette
            , style = args.style
            , showPassword = False
            , textType = R10.FormTypes.TextPlain
            , fieldType = Just <| R10.FormTypes.TypeSpecial <| R10.FormTypes.SpecialPhone { disableInternationalPrefixPhoneChange = False, isJapanService = False }
            , leadingIcon = args.leadingIcon
            , trailingIcon = args.trailingIcon
            , value = valueToShowOnTheScreen
            , maybeValid = args.maybeValid
            , helperText = args.helperText
            , requiredLabel = args.requiredLabel
            , idDom = Nothing
            , autocomplete = Nothing
            , floatingLabelAlwaysUp = True
            , placeholder = R10.Form.Internal.Shared.toPhonePlaceholder args.key maybeCountry
            }

        inputAttrs : List (Attribute (R10.Context.ContextInternal z) msg)
        inputAttrs =
            [ htmlAttribute <| Html.Attributes.type_ "tel"
            , htmlAttribute <| Html.Attributes.id <| R10.FormComponents.Internal.Phone.Common.inputPhoneElementId args.key

            --
            -- Move focusout listener from wrapper to input component.
            -- Otherwiss when country changed and auto focus to input, it will be triggered, and display validate errors.
            --
            , htmlAttribute <|
                Html.Events.on "focusout"
                    (R10.FormComponents.Internal.Utils.FocusOut.onFocusOut (R10.FormComponents.Internal.Phone.Common.dropdownContainerId args.key) <|
                        args.toMsg <|
                            R10.FormComponents.Internal.Phone.Common.OnLoseFocus model.value
                    )
            , htmlAttribute <|
                R10.FormComponents.Internal.UI.onKeyPressBatch <|
                    [ ( R10.FormComponents.Internal.UI.keyCode.enter
                      , args.toMsg <| R10.FormComponents.Internal.Phone.Common.OnEsc args.key False
                      )
                    ]
            ]

        arrowKeysPressBatch : List ( Int, msg )
        arrowKeysPressBatch =
            if args.disabledCountryChange then
                []

            else
                [ ( R10.FormComponents.Internal.UI.keyCode.down
                  , R10.FormComponents.Internal.Phone.Common.OnArrowDown
                        { key = args.key
                        , selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , filteredFieldOption = filteredFieldOption
                        }
                        |> args.toMsg
                  )
                , ( R10.FormComponents.Internal.UI.keyCode.up
                  , R10.FormComponents.Internal.Phone.Common.OnArrowUp
                        { key = args.key
                        , selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , filteredFieldOption = filteredFieldOption
                        }
                        |> args.toMsg
                  )
                ]
    in
    column [ width fill, spacing 50, paddingEach { top = 15, right = 0, bottom = 0, left = 0 } ]
        [ R10.FormComponents.Internal.Text.view
            [ htmlAttribute <| Html.Attributes.id <| R10.FormComponents.Internal.Phone.Common.dropdownContainerId <| args.key
            , htmlAttribute <| Html.Attributes.tabindex -1
            , htmlAttribute <|
                R10.FormComponents.Internal.UI.onKeyPressBatch <|
                    arrowKeysPressBatch
                        ++ (if model.opened then
                                ( R10.FormComponents.Internal.UI.keyCode.esc
                                , args.toMsg <| R10.FormComponents.Internal.Phone.Common.OnEsc args.key False
                                )
                                    :: (case R10.Country.fromString model.select of
                                            Just country ->
                                                [ ( R10.FormComponents.Internal.UI.keyCode.enter
                                                  , args.toMsg <| R10.FormComponents.Internal.Phone.Common.OnOptionSelect args.key country
                                                  )
                                                ]

                                            Nothing ->
                                                []
                                       )

                            else
                                []
                           )
            , inFront <| viewComboboxDropdown model args model.opened filteredFieldOption
            ]
            (inputAttrs ++ attrs)
            textArgs
        ]
