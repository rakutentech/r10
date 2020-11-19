module R10.FormComponents.Phone.Update exposing (..)

import Browser.Dom
import R10.FormComponents.Phone.Common as Common
import R10.FormComponents.Phone.Country exposing (Country)
import List.Extra
import Regex
import Set
import Task
import Time


notLettersRegex : Regex.Regex
notLettersRegex =
    Regex.fromString "[^a-zA-Z]"
        |> Maybe.withDefault Regex.never


searchTargetLength : Int
searchTargetLength =
    8


searchCleanThreshold : Int
searchCleanThreshold =
    1600


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


getOptionByLabel : List Common.FieldOption -> String -> Maybe Common.FieldOption
getOptionByLabel fieldOptions targetLabel =
    fieldOptions
        |> List.Extra.find (\opt -> opt.label == targetLabel)


{-| Compose search string:
Emit button + time.
If time since last press > 2 sec: create new search string
If less, append to existing search

-- select

-}
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
            |> List.map R10.FormComponents.Phone.Country.fromCountryCode
            |> List.filterMap identity
            |> List.head

    else
        Nothing


{-| helper to breakup search to time and value components
-}
breakupSearch : String -> ( Maybe Int, String )
breakupSearch search =
    let
        lastUpdateTime =
            search
                |> String.left searchTargetLength
                |> String.toInt

        searchValue =
            search
                |> String.dropLeft searchTargetLength
    in
    ( lastUpdateTime, searchValue )


{-| helper to compose new search from update time and new value
-}
composeSearch : Int -> String -> String
composeSearch time search =
    let
        newSearchPrefix =
            time
                |> String.fromInt
                |> String.padLeft searchTargetLength '0'
    in
    newSearchPrefix ++ search


normalizeString : String -> String
normalizeString =
    -- use for filtering, search <-> label comparison
    String.toLower >> String.trim


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


getMsgOnFlagClick : { a | value : String, scroll : Float } -> { b | selectOptionHeight : Int, maxDisplayCount : Int, key : String } -> List Country -> Common.Msg
getMsgOnFlagClick model args countryOptions =
    let
        activeOptionIndex : Int
        activeOptionIndex =
            extractCountry model.value
                |> Maybe.andThen (getOptionIndex countryOptions)
                |> Maybe.withDefault -1

        activeOptionY : Float
        activeOptionY =
            getOptionY model.scroll args activeOptionIndex (List.length countryOptions)
    in
    Common.OnFlagClick args.key activeOptionY


inboundIndex : number -> number -> Maybe number
inboundIndex maxIdx idx =
    if idx < 0 || idx > maxIdx then
        Nothing

    else
        Just idx


getNextNewSelectAndY :
    Common.Model
    -> { b | countryOptions : List Country, selectOptionHeight : Int, maxDisplayCount : Int }
    -> ( Country, Float )
getNextNewSelectAndY model args =
    getNewSelectAndY_ 1 0 R10.FormComponents.Phone.Country.listHead model args


getPrevNewSelectAndY :
    Common.Model
    -> { b | countryOptions : List Country, selectOptionHeight : Int, maxDisplayCount : Int }
    -> ( Country, Float )
getPrevNewSelectAndY model args =
    getNewSelectAndY_ -1 (List.length args.countryOptions - 1) R10.FormComponents.Phone.Country.listTail model args


getNewSelectAndY_ :
    Int
    -> Int
    -> Country
    -> Common.Model
    ->
        { b
            | countryOptions : List Country
            , selectOptionHeight : Int
            , maxDisplayCount : Int
        }
    -> ( Country, Float )
getNewSelectAndY_ step defaultIndex defaultCountry model args =
    let
        currentSelect : Maybe Country
        currentSelect =
            if model.select == Nothing then
                model.value |> extractCountry

            else
                model.select

        currentIndex : Maybe Int
        currentIndex =
            currentSelect
                |> Maybe.andThen (getOptionIndex args.countryOptions)

        newIndex : Int
        newIndex =
            currentIndex
                |> Maybe.map (\index -> index + step)
                |> Maybe.andThen (inboundIndex <| (List.length args.countryOptions - 1))
                |> Maybe.withDefault defaultIndex

        newSelect : Country
        newSelect =
            List.Extra.getAt newIndex args.countryOptions
                |> Maybe.withDefault defaultCountry

        newY : Float
        newY =
            getOptionY model.scroll args newIndex (List.length args.countryOptions)
    in
    ( newSelect, newY )


update : Common.Msg -> Common.Model -> ( Common.Model, Cmd Common.Msg )
update msg model =
    case msg of
        Common.NoOp ->
            ( model, Cmd.none )

        Common.OnSearchTime key args newUnfilteredSearchValue time ->
            let
                newSearchChars =
                    String.dropLeft (String.length model.value) newUnfilteredSearchValue
                        |> Regex.replace notLettersRegex (always "")
            in
            if String.isEmpty newSearchChars then
                ( model, Cmd.none )

            else
                let
                    newMills =
                        Time.posixToMillis time
                            -- shorten int to target length
                            |> modBy (10 ^ searchTargetLength)

                    ( maybeOldMills, oldSearch ) =
                        breakupSearch model.search

                    newSearch =
                        case maybeOldMills of
                            Just oldMills ->
                                if abs (oldMills - newMills) > searchCleanThreshold then
                                    newSearchChars

                                else
                                    oldSearch ++ newSearchChars

                            Nothing ->
                                newSearchChars

                    newSelect : Maybe Country
                    newSelect =
                        if String.isEmpty newSearch then
                            Nothing

                        else
                            case
                                args.countryOptions
                                    |> List.map (\country -> ( country, country |> R10.FormComponents.Phone.Country.toString |> normalizeString ))
                                    |> List.Extra.find (Tuple.second >> String.startsWith (normalizeString newSearch))
                                    |> Maybe.map Tuple.first
                            of
                                Just country ->
                                    Just country

                                Nothing ->
                                    model.select

                    maybeNewIndex : Maybe Int
                    maybeNewIndex =
                        newSelect |> Maybe.andThen (getOptionIndex args.countryOptions)

                    newY : Float
                    newY =
                        maybeNewIndex
                            |> Maybe.map (\newIndex -> getOptionY model.scroll args newIndex (List.length args.countryOptions))
                            |> Maybe.withDefault model.scroll

                    -- todo : Scroll to the new selection
                    newModel =
                        { model
                            | search = composeSearch newMills newSearch
                            , select = newSelect
                        }
                in
                onOpenHelper newModel key newY

        Common.OnSearch key countryOptions search ->
            if model.opened then
                ( model, Task.perform (Common.OnSearchTime key countryOptions search) Time.now )

            else
                ( { model | value = search }, Cmd.none )

        Common.OnOptionSelect newCountry ->
            let
                maybeOldCountry : Maybe Country
                maybeOldCountry =
                    extractCountry model.value

                newCode : String
                newCode =
                    newCountry
                        |> R10.FormComponents.Phone.Country.toCountryCode

                newValue : String
                newValue =
                    case maybeOldCountry of
                        Just oldCountry ->
                            let
                                oldCode : String
                                oldCode =
                                    R10.FormComponents.Phone.Country.toCountryCode oldCountry
                            in
                            model.value
                                |> String.replace " " ""
                                |> String.replace oldCode (newCode ++ " ")
                                |> String.replace "  " " "

                        Nothing ->
                            (newCode ++ " ") ++ model.value
            in
            ( { model | value = newValue, opened = False, select = Nothing, search = "" }, Cmd.none )

        Common.OnScroll scroll ->
            ( { model | scroll = scroll }, Cmd.none )

        Common.OnFlagClick key scroll ->
            if model.opened then
                ( { model | scroll = scroll, opened = False }, Cmd.none )

            else
                let
                    ( newModel, cmd ) =
                        onOpenHelper model key scroll

                    inputId =
                        Common.selectId key
                in
                ( newModel
                , Cmd.batch
                    [ cmd
                    , Task.attempt (always Common.NoOp) <| Browser.Dom.focus inputId
                    ]
                )

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
                ( model, Cmd.none )

        Common.OnArrowDown key args ->
            -- skip arrow msg if dropdown is closed
            if model.opened then
                getNextNewSelectAndY model args
                    |> (\( newValue, newY ) -> onArrowHelper model key newValue newY)

            else
                ( model, Cmd.none )

        Common.OnEsc ->
            ( { model | search = "", opened = False }, Cmd.none )
