module R10.FormComponents.Button exposing
    ( Args
    , Button(..)
    , view
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Html.Attributes
import R10.FormComponents.Style
import R10.FormComponents.UI
import R10.FormComponents.UI.Color
import R10.FormComponents.UI.Palette



{- https://material.io/components/buttons

   there is no "Toggle" button type, but you can create Icon button
   In order to do so, specify column and leave text empty
   it would result in

-}


type Button
    = Contained
    | Outlined
    | Text
    | Icon


iconPadding : number
iconPadding =
    0


borderWidth : number
borderWidth =
    1


getIconSize : Args msg -> Int
getIconSize args =
    case args.type_ of
        Icon ->
            24 + (iconPadding * 2)

        _ ->
            16 + (iconPadding * 2)


getRightPadding : Args msg -> Int
getRightPadding args =
    -- https://material.io/components/buttons#specs
    case args.type_ of
        Icon ->
            12

        Text ->
            8

        _ ->
            16


getLeftPadding : Args msg -> Int
getLeftPadding args =
    -- https://material.io/components/buttons#specs
    if args.icon == Nothing then
        getRightPadding args

    else
        case args.type_ of
            Icon ->
                12

            Text ->
                8

            _ ->
                12


viewIcon : Args msg -> Element msg -> Element msg
viewIcon args icon =
    el
        [ width <| px (getIconSize args)
        , height fill
        , padding iconPadding
        , behindContent <| el [ centerX, centerY ] icon
        ]
    <|
        none


getHeight : Args msg -> Int
getHeight args =
    case args.type_ of
        Icon ->
            48 - (borderWidth * 2)

        Text ->
            36

        _ ->
            36 - (borderWidth * 2)


getBorderRadius : Args msg -> number
getBorderRadius args =
    case args.style of
        R10.FormComponents.Style.Filled ->
            0

        R10.FormComponents.Style.Outlined ->
            case args.type_ of
                Icon ->
                    2

                _ ->
                    4


getBackgroundColor : Args msg -> Color
getBackgroundColor args =
    case args.type_ of
        Contained ->
            if args.disabled then
                R10.FormComponents.UI.Color.onSurfaceA 0.24 args.palette

            else
                R10.FormComponents.UI.Color.primary args.palette

        Outlined ->
            R10.FormComponents.UI.Color.primaryA 0 args.palette

        Text ->
            R10.FormComponents.UI.Color.primaryA 0 args.palette

        Icon ->
            R10.FormComponents.UI.Color.surface args.palette


getFontColor : Args msg -> Color
getFontColor args =
    case args.type_ of
        Contained ->
            if args.disabled then
                R10.FormComponents.UI.Color.font args.palette

            else
                R10.FormComponents.UI.Color.onPrimary args.palette

        Outlined ->
            if args.disabled then
                R10.FormComponents.UI.Color.font args.palette

            else
                R10.FormComponents.UI.Color.primary args.palette

        Text ->
            if args.disabled then
                R10.FormComponents.UI.Color.font args.palette

            else
                R10.FormComponents.UI.Color.primary args.palette

        Icon ->
            R10.FormComponents.UI.Color.font args.palette


getBorderColor : Args msg -> Color
getBorderColor args =
    case args.type_ of
        Contained ->
            R10.FormComponents.UI.Color.primaryA 0 args.palette

        Outlined ->
            if args.disabled then
                R10.FormComponents.UI.Color.onSurfaceA 0.5 args.palette

            else
                R10.FormComponents.UI.Color.primary args.palette

        Text ->
            R10.FormComponents.UI.Color.primaryA 0 args.palette

        Icon ->
            R10.FormComponents.UI.Color.background args.palette


getAccentColor : Args msg -> Bool -> Bool -> Color
getAccentColor args isHovered isFocused =
    let
        opacity : Float
        opacity =
            if isFocused then
                3

            else if isHovered then
                1

            else
                0
    in
    case args.type_ of
        Contained ->
            R10.FormComponents.UI.Color.surfaceA (0.08 * opacity) args.palette

        Outlined ->
            R10.FormComponents.UI.Color.primaryA (0.08 * opacity) args.palette

        Text ->
            R10.FormComponents.UI.Color.onSurfaceA (0.08 * opacity) args.palette

        Icon ->
            R10.FormComponents.UI.Color.onSurfaceA (0.04 * opacity) args.palette


getRippleCls : Args msg -> String
getRippleCls args =
    case args.type_ of
        Contained ->
            "ripple-on-primary"

        Outlined ->
            "ripple-primary"

        Text ->
            "ripple-primary"

        Icon ->
            "ripple"


type alias Args msg =
    { type_ : Button

    --  icon should be 18px, for Icon button 24px https://material.io/components/buttons#specs
    , icon : Maybe (Element msg)
    , text : String
    , onClick : msg
    , palette : R10.FormComponents.UI.Palette.Palette
    , style : R10.FormComponents.Style.Style
    , disabled : Bool
    }


view : List (Attribute msg) -> Args msg -> Element msg
view attrs args =
    row
        ([ Background.color <| getBackgroundColor args
         , Border.color <| getBorderColor args
         , Border.rounded <| getBorderRadius args
         , Border.width 1
         , Font.color <| getFontColor args
         , height <| px <| getHeight args
         , htmlAttribute <| Html.Attributes.style "user-select" "none"
         , paddingEach { top = 0, right = getRightPadding args, bottom = 0, left = getLeftPadding args }
         , spacing 8

         -- ripple effect
         , inFront <|
            el
                ([ width fill
                 , height fill
                 , htmlAttribute <| Html.Attributes.class <| getRippleCls args
                 ]
                    ++ (if args.disabled then
                            []

                        else
                            [ -- we dont want to put click listener directly on the button container
                              -- since click on child components (appended using below, etc.)
                              -- would be interpreted as a click on the button itself
                              Events.onClick args.onClick
                            ]
                       )
                )
                none

         -- todo: min-width should be 64 (button)/48 (icon) [https://material.io/components/buttons#specs]
         ]
            ++ (if args.disabled then
                    [ alpha 0.35 ]

                else
                    [ pointer

                    -- focus, mouseOver states. Note: `focused` should go before `mouseOver` in order to be higher priority then mouseOver
                    , Border.innerShadow { offset = ( 0, 0 ), size = 40, blur = 0, color = getAccentColor args False False }
                    , focused [ Border.innerShadow { offset = ( 0, 0 ), size = 40, blur = 0, color = getAccentColor args False True } ]
                    , mouseOver [ Border.innerShadow { offset = ( 0, 0 ), size = 40, blur = 0, color = getAccentColor args True False } ]

                    -- button should be activated by any "selection" key or click
                    , htmlAttribute <| Html.Attributes.tabindex 0
                    , htmlAttribute <| R10.FormComponents.UI.onSelectKey args.onClick
                    ]
                        ++ attrs
               )
        )
    <|
        (case args.icon of
            Just icon ->
                [ viewIcon args icon ]

            Nothing ->
                []
        )
            ++ (if args.type_ == Icon then
                    []

                else
                    [ el [ centerX ] <| text args.text ]
               )
