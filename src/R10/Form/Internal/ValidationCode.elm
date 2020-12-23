module R10.Form.Internal.ValidationCode exposing (fromValidationCodeToMessageWithReplacedValues)

import R10.Form.Internal.FieldConf
import Regex


fromValidationCodeToMessageWithReplacedValues :
    R10.Form.Internal.FieldConf.ValidationCode
    -> R10.Form.Internal.FieldConf.ValidationPayload
    -> (R10.Form.Internal.FieldConf.ValidationCode -> String)
    -> String
fromValidationCodeToMessageWithReplacedValues validationCode bracketsArgs translator_ =
    let
        translated : String
        translated =
            translator_ validationCode
    in
    if List.isEmpty bracketsArgs then
        translated

    else
        replaceBrackets bracketsArgs translated


replacer : ( Int, String ) -> String -> String
replacer ( index, value ) acc =
    Regex.replace (regexBracket index) (\_ -> value) acc


replaceBrackets : List String -> String -> String
replaceBrackets values target =
    values
        |> List.indexedMap Tuple.pair
        |> List.foldl replacer target


regexBracket : Int -> Regex.Regex
regexBracket index =
    -- Removing all pairs of square brackets that just contain comments
    Regex.fromStringWith { caseInsensitive = True, multiline = True } ("\\{" ++ String.fromInt index ++ "\\}")
        |> Maybe.withDefault Regex.never
