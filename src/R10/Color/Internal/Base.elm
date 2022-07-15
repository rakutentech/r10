module R10.Color.Internal.Base exposing (Color(..), list, toColor)

{-| Rakuten base colors.

From these 6 colors all other colors are generated programmatically.

This module is not exposed as these colors should not be used directly.

The only way to get these color is through `list` just for documentation purpose.

@docs Color, list, toColor

-}

import Color
import R10.Color.Utils
import R10.Mode
import R10.Theme


type Color
    = Background
    | BackgroundAlertDanger
    | BackgroundAlertSuccess
    | BackgroundAlertInfo
    | BackgroundAlertWarning
    | Font
    | FontAlertDanger
    | FontAlertSuccess
    | FontAlertInfo
    | FontAlertWarning
    | FontReversed
    | FontLink
    | Border


toColor : R10.Theme.Theme -> (Color -> Color.Color)
toColor theme =
    case theme.mode of
        R10.Mode.Light ->
            \c -> toColorLight_ c

        R10.Mode.Dark ->
            \c -> toColorDark_ c


list : R10.Theme.Theme -> List { color : Color.Color, name : String }
list theme =
    List.map
        (\color ->
            let
                color_ =
                    case theme.mode of
                        R10.Mode.Light ->
                            toColorLight_ color

                        R10.Mode.Dark ->
                            toColorDark_ color
            in
            { color = color_
            , name = toString_ color
            }
        )
        list_



-- INTERNALS


toString_ : Color -> String
toString_ value =
    case value of
        Background ->
            "Background"

        BackgroundAlertInfo ->
            "BackgroundAlertInfo"

        BackgroundAlertDanger ->
            "BackgroundAlertDanger"

        BackgroundAlertSuccess ->
            "BackgroundAlertSuccess"

        BackgroundAlertWarning ->
            "BackgroundAlertWarning"

        Font ->
            "Font"

        FontAlertInfo ->
            "FontAlertInfo"

        FontAlertDanger ->
            "FontAlertDanger"

        FontAlertSuccess ->
            "FontAlertSuccess"

        FontAlertWarning ->
            "FontAlertWarning"

        FontReversed ->
            "Font Reversed"

        FontLink ->
            "Font Link"

        Border ->
            "Border"


list_ : List Color
list_ =
    [ Background
    , BackgroundAlertDanger
    , BackgroundAlertSuccess
    , BackgroundAlertInfo
    , BackgroundAlertWarning
    , Font
    , FontAlertDanger
    , FontAlertSuccess
    , FontAlertInfo
    , FontAlertWarning
    , FontReversed
    , FontLink
    , Border
    ]


toColorLight_ : Color -> Color.Color
toColorLight_ color =
    case color of
        Font ->
            R10.Color.Utils.fromHexToColorColor "#000000"

        FontAlertDanger ->
            -- https://dev-cdn.rex.contents.rakuten.co.jp/rex-form/v1.7.0/components/alert.html
            R10.Color.Utils.fromHexToColorColor "#df0101"

        FontAlertInfo ->
            -- https://dev-cdn.rex.contents.rakuten.co.jp/rex-form/v1.7.0/components/alert.html
            R10.Color.Utils.fromHexToColorColor "#006497"

        FontAlertSuccess ->
            -- https://dev-cdn.rex.contents.rakuten.co.jp/rex-form/v1.7.0/components/alert.html
            R10.Color.Utils.fromHexToColorColor "#047205"

        FontAlertWarning ->
            -- https://dev-cdn.rex.contents.rakuten.co.jp/rex-form/v1.7.0/components/alert.html
            R10.Color.Utils.fromHexToColorColor "#a35e04"

        FontReversed ->
            R10.Color.Utils.fromHexToColorColor "#ffffff"

        FontLink ->
            -- OLD OMNI COLOR #00a0f0
            -- OLD COLOR but with enough contrast #0075af
            -- PRIMARY COLOR FROM REX #134ff3 https://dev-cdn.rex.contents.rakuten.co.jp/rex-form/v1.7.0/components/button.html
            -- INFO COLOR #006497 http://rex.public.rakuten-it.com/design/the-basics/ui-colors/ui-colors-overview/#ui-color
            R10.Color.Utils.fromHexToColorColor "#134ff3"

        Background ->
            R10.Color.Utils.fromHexToColorColor "#ebebeb"

        BackgroundAlertDanger ->
            -- https://dev-cdn.rex.contents.rakuten.co.jp/rex-form/v1.7.0/components/alert.html
            R10.Color.Utils.fromHexToColorColor "#fff0f0"

        BackgroundAlertInfo ->
            -- https://dev-cdn.rex.contents.rakuten.co.jp/rex-form/v1.7.0/components/alert.html
            R10.Color.Utils.fromHexToColorColor "#ebf7fe"

        BackgroundAlertSuccess ->
            -- https://dev-cdn.rex.contents.rakuten.co.jp/rex-form/v1.7.0/components/alert.html
            R10.Color.Utils.fromHexToColorColor "#ebf7ec"

        BackgroundAlertWarning ->
            -- https://dev-cdn.rex.contents.rakuten.co.jp/rex-form/v1.7.0/components/alert.html
            R10.Color.Utils.fromHexToColorColor "#fef0dd"

        Border ->
            -- Original #999999
            -- New      #cccccc (More subtle to avoid the outline input field to be too invasive
            R10.Color.Utils.fromHexToColorColor "#cccccc"


toColorDark_ : Color -> Color.Color
toColorDark_ color =
    -- http://rex.public.rakuten-it.com/design/mobile/mobile-apps/dark-mode/
    case color of
        Font ->
            R10.Color.Utils.fromHexToColorColor "#ffffff"

        FontAlertDanger ->
            -- Original ReX #ff8b8b
            -- Modified     #ff6969
            R10.Color.Utils.fromHexToColorColor "#ff6969"

        FontAlertInfo ->
            R10.Color.Utils.fromHexToColorColor "#3cbdff"

        FontAlertSuccess ->
            -- Original ReX #2ce42c
            -- Modified     #5cad5c
            R10.Color.Utils.fromHexToColorColor "#5cad5c"

        FontAlertWarning ->
            R10.Color.Utils.fromHexToColorColor "#f26a00"

        FontReversed ->
            R10.Color.Utils.fromHexToColorColor "#000000"

        FontLink ->
            -- https://jira.rakuten-it.com/jira/browse/OMN-5167
            -- http://rex.public.rakuten-it.com/design/mobile/mobile-apps/dark-mode/
            R10.Color.Utils.fromHexToColorColor "#3cbdff"

        Background ->
            R10.Color.Utils.fromHexToColorColor "#121212"

        BackgroundAlertDanger ->
            R10.Color.Utils.fromHexToColorColor "#333333"

        BackgroundAlertInfo ->
            R10.Color.Utils.fromHexToColorColor "#333333"

        BackgroundAlertSuccess ->
            R10.Color.Utils.fromHexToColorColor "#333333"

        BackgroundAlertWarning ->
            R10.Color.Utils.fromHexToColorColor "#333333"

        Border ->
            -- Original #999999
            -- New      #666666 (More subtle to avoid the outline input field to be too invasive
            R10.Color.Utils.fromHexToColorColor "#666666"
