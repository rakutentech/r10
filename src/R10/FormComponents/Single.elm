module R10.FormComponents.Single exposing
    ( defaultSearchFn
    , defaultToOptionEl
    , defaultTrailingIcon
    , dropdownContentId
    , extraCss
    , insertBold
    , normalizeString
    , update
    , view
    , viewCustom
    )

import Browser.Dom
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Html.Attributes
import Html.Events
import List.Extra
import R10.FormComponents.IconButton
import R10.FormComponents.Single.Common as Common
import R10.FormComponents.Single.Radio
import R10.FormComponents.Style
import R10.FormComponents.Text
import R10.FormComponents.UI
import R10.FormComponents.UI.Color
import R10.FormComponents.UI.Palette
import R10.FormComponents.Utils
import R10.FormComponents.Utils.FocusOut
import R10.FormComponents.Validations
import R10.SimpleMarkdown
import String.Extra
import Task



-- todo implement disabled style
-- todo implement custom logic for Radio (remove Input.Radio due to lack of customization. eg cannot apply disabled style)
-- About best UX for Radio Buttons:
-- https://uxplanet.org/radio-buttons-ux-design-588e5c0a50dc
-- constants


dropdownHingeHeight : number
dropdownHingeHeight =
    10


extraCss : String
extraCss =
    ""


dropdownContentId : String -> String
dropdownContentId key =
    "dropdown-content-" ++ key


selectId : String -> String
selectId key =
    "dropdown-" ++ key


update : Common.Msg -> Common.Model -> ( Common.Model, Cmd Common.Msg )
update msg model =
    case msg of
        Common.NoOp ->
            ( model, Cmd.none )

        Common.OnSearch string value ->
            ( { model | search = string, value = value }, Cmd.none )

        Common.OnOptionSelect value ->
            ( { model | value = value, opened = False }, Cmd.none )

        Common.OnScroll scroll ->
            ( { model | scroll = scroll }, Cmd.none )

        Common.OnInputClick scroll ->
            ( { model | scroll = scroll, opened = not model.opened }, Cmd.none )

        Common.OnLoseFocus value ->
            ( { model | focused = False, opened = False, value = value }, Cmd.none )

        Common.OnFocus value ->
            ( { model | focused = True, value = value }, Cmd.none )

        Common.OnArrowUp value scroll ->
            if model.opened then
                onArrowHelper model value scroll

            else
                onOpenHelper model scroll

        Common.OnArrowDown value scroll ->
            if model.opened then
                onArrowHelper model value scroll

            else
                onOpenHelper model scroll

        Common.OnEsc ->
            ( { model | search = "", opened = False }, Cmd.none )


defaultSearchFn : String -> Common.FieldOption -> Bool
defaultSearchFn search opt =
    String.contains
        (search |> normalizeString)
        (opt.label |> normalizeString)


defaultToOptionEl : { a | search : String, msgOnSelect : String -> msg } -> Common.FieldOption -> Element msg
defaultToOptionEl { search, msgOnSelect } { label, value } =
    let
        insertPositions : List Int
        insertPositions =
            String.indexes (search |> normalizeString) (label |> normalizeString)
                |> List.concatMap (\idx -> [ idx, idx + String.length search ])

        withBold : String
        withBold =
            if String.isEmpty search then
                label

            else
                insertBold insertPositions label
    in
    row
        [ width fill
        , height fill
        , R10.FormComponents.UI.onClickWithStopPropagation <| msgOnSelect value
        , pointer
        , paddingEach { top = 0, right = 0, bottom = 0, left = 12 }

        -- gradient for label overflow
        , htmlAttribute <| Html.Attributes.style "mask-image" "linear-gradient(right, rgba(255,255,0,0), rgba(255,255,0, 1) 16px)"
        , htmlAttribute <| Html.Attributes.style "-webkit-mask-image" "-webkit-linear-gradient(right, rgba(255,255,0,0) 10px, rgba(255,255,0, 1) 16px)"
        ]
        (withBold |> R10.SimpleMarkdown.elementMarkdown)


defaultTrailingIcon : { a | opened : Bool, palette : R10.FormComponents.UI.Palette.Palette } -> Element msg
defaultTrailingIcon { opened, palette } =
    R10.FormComponents.IconButton.view []
        { msgOnClick = Nothing
        , icon =
            el
                [ rotate <|
                    degrees
                        (if opened then
                            180

                         else
                            0
                        )
                , htmlAttribute <| Html.Attributes.style "transition" "all 0.13s"
                ]
            <|
                html <|
                    R10.FormComponents.UI.icons.combobox_arrow_
                        (R10.FormComponents.UI.Color.label palette |> R10.FormComponents.UI.Color.toCssString)
                        24
        , palette = palette
        , size = 24
        }



--helpers Public


normalizeString : String -> String
normalizeString =
    -- use for filtering, search <-> label comparison
    String.toLower >> String.trim


insertBold : List Int -> String -> String
insertBold indexes string =
    string
        |> R10.FormComponents.Utils.stringInsertAtMulti "**" indexes
        |> String.Extra.surround "**"



--helpers Private


onArrowHelper : Common.Model -> String -> Float -> ( Common.Model, Cmd Common.Msg )
onArrowHelper model value float =
    ( { model | scroll = float, value = value }
    , Task.attempt
        (always Common.NoOp)
        (Browser.Dom.setViewportOf
            (dropdownContentId "")
            0
            float
        )
    )


onOpenHelper : Common.Model -> Float -> ( Common.Model, Cmd Common.Msg )
onOpenHelper model float =
    ( { model
        | opened = True
        , scroll = float
      }
    , Task.attempt
        (always Common.NoOp)
        (Browser.Dom.setViewportOf
            (dropdownContentId "")
            0
            float
        )
    )


getDropdownHeight : { a | maxDisplayCount : Int, selectOptionHeight : Int } -> Int -> Int
getDropdownHeight args optionsCount =
    let
        displayCount : Int
        displayCount =
            min args.maxDisplayCount optionsCount
                -- we want to display at least "no options" text
                |> max 1

        bottomHingeHeight : Int
        bottomHingeHeight =
            if displayCount == optionsCount || optionsCount == 0 then
                dropdownHingeHeight

            else
                0

        dropdownHeight : Int
        dropdownHeight =
            (args.selectOptionHeight * displayCount) + dropdownHingeHeight + bottomHingeHeight
    in
    dropdownHeight


filterBySearch : Common.Args msg -> List Common.FieldOption
filterBySearch { searchFn, search, fieldOptions } =
    if
        String.isEmpty search
            || Common.isAnyOptionSelected { value = search, fieldOptions = fieldOptions }
    then
        fieldOptions

    else
        fieldOptions
            |> List.filter (searchFn search)


getSelectedOptionIndex : List { a | value : String } -> String -> Maybe Int
getSelectedOptionIndex filteredOptions value =
    filteredOptions
        |> List.Extra.findIndex (\opt -> opt.value == value)


inboundIndex : number -> number -> number
inboundIndex maxIdx idx =
    if idx < 0 || idx > maxIdx then
        -1

    else
        idx


getOptionByLabel : List Common.FieldOption -> String -> Maybe Common.FieldOption
getOptionByLabel fieldOptions targetLabel =
    fieldOptions
        |> List.Extra.find (\opt -> opt.label == targetLabel)


optionsLabelOrSearchValue : String -> String -> List Common.FieldOption -> String
optionsLabelOrSearchValue search value fieldOptions =
    fieldOptions
        |> List.Extra.find (\opt -> opt.value == value)
        |> Maybe.map .label
        |> Maybe.withDefault search


getMsgOnInputClick : Common.Args msg -> List Common.FieldOption -> msg
getMsgOnInputClick args filteredOptions =
    let
        selectedOptionIndex : Int
        selectedOptionIndex =
            getSelectedOptionIndex filteredOptions args.value
                |> Maybe.withDefault -1

        newY : Float
        newY =
            getOptionY args selectedOptionIndex (List.length filteredOptions)
    in
    args.msgOnInputClick newY


{-| get Y position of option element, relative to dropdown
used for virtual scrolling
-}
getOptionY : { a | scroll : Float, selectOptionHeight : Int, maxDisplayCount : Int } -> Int -> Int -> Float
getOptionY args optionIndex optionsCount =
    if optionIndex == -1 then
        -- no selection
        args.scroll

    else if optionIndex == 0 then
        -- first option
        0.0

    else
        let
            bottomHingeHeight : Int
            bottomHingeHeight =
                -- for last element we want to display bottom hinge as well
                if optionIndex == (optionsCount - 1) then
                    dropdownHingeHeight

                else
                    0

            optionY : Float
            optionY =
                optionIndex * args.selectOptionHeight + dropdownHingeHeight + bottomHingeHeight |> toFloat

            maxViewport : { bottom : Float, top : Float }
            maxViewport =
                { top = args.scroll
                , bottom = args.scroll + (toFloat <| getDropdownHeight args optionsCount)
                }
        in
        if optionY >= maxViewport.bottom then
            -- scroll so new option would be at the bottom of viewport
            optionY - toFloat (getDropdownHeight args optionsCount - args.selectOptionHeight)

        else if optionY <= maxViewport.top then
            -- scroll so new option would be at the top of viewport
            optionY

        else
            -- selected option is in viewport, do nothing
            args.scroll


getNextNewValueAndY : Common.Args msg -> List Common.FieldOption -> ( String, Float )
getNextNewValueAndY args filteredOptions =
    let
        newIndex : Int
        newIndex =
            getSelectedOptionIndex filteredOptions args.value
                |> Maybe.map ((+) 1)
                |> Maybe.map (inboundIndex <| List.length filteredOptions)
                |> Maybe.withDefault 0

        newValue : String
        newValue =
            List.Extra.getAt newIndex filteredOptions
                |> Maybe.map .value
                |> Maybe.withDefault ""

        newY : Float
        newY =
            getOptionY args newIndex (List.length filteredOptions)
    in
    ( newValue, newY )


getPrevNewValueAndY : Common.Args msg -> List Common.FieldOption -> ( String, Float )
getPrevNewValueAndY args filteredOptions =
    let
        newIndex : Int
        newIndex =
            getSelectedOptionIndex filteredOptions args.value
                |> Maybe.map ((+) -1)
                |> Maybe.map (inboundIndex <| List.length filteredOptions)
                |> Maybe.withDefault (List.length filteredOptions - 1)

        newValue : String
        newValue =
            List.Extra.getAt newIndex filteredOptions
                |> Maybe.map .value
                |> Maybe.withDefault ""

        newY : Float
        newY =
            getOptionY args newIndex (List.length filteredOptions)
    in
    ( newValue, newY )


getMsgOnComboboxChange : Common.Args msg -> String -> msg
getMsgOnComboboxChange args newSearch =
    let
        newValue : String
        newValue =
            getOptionByLabel args.fieldOptions newSearch
                |> Maybe.map .value
                |> Maybe.withDefault ""
    in
    args.msgOnSearch newSearch newValue


viewCombobox : List (Attribute msg) -> Common.Args msg -> Element msg
viewCombobox attrs args =
    -- todo add selected validation
    let
        filteredOptions : List Common.FieldOption
        filteredOptions =
            filterBySearch args

        textArgs :
            { disabled : Bool
            , focused : Bool
            , helperText : Maybe String
            , idDom : Maybe a3
            , label : String
            , leadingIcon : Maybe (Element msg)
            , msgOnChange : String -> msg
            , msgOnEnter : Maybe a2
            , msgOnFocus : msg
            , msgOnLoseFocus : Maybe a1
            , msgOnTogglePasswordShow : Maybe a
            , palette : R10.FormComponents.UI.Palette.Palette
            , requiredLabel : Maybe String
            , showPassword : Bool
            , style : R10.FormComponents.Style.Style
            , textType : R10.FormComponents.Text.TextType
            , trailingIcon : Maybe (Element msg)
            , validation : R10.FormComponents.Validations.Validation
            , value : String
            }
        textArgs =
            { disabled = args.disabled
            , focused = args.focused
            , label = args.label
            , msgOnChange = getMsgOnComboboxChange args
            , msgOnFocus = args.msgOnFocus args.value
            , msgOnLoseFocus = Nothing
            , msgOnEnter = Nothing
            , msgOnTogglePasswordShow = Nothing --todo
            , palette = args.palette
            , style = args.style
            , showPassword = False
            , textType = R10.FormComponents.Text.TextPlain
            , leadingIcon = args.leadingIcon
            , trailingIcon = args.trailingIcon
            , value = optionsLabelOrSearchValue args.search args.value args.fieldOptions
            , validation = args.validation
            , helperText = args.helperText
            , requiredLabel = args.requiredLabel
            , idDom = Nothing
            }

        inputAttrs : List (Attribute msg)
        inputAttrs =
            [ Events.onClick <| getMsgOnInputClick args filteredOptions
            ]
    in
    R10.FormComponents.Text.view
        ([ htmlAttribute <| Html.Attributes.id <| selectId args.key
         , htmlAttribute <|
            Html.Events.on "focusout"
                (R10.FormComponents.Utils.FocusOut.onFocusOut (selectId args.key) <|
                    args.msgOnLoseFocus args.value
                )
         , htmlAttribute <|
            R10.FormComponents.UI.onKeyPressBatch <|
                [ ( R10.FormComponents.UI.keyCode.down
                  , (\( newValue, newY ) -> args.msgOnArrowDown newValue newY) <|
                        getNextNewValueAndY args filteredOptions
                  )
                , ( R10.FormComponents.UI.keyCode.up
                  , (\( newValue, newY ) -> args.msgOnArrowUp newValue newY) <|
                        getPrevNewValueAndY args filteredOptions
                  )
                ]
                    ++ (if args.active then
                            [ ( R10.FormComponents.UI.keyCode.esc
                              , args.msgOnEsc
                              )
                            , ( R10.FormComponents.UI.keyCode.enter
                              , args.msgOnOptionSelect <|
                                    Common.getSelectedOrFirst filteredOptions args.value
                              )
                            ]

                        else
                            []
                       )
         ]
            ++ (if args.active then
                    [ inFront <| viewComboboxDropdown args filteredOptions ]

                else
                    []
               )
        )
        (inputAttrs ++ attrs)
        textArgs


viewComboboxDropdown : Common.Args msg -> List Common.FieldOption -> Element msg
viewComboboxDropdown args filteredOptions =
    let
        elementsScrolledFromTop : Int
        elementsScrolledFromTop =
            round args.scroll // args.selectOptionHeight

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
            toFloat (dropdownHingeHeight + max 0 visibleFrom * args.selectOptionHeight)

        visibleOptions : List (Element msg)
        visibleOptions =
            if List.length filteredOptions > 0 then
                filteredOptions
                    |> R10.FormComponents.Utils.listSlice visibleFrom visibleTo
                    |> List.map (viewComboboxOption args)

            else
                comboboxOptionsNoResults args

        optionsCount : Int
        optionsCount =
            List.length filteredOptions

        contentHeight : Int
        contentHeight =
            args.selectOptionHeight * max optionsCount 1
    in
    el
        [ width fill
        , height <| px <| getDropdownHeight args optionsCount
        , htmlAttribute <| Html.Attributes.style "z-index" "1"
        , htmlAttribute <| Html.Attributes.style "overscroll-behavior" "contain"
        , htmlAttribute <| R10.FormComponents.UI.onScroll args.msgOnScroll
        , htmlAttribute <| Html.Attributes.id <| dropdownContentId <| args.key
        , Font.color <| R10.FormComponents.UI.Color.font args.palette
        , Background.color <| R10.FormComponents.UI.Color.surface args.palette
        , paddingXY 0 dropdownHingeHeight
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
        , inFront <| column [ width <| fill, moveDown visibleMoveDown ] visibleOptions
        ]
    <|
        el [ height <| px contentHeight, width fill ] none


comboboxOptionsNoResults : { a | palette : R10.FormComponents.UI.Palette.Palette, selectOptionHeight : Int } -> List (Element msg)
comboboxOptionsNoResults { palette, selectOptionHeight } =
    [ el
        [ width fill
        , height <| px selectOptionHeight
        , paddingEach { top = 0, right = 0, bottom = 0, left = 12 }
        , Font.color <| R10.FormComponents.UI.Color.onSurfaceA 0.5 palette
        ]
      <|
        el [ centerY ] <|
            text "No results"
    ]


viewComboboxOption : Common.Args msg -> Common.FieldOption -> Element msg
viewComboboxOption args opt =
    let
        isActiveValue : Bool
        isActiveValue =
            args.value == opt.value

        isSelected_ : Bool
        isSelected_ =
            False

        getBackgroundColor : Color
        getBackgroundColor =
            if isActiveValue then
                R10.FormComponents.UI.Color.primaryVariantA 0.1 args.palette

            else if isSelected_ then
                R10.FormComponents.UI.Color.onSurfaceA 0.1 args.palette

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
        , htmlAttribute <| Html.Attributes.style "transition" "all 0.13s"
        , Background.color <| getBackgroundColor
        , mouseOver
            [ Border.innerShadow { offset = ( 0, 0 ), size = 40, blur = 0, color = getShadowColor } ]
        ]
    <|
        args.toOptionEl opt


view :
    List (Attribute msg)
    -- Shared.Args msg - without [toOptionEl, searchFn]
    ->
        { value : String
        , search : String
        , focused : Bool
        , scroll : Float
        , opened : Bool
        }
    ->
        { label : String
        , helperText : Maybe String
        , disabled : Bool
        , requiredLabel : Maybe String
        , key : String
        , style : R10.FormComponents.Style.Style
        , palette : R10.FormComponents.UI.Palette.Palette
        , singleType : Common.TypeSingle
        , fieldOptions : List Common.FieldOption
        , validation : R10.FormComponents.Validations.Validation
        , toMsg : Common.Msg -> msg
        }
    -> Element msg
view attrs model conf =
    let
        args :
            { active : Bool
            , disabled : Bool
            , fieldOptions : List Common.FieldOption
            , focused : Bool
            , helperText : Maybe String
            , key : String
            , label : String
            , leadingIcon : Maybe a
            , maxDisplayCount : number
            , msgNoOp : msg
            , msgOnArrowDown : String -> Float -> msg
            , msgOnArrowUp : String -> Float -> msg
            , msgOnEsc : msg
            , msgOnFocus : String -> msg
            , msgOnInputClick : Float -> msg
            , msgOnLoseFocus : String -> msg
            , msgOnOptionSelect : String -> msg
            , msgOnScroll : Float -> msg
            , msgOnSearch : String -> String -> msg
            , palette : R10.FormComponents.UI.Palette.Palette
            , requiredLabel : Maybe String
            , scroll : Float
            , search : String
            , searchFn : String -> Common.FieldOption -> Bool
            , selectOptionHeight : number1
            , singleType : Common.TypeSingle
            , style : R10.FormComponents.Style.Style
            , toOptionEl : Common.FieldOption -> Element msg
            , trailingIcon : Maybe (Element msg)
            , validation : R10.FormComponents.Validations.Validation
            , value : String
            }
        args =
            { value = model.value
            , search = model.search
            , focused = model.focused
            , scroll = model.scroll
            , active = model.opened
            , validation = conf.validation
            , msgNoOp = Common.NoOp |> conf.toMsg
            , msgOnFocus = Common.OnFocus >> conf.toMsg
            , msgOnLoseFocus = Common.OnLoseFocus >> conf.toMsg
            , msgOnScroll = Common.OnScroll >> conf.toMsg
            , msgOnSearch = \s1 s2 -> Common.OnSearch s1 s2 |> conf.toMsg
            , msgOnOptionSelect = Common.OnOptionSelect >> conf.toMsg
            , msgOnArrowUp = \s1 f1 -> Common.OnArrowUp s1 f1 |> conf.toMsg
            , msgOnArrowDown = \s1 f1 -> Common.OnArrowDown s1 f1 |> conf.toMsg
            , msgOnEsc = Common.OnEsc |> conf.toMsg
            , msgOnInputClick = Common.OnInputClick >> conf.toMsg
            , label = conf.label
            , helperText = conf.helperText
            , disabled = conf.disabled
            , requiredLabel = conf.requiredLabel
            , style = conf.style
            , key = conf.key
            , palette = conf.palette
            , singleType = conf.singleType
            , fieldOptions = conf.fieldOptions
            , searchFn = defaultSearchFn
            , toOptionEl =
                defaultToOptionEl
                    { search = model.search
                    , msgOnSelect = Common.OnOptionSelect >> conf.toMsg
                    }
            , selectOptionHeight = 36
            , maxDisplayCount = 5
            , leadingIcon = Nothing
            , trailingIcon = Just <| defaultTrailingIcon { opened = model.opened, palette = conf.palette }
            }
    in
    case args.singleType of
        Common.SingleCombobox ->
            viewCombobox attrs args

        Common.SingleRadio ->
            R10.FormComponents.Single.Radio.viewRadio attrs args


viewCustom :
    List (Attribute msg)
    -- Shared.Args msg - without [toOptionEl, searchFn]
    ->
        { value : String
        , search : String
        , focused : Bool
        , scroll : Float
        , opened : Bool
        }
    ->
        { label : String
        , helperText : Maybe String
        , disabled : Bool
        , requiredLabel : Maybe String
        , key : String
        , style : R10.FormComponents.Style.Style
        , palette : R10.FormComponents.UI.Palette.Palette
        , singleType : Common.TypeSingle
        , fieldOptions : List Common.FieldOption
        , validation : R10.FormComponents.Validations.Validation
        , toMsg : Common.Msg -> msg
        , searchFn : String -> Common.FieldOption -> Bool
        , toOptionEl : Common.FieldOption -> Element msg
        , selectOptionHeight : Int
        , maxDisplayCount : Int
        , leadingIcon : Maybe (Element msg)
        , trailingIcon : Maybe (Element msg)
        }
    -> Element msg
viewCustom attrs model conf =
    let
        args :
            { active : Bool
            , disabled : Bool
            , fieldOptions : List Common.FieldOption
            , focused : Bool
            , helperText : Maybe String
            , key : String
            , label : String
            , leadingIcon : Maybe (Element msg)
            , maxDisplayCount : Int
            , msgNoOp : msg
            , msgOnArrowDown : String -> Float -> msg
            , msgOnArrowUp : String -> Float -> msg
            , msgOnEsc : msg
            , msgOnFocus : String -> msg
            , msgOnInputClick : Float -> msg
            , msgOnLoseFocus : String -> msg
            , msgOnOptionSelect : String -> msg
            , msgOnScroll : Float -> msg
            , msgOnSearch : String -> String -> msg
            , palette : R10.FormComponents.UI.Palette.Palette
            , requiredLabel : Maybe String
            , scroll : Float
            , search : String
            , searchFn : String -> Common.FieldOption -> Bool
            , selectOptionHeight : Int
            , singleType : Common.TypeSingle
            , style : R10.FormComponents.Style.Style
            , toOptionEl : Common.FieldOption -> Element msg
            , trailingIcon : Maybe (Element msg)
            , validation : R10.FormComponents.Validations.Validation
            , value : String
            }
        args =
            { value = model.value
            , search = model.search
            , focused = model.focused
            , scroll = model.scroll
            , active = model.opened
            , validation = conf.validation
            , msgNoOp = Common.NoOp |> conf.toMsg
            , msgOnFocus = Common.OnFocus >> conf.toMsg
            , msgOnLoseFocus = Common.OnLoseFocus >> conf.toMsg
            , msgOnScroll = Common.OnScroll >> conf.toMsg
            , msgOnSearch = \s1 s2 -> Common.OnSearch s1 s2 |> conf.toMsg
            , msgOnOptionSelect = Common.OnOptionSelect >> conf.toMsg
            , msgOnArrowUp = \s1 f1 -> Common.OnArrowUp s1 f1 |> conf.toMsg
            , msgOnArrowDown = \s1 f1 -> Common.OnArrowDown s1 f1 |> conf.toMsg
            , msgOnEsc = Common.OnEsc |> conf.toMsg
            , msgOnInputClick = Common.OnInputClick >> conf.toMsg
            , label = conf.label
            , helperText = conf.helperText
            , disabled = conf.disabled
            , requiredLabel = conf.requiredLabel
            , style = conf.style
            , key = conf.key
            , palette = conf.palette
            , singleType = conf.singleType
            , fieldOptions = conf.fieldOptions
            , searchFn = conf.searchFn
            , toOptionEl = conf.toOptionEl
            , selectOptionHeight = conf.selectOptionHeight
            , maxDisplayCount = conf.maxDisplayCount
            , leadingIcon = conf.leadingIcon
            , trailingIcon = conf.trailingIcon
            }
    in
    case args.singleType of
        Common.SingleCombobox ->
            viewCombobox attrs args

        Common.SingleRadio ->
            R10.FormComponents.Single.Radio.viewRadio attrs args
