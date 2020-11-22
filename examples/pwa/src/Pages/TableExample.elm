module Pages.TableExample exposing
    ( Model
    , Msg
    , init
    , title
    , update
    , view
    )

import Color
import Dict exposing (Dict)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Html.Attributes
import Json.Encode
import Pages.Shared.Utils
import R10.Card
import R10.Color
import R10.Color.Utils
import R10.Language
import R10.Mode
import R10.Table
import R10.Table.Config
import R10.Table.Header
import R10.Table.Msg
import R10.Table.Placeholder
import R10.Table.State
import R10.Table.Style
import R10.Table.Types
import R10.Table.Update
import R10.Theme


title : R10.Language.Translations
title =
    { key = "title"
    , en_us = "Sortable Table"
    , ja_jp = "Sortable Table"
    , zh_tw = "Sortable Table"
    , es_es = "Sortable Table"
    , fr_fr = "Sortable Table"
    , de_de = "Sortable Table"
    , it_it = "Sortable Table"
    , nl_nl = "Sortable Table"
    , pt_pt = "Sortable Table"
    , nb_no = "Sortable Table"
    , fi_fl = "Sortable Table"
    , da_dk = "Sortable Table"
    , sv_se = "Sortable Table"
    }


type Theme
    = DarkTheme
    | LightTheme


defaultTheme : Theme
defaultTheme =
    LightTheme


type alias TableRecord =
    { id : String
    , name : String
    , color : Element.Color
    , isAccordionExpanded : Bool
    }


type alias Model =
    { tableRecords : Dict String TableRecord
    , table1State : R10.Table.State.State
    , table2State : R10.Table.State.State
    }


type Msg
    = Table1Msg R10.Table.Msg.Msg
    | Table2Msg R10.Table.Msg.Msg
    | Table2ToggleLoadingMsg
    | AccordionToggle String


tableData : Dict String TableRecord
tableData =
    Dict.fromList
        [ ( "id-1", { id = "id-1", name = "Rakuten", color = rgb 0.69 0 0, isAccordionExpanded = False } )
        , ( "id-2", { id = "id-2", name = "Membership - Portal", color = rgb 1 0.2 0.4, isAccordionExpanded = False } )
        , ( "id-3", { id = "id-3", name = "Rakuten Mobile", color = rgb 0.98 0 0.55, isAccordionExpanded = False } )
        ]


actionColumn : String -> List (Attribute Msg) -> Theme -> R10.Table.Column TableRecord Msg
actionColumn columnName headerAttrs theme =
    R10.Table.columnWithViews
        { name = columnName
        , viewCell = always <| viewActionRow theme
        , viewHeader = R10.Table.Header.simpleHeader headerAttrs
        , maybeToCmp = Nothing
        }


viewActionRow : Theme -> Maybe TableRecord -> Element Msg
viewActionRow theme maybeRecord =
    -- todo create Icon button
    -- todo move accordion button to Components
    row
        (R10.Table.Style.defaultCellAttrs ++ [ spacing 8, width <| px 56 ])
        [ el
            ([ width <| px 40
             , height <| px 40
             , Border.rounded 4
             , alpha 0.5
             , mouseOver [ alpha 1, Background.color <| mouseOverBackgroundColor ]

             -- TODO - Remove the "all" from the transition
             , htmlAttribute <| Html.Attributes.style "transition" "all 0.2s ease-in-out"
             , pointer
             , clip
             ]
                ++ (maybeRecord
                        |> Maybe.map (List.singleton << Events.onClick << AccordionToggle << .id)
                        |> Maybe.withDefault []
                   )
            )
          <|
            el
                [ width <| px 40
                , height <| px 40
                , padding 5

                -- TODO - Remove the "all" from the transition
                , htmlAttribute <| Html.Attributes.style "transition" "all 0.3s ease-in-out"
                , rotate
                    (if maybeRecord |> Maybe.map .isAccordionExpanded |> Maybe.withDefault False then
                        degrees 180

                     else
                        0
                    )
                ]
                -- (html <| UI.Icon.keyboardArrowDown "black" 24)
                (text "Icon arrow down")
        ]



-- accordion


accordionExpandedHeight : number
accordionExpandedHeight =
    120


viewAccordionContent : Theme -> TableRecord -> Element msg
viewAccordionContent theme record =
    el [ width fill, height fill, Background.color grayLightest, paddingXY 16 12 ] <|
        el
            (subTitle
                ++ [ paddingXY 12 16
                   , alignRight
                   , width <| px 200
                   , Background.color record.color
                   ]
            )
        <|
            el [ centerX, Font.color <| rgb 1 1 1 ] <|
                text recordColor



-- Records encoder


tableRecordsEncoder : Dict String TableRecord -> Json.Encode.Value
tableRecordsEncoder dict =
    (Dict.toList >> List.map (\( k, v ) -> ( k, encodeTableRecord v )) >> Json.Encode.object) dict


encodeTableRecord : TableRecord -> Json.Encode.Value
encodeTableRecord tableRecord =
    Json.Encode.object <|
        [ ( "id", Json.Encode.string tableRecord.id )
        , ( "name", Json.Encode.string tableRecord.name )
        , ( "color", encodeColor tableRecord.color )
        , ( "isAccordionExpanded", Json.Encode.bool tableRecord.isAccordionExpanded )
        ]


encodeColor : Element.Color -> Json.Encode.Value
encodeColor color =
    Json.Encode.string <| R10.Color.Utils.toHex <| R10.Color.Utils.elementColorToColor color



-- color column


colorColumn : Theme -> String -> (TableRecord -> String) -> Maybe (R10.Table.Config.ColumnAttrs Msg) -> R10.Table.Column TableRecord Msg
colorColumn theme columnName toStr _ =
    R10.Table.columnWithViews
        { name = columnName
        , viewCell = always <| viewColorColumn theme
        , viewHeader = R10.Table.Header.simpleHeader []
        , maybeToCmp = Just toStr
        }


viewColorColumn : Theme -> Maybe TableRecord -> Element Msg
viewColorColumn theme maybeRecord =
    row
        (R10.Table.Style.defaultCellAttrs ++ [ spacing 8 ])
        (case maybeRecord of
            Just record ->
                [ el [ Background.color record.color, paddingXY 8 6, width fill ] <|
                    el [ centerX, Font.color <| rgb 1 1 1 ] <|
                        text recordColor
                ]

            Nothing ->
                [ R10.Table.Placeholder.view colorPrimary [] ]
        )



-- rest


init : Model
init =
    { tableRecords = tableData
    , table1State = R10.Table.initialStateSort { name = "Id", isReversed = False }
    , table2State =
        R10.Table.initialStateSort { name = "Id", isReversed = False }
            |> R10.Table.initialStatePagination { length = 3 }
            |> R10.Table.initialStateFilters { filterValues = Dict.empty }
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        AccordionToggle recordId ->
            { model
                | tableRecords =
                    model.tableRecords
                        |> Dict.get recordId
                        |> Maybe.map (\record -> { record | isAccordionExpanded = not record.isAccordionExpanded })
                        |> Maybe.map (\record -> Dict.insert record.id record model.tableRecords)
                        |> Maybe.withDefault model.tableRecords
            }

        Table1Msg tableMsg ->
            { model | table1State = R10.Table.Update.update tableMsg model.table1State }

        Table2ToggleLoadingMsg ->
            { model
                | table2State =
                    model.table2State
                        |> R10.Table.setLoading (not <| R10.Table.isLoading model.table2State)
            }

        Table2Msg tableMsg ->
            { model | table2State = R10.Table.Update.update tableMsg model.table2State }


buildFilterOptions : List String -> List { value : String, label : String }
buildFilterOptions filterOptions =
    List.map (\s -> { value = s, label = s }) filterOptions


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
    let
        colorAsString : TableRecord -> String
        colorAsString record =
            recordColor

        -- tableSimple
        tableSimple =
            R10.Table.view
                (Pages.Shared.Utils.toFormPalette theme)
                (R10.Table.config
                    { toId = .id
                    , toMsg = Table1Msg
                    , columns =
                        [ R10.Table.columnSimple { name = "Id", toStr = .id }
                        , R10.Table.columnSimple { name = "Name", toStr = .name }
                        , R10.Table.columnSimple { name = "Color", toStr = colorAsString }
                        ]
                    }
                )
                model.table1State
                (Dict.values model.tableRecords)

        tableWithAccordion =
            R10.Table.view
                (Pages.Shared.Utils.toFormPalette theme)
                (R10.Table.config
                    { toId = .id
                    , toMsg = Table1Msg
                    , columns =
                        [ R10.Table.columnSimple { name = "Id", toStr = .id }
                        , R10.Table.columnSimple { name = "Name", toStr = .name }
                        , R10.Table.columnSimple { name = "Color", toStr = colorAsString }
                        , actionColumn "" [ width <| px 56 ] defaultTheme
                        ]
                    }
                    |> R10.Table.configWithAccordionRow
                        (Maybe.map (viewAccordionContent defaultTheme) >> Maybe.withDefault none)
                        accordionExpandedHeight
                        (Maybe.map .isAccordionExpanded >> Maybe.withDefault False)
                        (always False)
                )
                model.table1State
                (Dict.values model.tableRecords)

        -- tableWithPaginationAndFilters
        tableWithPaginationAndFilters =
            R10.Table.view
                (Pages.Shared.Utils.toFormPalette theme)
                (R10.Table.customConfig
                    { toId = .id
                    , toMsg = Table2Msg
                    , columns =
                        [ R10.Table.columnWithAttrs { name = "Id", toStr = .id, maybeToCmp = Nothing, maybeAttrs = Just { header = [ width <| px 100 ], cell = [ width <| px 100 ] } }
                        , R10.Table.columnSimple { name = "Name", toStr = .name }
                        , colorColumn defaultTheme "Color" colorAsString Nothing
                        ]
                    , pagination = Just { lengthOptions = [ 1, 2, 3 ] }
                    , bodyAttrs = []
                    , rowAttrsBuilder = always []
                    , filters =
                        Just
                            { filterFields =
                                [ R10.Table.Types.FilterText
                                    { label = "Name label"
                                    , key = "name"
                                    }
                                , R10.Table.Types.FilterSelect
                                    { label = "Color label"
                                    , key = "color"
                                    , options = buildFilterOptions (Dict.values model.tableRecords |> List.map colorAsString)
                                    }
                                ]
                            }
                    }
                )
                model.table2State
                (Dict.values model.tableRecords)

        -- tableWithCustomStyles
        tableWithCustomStyles =
            R10.Table.view
                (Pages.Shared.Utils.toFormPalette theme)
                (R10.Table.customConfig
                    { toId = .id
                    , toMsg = Table1Msg
                    , columns =
                        [ R10.Table.columnWithAttrs
                            { name = "Id"
                            , toStr = .id
                            , maybeToCmp = Just .id
                            , maybeAttrs =
                                Just
                                    { header = [ Background.color <| rgba 0 0 1 0.3, mouseOver [ Background.color <| rgba 0 0 1 1 ] ]
                                    , cell = [ height <| px 40, paddingXY 8 6, Background.color <| rgba 0 0 1 0.6, mouseOver [ Background.color <| rgba 0 0 1 1 ] ]
                                    }
                            }
                        , R10.Table.columnWithAttrs
                            { name = "Name"
                            , toStr = .name
                            , maybeToCmp = Just .name
                            , maybeAttrs =
                                Just
                                    { header = []
                                    , cell = [ height <| px 40, paddingXY 8 6, Background.color <| rgba 0 1 0 0.3, mouseOver [ Background.color <| rgba 0 1 0 1 ] ]
                                    }
                            }
                        , R10.Table.columnWithAttrs
                            { name = "Color"
                            , toStr = colorAsString
                            , maybeToCmp = Just colorAsString
                            , maybeAttrs =
                                Just
                                    { header = [ Background.color <| rgba 1 0 0 0.3, mouseOver [ Background.color <| rgba 1 0 0 1 ] ]
                                    , cell = [ height <| px 40, paddingXY 8 6 ]
                                    }
                            }
                        ]
                    , bodyAttrs = [ width fill, height fill, Border.width 2, padding 6, spacing 6 ]
                    , rowAttrsBuilder =
                        \maybeRecord ->
                            [ Border.color (maybeRecord |> Maybe.map .color |> Maybe.withDefault (rgba 1 0 1 0.3))
                            , Border.width 3
                            , mouseOver [ Background.color <| rgba 0 0 0 0.1 ]
                            ]
                                ++ R10.Table.Style.defaultRowAttrs
                    , pagination = Nothing
                    , filters = Nothing
                    }
                )
                model.table1State
                (Dict.values model.tableRecords)
    in
    [ column [ width fill, height fill, spacing 16 ]
        [ column (R10.Card.normal theme)
            [ el subTitle <| text "Table data"
            , text (Json.Encode.encode 4 <| tableRecordsEncoder model.tableRecords)
            ]
        , column (R10.Card.normal theme)
            [ el subTitle <| text "Table simple"
            , tableSimple
            ]
        , column (R10.Card.normal theme)
            [ row [ width fill ]
                [ el subTitle <| text "tableWithPaginationAndFilters and custom column"
                , el (buttonOutlined ++ [ alignRight, Events.onClick <| Table2ToggleLoadingMsg ]) (text "Toggle loading state")
                ]
            , tableWithPaginationAndFilters
            ]
        , column (R10.Card.normal theme)
            [ el subTitle <| text "tableWithAccordion"
            , tableWithAccordion
            ]
        , column (R10.Card.normal theme)
            [ el subTitle <| text "tableWithCustomStyles"
            , tableWithCustomStyles
            ]
        ]
    ]



--
--
--
--


mouseOverBackgroundColor : Color
mouseOverBackgroundColor =
    rgb 1 0 1


grayLightest : Color
grayLightest =
    rgb 1 0 1


subTitle : List (Attr decorative msg)
subTitle =
    [ Font.size 24 ]


recordColor : String
recordColor =
    "#ff00ff"


buttonOutlined : List (Attribute msg)
buttonOutlined =
    [ Border.width 1 ]


colorPrimary : Color
colorPrimary =
    rgb 1 0 1
