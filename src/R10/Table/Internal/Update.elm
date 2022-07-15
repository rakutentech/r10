module R10.Table.Internal.Update exposing (update)

import Dict
import R10.Form
import R10.Form.Internal.Msg
import R10.FormComponents.Internal.Single.Common
import R10.FormTypes
import R10.Table.Internal.Msg
import R10.Table.Internal.State
import R10.Table.Internal.Types


isPopupOpen : R10.Table.Internal.State.FiltersStateRecord -> String -> Bool
isPopupOpen filters key =
    case filters.filterEditor of
        Just ( str, _ ) ->
            key == str

        Nothing ->
            False


getFilterKey : R10.Table.Internal.Types.Filter -> String
getFilterKey filterType =
    case filterType of
        R10.Table.Internal.Types.FilterText { key } ->
            key

        R10.Table.Internal.Types.FilterSelect { key } ->
            key


getFilterLabel : R10.Table.Internal.Types.Filter -> String
getFilterLabel filterType =
    case filterType of
        R10.Table.Internal.Types.FilterText { label } ->
            label

        R10.Table.Internal.Types.FilterSelect { label } ->
            label


getFilterValue : R10.Table.Internal.Types.Filter -> R10.Table.Internal.State.FiltersStateRecord -> Maybe String
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


buildFormModel : R10.Table.Internal.Types.Filter -> Maybe String -> R10.Form.Form
buildFormModel filter defaultValue =
    let
        extra : { type_ : R10.FormTypes.FieldType }
        extra =
            case filter of
                R10.Table.Internal.Types.FilterText _ ->
                    { type_ = R10.FormTypes.TypeText R10.FormTypes.TextPlain
                    }

                R10.Table.Internal.Types.FilterSelect { options } ->
                    { type_ = R10.FormTypes.TypeSingle R10.FormTypes.SingleCombobox options
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


justUpdateForm : R10.Form.Internal.Msg.Msg -> R10.Table.Internal.State.FiltersStateRecord -> ( R10.Table.Internal.State.FiltersStateRecord, Cmd R10.Table.Internal.Msg.Msg )
justUpdateForm formMsg filtersState =
    case filtersState.filterEditor of
        Nothing ->
            ( filtersState, Cmd.none )

        Just ( key, form ) ->
            let
                ( newFormState_, formCmd ) =
                    R10.Form.update (\_ value -> value) formMsg form.state
            in
            ( { filtersState
                | filterEditor =
                    Just ( key, { form | state = newFormState_ } )
              }
            , Cmd.map R10.Table.Internal.Msg.FiltersPopupFormMsg formCmd
            )


updateFilterValuesAndCloseForm : R10.Table.Internal.State.FiltersStateRecord -> R10.Table.Internal.State.FiltersStateRecord
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


update : R10.Table.Internal.Msg.Msg -> R10.Table.Internal.State.State -> R10.Table.Internal.State.State
update msg state =
    case msg of
        R10.Table.Internal.Msg.Sort name isReversed ->
            { state | sort = { name = name, isReversed = isReversed } }

        R10.Table.Internal.Msg.FilterClear key ->
            case state.filters of
                R10.Table.Internal.State.NoFilters ->
                    state

                R10.Table.Internal.State.Filters filtersState ->
                    let
                        newFiltersState : R10.Table.Internal.State.FiltersStateRecord
                        newFiltersState =
                            { filtersState
                                | filterEditor = Nothing
                                , filterValues = Dict.remove key filtersState.filterValues
                            }
                    in
                    { state | filters = R10.Table.Internal.State.Filters newFiltersState }

        R10.Table.Internal.Msg.FiltersTogglePopup filter ->
            case state.filters of
                R10.Table.Internal.State.NoFilters ->
                    state

                R10.Table.Internal.State.Filters filtersState ->
                    let
                        key : String
                        key =
                            getFilterKey filter

                        newFiltersState : R10.Table.Internal.State.FiltersStateRecord
                        newFiltersState =
                            if isPopupOpen filtersState key then
                                { filtersState | filterEditor = Nothing }

                            else
                                { filtersState
                                    | filterEditor =
                                        Just ( key, buildFormModel filter (getFilterValue filter filtersState) )
                                }
                    in
                    { state | filters = R10.Table.Internal.State.Filters newFiltersState }

        R10.Table.Internal.Msg.FiltersPopupFormMsg formMsg ->
            -- TODO possibly separate actions for FilterValuesUpdate and internal management
            case ( state.filters, formMsg ) of
                ( R10.Table.Internal.State.NoFilters, _ ) ->
                    state

                ( R10.Table.Internal.State.Filters filtersState, R10.Form.Internal.Msg.LoseFocus _ _ ) ->
                    { state
                        | filters = R10.Table.Internal.State.Filters <| updateFilterValuesAndCloseForm filtersState
                    }

                ( R10.Table.Internal.State.Filters filtersState, R10.Form.Internal.Msg.OnSingleMsg _ _ _ (R10.FormComponents.Internal.Single.Common.OnLoseFocus _) ) ->
                    { state
                        | filters = R10.Table.Internal.State.Filters <| updateFilterValuesAndCloseForm filtersState
                    }

                ( R10.Table.Internal.State.Filters filtersState, _ ) ->
                    let
                        -- todo add formCmd emit
                        ( formState, _ ) =
                            justUpdateForm formMsg filtersState
                    in
                    { state
                        | filters = R10.Table.Internal.State.Filters <| formState
                    }

        R10.Table.Internal.Msg.PaginatorNextPage ->
            state

        R10.Table.Internal.Msg.PaginatorPrevPage ->
            state

        R10.Table.Internal.Msg.PaginatorLengthOption int ->
            case state.pagination of
                R10.Table.Internal.State.Pagination paginationState ->
                    let
                        newPaginationState =
                            { paginationState | length = int }
                    in
                    { state | pagination = R10.Table.Internal.State.Pagination newPaginationState }

                R10.Table.Internal.State.NoPagination ->
                    state
