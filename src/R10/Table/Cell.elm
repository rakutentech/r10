module R10.Table.Cell exposing (simpleCell)

import Element exposing (..)
import Element.Font as Font
import R10.FormComponents.UI.Color
import R10.FormTypes
import R10.Table.Placeholder
import R10.Table.Style


simpleCell : List (Attribute msg) -> (Maybe data -> Maybe String) -> R10.FormTypes.Palette -> Maybe data -> Element msg
simpleCell attrs toStr palette maybeData =
    row
        (R10.Table.Style.defaultCellAttrs ++ attrs)
        (case toStr maybeData of
            Just str ->
                [ paragraph
                    [ Font.color <| R10.FormComponents.UI.Color.onSurface palette ]
                    [ text str ]
                ]

            Nothing ->
                [ R10.Table.Placeholder.view (R10.FormComponents.UI.Color.primary palette) [] ]
        )
