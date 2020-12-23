module R10.FormComponents.Internal.Single.Update exposing
    ( dropdownHingeHeight
    , getDropdownHeight
    , getMsgOnSearch
    , getOptionIndex
    , getOptionY
    , update
    )

import Browser.Dom
import List.Extra
import R10.FormComponents.Internal.Single.Common as Common
import Task


dropdownHingeHeight : number
dropdownHingeHeight =
    10


onArrowHelper : String -> Common.Model -> String -> Float -> ( Common.Model, Cmd Common.Msg )
onArrowHelper key model value float =
    ( { model | scroll = float, select = value }
    , Task.attempt
        (always Common.NoOp)
        (Browser.Dom.setViewportOf
            (Common.dropdownContentId key)
            0
            float
        )
    )


onOpenHelper : String -> Common.Model -> Float -> ( Common.Model, Cmd Common.Msg )
onOpenHelper key model float =
    ( { model
        | opened = True
        , scroll = float
      }
    , Cmd.batch
        [ Task.attempt
            (always Common.NoOp)
            (Browser.Dom.setViewportOf
                (Common.dropdownContentId key)
                0
                float
            )
        , Task.attempt
            (always Common.NoOp)
            (Browser.Dom.focus <| Common.singleSearchBoxId key)
        ]
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


getMsgOnSearch :
    { a
        | key : String
        , selectOptionHeight : Int
        , maxDisplayCount : Int
        , searchFn : String -> Common.FieldOption -> Bool
        , fieldOptions : List Common.FieldOption
    }
    -> String
    -> Common.Msg
getMsgOnSearch args newSearch =
    Common.OnSearch
        { key = args.key
        , selectOptionHeight = args.selectOptionHeight
        , maxDisplayCount = args.maxDisplayCount
        , filteredFieldOption = Common.filterBySearch newSearch args
        }
        newSearch


getOptionIndex : List { a | value : String } -> String -> Maybe Int
getOptionIndex filteredOptions value =
    filteredOptions
        |> List.Extra.findIndex (.value >> (==) value)


inboundIndex : number -> number -> Maybe number
inboundIndex maxIdx idx =
    if idx < 0 || idx > maxIdx then
        Nothing

    else
        Just idx


getNextNewSelectAndY : Common.Model -> { b | filteredFieldOption : List Common.FieldOption, selectOptionHeight : Int, maxDisplayCount : Int } -> ( String, Float )
getNextNewSelectAndY model args =
    getNewSelectAndY_ 1 0 model args


getPrevNewSelectAndY : Common.Model -> { b | filteredFieldOption : List Common.FieldOption, selectOptionHeight : Int, maxDisplayCount : Int } -> ( String, Float )
getPrevNewSelectAndY model args =
    getNewSelectAndY_ -1 (List.length args.filteredFieldOption - 1) model args


getNewSelectAndY_ : Int -> Int -> Common.Model -> { b | filteredFieldOption : List Common.FieldOption, selectOptionHeight : Int, maxDisplayCount : Int } -> ( String, Float )
getNewSelectAndY_ step default model args =
    let
        select : String
        select =
            if String.isEmpty model.select then
                model.value

            else
                model.select

        newIndex : Int
        newIndex =
            getOptionIndex args.filteredFieldOption select
                |> Maybe.map (\index -> index + step)
                |> Maybe.andThen (inboundIndex <| (List.length args.filteredFieldOption - 1))
                |> Maybe.withDefault default

        newValue : String
        newValue =
            List.Extra.getAt newIndex args.filteredFieldOption
                |> Maybe.map .value
                |> Maybe.withDefault ""

        newY : Float
        newY =
            getOptionY model.scroll args newIndex (List.length args.filteredFieldOption)
    in
    ( newValue, newY )


update : Common.Msg -> Common.Model -> ( Common.Model, Cmd Common.Msg )
update msg model =
    case msg of
        Common.NoOp ->
            ( model, Cmd.none )

        Common.OnSearch args newSearch ->
            let
                isSelectInsideCountryOptions : Bool
                isSelectInsideCountryOptions =
                    args.filteredFieldOption
                        |> List.any (.value >> (==) model.select)

                newSelect : String
                newSelect =
                    if isSelectInsideCountryOptions then
                        model.select

                    else
                        args.filteredFieldOption |> List.head |> Maybe.map .value |> Maybe.withDefault ""

                maybeNewIndex : Maybe Int
                maybeNewIndex =
                    newSelect
                        |> getOptionIndex args.filteredFieldOption

                newY : Float
                newY =
                    maybeNewIndex
                        |> Maybe.map (\newIndex -> getOptionY model.scroll args newIndex (List.length args.filteredFieldOption))
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
                        (Common.dropdownContentId args.key)
                        0
                        newY
                    )
                ]
            )

        Common.OnOptionSelect value ->
            ( { model | value = value, opened = False, select = "", search = "" }, Cmd.none )

        Common.OnScroll scroll ->
            ( { model | scroll = scroll }, Cmd.none )

        Common.OnInputClick args ->
            if model.opened then
                ( { model | scroll = args.selectedY, opened = False }, Cmd.none )

            else
                onOpenHelper args.key model args.selectedY

        Common.OnLoseFocus value ->
            ( { model | focused = False, opened = False, value = value, select = "", search = "" }, Cmd.none )

        Common.OnFocus value ->
            ( { model | focused = True, value = value }, Cmd.none )

        Common.OnArrowUp args ->
            if model.opened then
                getPrevNewSelectAndY model args
                    |> (\( newValue, newY ) -> onArrowHelper args.key model newValue newY)

            else
                onOpenHelper args.key model model.scroll

        Common.OnArrowDown args ->
            if model.opened then
                getNextNewSelectAndY model args
                    |> (\( newValue, newY ) -> onArrowHelper args.key model newValue newY)

            else
                onOpenHelper args.key model model.scroll

        Common.OnEsc ->
            ( { model | search = "", opened = False }, Cmd.none )
