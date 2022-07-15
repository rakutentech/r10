module R10.FormComponents.Internal.Style exposing (Style(..), default, fromString, toString)


type Style
    = FloatingLabels
    | FixedLabels


toString : Style -> String
toString style =
    case style of
        FloatingLabels ->
            "floatingLabels"

        FixedLabels ->
            "fixedLabels"


fromString : String -> Style
fromString string =
    case string of
        "floatingLabels" ->
            FloatingLabels

        "fixedLabels" ->
            FixedLabels

        _ ->
            default


default : Style
default =
    FloatingLabels
