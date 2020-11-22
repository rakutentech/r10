module R10.Table.Header exposing (simpleHeader, toHeaderInfo, toSortArrowInfo, viewHeaderSortArrow, viewHeaderTitle)

import Element exposing (..)
import Element.Events as Events
import Element.Font as Font
import Html.Attributes
import R10.Form
import R10.Table.Config
import R10.Table.State
import R10.Table.Style
import R10.Table.Svg exposing (arrowDown)
import R10.Table.Types


type ArrowType
    = ArrowActive
    | ArrowNone
    | ArrowInactive


toSortArrowInfo : R10.Table.Types.Status -> ( ArrowType, Bool )
toSortArrowInfo status =
    case status of
        R10.Table.Types.Unsortable ->
            ( ArrowNone, False )

        R10.Table.Types.Sortable selected ->
            if selected then
                ( ArrowActive, False )

            else
                ( ArrowInactive, False )

        R10.Table.Types.Reversible Nothing ->
            ( ArrowInactive, False )

        R10.Table.Types.Reversible (Just isReversed) ->
            ( ArrowActive, isReversed )


toHeaderInfo : R10.Table.State.State -> R10.Table.Config.ColumnConf data msg -> (String -> Bool -> msg) -> R10.Table.Config.HeaderInfo msg
toHeaderInfo state columnData sortMsg =
    let
        sortName : String
        sortName =
            state.sort.name

        isReversed : Bool
        isReversed =
            state.sort.isReversed

        sorter : R10.Table.Types.Sorter data
        sorter =
            columnData.sorter

        name : String
        name =
            columnData.name
    in
    -- todo if we go to `Table.Config.HeaderData data msg` and rename,onClickMsg , only first branch would be changed
    case sorter of
        R10.Table.Types.None ->
            { name = name
            , sortStatus = R10.Table.Types.Unsortable
            , onSortMsg = sortMsg sortName isReversed
            }

        R10.Table.Types.Increasing _ ->
            { name = name
            , sortStatus = R10.Table.Types.Sortable (name == sortName)
            , onSortMsg = sortMsg name False
            }

        R10.Table.Types.Decreasing _ ->
            { name = name
            , sortStatus = R10.Table.Types.Sortable (name == sortName)
            , onSortMsg = sortMsg name False
            }

        R10.Table.Types.IncOrDec _ ->
            if name == sortName then
                { name = name
                , sortStatus = R10.Table.Types.Reversible (Just isReversed)
                , onSortMsg = sortMsg name (not isReversed)
                }

            else
                { name = name
                , sortStatus = R10.Table.Types.Reversible Nothing
                , onSortMsg = sortMsg name False
                }

        R10.Table.Types.DecOrInc _ ->
            if name == sortName then
                { name = name
                , sortStatus = R10.Table.Types.Reversible (Just isReversed)
                , onSortMsg = sortMsg name (not isReversed)
                }

            else
                { name = name
                , sortStatus = R10.Table.Types.Reversible Nothing
                , onSortMsg = sortMsg name False
                }


viewHeaderTitle : String -> Element msg
viewHeaderTitle columnName =
    paragraph
        [ paddingEach { top = 0, right = 0, bottom = 0, left = 16 }
        , Font.color <| rgba 0 0 0 0.8
        , width fill
        , centerY
        ]
        [ text columnName ]


viewHeaderSortArrow : ( ArrowType, Bool ) -> Element msg
viewHeaderSortArrow ( buttonType, isReversed ) =
    let
        buttonAttrs : List (Attr () msg)
        buttonAttrs =
            case buttonType of
                ArrowActive ->
                    [ alpha 0.7, pointer ]

                ArrowInactive ->
                    [ alpha 0, mouseOver [ alpha 0.3 ], pointer ]

                ArrowNone ->
                    [ alpha 0 ]
    in
    el
        ([ width fill
         , height fill
         , htmlAttribute <| Html.Attributes.style "transition" "all 0.15s"
         ]
            ++ buttonAttrs
        )
    <|
        el
            [ centerY
            , moveLeft 3
            , rotate
                (if isReversed then
                    degrees 180

                 else
                    0
                )
            , htmlAttribute <| Html.Attributes.style "transition" "all 0.15s, transform 0.2s"
            ]
        <|
            html <|
                arrowDown "black" 18


simpleHeader : List (Attribute msg) -> R10.Form.Palette -> R10.Table.Config.HeaderInfo msg -> Element msg
simpleHeader attrs palette headerInfo =
    el
        (R10.Table.Style.defaultHeaderAttrs
            ++ [ htmlAttribute <| Html.Attributes.style "transition" "all 0.25s ease-out"
               , Events.onClick <| headerInfo.onSortMsg
               , behindContent <| viewHeaderTitle headerInfo.name
               , behindContent <| viewHeaderSortArrow <| toSortArrowInfo headerInfo.sortStatus
               ]
            ++ attrs
        )
        none
