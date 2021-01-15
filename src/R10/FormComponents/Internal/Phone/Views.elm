module R10.FormComponents.Internal.Phone.Views exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Keyed as Keyed
import Html.Attributes
import Html.Events
import R10.Country
import R10.FormComponents.Internal.Phone.Common
import R10.FormComponents.Internal.Phone.Update
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.Text
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.Utils
import R10.FormComponents.Internal.Utils.FocusOut
import R10.FormTypes


viewSearchBox : R10.FormComponents.Internal.Phone.Common.Model -> R10.FormComponents.Internal.Phone.Common.Args msg -> Element msg
viewSearchBox model args =
    R10.FormComponents.Internal.Text.viewInput
        [ htmlAttribute <| Html.Attributes.id <| R10.FormComponents.Internal.Phone.Common.dropdownSearchBoxId args.key
        , Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
        , Border.rounded 0
        ]
        { disabled = args.disabled
        , focused = model.focused
        , label = args.label
        , msgOnChange = args.toMsg << R10.FormComponents.Internal.Phone.Update.getMsgOnSearch args
        , msgOnFocus = args.toMsg <| R10.FormComponents.Internal.Phone.Common.OnFocus
        , msgOnLoseFocus = Nothing
        , msgOnEnter = Nothing
        , palette = args.palette
        , style = args.style
        , showPassword = False
        , textType = R10.FormTypes.TextPlain
        , leadingIcon = Nothing
        , trailingIcon = Nothing
        , value = model.search
        }


viewComboboxDropdown : R10.FormComponents.Internal.Phone.Common.Model -> R10.FormComponents.Internal.Phone.Common.Args msg -> Bool -> List R10.Country.Country -> Element msg
viewComboboxDropdown model args opened filteredCountryOptions =
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
            List.length filteredCountryOptions

        visibleOptions : List ( String, Element msg )
        visibleOptions =
            if optionsCount > 0 then
                filteredCountryOptions
                    |> R10.FormComponents.Internal.Utils.listSlice visibleFrom visibleTo
                    |> List.map
                        (\country ->
                            ( country |> R10.Country.toString
                            , viewComboboxOption model.countryValue model.select args country
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
            , moveDown 52
            , htmlAttribute <| Html.Attributes.tabindex -1
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
                , height <| px <| R10.FormComponents.Internal.Phone.Update.getDropdownHeight args optionsCount
                , htmlAttribute <| Html.Attributes.style "overscroll-behavior" "contain"
                , htmlAttribute <| R10.FormComponents.Internal.UI.onScroll <| (args.toMsg << R10.FormComponents.Internal.Phone.Common.OnScroll)
                , Font.color <| R10.FormComponents.Internal.UI.Color.font args.palette
                , paddingXY 0 R10.FormComponents.Internal.Phone.Update.dropdownHingeHeight
                , htmlAttribute <| Html.Attributes.id <| R10.FormComponents.Internal.Phone.Common.dropdownContentId <| args.key
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


viewComboboxOption : Maybe R10.Country.Country -> Maybe R10.Country.Country -> R10.FormComponents.Internal.Phone.Common.Args msg -> R10.Country.Country -> Element msg
viewComboboxOption countryValue select args country =
    let
        isActiveValue : Bool
        isActiveValue =
            countryValue == Just country

        isSelected_ : Bool
        isSelected_ =
            select == Just country

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
        args.toOptionEl country


view : List (Attribute msg) -> R10.FormComponents.Internal.Phone.Common.Model -> R10.FormComponents.Internal.Phone.Common.Args msg -> Element msg
view attrs model args =
    -- todo add selected validation
    let
        filteredCountryOptions =
            R10.FormComponents.Internal.Phone.Common.filterBySearch model.search args.countryOptions

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
            , style : R10.FormComponents.Internal.Style.Style
            , textType : R10.FormTypes.TypeText
            , trailingIcon : Maybe (Element msg)
            , valid : Maybe Bool
            , value : String
            }
        textArgs =
            { disabled = args.disabled
            , focused = model.focused
            , label = args.label
            , msgOnChange = args.toMsg << R10.FormComponents.Internal.Phone.Common.OnValueChange args.key { selectOptionHeight = args.selectOptionHeight, maxDisplayCount = args.maxDisplayCount, filteredCountryOptions = filteredCountryOptions }
            , msgOnFocus = args.toMsg <| R10.FormComponents.Internal.Phone.Common.OnFocus
            , msgOnLoseFocus = Nothing
            , msgOnEnter = Nothing
            , msgOnTogglePasswordShow = Nothing --todo
            , palette = args.palette
            , style = args.style
            , showPassword = False
            , textType = R10.FormTypes.TextPlain
            , leadingIcon = args.leadingIcon
            , trailingIcon = Nothing
            , value = model.value
            , valid = args.valid
            , helperText = args.helperText
            , requiredLabel = args.requiredLabel
            , idDom = Nothing
            }

        inputAttrs : List (Attribute msg)
        inputAttrs =
            [ htmlAttribute <| Html.Attributes.type_ "tel" ]
    in
    R10.FormComponents.Internal.Text.view
        [ htmlAttribute <| Html.Attributes.id <| R10.FormComponents.Internal.Phone.Common.dropdownContainerId <| args.key
        , htmlAttribute <| Html.Attributes.tabindex -1
        , htmlAttribute <|
            Html.Events.on "focusout"
                (R10.FormComponents.Internal.Utils.FocusOut.onFocusOut (R10.FormComponents.Internal.Phone.Common.dropdownContainerId args.key) <|
                    args.toMsg <|
                        R10.FormComponents.Internal.Phone.Common.OnLoseFocus
                )
        , htmlAttribute <|
            R10.FormComponents.Internal.UI.onKeyPressBatch <|
                [ ( R10.FormComponents.Internal.UI.keyCode.down
                  , R10.FormComponents.Internal.Phone.Common.OnArrowDown args.key
                        { selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , filteredCountryOptions = filteredCountryOptions
                        }
                        |> args.toMsg
                  )
                , ( R10.FormComponents.Internal.UI.keyCode.up
                  , R10.FormComponents.Internal.Phone.Common.OnArrowUp args.key
                        { selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , filteredCountryOptions = filteredCountryOptions
                        }
                        |> args.toMsg
                  )
                ]
                    ++ (if model.opened then
                            [ ( R10.FormComponents.Internal.UI.keyCode.esc
                              , args.toMsg R10.FormComponents.Internal.Phone.Common.OnEsc
                              )
                            ]
                                ++ (case model.select of
                                        Just select_ ->
                                            [ ( R10.FormComponents.Internal.UI.keyCode.enter
                                              , args.toMsg <| R10.FormComponents.Internal.Phone.Common.OnOptionSelect select_
                                              )
                                            ]

                                        Nothing ->
                                            []
                                   )

                        else
                            []
                       )
        , inFront <| viewComboboxDropdown model args model.opened filteredCountryOptions
        ]
        (inputAttrs ++ attrs)
        textArgs
