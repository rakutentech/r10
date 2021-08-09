module R10.Table.Internal.Cell exposing (simpleCell)

import Element.WithContext exposing (..)
import Element.WithContext.Font as Font
import R10.Context exposing (..)
import R10.FormComponents.Internal.UI.Color
import R10.FormTypes
import R10.Table.Internal.Placeholder
import R10.Table.Internal.Style


simpleCell : List (AttributeC msg) -> (Maybe data -> Maybe String) -> R10.FormTypes.Palette -> Maybe data -> ElementC msg
simpleCell attrs toStr palette maybeData =
    row
        (R10.Table.Internal.Style.defaultCellAttrs ++ attrs)
        (case toStr maybeData of
            Just str ->
                [ paragraph
                    [ Font.color <| R10.FormComponents.Internal.UI.Color.onSurface palette ]
                    [ text str ]
                ]

            Nothing ->
                [ R10.Table.Internal.Placeholder.view (R10.FormComponents.Internal.UI.Color.primary palette) [] ]
        )
