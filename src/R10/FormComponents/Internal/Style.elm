module R10.FormComponents.Internal.Style exposing (Style(..), default, fromString, toString)


type Style
    = Filled
    | Outlined


toString : Style -> String
toString style =
    case style of
        Filled ->
            "filled"

        Outlined ->
            "outlined"


fromString : String -> Style
fromString string =
    case string of
        "filled" ->
            Filled

        "outlined" ->
            Outlined

        _ ->
            default


default : Style
default =
    Filled
