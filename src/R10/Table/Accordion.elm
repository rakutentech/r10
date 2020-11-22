module R10.Table.Accordion exposing (getAttrs)

import Element exposing (..)
import Html
import Html.Attributes
import R10.Table.Style


spinnerElementCss : Element msg
spinnerElementCss =
    Html.node "style"
        []
        [ Html.text
            """
.spinner {
  font-size: 8px;
  width: 1em;
  height: 1em;

  border-radius: 50%;

  -webkit-animation: load5 1.1s infinite ease;
  animation: load5 1.1s infinite ease;
  -webkit-transform: translateZ(0);
  -ms-transform: translateZ(0);
  transform: translateZ(0);
}
@-webkit-keyframes load5 {
  0%,
  100% {
    box-shadow: 0em -2.6em 0em 0em #000000, 1.8em -1.8em 0 0em rgba(0,0,0, 0.2), 2.5em 0em 0 0em rgba(0,0,0, 0.2), 1.75em 1.75em 0 0em rgba(0,0,0, 0.2), 0em 2.5em 0 0em rgba(0,0,0, 0.2), -1.8em 1.8em 0 0em rgba(0,0,0, 0.2), -2.6em 0em 0 0em rgba(0,0,0, 0.5), -1.8em -1.8em 0 0em rgba(0,0,0, 0.7);
  }
  12.5% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.7), 1.8em -1.8em 0 0em #000000, 2.5em 0em 0 0em rgba(0,0,0, 0.2), 1.75em 1.75em 0 0em rgba(0,0,0, 0.2), 0em 2.5em 0 0em rgba(0,0,0, 0.2), -1.8em 1.8em 0 0em rgba(0,0,0, 0.2), -2.6em 0em 0 0em rgba(0,0,0, 0.2), -1.8em -1.8em 0 0em rgba(0,0,0, 0.5);
  }
  25% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.5), 1.8em -1.8em 0 0em rgba(0,0,0, 0.7), 2.5em 0em 0 0em #000000, 1.75em 1.75em 0 0em rgba(0,0,0, 0.2), 0em 2.5em 0 0em rgba(0,0,0, 0.2), -1.8em 1.8em 0 0em rgba(0,0,0, 0.2), -2.6em 0em 0 0em rgba(0,0,0, 0.2), -1.8em -1.8em 0 0em rgba(0,0,0, 0.2);
  }
  37.5% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.2), 1.8em -1.8em 0 0em rgba(0,0,0, 0.5), 2.5em 0em 0 0em rgba(0,0,0, 0.7), 1.75em 1.75em 0 0em #000000, 0em 2.5em 0 0em rgba(0,0,0, 0.2), -1.8em 1.8em 0 0em rgba(0,0,0, 0.2), -2.6em 0em 0 0em rgba(0,0,0, 0.2), -1.8em -1.8em 0 0em rgba(0,0,0, 0.2);
  }
  50% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.2), 1.8em -1.8em 0 0em rgba(0,0,0, 0.2), 2.5em 0em 0 0em rgba(0,0,0, 0.5), 1.75em 1.75em 0 0em rgba(0,0,0, 0.7), 0em 2.5em 0 0em #000000, -1.8em 1.8em 0 0em rgba(0,0,0, 0.2), -2.6em 0em 0 0em rgba(0,0,0, 0.2), -1.8em -1.8em 0 0em rgba(0,0,0, 0.2);
  }
  62.5% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.2), 1.8em -1.8em 0 0em rgba(0,0,0, 0.2), 2.5em 0em 0 0em rgba(0,0,0, 0.2), 1.75em 1.75em 0 0em rgba(0,0,0, 0.5), 0em 2.5em 0 0em rgba(0,0,0, 0.7), -1.8em 1.8em 0 0em #000000, -2.6em 0em 0 0em rgba(0,0,0, 0.2), -1.8em -1.8em 0 0em rgba(0,0,0, 0.2);
  }
  75% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.2), 1.8em -1.8em 0 0em rgba(0,0,0, 0.2), 2.5em 0em 0 0em rgba(0,0,0, 0.2), 1.75em 1.75em 0 0em rgba(0,0,0, 0.2), 0em 2.5em 0 0em rgba(0,0,0, 0.5), -1.8em 1.8em 0 0em rgba(0,0,0, 0.7), -2.6em 0em 0 0em #000000, -1.8em -1.8em 0 0em rgba(0,0,0, 0.2);
  }
  87.5% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.2), 1.8em -1.8em 0 0em rgba(0,0,0, 0.2), 2.5em 0em 0 0em rgba(0,0,0, 0.2), 1.75em 1.75em 0 0em rgba(0,0,0, 0.2), 0em 2.5em 0 0em rgba(0,0,0, 0.2), -1.8em 1.8em 0 0em rgba(0,0,0, 0.5), -2.6em 0em 0 0em rgba(0,0,0, 0.7), -1.8em -1.8em 0 0em #000000;
  }
}
@keyframes load5 {
  0%,
  100% {
    box-shadow: 0em -2.6em 0em 0em #000000, 1.8em -1.8em 0 0em rgba(0,0,0, 0.2), 2.5em 0em 0 0em rgba(0,0,0, 0.2), 1.75em 1.75em 0 0em rgba(0,0,0, 0.2), 0em 2.5em 0 0em rgba(0,0,0, 0.2), -1.8em 1.8em 0 0em rgba(0,0,0, 0.2), -2.6em 0em 0 0em rgba(0,0,0, 0.5), -1.8em -1.8em 0 0em rgba(0,0,0, 0.7);
  }
  12.5% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.7), 1.8em -1.8em 0 0em #000000, 2.5em 0em 0 0em rgba(0,0,0, 0.2), 1.75em 1.75em 0 0em rgba(0,0,0, 0.2), 0em 2.5em 0 0em rgba(0,0,0, 0.2), -1.8em 1.8em 0 0em rgba(0,0,0, 0.2), -2.6em 0em 0 0em rgba(0,0,0, 0.2), -1.8em -1.8em 0 0em rgba(0,0,0, 0.5);
  }
  25% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.5), 1.8em -1.8em 0 0em rgba(0,0,0, 0.7), 2.5em 0em 0 0em #000000, 1.75em 1.75em 0 0em rgba(0,0,0, 0.2), 0em 2.5em 0 0em rgba(0,0,0, 0.2), -1.8em 1.8em 0 0em rgba(0,0,0, 0.2), -2.6em 0em 0 0em rgba(0,0,0, 0.2), -1.8em -1.8em 0 0em rgba(0,0,0, 0.2);
  }
  37.5% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.2), 1.8em -1.8em 0 0em rgba(0,0,0, 0.5), 2.5em 0em 0 0em rgba(0,0,0, 0.7), 1.75em 1.75em 0 0em #000000, 0em 2.5em 0 0em rgba(0,0,0, 0.2), -1.8em 1.8em 0 0em rgba(0,0,0, 0.2), -2.6em 0em 0 0em rgba(0,0,0, 0.2), -1.8em -1.8em 0 0em rgba(0,0,0, 0.2);
  }
  50% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.2), 1.8em -1.8em 0 0em rgba(0,0,0, 0.2), 2.5em 0em 0 0em rgba(0,0,0, 0.5), 1.75em 1.75em 0 0em rgba(0,0,0, 0.7), 0em 2.5em 0 0em #000000, -1.8em 1.8em 0 0em rgba(0,0,0, 0.2), -2.6em 0em 0 0em rgba(0,0,0, 0.2), -1.8em -1.8em 0 0em rgba(0,0,0, 0.2);
  }
  62.5% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.2), 1.8em -1.8em 0 0em rgba(0,0,0, 0.2), 2.5em 0em 0 0em rgba(0,0,0, 0.2), 1.75em 1.75em 0 0em rgba(0,0,0, 0.5), 0em 2.5em 0 0em rgba(0,0,0, 0.7), -1.8em 1.8em 0 0em #000000, -2.6em 0em 0 0em rgba(0,0,0, 0.2), -1.8em -1.8em 0 0em rgba(0,0,0, 0.2);
  }
  75% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.2), 1.8em -1.8em 0 0em rgba(0,0,0, 0.2), 2.5em 0em 0 0em rgba(0,0,0, 0.2), 1.75em 1.75em 0 0em rgba(0,0,0, 0.2), 0em 2.5em 0 0em rgba(0,0,0, 0.5), -1.8em 1.8em 0 0em rgba(0,0,0, 0.7), -2.6em 0em 0 0em #000000, -1.8em -1.8em 0 0em rgba(0,0,0, 0.2);
  }
  87.5% {
    box-shadow: 0em -2.6em 0em 0em rgba(0,0,0, 0.2), 1.8em -1.8em 0 0em rgba(0,0,0, 0.2), 2.5em 0em 0 0em rgba(0,0,0, 0.2), 1.75em 1.75em 0 0em rgba(0,0,0, 0.2), 0em 2.5em 0 0em rgba(0,0,0, 0.2), -1.8em 1.8em 0 0em rgba(0,0,0, 0.5), -2.6em 0em 0 0em rgba(0,0,0, 0.7), -1.8em -1.8em 0 0em #000000;
  }
}
    """
        ]
        |> html


getAccordionContainer : Int -> Bool -> (Element msg -> Element msg)
getAccordionContainer expandedHeight isExpanded =
    let
        commonAttrs : List (Attribute msg)
        commonAttrs =
            [ width fill
            , alignBottom
            , htmlAttribute <| Html.Attributes.style "transition" "all 0.3s ease-in-out"
            , clipY
            ]
    in
    if isExpanded then
        el (commonAttrs ++ [ height <| px expandedHeight ])

    else
        el (commonAttrs ++ [ height <| px 0 ])


spinnerOverlay : Int -> Element msg
spinnerOverlay expandedHeight =
    row
        [ width fill
        , height <| px expandedHeight
        , alignBottom
        ]
        [ spinnerElementCss
        , el
            [ width <| px 10
            , height <| px 10
            , centerX
            , centerY
            , htmlAttribute <| Html.Attributes.class <| "spinner"
            ]
            none
        ]


viewAccordionContainer : Int -> Bool -> (Element msg -> Element msg)
viewAccordionContainer expandedHeight isLoading =
    el
        ([ width fill
         , height <| px expandedHeight
         ]
            ++ (if isLoading then
                    [ alpha 0.7
                    , behindContent <| spinnerOverlay expandedHeight
                    ]

                else
                    [ scrollbarY ]
               )
        )


getAttrs : (Maybe data -> Element msg) -> Int -> (Maybe data -> Bool) -> (Maybe data -> Bool) -> Maybe data -> List (Attribute msg)
getAttrs viewContent expandedHeight getIsExpanded getIsLoading maybeData =
    let
        container : Element msg -> Element msg
        container =
            getAccordionContainer expandedHeight (getIsExpanded maybeData)

        scrollableContainer : Element msg -> Element msg
        scrollableContainer =
            viewAccordionContainer expandedHeight (getIsLoading maybeData)
    in
    R10.Table.Style.defaultRowAttrs
        ++ [ htmlAttribute <| Html.Attributes.style "transition" "padding 0.3s ease-in-out"
           , behindContent <| container <| scrollableContainer <| viewContent maybeData
           ]
        ++ (if getIsExpanded maybeData then
                [ paddingEach { top = 0, right = 0, bottom = expandedHeight, left = 0 } ]

            else
                []
           )
