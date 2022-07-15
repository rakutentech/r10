module R10.ValidationDate exposing
    ( Range
    , RangeResult(..)
    , dateToMillis
    , range
    )

import Iso8601
import Parser
import R10.Utils
import Time


prepareDate : String -> Result RangeResult String
prepareDate value =
    -- Remove non-digits and extract year/month/day.
    -- Format the output as YYYY-MM-DD unless there
    -- errors. In which case it returns "" that will
    -- then fail later, during the conversion to date.
    let
        newValue : String
        newValue =
            value
                -- Remove all non-digits
                |> R10.Utils.userReplace "[^\\d]" (\_ -> "")
                -- Add an extra zero if needed, for example
                -- "2000/01/2" -> "2000/01/02"
                |> (\v ->
                        if String.length v == 7 then
                            String.left 6 v ++ "0" ++ String.right 1 v

                        else
                            v
                   )
    in
    if String.length newValue /= 8 then
        Err Need8Digits

    else
        let
            year : String
            year =
                String.slice 0 4 newValue

            month : String
            month =
                String.slice 4 6 newValue

            day : String
            day =
                String.slice 6 8 newValue
        in
        Ok <| year ++ "-" ++ month ++ "-" ++ day


dateToMillis : String -> Result RangeResult Int
dateToMillis date =
    case prepareDate date of
        Err rangeResult ->
            Err rangeResult

        Ok preparedDate ->
            case Iso8601.toTime preparedDate of
                Err iso8601Error ->
                    Err <| ParsingError iso8601Error

                Ok posix ->
                    Ok <| Time.posixToMillis posix


type RangeResult
    = TooOld
    | TooNew
    | MinRangeNotValid
    | MaxRangeNotValid
    | InvertedMinMax
    | Need8Digits
    | ParsingError (List Parser.DeadEnd)


type alias Range =
    { min : Int, max : Int }


range : Range -> String -> Result RangeResult Int
range { min, max } date =
    let
        maybePosixDate =
            dateToMillis date
    in
    case maybePosixDate of
        Err err ->
            Err err

        Ok posixDate ->
            if min > max then
                Err InvertedMinMax

            else if posixDate < min then
                Err TooOld

            else if posixDate > max then
                Err TooNew

            else
                Ok posixDate
