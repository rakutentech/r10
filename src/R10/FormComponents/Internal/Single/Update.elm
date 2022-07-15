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
import R10.FormComponents.Internal.Single.Common
import Task


dropdownHingeHeight : number
dropdownHingeHeight =
    10


onArrowHelper : String -> R10.FormComponents.Internal.Single.Common.Model -> String -> Float -> ( R10.FormComponents.Internal.Single.Common.Model, Cmd R10.FormComponents.Internal.Single.Common.Msg )
onArrowHelper key model value float =
    ( { model | scroll = float, select = value }
    , Task.attempt
        (always R10.FormComponents.Internal.Single.Common.NoOp)
        (Browser.Dom.setViewportOf
            (R10.FormComponents.Internal.Single.Common.dropdownContentId key)
            0
            float
        )
    )


onOpenHelper : String -> R10.FormComponents.Internal.Single.Common.Model -> Float -> ( R10.FormComponents.Internal.Single.Common.Model, Cmd R10.FormComponents.Internal.Single.Common.Msg )
onOpenHelper key model float =
    ( { model
        | opened = True
        , scroll = float
      }
    , Cmd.batch
        [ Task.attempt
            (always R10.FormComponents.Internal.Single.Common.NoOp)
            (Browser.Dom.setViewportOf
                (R10.FormComponents.Internal.Single.Common.dropdownContentId key)
                0
                float
            )
        , Task.attempt
            (always R10.FormComponents.Internal.Single.Common.NoOp)
            (Browser.Dom.focus <| R10.FormComponents.Internal.Single.Common.singleSearchBoxId key)
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
        , searchFn : String -> R10.FormComponents.Internal.Single.Common.FieldOption -> Bool
        , fieldOptions : List R10.FormComponents.Internal.Single.Common.FieldOption
    }
    -> String
    -> R10.FormComponents.Internal.Single.Common.Msg
getMsgOnSearch args newSearch =
    R10.FormComponents.Internal.Single.Common.OnSearch
        { key = args.key
        , selectOptionHeight = args.selectOptionHeight
        , maxDisplayCount = args.maxDisplayCount
        , filteredFieldOption = R10.FormComponents.Internal.Single.Common.filterBySearch newSearch args
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


getNextNewSelectAndY : R10.FormComponents.Internal.Single.Common.Model -> { b | filteredFieldOption : List R10.FormComponents.Internal.Single.Common.FieldOption, selectOptionHeight : Int, maxDisplayCount : Int } -> ( String, Float )
getNextNewSelectAndY model args =
    getNewSelectAndY_ 1 0 model args


getPrevNewSelectAndY : R10.FormComponents.Internal.Single.Common.Model -> { b | filteredFieldOption : List R10.FormComponents.Internal.Single.Common.FieldOption, selectOptionHeight : Int, maxDisplayCount : Int } -> ( String, Float )
getPrevNewSelectAndY model args =
    getNewSelectAndY_ -1 (List.length args.filteredFieldOption - 1) model args


getNewSelectAndY_ : Int -> Int -> R10.FormComponents.Internal.Single.Common.Model -> { b | filteredFieldOption : List R10.FormComponents.Internal.Single.Common.FieldOption, selectOptionHeight : Int, maxDisplayCount : Int } -> ( String, Float )
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


update : R10.FormComponents.Internal.Single.Common.Msg -> R10.FormComponents.Internal.Single.Common.Model -> ( R10.FormComponents.Internal.Single.Common.Model, Cmd R10.FormComponents.Internal.Single.Common.Msg )
update msg model =
    case msg of
        R10.FormComponents.Internal.Single.Common.NoOp ->
            ( model, Cmd.none )

        R10.FormComponents.Internal.Single.Common.OnFocus ->
            ( { model | focused = True }, Cmd.none )

        R10.FormComponents.Internal.Single.Common.OnLoseFocus value ->
            ( { model | focused = False, opened = False, value = value, select = "", search = "" }, Cmd.none )

        R10.FormComponents.Internal.Single.Common.OnScroll scroll ->
            ( { model | scroll = scroll }, Cmd.none )

        R10.FormComponents.Internal.Single.Common.OnEsc ->
            ( { model | search = "", opened = False }, Cmd.none )

        --
        --
        --
        --
        R10.FormComponents.Internal.Single.Common.OnSearch args newSearch ->
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
                    newSelect |> getOptionIndex args.filteredFieldOption

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
                    (always R10.FormComponents.Internal.Single.Common.NoOp)
                    (Browser.Dom.setViewportOf
                        (R10.FormComponents.Internal.Single.Common.dropdownContentId args.key)
                        0
                        newY
                    )
                ]
            )

        R10.FormComponents.Internal.Single.Common.Hover over ->
            ( { model | over = over }, Cmd.none )

        R10.FormComponents.Internal.Single.Common.OnOptionSelect value ->
            ( { model | value = value, opened = False, select = "", search = "" }, Cmd.none )

        R10.FormComponents.Internal.Single.Common.OnInputClick args ->
            if model.opened then
                ( { model | scroll = args.selectedY, opened = False }, Cmd.none )

            else
                onOpenHelper args.key model args.selectedY

        R10.FormComponents.Internal.Single.Common.OnArrowUp args ->
            -- skip arrow msg if dropdown is closed
            if model.opened then
                getPrevNewSelectAndY model args
                    |> (\( newValue, newY ) -> onArrowHelper args.key model newValue newY)

            else
                onOpenHelper args.key model model.scroll

        R10.FormComponents.Internal.Single.Common.OnArrowDown args ->
            -- skip arrow msg if dropdown is closed
            if model.opened then
                getNextNewSelectAndY model args
                    |> (\( newValue, newY ) -> onArrowHelper args.key model newValue newY)

            else
                onOpenHelper args.key model model.scroll

        R10.FormComponents.Internal.Single.Common.OnDelBackspace ->
            ( { model | value = "" }, Cmd.none )
