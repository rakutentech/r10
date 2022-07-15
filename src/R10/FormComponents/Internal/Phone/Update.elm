module R10.FormComponents.Internal.Phone.Update exposing
    ( dropdownHingeHeight
    , getDropdownHeight
    , getMsgOnInputClick
    , getMsgOnSearch
    , update
    )

import Browser.Dom
import List.Extra
import Process
import R10.Country
import R10.FormComponents.Internal.Phone.Common
import R10.Utils
import Task


dropdownHingeHeight : number
dropdownHingeHeight =
    10


onArrowHelper : R10.FormComponents.Internal.Phone.Common.Model -> String -> R10.Country.Country -> Float -> ( R10.FormComponents.Internal.Phone.Common.Model, Cmd R10.FormComponents.Internal.Phone.Common.Msg )
onArrowHelper model key country float =
    ( { model | scroll = float, select = R10.Country.toString country }
    , Task.attempt
        (always R10.FormComponents.Internal.Phone.Common.NoOp)
        (Browser.Dom.setViewportOf
            (R10.FormComponents.Internal.Phone.Common.dropdownContentId key)
            0
            float
        )
    )


onOpenHelper : R10.FormComponents.Internal.Phone.Common.Model -> String -> Float -> ( R10.FormComponents.Internal.Phone.Common.Model, Cmd R10.FormComponents.Internal.Phone.Common.Msg )
onOpenHelper model key float =
    ( { model
        | opened = True
        , scroll = float
      }
    , Task.attempt
        (always R10.FormComponents.Internal.Phone.Common.NoOp)
        (Browser.Dom.setViewportOf
            (R10.FormComponents.Internal.Phone.Common.dropdownContentId key)
            0
            float
        )
    )


focusSearchBoxCmd : String -> ( R10.FormComponents.Internal.Phone.Common.Model, Cmd R10.FormComponents.Internal.Phone.Common.Msg ) -> ( R10.FormComponents.Internal.Phone.Common.Model, Cmd R10.FormComponents.Internal.Phone.Common.Msg )
focusSearchBoxCmd key ( model, cmd ) =
    ( model
    , Cmd.batch
        [ cmd
        , Task.attempt
            (always R10.FormComponents.Internal.Phone.Common.NoOp)
            (Browser.Dom.focus <| R10.FormComponents.Internal.Phone.Common.dropdownSearchBoxId key)
        ]
    )


extractCountry : String -> Maybe R10.Country.Country
extractCountry untrimmedString =
    let
        str =
            String.replace " " "" untrimmedString
    in
    if String.startsWith "+" str then
        List.range 2 7
            |> List.reverse
            |> List.map (\i -> String.left i str)
            |> List.map R10.Country.fromCountryTelCode
            |> List.filterMap identity
            |> List.head

    else
        Nothing


{-| get Y position of option element, relative to dropdown
used for virtual scrolling
-}
getOptionY : Float -> { a | selectOptionHeight : Int, maxDisplayCount : Int } -> Int -> Int -> Float
getOptionY scroll args optionIndex optionsCount =
    if optionIndex == -1 then
        -- no selection
        scroll

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
                { top = scroll
                , bottom = scroll + (toFloat <| getDropdownHeight args optionsCount)
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
            scroll


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


getOptionIndex : List R10.Country.Country -> R10.Country.Country -> Maybe Int
getOptionIndex fieldOptions value =
    fieldOptions
        |> List.Extra.findIndex (\country -> country == value)


getMsgOnInputClick : { a | scroll : Float, value : String } -> { b | selectOptionHeight : Int, maxDisplayCount : Int, key : String } -> List R10.Country.Country -> R10.FormComponents.Internal.Phone.Common.Msg
getMsgOnInputClick model args filteredFieldOption =
    let
        maybeCountryValue : Maybe R10.Country.Country
        maybeCountryValue =
            R10.Country.fromTelephoneAsString model.value

        activeOptionIndex : Int
        activeOptionIndex =
            maybeCountryValue
                |> Maybe.andThen (getOptionIndex filteredFieldOption)
                |> Maybe.withDefault -1

        activeOptionY : Float
        activeOptionY =
            getOptionY model.scroll args activeOptionIndex (List.length filteredFieldOption)
    in
    R10.FormComponents.Internal.Phone.Common.OnInputClick { key = args.key, selectedY = activeOptionY }


inboundIndex : number -> number -> Maybe number
inboundIndex maxIdx idx =
    if idx < 0 || idx > maxIdx then
        Nothing

    else
        Just idx


getMsgOnSearch :
    { a
        | key : String
        , selectOptionHeight : Int
        , maxDisplayCount : Int
        , countryOptions : List R10.Country.Country
    }
    -> (String -> R10.FormComponents.Internal.Phone.Common.Msg)
getMsgOnSearch args newSearch =
    R10.FormComponents.Internal.Phone.Common.OnSearch
        { key = args.key
        , selectOptionHeight = args.selectOptionHeight
        , maxDisplayCount = args.maxDisplayCount
        , filteredFieldOption = R10.FormComponents.Internal.Phone.Common.filterBySearch newSearch args.countryOptions
        }
        newSearch


getNextNewSelectAndY :
    R10.FormComponents.Internal.Phone.Common.Model
    -> { b | filteredFieldOption : List R10.Country.Country, selectOptionHeight : Int, maxDisplayCount : Int }
    -> ( R10.Country.Country, Float )
getNextNewSelectAndY model args =
    getNewSelectAndY_ 1 0 R10.Country.listHead model args


getPrevNewSelectAndY :
    R10.FormComponents.Internal.Phone.Common.Model
    -> { b | filteredFieldOption : List R10.Country.Country, selectOptionHeight : Int, maxDisplayCount : Int }
    -> ( R10.Country.Country, Float )
getPrevNewSelectAndY model args =
    getNewSelectAndY_ -1 (List.length args.filteredFieldOption - 1) R10.Country.listTail model args


getNewSelectAndY_ :
    Int
    -> Int
    -> R10.Country.Country
    -> R10.FormComponents.Internal.Phone.Common.Model
    ->
        { b
            | filteredFieldOption : List R10.Country.Country
            , selectOptionHeight : Int
            , maxDisplayCount : Int
        }
    -> ( R10.Country.Country, Float )
getNewSelectAndY_ step defaultIndex defaultCountry model args =
    let
        maybeCountryValue : Maybe R10.Country.Country
        maybeCountryValue =
            R10.Country.fromTelephoneAsString model.value

        currentSelect : Maybe R10.Country.Country
        currentSelect =
            case R10.Country.fromString model.select of
                Nothing ->
                    maybeCountryValue

                Just country ->
                    Just country

        currentIndex : Maybe Int
        currentIndex =
            currentSelect
                |> Maybe.andThen (getOptionIndex args.filteredFieldOption)

        newIndex : Int
        newIndex =
            currentIndex
                |> Maybe.map (\index -> index + step)
                |> Maybe.andThen (inboundIndex <| (List.length args.filteredFieldOption - 1))
                |> Maybe.withDefault defaultIndex

        newSelect : R10.Country.Country
        newSelect =
            List.Extra.getAt newIndex args.filteredFieldOption
                |> Maybe.withDefault defaultCountry

        newY : Float
        newY =
            getOptionY model.scroll args newIndex (List.length args.filteredFieldOption)
    in
    ( newSelect, newY )


cleanPhoneNumber : String -> String
cleanPhoneNumber phone =
    R10.Utils.userReplace "[^0-9 \\-\\(\\).]" (\_ -> "") phone


helperFocusField : String -> Cmd R10.FormComponents.Internal.Phone.Common.Msg
helperFocusField id =
    Task.attempt (\_ -> R10.FormComponents.Internal.Phone.Common.NoOp)
        (Process.sleep 500
            |> Task.andThen (\_ -> Browser.Dom.focus id)
        )


update : R10.FormComponents.Internal.Phone.Common.Msg -> R10.FormComponents.Internal.Phone.Common.Model -> ( R10.FormComponents.Internal.Phone.Common.Model, Cmd R10.FormComponents.Internal.Phone.Common.Msg )
update msg model =
    case msg of
        R10.FormComponents.Internal.Phone.Common.NoOp ->
            ( model, Cmd.none )

        R10.FormComponents.Internal.Phone.Common.OnFocus value ->
            ( { model | focused = True, value = value, opened = False }, Cmd.none )

        R10.FormComponents.Internal.Phone.Common.OnLoseFocus value ->
            ( { model | focused = False, opened = False, value = value, select = "", search = "" }, Cmd.none )

        R10.FormComponents.Internal.Phone.Common.OnScroll scroll ->
            ( { model | scroll = scroll }, Cmd.none )

        R10.FormComponents.Internal.Phone.Common.OnEsc key needFocusToInput ->
            ( { model | search = "", opened = False }
            , if needFocusToInput then
                helperFocusField <| R10.FormComponents.Internal.Phone.Common.inputPhoneElementId key

              else
                Cmd.none
            )

        --
        --
        --
        --
        R10.FormComponents.Internal.Phone.Common.OnValueChange key args newValue_ ->
            let
                maybeCountryValue : Maybe R10.Country.Country
                maybeCountryValue =
                    R10.Country.fromTelephoneAsString model.value

                newValue : String
                newValue =
                    -- Here we add the country code because this is how it
                    -- was working before
                    maybeCountryValue
                        |> Maybe.map R10.Country.toCountryTelCode
                        |> Maybe.withDefault ""
                        |> (\v -> v ++ cleanPhoneNumber newValue_)

                hasCurrentCountryCode : Bool
                hasCurrentCountryCode =
                    case maybeCountryValue of
                        Just countryValue ->
                            newValue
                                |> String.replace " " ""
                                |> String.startsWith
                                    (countryValue |> R10.Country.toCountryTelCode)

                        Nothing ->
                            False

                newCountryValue : Maybe R10.Country.Country
                newCountryValue =
                    if hasCurrentCountryCode then
                        maybeCountryValue

                    else
                        let
                            codeFromVal =
                                newValue |> extractCountry
                        in
                        if codeFromVal /= Nothing then
                            codeFromVal

                        else
                            maybeCountryValue

                newY : Float
                newY =
                    if newCountryValue == maybeCountryValue then
                        model.scroll

                    else
                        newCountryValue
                            |> Maybe.andThen (getOptionIndex args.filteredFieldOption)
                            |> Maybe.map (\newIndex -> getOptionY model.scroll args newIndex (List.length args.filteredFieldOption))
                            |> Maybe.withDefault model.scroll
            in
            ( { model
                | value = newValue
                , scroll = newY
              }
            , Task.attempt
                (always R10.FormComponents.Internal.Phone.Common.NoOp)
                (Browser.Dom.setViewportOf
                    (R10.FormComponents.Internal.Phone.Common.dropdownContentId key)
                    0
                    newY
                )
            )

        R10.FormComponents.Internal.Phone.Common.OnSearch args newSearch ->
            let
                isSelectInsideCountryOptions : Bool
                isSelectInsideCountryOptions =
                    model.select
                        |> R10.Country.fromString
                        |> Maybe.map (\s -> List.member s args.filteredFieldOption)
                        |> Maybe.withDefault False

                newSelect : Maybe R10.Country.Country
                newSelect =
                    if isSelectInsideCountryOptions then
                        model.select
                            |> R10.Country.fromString

                    else
                        args.filteredFieldOption
                            |> List.head

                maybeNewIndex : Maybe Int
                maybeNewIndex =
                    newSelect |> Maybe.andThen (getOptionIndex args.filteredFieldOption)

                newY : Float
                newY =
                    maybeNewIndex
                        |> Maybe.map (\newIndex -> getOptionY model.scroll args newIndex (List.length args.filteredFieldOption))
                        |> Maybe.withDefault model.scroll
            in
            ( { model
                | search = newSearch
                , select = Maybe.withDefault "" (Maybe.map R10.Country.toString newSelect)
                , scroll = newY
              }
            , Cmd.batch
                [ Task.attempt
                    (always R10.FormComponents.Internal.Phone.Common.NoOp)
                    (Browser.Dom.setViewportOf
                        (R10.FormComponents.Internal.Phone.Common.dropdownContentId args.key)
                        0
                        newY
                    )
                ]
            )

        R10.FormComponents.Internal.Phone.Common.OnOptionSelect key newCountry ->
            let
                newCode : String
                newCode =
                    newCountry
                        |> R10.Country.toCountryTelCode

                maybeCountryValue : Maybe R10.Country.Country
                maybeCountryValue =
                    R10.Country.fromTelephoneAsString model.value

                newValue : String
                newValue =
                    case maybeCountryValue of
                        Just oldCountry ->
                            let
                                oldCode : String
                                oldCode =
                                    R10.Country.toCountryTelCode oldCountry
                            in
                            model.value
                                |> String.replace " " ""
                                |> String.replace oldCode newCode
                                |> String.replace "  " " "

                        Nothing ->
                            (newCode ++ " ") ++ model.value
            in
            ( { model
                | value = newValue
                , opened = False
                , select = ""
                , search = ""
              }
            , helperFocusField <| R10.FormComponents.Internal.Phone.Common.inputPhoneElementId key
            )

        R10.FormComponents.Internal.Phone.Common.OnInputClick args ->
            if model.opened then
                ( { model | scroll = args.selectedY, opened = False }, Cmd.none )

            else
                onOpenHelper model args.key args.selectedY
                    |> focusSearchBoxCmd args.key

        R10.FormComponents.Internal.Phone.Common.OnArrowUp args ->
            -- skip arrow msg if dropdown is closed
            if model.opened then
                getPrevNewSelectAndY model args
                    |> (\( newValue, newY ) -> onArrowHelper model args.key newValue newY)

            else
                onOpenHelper model args.key model.scroll

        R10.FormComponents.Internal.Phone.Common.OnArrowDown args ->
            -- skip arrow msg if dropdown is closed
            if model.opened then
                getNextNewSelectAndY model args
                    |> (\( newValue, newY ) -> onArrowHelper model args.key newValue newY)

            else
                onOpenHelper model args.key model.scroll
                    |> focusSearchBoxCmd args.key

        R10.FormComponents.Internal.Phone.Common.OnSimpleValueChange disabledChangeCountry value ->
            let
                maybeCountryValue : Maybe R10.Country.Country
                maybeCountryValue =
                    R10.Country.fromTelephoneAsString model.value

                countryTelCode : String
                countryTelCode =
                    Maybe.map R10.Country.toCountryTelCode maybeCountryValue
                        |> Maybe.withDefault ""

                newValue : String
                newValue =
                    if disabledChangeCountry && model.value == countryTelCode && (String.length model.value > String.length value) then
                        model.value

                    else
                        "+" ++ cleanPhoneNumber value
            in
            ( { model | value = newValue }, Cmd.none )
