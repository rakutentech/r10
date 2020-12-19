module Pages.Counter exposing
    ( Model
    , Msg
    , init
    , subscriptions
    , update
    , view
    )

import Browser.Events
import Element exposing (..)
import Element.Font as Font
import R10.Button
import R10.Counter
import R10.Libu
import R10.Theme


type alias Model =
    { counter : R10.Counter.Counter }


init : Model
init =
    { counter =
        R10.Counter.init
            |> R10.Counter.start
    }


type Msg
    = OnAnimationFrame
    | GoTo Int
    | Add Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        OnAnimationFrame ->
            { model | counter = R10.Counter.update model.counter }

        GoTo value ->
            { model | counter = R10.Counter.moveTo value model.counter }

        Add value ->
            { model | counter = R10.Counter.add value model.counter }


view : Model -> R10.Theme.Theme -> List (Element Msg)
view model theme =
    [ el [ Font.family [ Font.monospace ] ] <| R10.Counter.view model.counter 100
    , row [ spacing 20 ]
        [ R10.Button.secondary [ width shrink ]
            { label = text "Jump To 10"
            , libu = R10.Libu.Bu <| Just <| GoTo 10
            , theme = theme
            }
        , R10.Button.secondary [ width shrink ]
            { label = text "Jump To 0"
            , libu = R10.Libu.Bu <| Just <| GoTo 0
            , theme = theme
            }
        , R10.Button.secondary [ width shrink ]
            { label = text "Add 10"
            , libu = R10.Libu.Bu <| Just <| Add 10
            , theme = theme
            }
        , R10.Button.secondary [ width shrink ]
            { label = text "Add 94,851"
            , libu = R10.Libu.Bu <| Just <| Add 94857
            , theme = theme
            }
        , R10.Button.secondary [ width shrink ]
            { label = text "Subtract 10"
            , libu = R10.Libu.Bu <| Just <| Add -10
            , theme = theme
            }
        ]
    ]



-- COUNTER


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch <|
        if R10.Counter.areMoving [ model.counter ] then
            [ Browser.Events.onAnimationFrame (\_ -> OnAnimationFrame) ]

        else
            []
