module R10.Table.Internal.Paginator exposing (getPaginationStateRecord_, paginationButtonDisableAll_, paginationButtonEnableAll_, paginationButtonEnableOther_, paginationButtonNextFetch_, paginationButtonPrevFetch_, updatePaginationState_, view)

import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Events as Events
import Html
import Html.Attributes
import Html.Events
import R10.Context exposing (..)
import R10.Palette
import R10.Table.Internal.Config
import R10.Table.Internal.Msg
import R10.Table.Internal.State
import R10.Table.Internal.Svg
import R10.Transition
import Svg


buttonStyle : List (Attribute (R10.Context.ContextInternal context) msg)
buttonStyle =
    [ padding 9
    , alignRight
    , Border.rounded 4
    , alpha 0.7
    , width <| px 40
    , height <| px 40
    , R10.Transition.transition "all 0.2s ease-out"
    ]


intToOption : Int -> Html.Html msg
intToOption v =
    Html.option [ Html.Attributes.value (String.fromInt v) ] [ Html.text (String.fromInt v) ]


numberOfRowsSelector :
    R10.Table.Internal.Config.PaginationConfig
    -> R10.Table.Internal.State.PaginationStateRecord
    -- -> Element R10.Table.Internal.Msg.Msg context
    -> Element (ContextInternal context) R10.Table.Internal.Msg.Msg
numberOfRowsSelector paginationConfig state =
    row
        [ alignRight
        , spacing 8
        ]
        [ text "Rows per page"
        , el [ moveDown 1 ] <|
            html <|
                Html.select
                    [ Html.Events.onInput <|
                        String.toInt
                            >> Maybe.withDefault 0
                            >> R10.Table.Internal.Msg.PaginatorLengthOption
                    , Html.Attributes.value <| String.fromInt state.length
                    ]
                <|
                    List.map intToOption paginationConfig.lengthOptions
        ]


viewPaginationButton :
    R10.Table.Internal.Msg.Msg
    -> (String -> Int -> Svg.Svg R10.Table.Internal.Msg.Msg)
    -> R10.Table.Internal.State.PaginationButtonState
    -> Element (ContextInternal context) R10.Table.Internal.Msg.Msg
viewPaginationButton msg icon state =
    el
        (buttonStyle
            ++ (case state of
                    R10.Table.Internal.State.PaginationButtonEnabled ->
                        [ Events.onClick <| msg
                        , pointer
                        , mouseOver [ alpha 1, Background.color <| rgba 0 0 0 0.035 ]
                        ]

                    _ ->
                        [ alpha 0.3 ]
               )
        )
        (html <| icon "black" 22)


view :
    R10.Palette.Palette
    -> R10.Table.Internal.Config.PaginationConfig
    -> R10.Table.Internal.State.PaginationState
    -> Element (ContextInternal context) R10.Table.Internal.Msg.Msg
view _ paginationConfig paginationState =
    case paginationState of
        -- todo refactor it so pagination would work with default state initially,
        -- creating custom state on pagination change
        R10.Table.Internal.State.Pagination state ->
            row
                [ width fill
                , height <| px 56
                , spacing 32
                , paddingXY 16 0
                ]
                [ numberOfRowsSelector paginationConfig state
                , row [ spacing 16 ]
                    [ viewPaginationButton R10.Table.Internal.Msg.PaginatorPrevPage R10.Table.Internal.Svg.arrowPrev state.prevButtonState
                    , viewPaginationButton R10.Table.Internal.Msg.PaginatorNextPage R10.Table.Internal.Svg.arrowNext state.nextButtonState
                    ]
                ]

        R10.Table.Internal.State.NoPagination ->
            none


updatePaginationState_ : R10.Table.Internal.State.PaginationStateRecord -> R10.Table.Internal.State.State -> R10.Table.Internal.State.State
updatePaginationState_ paginationStateRecord state =
    { state | pagination = R10.Table.Internal.State.Pagination paginationStateRecord }


paginationButtonNextFetch_ : R10.Table.Internal.State.State -> R10.Table.Internal.State.State
paginationButtonNextFetch_ state =
    case getPaginationStateRecord_ state of
        Just paginationStateRecord ->
            { state
                | pagination =
                    R10.Table.Internal.State.Pagination
                        { paginationStateRecord
                            | nextButtonState = R10.Table.Internal.State.PaginationButtonLoading
                            , prevButtonState =
                                if paginationStateRecord.prevButtonState == R10.Table.Internal.State.PaginationButtonLoading then
                                    R10.Table.Internal.State.PaginationButtonOtherLoading

                                else
                                    paginationStateRecord.prevButtonState
                        }
            }

        Nothing ->
            state


paginationButtonPrevFetch_ : R10.Table.Internal.State.State -> R10.Table.Internal.State.State
paginationButtonPrevFetch_ state =
    case getPaginationStateRecord_ state of
        Just paginationStateRecord ->
            { state
                | pagination =
                    R10.Table.Internal.State.Pagination
                        { paginationStateRecord
                            | nextButtonState =
                                if paginationStateRecord.nextButtonState == R10.Table.Internal.State.PaginationButtonLoading then
                                    R10.Table.Internal.State.PaginationButtonOtherLoading

                                else
                                    paginationStateRecord.nextButtonState
                            , prevButtonState = R10.Table.Internal.State.PaginationButtonLoading
                        }
            }

        Nothing ->
            state


paginationButtonEnableAll_ : R10.Table.Internal.State.State -> R10.Table.Internal.State.State
paginationButtonEnableAll_ state =
    case getPaginationStateRecord_ state of
        Just paginationStateRecord ->
            { state
                | pagination =
                    R10.Table.Internal.State.Pagination
                        { paginationStateRecord
                            | nextButtonState = R10.Table.Internal.State.PaginationButtonEnabled
                            , prevButtonState = R10.Table.Internal.State.PaginationButtonEnabled
                        }
            }

        Nothing ->
            state


paginationButtonDisableAll_ : R10.Table.Internal.State.State -> R10.Table.Internal.State.State
paginationButtonDisableAll_ state =
    case getPaginationStateRecord_ state of
        Just paginationStateRecord ->
            { state
                | pagination =
                    R10.Table.Internal.State.Pagination
                        { paginationStateRecord
                            | nextButtonState = R10.Table.Internal.State.PaginationButtonDisabled
                            , prevButtonState = R10.Table.Internal.State.PaginationButtonDisabled
                        }
            }

        Nothing ->
            state


paginationButtonEnableOther_ : R10.Table.Internal.State.State -> R10.Table.Internal.State.State
paginationButtonEnableOther_ state =
    case getPaginationStateRecord_ state of
        Just paginationStateRecord ->
            let
                nextState : R10.Table.Internal.State.PaginationButtonState -> R10.Table.Internal.State.PaginationButtonState
                nextState current =
                    case current of
                        R10.Table.Internal.State.PaginationButtonDisabled ->
                            R10.Table.Internal.State.PaginationButtonDisabled

                        R10.Table.Internal.State.PaginationButtonLoading ->
                            R10.Table.Internal.State.PaginationButtonDisabled

                        R10.Table.Internal.State.PaginationButtonOtherLoading ->
                            R10.Table.Internal.State.PaginationButtonEnabled

                        R10.Table.Internal.State.PaginationButtonEnabled ->
                            R10.Table.Internal.State.PaginationButtonEnabled
            in
            { state
                | pagination =
                    R10.Table.Internal.State.Pagination
                        { paginationStateRecord
                            | nextButtonState = nextState paginationStateRecord.nextButtonState
                            , prevButtonState = nextState paginationStateRecord.prevButtonState
                        }
            }

        Nothing ->
            state


getPaginationStateRecord_ : R10.Table.Internal.State.State -> Maybe R10.Table.Internal.State.PaginationStateRecord
getPaginationStateRecord_ state =
    case state.pagination of
        R10.Table.Internal.State.Pagination paginationState ->
            Just paginationState

        R10.Table.Internal.State.NoPagination ->
            Nothing
