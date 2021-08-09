-- Eventually we could make this the same as R10.Country, but for the moment
-- this is a much simpler version


module R10.CountryCode exposing
    ( CountryCode(..)
    , decoder
    , default
    , fromString
    , isJapan
    , toString
    )

import Json.Decode.Exploration


type CountryCode
    = JP
    | DE
    | Others String


default : CountryCode
default =
    Others "tw"


decoder : Json.Decode.Exploration.Decoder CountryCode
decoder =
    Json.Decode.Exploration.string
        |> Json.Decode.Exploration.andThen
            (\string -> Json.Decode.Exploration.succeed <| fromString string)


fromString : String -> CountryCode
fromString string =
    case String.toLower string of
        "de" ->
            DE

        "jp" ->
            JP

        _ ->
            Others string


toString : CountryCode -> String
toString countryCode =
    case countryCode of
        JP ->
            "jp"

        DE ->
            "de"

        Others string ->
            String.toLower string


isJapan : CountryCode -> Bool
isJapan countryCode =
    case countryCode of
        JP ->
            True

        _ ->
            False
