module R10.Table.Internal.Style exposing
    ( defaultCellAttrs
    , defaultHeaderAttrs
    , defaultRowAttrs
    )

import Element.WithContext exposing (..)
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Html.Attributes
import R10.Context exposing (..)
import R10.Transition



-- Application specific


borderColor : Color
borderColor =
    rgba 0 0 0 0.2



{-
   Following styles are from
   https://material.io/components/data-tables/#specs
-}
-- Table cell padding


tableCellPaddingX : number
tableCellPaddingX =
    8


tableCellPaddingY : number
tableCellPaddingY =
    6



-- Corner radius


cornerRadius : number
cornerRadius =
    4



-- Container outline


containerOutline : number
containerOutline =
    1



-- Height and padding


headerRowHeight : number
headerRowHeight =
    56


rowHeight : number
rowHeight =
    52


columnPadding : number
columnPadding =
    16



{-
   Default styles
-}


defaultHeadRowAttrs : List (AttributeC msg)
defaultHeadRowAttrs =
    [ width fill
    , height fill
    , Border.color borderColor
    , Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
    ]


defaultHeaderAttrs : List (AttributeC msg)
defaultHeaderAttrs =
    [ paddingXY columnPadding 0
    , spacing columnPadding
    , width (fill |> minimum 120) -- minimum 120: weird behaviour on shrink otherwise
    , height <| px headerRowHeight
    , htmlAttribute <| Html.Attributes.style "word-break" "break-all"
    , htmlAttribute (Html.Attributes.style "user-select" "none")
    , Font.extraBold
    , Border.color borderColor
    , Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
    ]


defaultRowAttrs : List (AttributeC msg)
defaultRowAttrs =
    [ width fill
    , height fill
    , Border.color borderColor
    , Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
    ]


defaultCellAttrs : List (AttributeC msg)
defaultCellAttrs =
    [ width (fill |> minimum 120)
    , R10.Transition.transition "all 0.25s ease-out"
    , height (fill |> minimum 54)
    , paddingXY 16 6
    , htmlAttribute <| Html.Attributes.style "word-break" "break-word"
    ]
