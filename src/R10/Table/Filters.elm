module R10.Table.Filters exposing (view)

import Dict
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Html.Attributes
import Html.Events
import Json.Decode
import R10.Form
import R10.FormComponents.UI.Color
import R10.FormTypes
import R10.Table.Config
import R10.Table.Msg
import R10.Table.State
import R10.Table.Style
import R10.Table.Svg
import R10.Table.Types


onClickWithStopPropagation : msg -> Attribute msg
onClickWithStopPropagation message =
    htmlAttribute <| Html.Events.stopPropagationOn "click" (Json.Decode.succeed ( message, True ))


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



-- State management


viewEditPopup :
    R10.FormTypes.Palette
    -> R10.Form.Form
    -> Element R10.Table.Msg.Msg
viewEditPopup palette formModel =
    row
        [ width <| px 400 ]
    <|
        R10.Form.viewWithPalette
            formModel
            R10.Table.Msg.FiltersPopupFormMsg
            palette


viewChipLabel : String -> Maybe String -> Element msg
viewChipLabel label maybeValue =
    -- having 248 allows us to sum up max to 300, which is Form's field length
    el [ width (fill |> maximum 248), clip ]
        (case maybeValue of
            Just value ->
                text (label ++ ": " ++ value)

            Nothing ->
                text label
        )


getFilterValue : R10.Table.Types.Filter -> R10.Table.State.FiltersStateRecord -> Maybe String
getFilterValue filterType filtersState =
    Dict.get (getFilterKey filterType) filtersState.filterValues


viewChipRemoveButton : String -> Element R10.Table.Msg.Msg
viewChipRemoveButton key =
    el
        [ alpha 0.5
        , htmlAttribute <| Html.Attributes.style "transition" "all 0.2s ease-out"
        , pointer
        , mouseOver [ alpha 0.9 ]
        , onClickWithStopPropagation <| R10.Table.Msg.FilterClear key
        ]
    <|
        html <|
            R10.Table.Svg.removeCircle "black" 18


viewChip :
    R10.FormTypes.Palette
    -> R10.Table.State.FiltersStateRecord
    -> R10.Table.Types.Filter
    -> Element R10.Table.Msg.Msg
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

        removeButton : Element R10.Table.Msg.Msg
        removeButton =
            if isActive then
                viewChipRemoveButton key

            else
                none
    in
    row
        ([ Border.width 1
         , Border.rounded 50
         , htmlAttribute <| Html.Attributes.style "transition" "opacity 0.2s ease-out"
         , alpha 0.7
         , mouseOver [ alpha 1 ]
         , paddingXY 12 8
         , spacing 8
         , Events.onClick <| R10.Table.Msg.FiltersTogglePopup filterType
         ]
            ++ (if isActive then
                    [ Border.color <| R10.FormComponents.UI.Color.container palette
                    , Background.color <| R10.FormComponents.UI.Color.background palette
                    ]

                else
                    [ Border.color <| R10.FormComponents.UI.Color.container palette ]
               )
        )
    <|
        [ viewChipLabel label (getFilterValue filterType filtersState)
        , removeButton
        ]


viewFilter :
    R10.FormTypes.Palette
    -> R10.Table.State.FiltersStateRecord
    -> R10.Table.Types.Filter
    -> Element R10.Table.Msg.Msg
viewFilter palette filtersState filterType =
    let
        key : String
        key =
            getFilterKey filterType

        maybeEditPopupEl : Maybe (Element R10.Table.Msg.Msg)
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


viewFilterPanelButton : Element R10.Table.Msg.Msg
viewFilterPanelButton =
    el
        [ htmlAttribute <| Html.Attributes.style "transition" "all 0.2s ease-out"
        , alpha 0.7
        , padding 8
        , pointer
        , Border.rounded 4
        , mouseOver [ alpha 1, Background.color <| rgba 0 0 0 0.035 ]
        , alignTop
        ]
    <|
        html <|
            R10.Table.Svg.filterList "black" 22


view :
    R10.FormTypes.Palette
    -> R10.Table.Config.FiltersConfig
    -> R10.Table.State.State
    -> Element R10.Table.Msg.Msg
view palette filtersConfig state =
    case state.filters of
        R10.Table.State.Filters filtersState ->
            row
                (R10.Table.Style.defaultRowAttrs
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

        R10.Table.State.NoFilters ->
            none
