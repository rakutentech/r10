module Counter exposing
    ( Counter
    , add
    , animationPosition
    , areMoving
    , init
    , jumpTo
    , lastValueInTheQueue
    , moveTo
    , nextValue
    , pause
    , presentValue
    , setSpeedInDigitsPerSecond
    , start
    , stop
    , update
    , wheelsQuantity
    )

import Array


type Size
    = Flexible
    | Fixed Int


type Speed
    = Elastic
    | Rigid Float


type Counter
    = Counter
        { size : Size
        , nextValues : List Int
        , value : Int
        , cachedStepSize : Float
        , animationPosition : Float
        , speed : Speed
        , pause : Bool
        }


init : Counter
init =
    let
        defaultNextValues =
            []

        defaultSpeed =
            Elastic
    in
    Counter
        { -- TODO Fix the case that size = Flexible, because it doesn't work...
          size = Fixed 9
        , value = 0
        , nextValues = defaultNextValues
        , cachedStepSize = calculateCachedStepSize defaultSpeed (List.length defaultNextValues)
        , animationPosition = 0
        , speed = defaultSpeed
        , pause = True
        }


presentValue : Counter -> Int
presentValue (Counter data) =
    data.value


animationPosition : Counter -> Float
animationPosition (Counter data) =
    data.animationPosition


stop : Counter -> Counter
stop (Counter data) =
    Counter
        { data
            | nextValues =
                case data.nextValues of
                    [] ->
                        []

                    value :: _ ->
                        [ value ]
        }


pause : Counter -> Counter
pause (Counter data) =
    Counter { data | pause = True }


nextValue : Counter -> Maybe Int
nextValue (Counter data) =
    List.head data.nextValues


startNextTransition : Counter -> Counter
startNextTransition (Counter data) =
    case data.nextValues of
        [] ->
            Counter data

        newValue :: [] ->
            -- There was only one element in the nextValues
            -- so no need to start a new animation cycle
            Counter
                { data
                    | value = newValue
                    , nextValues = []
                    , animationPosition = 0
                }

        newValue :: newNextValues ->
            Counter
                { data
                    | value = newValue
                    , nextValues = newNextValues
                    , cachedStepSize = calculateCachedStepSize data.speed (List.length data.nextValues)
                    , animationPosition = 1
                }


calculateCachedStepSize : Speed -> Int -> Float
calculateCachedStepSize speed lengthNextValues =
    case speed of
        Elastic ->
            toFloat (lengthNextValues + 1) / 60

        Rigid speed_ ->
            speed_ / 60


update : Counter -> Counter
update (Counter data) =
    if data.pause then
        Counter data

    else
        let
            newPosition =
                data.animationPosition - data.cachedStepSize

            newCounter =
                if newPosition < 0 then
                    startNextTransition (Counter { data | animationPosition = 0 })

                else
                    Counter { data | animationPosition = newPosition }
        in
        newCounter


areMoving : List Counter -> Bool
areMoving counters =
    List.foldl
        (\(Counter data) acc ->
            if acc then
                True

            else
                (data.animationPosition > 0 || List.length data.nextValues >= 1) && not data.pause
        )
        False
        counters


setSpeedInDigitsPerSecond : Float -> Counter -> Counter
setSpeedInDigitsPerSecond dps (Counter data) =
    {-
        0.5                    0.5 / 60
        1   digit per second:   1  / 60 = 1/60
        2   digit per second:   2  / 60 = 2/60
       60   digit per second:  60  / 60 = 1

       Automatic speed

       Diff  Speed (dps)

       1     1
       2     2

    -}
    Counter { data | cachedStepSize = dps / 60 }


start : Counter -> Counter
start (Counter data) =
    Counter { data | pause = False }


add : Int -> Counter -> Counter
add delta (Counter data) =
    moveTo
        (lastValueInTheQueue (Counter data) + delta)
        (Counter data)


moveTo : Int -> Counter -> Counter
moveTo target (Counter data) =
    -- Move gradually to a certain number. Use only if the difference
    -- with the present value is small
    let
        targetNotNegative =
            if target < 0 then
                0

            else
                target
    in
    if targetNotNegative == lastValueInTheQueue (Counter data) then
        Counter data

    else
        let
            lastValue =
                lastValueInTheQueue (Counter data)

            quantity =
                abs (targetNotNegative - lastValue)

            direction =
                if targetNotNegative < lastValue then
                    -1

                else
                    1
        in
        List.foldl
            (\_ counter_ -> jumpTo (lastValueInTheQueue counter_ + direction) counter_)
            (Counter data)
            (List.repeat quantity ())


lastValueInTheQueue : Counter -> Int
lastValueInTheQueue (Counter data) =
    Maybe.withDefault data.value <|
        Array.get
            (List.length data.nextValues - 1)
            (Array.fromList data.nextValues)


numberOfDigits : Int -> Int
numberOfDigits number =
    round (logBase 10 (toFloat number + 1) + 1)


wheelsQuantity : Counter -> Int
wheelsQuantity (Counter data) =
    case data.size of
        Flexible ->
            numberOfDigits <| max data.value (Maybe.withDefault 0 (nextValue (Counter data)))

        Fixed wheels ->
            wheels


jumpTo : Int -> Counter -> Counter
jumpTo target (Counter data) =
    -- Jump into a certain number as fast as possible, rotating the wheel in
    -- the most convenient direction
    let
        targetNotNegative =
            if target < 0 then
                0

            else
                target
    in
    if target == lastValueInTheQueue (Counter data) then
        Counter data

    else
        let
            newNextValues =
                data.nextValues
                    ++ List.reverse
                        -- We generate all steps recursively
                        (listSteps
                            { target = targetNotNegative
                            , present = lastValueInTheQueue (Counter data)
                            , wheelsQuantity = wheelsQuantity (Counter data)
                            , nextValues = []
                            }
                        )

            newCashedStepSize =
                calculateCachedStepSize data.speed (List.length newNextValues)

            newAnimationPosition =
                -- restart the transition in case the counter was not moving
                if data.animationPosition == 0 then
                    1

                else
                    data.animationPosition
        in
        Counter
            { data
                | nextValues = newNextValues
                , animationPosition = newAnimationPosition
                , cachedStepSize = newCashedStepSize
            }


addLimited : number -> number -> number
addLimited a b =
    let
        sum =
            a + b
    in
    if sum > 9 then
        sum - 10

    else if sum < 0 then
        sum + 10

    else
        sum


directionClosestToTarget : Int -> Int -> Int
directionClosestToTarget present target =
    if present == target then
        0

    else
        let
            normalizedTarget =
                target - present
        in
        if normalizedTarget > 5 || (normalizedTarget < 0 && normalizedTarget >= -5) then
            -1

        else
            1


getCharFromEnd : Int -> String -> String
getCharFromEnd index string =
    String.slice (-2 - index) (-1 - index) (string ++ "X")


toInt : String -> Int
toInt string =
    Maybe.withDefault 0 <| String.toInt string


helper : String -> String -> Int -> a -> String
helper present target index _ =
    let
        slicePresent =
            getCharFromEnd index present

        sliceTarget =
            getCharFromEnd index target

        sliceIntPresent =
            toInt slicePresent

        sliceIntTarget =
            toInt sliceTarget

        direction =
            directionClosestToTarget sliceIntPresent sliceIntTarget

        gettingCloser =
            addLimited sliceIntPresent direction
    in
    String.fromInt gettingCloser


convertToPaddedString : Int -> Int -> String
convertToPaddedString value digitsQuantity =
    String.padLeft digitsQuantity '0' (String.fromInt value)


calculateNextValue : Int -> Int -> Int -> Maybe Int
calculateNextValue valueTarget valuePresent digitsQuantity =
    if valueTarget == valuePresent then
        Nothing

    else
        Just <|
            let
                present =
                    convertToPaddedString valuePresent digitsQuantity

                target =
                    convertToPaddedString valueTarget digitsQuantity
            in
            List.indexedMap (helper present target) (List.repeat digitsQuantity ())
                |> List.reverse
                |> String.join ""
                |> String.toInt
                |> Maybe.withDefault 0


listSteps :
    { wheelsQuantity : Int
    , nextValues : List Int
    , present : Int
    , target : Int
    }
    -> List Int
listSteps args =
    let
        maybeGettingCloser =
            calculateNextValue args.target args.present args.wheelsQuantity
    in
    case maybeGettingCloser of
        Nothing ->
            -- No next value, probably we were already there
            args.nextValues

        Just gettingCloser ->
            if gettingCloser == args.target then
                -- We reach the goal, end of the recursion!
                gettingCloser :: args.nextValues

            else
                listSteps
                    { target = args.target
                    , present = gettingCloser
                    , wheelsQuantity = args.wheelsQuantity
                    , nextValues = gettingCloser :: args.nextValues
                    }
