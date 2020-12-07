module R10.FormComponents.Phone.Views exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Keyed as Keyed
import Html.Attributes
import Html.Events
import R10.Country exposing (Country)
import R10.FormComponents.Phone.Common as Common
import R10.FormComponents.Phone.Update
import R10.FormComponents.Style
import R10.FormComponents.Text
import R10.FormComponents.UI
import R10.FormComponents.UI.Color
import R10.FormComponents.Utils
import R10.FormComponents.Utils.FocusOut
import R10.FormComponents.Validations
import R10.FormTypes


viewComboboxDropdown : Common.Model -> Common.Args msg -> Element msg
viewComboboxDropdown model args =
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
            toFloat (R10.FormComponents.Phone.Update.dropdownHingeHeight + max 0 visibleFrom * args.selectOptionHeight)

        optionsCount : Int
        optionsCount =
            List.length args.countryOptions

        visibleOptions : List ( String, Element msg )
        visibleOptions =
            if optionsCount > 0 then
                args.countryOptions
                    |> R10.FormComponents.Utils.listSlice visibleFrom visibleTo
                    |> List.map
                        (\country ->
                            ( country |> R10.Country.toString
                            , viewComboboxOption model.value model.select args country
                            )
                        )

            else
                [ ( "no_results", comboboxOptionNoResults args ) ]

        contentHeight : Int
        contentHeight =
            args.selectOptionHeight * max optionsCount 1
    in
    el
        [ width fill
        , height <| px <| R10.FormComponents.Phone.Update.getDropdownHeight args optionsCount
        , htmlAttribute <| Html.Attributes.style "z-index" "1"
        , htmlAttribute <| Html.Attributes.tabindex 0
        , htmlAttribute <| Html.Attributes.style "overscroll-behavior" "contain"
        , htmlAttribute <| R10.FormComponents.UI.onScroll <| (args.toMsg << Common.OnScroll)
        , htmlAttribute <| Html.Attributes.id <| Common.dropdownContentId <| args.key
        , Font.color <| R10.FormComponents.UI.Color.font args.palette
        , Background.color <| R10.FormComponents.UI.Color.surface args.palette
        , paddingXY 0 R10.FormComponents.Phone.Update.dropdownHingeHeight
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
        , moveUp 52
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


viewComboboxOption : String -> Maybe Country -> Common.Args msg -> Country -> Element msg
viewComboboxOption value select args country =
    let
        isActiveValue : Bool
        isActiveValue =
            R10.FormComponents.Phone.Update.extractCountry value
                |> (\c -> c == Just country)

        isSelected_ : Bool
        isSelected_ =
            select == Just country

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
        args.toOptionEl country


view : List (Attribute msg) -> Common.Model -> Common.Args msg -> Element msg
view attrs model args =
    -- todo add selected validation
    let
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
            , msgOnChange =
                args.toMsg
                    << Common.OnSearch args.key
                        { selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , countryOptions = args.countryOptions
                        }
            , msgOnFocus = args.toMsg <| Common.OnFocus
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
            , validation = args.validation
            , helperText = args.helperText
            , requiredLabel = args.requiredLabel
            , idDom = Just <| Common.selectId args.key
            }

        inputAttrs : List (Attribute msg)
        inputAttrs =
            [ htmlAttribute <| Html.Attributes.type_ "tel" ]
    in
    R10.FormComponents.Text.view
        ([ htmlAttribute <|
            Html.Events.on "focusout"
                (R10.FormComponents.Utils.FocusOut.onFocusOut (Common.dropdownContentId args.key) <|
                    args.toMsg <|
                        Common.OnLoseFocus
                )
         , htmlAttribute <|
            R10.FormComponents.UI.onKeyPressBatch <|
                [ ( R10.FormComponents.UI.keyCode.down
                  , Common.OnArrowDown args.key
                        { selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , countryOptions = args.countryOptions
                        }
                        |> args.toMsg
                  )
                , ( R10.FormComponents.UI.keyCode.up
                  , Common.OnArrowUp args.key
                        { selectOptionHeight = args.selectOptionHeight
                        , maxDisplayCount = args.maxDisplayCount
                        , countryOptions = args.countryOptions
                        }
                        |> args.toMsg
                  )
                ]
                    ++ (if model.opened then
                            [ ( R10.FormComponents.UI.keyCode.esc
                              , args.toMsg Common.OnEsc
                              )
                            ]
                                ++ (case model.select of
                                        Just select_ ->
                                            [ ( R10.FormComponents.UI.keyCode.enter
                                              , args.toMsg <| Common.OnOptionSelect select_
                                              )
                                            ]

                                        Nothing ->
                                            []
                                   )

                        else
                            []
                       )
         ]
            ++ (if model.opened then
                    [ inFront <| viewComboboxDropdown model args ]

                else
                    []
               )
        )
        (inputAttrs ++ attrs)
        textArgs
