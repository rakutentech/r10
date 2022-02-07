module R10.Transition exposing
    ( parseCharacteristics
    , transition
    )

import Element.WithContext exposing (..)
import Html.Attributes
import R10.Context
import String.Extra



-- Examples
--
-- "color .2s ease-out, background-color .2s ease-out"
-- "background-color 0.8s"
-- "all 0.15s ease-out"
-- "all 0.2s "
-- "all 0.13s"
-- "all 0.15s ease-in, opacity 0.15s 0.2s ease-in"
-- "opacity 0.2s, visibility 0.2s"
-- "color .2s ease-out, background-color .2s ease-out"
-- "font-size 300ms 0ms ease-in, opacity 300ms 300ms ease-in"
-- "0.2s"
--
--


transition : String -> Attribute (R10.Context.ContextInternal z) msg
transition characteristics =
    withContextAttribute <| \c -> htmlAttribute <| Html.Attributes.style "transition" (parseCharacteristics c.contextR10.debugger_transitionSpeed characteristics)


parseCharacteristics : Float -> String -> String
parseCharacteristics ratio characteristics =
    characteristics
        |> String.Extra.clean
        |> String.split ","
        |> List.map (parseUnit ratio)
        |> String.join ","


parseUnit : Float -> String -> String
parseUnit ratio unit =
    unit
        |> String.split " "
        |> List.map (parseSubUnit ratio)
        |> String.join " "


parseSubUnit : Float -> String -> String
parseSubUnit ratio subUnit =
    if String.endsWith "ms" subUnit then
        case String.toFloat ("0" ++ String.dropRight 2 subUnit) of
            Just value ->
                String.fromFloat (value * ratio) ++ "ms"

            Nothing ->
                subUnit

    else if String.endsWith "s" subUnit then
        case String.toFloat ("0" ++ String.dropRight 1 subUnit) of
            Just value ->
                String.fromFloat (value * ratio) ++ "s"

            Nothing ->
                subUnit

    else
        subUnit
