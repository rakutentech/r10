module R10.FormComponents.Internal.Phone.Update exposing
    ( dropdownHingeHeight
    , getDropdownHeight
    , getMsgOnFlagClick
    , getMsgOnSearch
    , update
    )

import Browser.Dom
import List.Extra
import R10.Country exposing (Country)
import R10.FormComponents.Internal.Phone.Common as Common
import Task


dropdownHingeHeight : number
dropdownHingeHeight =
    10


onArrowHelper : Common.Model -> String -> Country -> Float -> ( Common.Model, Cmd Common.Msg )
onArrowHelper model key value float =
    ( { model | scroll = float, select = Just value }
    , Task.attempt
        (always Common.NoOp)
        (Browser.Dom.setViewportOf
            (Common.dropdownContentId key)
            0
            float
        )
    )


onOpenHelper : Common.Model -> String -> Float -> ( Common.Model, Cmd Common.Msg )
onOpenHelper model key float =
    ( { model
        | opened = True
        , scroll = float
      }
    , Task.attempt
        (always Common.NoOp)
        (Browser.Dom.setViewportOf
            (Common.dropdownContentId key)
            0
            float
        )
    )


focusSearchBoxCmd : String -> ( Common.Model, Cmd Common.Msg ) -> ( Common.Model, Cmd Common.Msg )
focusSearchBoxCmd key ( model, cmd ) =
    ( model
    , Cmd.batch
        [ cmd
        , Task.attempt
            (always Common.NoOp)
            (Browser.Dom.focus <| Common.dropdownSearchBoxId key)
        ]
    )


extractCountry : String -> Maybe Country
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


getOptionIndex : List Country -> Country -> Maybe Int
getOptionIndex fieldOptions value =
    fieldOptions
        |> List.Extra.findIndex (\country -> country == value)


getMsgOnFlagClick : { a | countryValue : Maybe Country, scroll : Float } -> { b | selectOptionHeight : Int, maxDisplayCount : Int, key : String } -> List Country -> Common.Msg
getMsgOnFlagClick model args filteredCountryOptions =
    let
        activeOptionIndex : Int
        activeOptionIndex =
            model.countryValue
                |> Maybe.andThen (getOptionIndex filteredCountryOptions)
                |> Maybe.withDefault -1

        activeOptionY : Float
        activeOptionY =
            getOptionY model.scroll args activeOptionIndex (List.length filteredCountryOptions)
    in
    Common.OnFlagClick args.key activeOptionY


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
        , countryOptions : List Country
    }
    -> (String -> Common.Msg)
getMsgOnSearch args newSearch =
    Common.OnSearch args.key
        { selectOptionHeight = args.selectOptionHeight
        , maxDisplayCount = args.maxDisplayCount
        , filteredCountryOptions = Common.filterBySearch newSearch args.countryOptions
        }
        newSearch


getNextNewSelectAndY :
    Common.Model
    -> { b | filteredCountryOptions : List Country, selectOptionHeight : Int, maxDisplayCount : Int }
    -> ( Country, Float )
getNextNewSelectAndY model args =
    getNewSelectAndY_ 1 0 R10.Country.listHead model args


getPrevNewSelectAndY :
    Common.Model
    -> { b | filteredCountryOptions : List Country, selectOptionHeight : Int, maxDisplayCount : Int }
    -> ( Country, Float )
getPrevNewSelectAndY model args =
    getNewSelectAndY_ -1 (List.length args.filteredCountryOptions - 1) R10.Country.listTail model args


getNewSelectAndY_ :
    Int
    -> Int
    -> Country
    -> Common.Model
    ->
        { b
            | filteredCountryOptions : List Country
            , selectOptionHeight : Int
            , maxDisplayCount : Int
        }
    -> ( Country, Float )
getNewSelectAndY_ step defaultIndex defaultCountry model args =
    let
        currentSelect : Maybe Country
        currentSelect =
            if model.select == Nothing then
                model.countryValue

            else
                model.select

        currentIndex : Maybe Int
        currentIndex =
            currentSelect
                |> Maybe.andThen (getOptionIndex args.filteredCountryOptions)

        newIndex : Int
        newIndex =
            currentIndex
                |> Maybe.map (\index -> index + step)
                |> Maybe.andThen (inboundIndex <| (List.length args.filteredCountryOptions - 1))
                |> Maybe.withDefault defaultIndex

        newSelect : Country
        newSelect =
            List.Extra.getAt newIndex args.filteredCountryOptions
                |> Maybe.withDefault defaultCountry

        newY : Float
        newY =
            getOptionY model.scroll args newIndex (List.length args.filteredCountryOptions)
    in
    ( newSelect, newY )


update : Common.Msg -> Common.Model -> ( Common.Model, Cmd Common.Msg )
update msg model =
    case msg of
        Common.NoOp ->
            ( model, Cmd.none )

        Common.OnValue newValue ->
            let
                hasCurrentCountryCode : Bool
                hasCurrentCountryCode =
                    case model.countryValue of
                        Just countryValue ->
                            newValue
                                |> String.replace " " ""
                                |> String.startsWith
                                    (countryValue |> R10.Country.toCountryTelCode)

                        Nothing ->
                            False

                newCountryValue : Maybe Country
                newCountryValue =
                    if hasCurrentCountryCode then
                        model.countryValue

                    else
                        let
                            codeFromVal =
                                newValue |> extractCountry
                        in
                        if codeFromVal /= Nothing then
                            codeFromVal

                        else
                            model.countryValue
            in
            ( { model | value = newValue, countryValue = newCountryValue }, Cmd.none )

        Common.OnSearch key args newSearch ->
            let
                isSelectInsideCountryOptions : Bool
                isSelectInsideCountryOptions =
                    model.select
                        |> Maybe.map (\s -> List.member s args.filteredCountryOptions)
                        |> Maybe.withDefault False

                newSelect : Maybe Country
                newSelect =
                    if isSelectInsideCountryOptions then
                        model.select

                    else
                        args.filteredCountryOptions |> List.head

                maybeNewIndex : Maybe Int
                maybeNewIndex =
                    newSelect |> Maybe.andThen (getOptionIndex args.filteredCountryOptions)

                newY : Float
                newY =
                    maybeNewIndex
                        |> Maybe.map (\newIndex -> getOptionY model.scroll args newIndex (List.length args.filteredCountryOptions))
                        |> Maybe.withDefault model.scroll
            in
            ( { model
                | search = newSearch
                , select = newSelect
                , scroll = newY
              }
            , Cmd.batch
                [ Task.attempt
                    (always Common.NoOp)
                    (Browser.Dom.setViewportOf
                        (Common.dropdownContentId key)
                        0
                        newY
                    )
                ]
            )

        Common.OnOptionSelect newCountry ->
            let
                newCode : String
                newCode =
                    newCountry
                        |> R10.Country.toCountryTelCode

                newValue : String
                newValue =
                    case model.countryValue of
                        Just oldCountry ->
                            let
                                oldCode : String
                                oldCode =
                                    R10.Country.toCountryTelCode oldCountry
                            in
                            model.value
                                |> String.replace " " ""
                                |> String.replace oldCode (newCode ++ " ")
                                |> String.replace "  " " "

                        Nothing ->
                            (newCode ++ " ") ++ model.value
            in
            ( { model
                | value = newValue
                , countryValue = Just newCountry
                , opened = False
                , select = Nothing
                , search = ""
              }
            , Cmd.none
            )

        Common.OnScroll scroll ->
            ( { model | scroll = scroll }, Cmd.none )

        Common.OnFlagClick key scroll ->
            if model.opened then
                ( { model | scroll = scroll, opened = False }, Cmd.none )

            else
                onOpenHelper model key scroll
                    |> focusSearchBoxCmd key

        Common.OnLoseFocus ->
            ( { model
                | focused = False
                , opened = False
              }
            , Cmd.none
            )

        Common.OnFocus ->
            ( { model
                | focused = True
              }
            , Cmd.none
            )

        Common.OnArrowUp key args ->
            -- skip arrow msg if dropdown is closed
            if model.opened then
                getPrevNewSelectAndY model args
                    |> (\( newValue, newY ) -> onArrowHelper model key newValue newY)

            else
                onOpenHelper model key model.scroll

        Common.OnArrowDown key args ->
            -- skip arrow msg if dropdown is closed
            if model.opened then
                getNextNewSelectAndY model args
                    |> (\( newValue, newY ) -> onArrowHelper model key newValue newY)

            else
                onOpenHelper model key model.scroll

        Common.OnEsc ->
            ( { model | search = "", opened = False }, Cmd.none )
