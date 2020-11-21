module Counter.View exposing (view)

import Counter
import Element exposing (..)
import Element.Font as Font
import Html.Attributes


addSeparator : a -> List a -> List a
addSeparator separator list =
    List.foldl
        (\( index, item ) acc ->
            if modBy 3 ((List.length list - index) - 1) == 0 && List.length list /= index + 1 then
                [ separator, item ] ++ acc

            else
                item :: acc
        )
        []
        (List.indexedMap (\index item -> ( index, item )) list)


downDirection : String -> String -> Bool
downDirection present target =
    case ( String.toInt present, String.toInt target ) of
        ( Just from_, Just to_ ) ->
            to_ - from_ == 1 || to_ - from_ == -9

        _ ->
            False


transition :
    { a
        | position : Float
        , present : String
        , size : Float
        , target : String
    }
    -> Element msg
transition { present, target, size, position } =
    let
        noTransition =
            present == target
    in
    el
        ([ Font.size <| round size
         , clip
         , width fill
         , height fill
         ]
            ++ (if noTransition then
                    []

                else
                    let
                        downDirection_ =
                            downDirection present target

                        -- realPosition goes from size to 0
                        realPosition =
                            size * position
                    in
                    [ inFront <|
                        el
                            [ htmlAttribute <|
                                Html.Attributes.style
                                    -- Using CSS transofrm here instead of Element.moveUp because
                                    -- maybe it has better performcmance
                                    "transform"
                                    ("translateY("
                                        ++ ((if downDirection_ then
                                                -- goes from 0 to size
                                                String.fromFloat (size - realPosition)

                                             else
                                                -- goes from 0 to -size
                                                String.fromFloat (0 - (size - realPosition))
                                            )
                                                ++ "px)"
                                           )
                                    )
                            ]
                        <|
                            text present
                    , inFront <|
                        el
                            [ htmlAttribute <|
                                Html.Attributes.style
                                    "transform"
                                    ("translateY("
                                        ++ (if downDirection present target then
                                                -- goes from -size to 0
                                                String.fromFloat (0 - realPosition)

                                            else
                                                -- goes from size to 0
                                                String.fromFloat realPosition
                                           )
                                        ++ "px)"
                                    )
                            ]
                        <|
                            text target
                    ]
               )
        )
    <|
        el
            (if noTransition then
                []

             else
                [ Font.color <| rgba 0 0 0 0 ]
            )
        <|
            -- This is just a placeholder to occupy the right amount
            -- of space of the target text
            text target


convertToPaddedString : Int -> Int -> String
convertToPaddedString value wheelsQuantity =
    String.padLeft wheelsQuantity '0' (String.fromInt value)


getCharFromStart : Int -> String -> String
getCharFromStart index string =
    String.slice index (index + 1) string


view : Counter.Counter -> Float -> Element msg
view counter size =
    let
        wheelsQuantity =
            Counter.wheelsQuantity counter

        paddedPresent =
            convertToPaddedString (Counter.presentValue counter) wheelsQuantity

        maybeValueTarget =
            Counter.nextValue counter

        separator =
            el [ Font.size <| round size ] <| text ","
    in
    case maybeValueTarget of
        Nothing ->
            -- Counter has no new values to target
            row [] <|
                List.reverse <|
                    addSeparator separator <|
                        List.map
                            (\target ->
                                transition
                                    { present = target
                                    , target = target
                                    , size = size
                                    , position = 0
                                    }
                            )
                            (String.split "" paddedPresent)

        Just valueTarget ->
            let
                paddedTarget =
                    convertToPaddedString valueTarget wheelsQuantity
            in
            row [] <|
                List.reverse <|
                    addSeparator separator <|
                        List.indexedMap
                            (\index _ ->
                                let
                                    target =
                                        getCharFromStart index paddedTarget

                                    present =
                                        getCharFromStart index paddedPresent
                                in
                                transition
                                    { present = present
                                    , target = target
                                    , size = size
                                    , position = Counter.animationPosition counter
                                    }
                            )
                            (List.repeat wheelsQuantity ())
