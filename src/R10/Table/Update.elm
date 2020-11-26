module R10.Table.Update exposing (update)

import Dict
import R10.Form
import R10.Form.Msg
import R10.FormComponents.Single.Common
import R10.Table.Msg
import R10.Table.State
import R10.Table.Types


isPopupOpen : R10.Table.State.FiltersStateRecord -> String -> Bool
isPopupOpen filters key =
    case filters.filterEditor of
        Just ( str, _ ) ->
            key == str

        Nothing ->
            False


getFilterKey : R10.Table.Types.Filter -> String
getFilterKey filterType =
    case filterType of
        R10.Table.Types.FilterText { key } ->
            key

        R10.Table.Types.FilterSelect { key } ->
            key


getFilterLabel : R10.Table.Types.Filter -> String
getFilterLabel filterType =
    case filterType of
        R10.Table.Types.FilterText { label } ->
            label

        R10.Table.Types.FilterSelect { label } ->
            label


getFilterValue : R10.Table.Types.Filter -> R10.Table.State.FiltersStateRecord -> Maybe String
getFilterValue filterType filtersState =
    Dict.get (getFilterKey filterType) filtersState.filterValues


fieldConfigInit : R10.Form.FieldConf
fieldConfigInit =
    R10.Form.initFieldConf


formStateInit : R10.Form.State
formStateInit =
    R10.Form.initState


fieldStateInit : R10.Form.FieldState
fieldStateInit =
    R10.Form.initFieldState


buildFormModel : R10.Table.Types.Filter -> Maybe String -> R10.Form.Form
buildFormModel filter defaultValue =
    let
        extra : { type_ : R10.Form.FieldType }
        extra =
            case filter of
                R10.Table.Types.FilterText { label, key } ->
                    { type_ = R10.Form.fieldType.text R10.Form.text.plain
                    }

                R10.Table.Types.FilterSelect { options } ->
                    { type_ = R10.Form.fieldType.single R10.Form.single.combobox options
                    }
    in
    { conf =
        [ R10.Form.entity.field
            { fieldConfigInit
                | type_ = extra.type_
                , label = getFilterLabel filter
                , id = getFilterKey filter
            }
        ]
    , state =
        { formStateInit
            | fieldsState =
                Dict.singleton (getFilterKey filter)
                    { fieldStateInit
                        | value = Maybe.withDefault "" defaultValue
                    }
        }
    }


getFormFieldValue : String -> R10.Form.State -> Maybe String
getFormFieldValue key formModel =
    Dict.get key formModel.fieldsState
        |> Maybe.map .value


justUpdateForm : R10.Form.Msg.Msg -> R10.Table.State.FiltersStateRecord -> ( R10.Table.State.FiltersStateRecord, Cmd R10.Table.Msg.Msg )
justUpdateForm formMsg filtersState =
    case filtersState.filterEditor of
        Nothing ->
            ( filtersState, Cmd.none )

        Just ( key, form ) ->
            let
                ( newFormState_, formCmd ) =
                    R10.Form.update formMsg form.state
            in
            ( { filtersState
                | filterEditor =
                    Just ( key, { form | state = newFormState_ } )
              }
            , Cmd.map R10.Table.Msg.FiltersPopupFormMsg formCmd
            )


updateFilterValuesAndCloseForm : R10.Table.State.FiltersStateRecord -> R10.Table.State.FiltersStateRecord
updateFilterValuesAndCloseForm filtersState =
    case filtersState.filterEditor of
        Nothing ->
            filtersState

        Just ( key, formModel ) ->
            let
                newValue : String
                newValue =
                    getFormFieldValue key formModel.state
                        -- should never accrue
                        |> Maybe.withDefault ""
            in
            { filtersState
                | filterEditor = Nothing
                , filterValues =
                    if String.isEmpty newValue then
                        Dict.remove key filtersState.filterValues

                    else
                        Dict.insert key newValue filtersState.filterValues
            }


update : R10.Table.Msg.Msg -> R10.Table.State.State -> R10.Table.State.State
update msg state =
    case msg of
        R10.Table.Msg.Sort name isReversed ->
            { state | sort = { name = name, isReversed = isReversed } }

        R10.Table.Msg.FilterClear key ->
            case state.filters of
                R10.Table.State.NoFilters ->
                    state

                R10.Table.State.Filters filtersState ->
                    let
                        newFiltersState : R10.Table.State.FiltersStateRecord
                        newFiltersState =
                            { filtersState
                                | filterEditor = Nothing
                                , filterValues = Dict.remove key filtersState.filterValues
                            }
                    in
                    { state | filters = R10.Table.State.Filters newFiltersState }

        R10.Table.Msg.FiltersTogglePopup filter ->
            case state.filters of
                R10.Table.State.NoFilters ->
                    state

                R10.Table.State.Filters filtersState ->
                    let
                        key : String
                        key =
                            getFilterKey filter

                        newFiltersState : R10.Table.State.FiltersStateRecord
                        newFiltersState =
                            if isPopupOpen filtersState key then
                                { filtersState | filterEditor = Nothing }

                            else
                                { filtersState
                                    | filterEditor =
                                        Just ( key, buildFormModel filter (getFilterValue filter filtersState) )
                                }
                    in
                    { state | filters = R10.Table.State.Filters newFiltersState }

        R10.Table.Msg.FiltersPopupFormMsg formMsg ->
            -- TODO possibly separate actions for FilterValuesUpdate and internal management
            case ( state.filters, formMsg ) of
                ( R10.Table.State.NoFilters, _ ) ->
                    state

                ( R10.Table.State.Filters filtersState, R10.Form.Msg.LoseFocus _ _ ) ->
                    { state
                        | filters = R10.Table.State.Filters <| updateFilterValuesAndCloseForm filtersState
                    }

                ( R10.Table.State.Filters filtersState, R10.Form.Msg.OnSingleMsg _ _ _ (R10.FormComponents.Single.Common.OnLoseFocus _) ) ->
                    { state
                        | filters = R10.Table.State.Filters <| updateFilterValuesAndCloseForm filtersState
                    }

                ( R10.Table.State.Filters filtersState, _ ) ->
                    let
                        -- todo add formCmd emit
                        ( formState, _ ) =
                            justUpdateForm formMsg filtersState
                    in
                    { state
                        | filters = R10.Table.State.Filters <| formState
                    }

        R10.Table.Msg.PaginatorNextPage ->
            state

        R10.Table.Msg.PaginatorPrevPage ->
            state

        R10.Table.Msg.PaginatorLengthOption int ->
            case state.pagination of
                R10.Table.State.Pagination paginationState ->
                    let
                        newPaginationState =
                            { paginationState | length = int }
                    in
                    { state | pagination = R10.Table.State.Pagination newPaginationState }

                R10.Table.State.NoPagination ->
                    state
