module R10.FormComponents.Internal.IconButton exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Html.Attributes
import Html.Events
import Json.Decode
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormTypes


view :
    List (Attribute msg)
    ->
        { msgOnClick : Maybe msg
        , icon : Element msg
        , palette : R10.FormTypes.Palette
        , size : Int
        }
    -> Element msg
view args { msgOnClick, icon, palette, size } =
    let
        padding_ : Int
        padding_ =
            8

        containerSize : Int
        containerSize =
            24

        iconHitboxSize : Int
        iconHitboxSize =
            size + (padding_ * 2)

        moveUp_ : Float
        moveUp_ =
            toFloat (iconHitboxSize - containerSize) / 2

        attrsCommon : List (Attr () msg)
        attrsCommon =
            [ Background.color <| R10.FormComponents.Internal.UI.Color.onSurfaceA 0 palette
            , padding padding_
            , centerX

            -- achieving `centerY` here. Note: we cannot use `moveUp` because `Html.Attributes.class <| "ripple"` brakes it
            , htmlAttribute <| Html.Attributes.style "margin-top" ("-" ++ String.fromFloat moveUp_ ++ "px")
            ]

        attrsClickable : List (Attr () msg)
        attrsClickable =
            case msgOnClick of
                Just msgOnClick_ ->
                    [ htmlAttribute <| Html.Attributes.tabindex 0
                    , htmlAttribute <| R10.FormComponents.Internal.UI.onSelectKey msgOnClick_
                    , htmlAttribute <| Html.Events.stopPropagationOn "mouseup" (Json.Decode.succeed ( msgOnClick_, False ))
                    , htmlAttribute <| Html.Attributes.class <| "ripple"
                    , htmlAttribute <| Html.Attributes.style "transition" "all 0.13s; margin-top 0s "
                    , pointer
                    , Border.rounded 40
                    , mouseOver [ Border.innerShadow { offset = ( 0, 0 ), size = 40, blur = 0, color = R10.FormComponents.Internal.UI.Color.onSurfaceA 0.07 palette } ]
                    , focused [ Background.color <| R10.FormComponents.Internal.UI.Color.onSurfaceA 0.14 palette ]
                    ]

                Nothing ->
                    [ alpha 0.5 ]
    in
    el
        ([ width <| px containerSize
         , height <| px containerSize
         ]
            ++ args
        )
    <|
        el
            (attrsCommon ++ attrsClickable)
        <|
            el [ centerX, centerY, width <| px size, height <| px size ] <|
                icon
