module R10.Table.Internal.Filters exposing (view)

import Dict
import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Events as Events
import Html.Events
import Json.Decode
import R10.Context exposing (..)
import R10.Form
import R10.FormComponents.Internal.UI.Color
import R10.Palette
import R10.Table.Internal.Config
import R10.Table.Internal.Msg
import R10.Table.Internal.State
import R10.Table.Internal.Style
import R10.Table.Internal.Svg
import R10.Table.Internal.Types
import R10.Transition


onClickWithStopPropagation : msg -> Attribute (R10.Context.ContextInternal z) msg
onClickWithStopPropagation message =
    htmlAttribute <| Html.Events.stopPropagationOn "click" (Json.Decode.succeed ( message, True ))


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



-- State management


viewEditPopup :
    R10.Palette.Palette
    -> R10.Form.Form
    -> Element (ContextInternal context) R10.Table.Internal.Msg.Msg
viewEditPopup palette formModel =
    row
        [ width <| px 400 ]
    <|
        R10.Form.viewWithPalette
            formModel
            R10.Table.Internal.Msg.FiltersPopupFormMsg
            palette


viewChipLabel : String -> Maybe String -> Element (R10.Context.ContextInternal z) msg
viewChipLabel label maybeValue =
    -- having 248 allows us to sum up max to 300, which is Form's field length
    el [ width (fill |> maximum 248), clip ]
        (case maybeValue of
            Just value ->
                text (label ++ ": " ++ value)

            Nothing ->
                text label
        )


getFilterValue : R10.Table.Internal.Types.Filter -> R10.Table.Internal.State.FiltersStateRecord -> Maybe String
getFilterValue filterType filtersState =
    Dict.get (getFilterKey filterType) filtersState.filterValues


viewChipRemoveButton : String -> Element (ContextInternal context) R10.Table.Internal.Msg.Msg
viewChipRemoveButton key =
    el
        [ alpha 0.5
        , R10.Transition.transition "all 0.2s ease-out"
        , pointer
        , mouseOver [ alpha 0.9 ]
        , onClickWithStopPropagation <| R10.Table.Internal.Msg.FilterClear key
        ]
    <|
        html <|
            R10.Table.Internal.Svg.removeCircle "black" 18


viewChip :
    R10.Palette.Palette
    -> R10.Table.Internal.State.FiltersStateRecord
    -> R10.Table.Internal.Types.Filter
    -> Element (ContextInternal context) R10.Table.Internal.Msg.Msg
viewChip palette filtersState filterType =
    let
        key : String
        key =
            getFilterKey filterType

        label : String
        label =
            getFilterLabel filterType

        isActive : Bool
        isActive =
            case getFilterValue filterType filtersState of
                Just _ ->
                    True

                Nothing ->
                    False

        removeButton : Element (ContextInternal context) R10.Table.Internal.Msg.Msg
        removeButton =
            if isActive then
                viewChipRemoveButton key

            else
                none
    in
    row
        ([ Border.width 1
         , Border.rounded 50
         , R10.Transition.transition "opacity 0.2s ease-out"
         , alpha 0.7
         , mouseOver [ alpha 1 ]
         , paddingXY 12 8
         , spacing 8
         , Events.onClick <| R10.Table.Internal.Msg.FiltersTogglePopup filterType
         ]
            ++ (if isActive then
                    [ Border.color <| R10.FormComponents.Internal.UI.Color.container palette
                    , Background.color <| R10.FormComponents.Internal.UI.Color.background palette
                    ]

                else
                    [ Border.color <| R10.FormComponents.Internal.UI.Color.container palette ]
               )
        )
    <|
        [ viewChipLabel label (getFilterValue filterType filtersState)
        , removeButton
        ]


viewFilter :
    R10.Palette.Palette
    -> R10.Table.Internal.State.FiltersStateRecord
    -> R10.Table.Internal.Types.Filter
    -> Element (ContextInternal context) R10.Table.Internal.Msg.Msg
viewFilter palette filtersState filterType =
    let
        key : String
        key =
            getFilterKey filterType

        maybeEditPopupEl : Maybe (Element (ContextInternal context) R10.Table.Internal.Msg.Msg)
        maybeEditPopupEl =
            case filtersState.filterEditor of
                Just ( key_, formModel ) ->
                    if key_ == key then
                        Just <| viewEditPopup palette formModel

                    else
                        Nothing

                Nothing ->
                    Nothing
    in
    case maybeEditPopupEl of
        Just editPopupEl ->
            editPopupEl

        Nothing ->
            viewChip palette filtersState filterType


viewFilterPanelButton : Element (ContextInternal context) R10.Table.Internal.Msg.Msg
viewFilterPanelButton =
    el
        [ R10.Transition.transition "all 0.2s ease-out"
        , alpha 0.7
        , padding 8
        , pointer
        , Border.rounded 4
        , mouseOver [ alpha 1, Background.color <| rgba 0 0 0 0.035 ]
        , alignTop
        ]
    <|
        html <|
            R10.Table.Internal.Svg.filterList "black" 22


view :
    R10.Palette.Palette
    -> R10.Table.Internal.Config.FiltersConfig
    -> R10.Table.Internal.State.State
    -> Element (ContextInternal context) R10.Table.Internal.Msg.Msg
view palette filtersConfig state =
    case state.filters of
        R10.Table.Internal.State.Filters filtersState ->
            row
                (R10.Table.Internal.Style.defaultRowAttrs
                    ++ [ paddingXY 8 0
                       , spacing 20
                       ]
                )
                [ el [ paddingXY 0 10 ] viewFilterPanelButton
                , row
                    [ spacing 8, width fill ]
                    (List.map
                        (viewFilter palette filtersState)
                        filtersConfig.filterFields
                    )
                ]

        R10.Table.Internal.State.NoFilters ->
            none
