module R10.Color.Internal.Primary exposing
    ( Color(..), list, default, toColor, toString
    , decoderExploration, decoder
    )

{-| Rakuten brand colors

![Colors](https://r10.netlify.app/images/colors-overview400.png)

More info about colors at <https://r10.netlify.app/>

@docs Color, list, default, toColor, toString


# Encoders/Decoders

@docs decoderExploration, decoder

-}

import Color
import Json.Decode
import Json.Decode.Exploration
import Json.Encode
import R10.Color.Utils
import R10.Mode


{-| -}
type Color
    = Yellow
    | Purple
    | Pink
    | Orange
    | LightBlue
    | Green
    | CrimsonRed
    | Blue
    | BlueSky


{-| -}
decoder : Json.Decode.Decoder Color
decoder =
    let
        findMatch str =
            case
                str
                    |> String.toLower
                    |> String.replace " " ""
                    |> String.replace "crimson" ""
            of
                "yellow" ->
                    Json.Decode.succeed Yellow

                "purple" ->
                    Json.Decode.succeed Purple

                "pink" ->
                    Json.Decode.succeed Pink

                "orange" ->
                    Json.Decode.succeed Orange

                "lightblue" ->
                    Json.Decode.succeed LightBlue

                "green" ->
                    Json.Decode.succeed Green

                "red" ->
                    Json.Decode.succeed CrimsonRed

                "blue" ->
                    Json.Decode.succeed Blue

                "bluesky" ->
                    Json.Decode.succeed BlueSky

                _ ->
                    Json.Decode.fail "Unknown value for Color"
    in
    Json.Decode.string |> Json.Decode.andThen findMatch


{-| -}
toString : Color -> String
toString value =
    case value of
        Yellow ->
            "Yellow"

        Purple ->
            "Purple"

        Pink ->
            "Pink"

        Orange ->
            "Orange"

        LightBlue ->
            "Light Blue"

        Green ->
            "Green"

        CrimsonRed ->
            "Crimson Red"

        Blue ->
            "Blue"

        BlueSky ->
            "Blue Sky"


list :
    { a | mode : R10.Mode.Mode }
    ->
        List
            { color : Color.Color
            , description : String
            , name : String
            , type_ : Color
            }
list theme =
    -- List.map
    --     (\color ->
    --         { color = toColor theme color
    --         , name = toString color
    --         , description = ""
    --         , type_ = color
    --         }
    --     )
    --     list_
    List.map
        (\color ->
            let
                ( color_, description_ ) =
                    case theme.mode of
                        R10.Mode.Light ->
                            toColorLight_ color

                        R10.Mode.Dark ->
                            toColorDark_ color
            in
            { color = color_
            , name = toString color
            , description = description_
            , type_ = color
            }
        )
        list_


{-| -}
list_ : List Color
list_ =
    [ CrimsonRed
    , Pink
    , Purple
    , Blue
    , LightBlue
    , Green
    , Orange
    , Yellow
    ]



-- EXTRA


{-| -}
default : Color
default =
    CrimsonRed


{-| -}
fromString : String -> Color
fromString string =
    Result.withDefault default <|
        Json.Decode.decodeValue decoder (Json.Encode.string string)


{-| -}
decoderExploration : Json.Decode.Exploration.Decoder Color
decoderExploration =
    Json.Decode.Exploration.string
        |> Json.Decode.Exploration.andThen (fromString >> Json.Decode.Exploration.succeed)


{-| -}
toColorLight_ : Color -> ( Color.Color, String )
toColorLight_ color =
    case color of
        CrimsonRed ->
            ( R10.Color.Utils.fromHexToColorColor "#bf0000"
            , "Hard coded as #bf0000"
            )

        Orange ->
            ( R10.Color.Utils.fromHexToColorColor "#f59600"
            , "Hard coded as #f59600"
            )

        Yellow ->
            ( R10.Color.Utils.fromHexToColorColor "#ffcc00"
            , "Hard coded as #ffcc00"
            )

        Green ->
            ( R10.Color.Utils.fromHexToColorColor "#00b900"
            , "Hard coded as #00b900"
            )

        LightBlue ->
            ( R10.Color.Utils.fromHexToColorColor "#00a0f0"
            , "Hard coded as #00a0f0"
            )

        Blue ->
            ( R10.Color.Utils.fromHexToColorColor "#002896"
            , "Hard coded as #002896"
            )

        Purple ->
            ( R10.Color.Utils.fromHexToColorColor "#7d00be"
            , "Hard coded as #7d00be"
            )

        Pink ->
            -- The pink color changed fromm to #ff008c from #ff41be as
            -- per Rakuten Mobile request on 2020.11.19
            ( R10.Color.Utils.fromHexToColorColor "#ff008c"
            , "Hard coded as #ff008c"
            )

        BlueSky ->
            -- The pink color changed fromm to #ff008c from #ff41be as
            -- per Rakuten Mobile request on 2020.11.19
            ( R10.Color.Utils.fromHexToColorColor "#117bb4"
            , "Hard coded as #117bb4"
            )


{-| -}
toColorDark_ : Color -> ( Color.Color, String )
toColorDark_ color =
    case color of
        CrimsonRed ->
            ( R10.Color.Utils.fromLightToDark <| Tuple.first <| toColorLight_ color
            , "Converted from light mode using `R10.Color.Utils.fromLightToDark`"
            )

        Orange ->
            ( R10.Color.Utils.fromLightToDark <| Tuple.first <| toColorLight_ color
            , "Converted from light mode using `R10.Color.Utils.fromLightToDark`"
            )

        Yellow ->
            ( R10.Color.Utils.fromLightToDark <| Tuple.first <| toColorLight_ color
            , "Converted from light mode using `R10.Color.Utils.fromLightToDark`"
            )

        Green ->
            ( R10.Color.Utils.fromLightToDark <| Tuple.first <| toColorLight_ color
            , "Converted from light mode using `R10.Color.Utils.fromLightToDark`"
            )

        LightBlue ->
            ( R10.Color.Utils.fromLightToDark <| Tuple.first <| toColorLight_ color
            , "Converted from light mode using `R10.Color.Utils.fromLightToDark`"
            )

        Blue ->
            ( R10.Color.Utils.fromLightToDark <| Tuple.first <| toColorLight_ color
            , "Converted from light mode using `R10.Color.Utils.fromLightToDark`"
            )

        Purple ->
            ( R10.Color.Utils.fromLightToDark <| Tuple.first <| toColorLight_ color
            , "Converted from light mode using `R10.Color.Utils.fromLightToDark`"
            )

        Pink ->
            ( R10.Color.Utils.fromLightToDark <| Tuple.first <| toColorLight_ color
            , "Converted from light mode using `R10.Color.Utils.fromLightToDark`"
            )

        BlueSky ->
            ( R10.Color.Utils.fromLightToDark <| Tuple.first <| toColorLight_ color
            , "Converted from light mode using `R10.Color.Utils.fromLightToDark`"
            )


{-| Convert a primary color into a `avh4/elm-color` type of color. It requiires a `Mode` because the color can be sligtly different in Light or Dark mode.
-}
toColor : { a | mode : R10.Mode.Mode } -> Color -> Color.Color
toColor theme =
    case theme.mode of
        R10.Mode.Light ->
            \c -> Tuple.first (toColorLight_ c)

        R10.Mode.Dark ->
            \c -> Tuple.first (toColorDark_ c)
