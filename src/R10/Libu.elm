module R10.Libu exposing (view, Type(..))

{-|

    ██      ██ ██████  ██    ██
    ██      ██ ██   ██ ██    ██
    ██      ██ ██████  ██    ██
    ██      ██ ██   ██ ██    ██
    ███████ ██ ██████   ██████

Hi! I'm Libu, your new friend, half Link and half Button

I am a super-entity that will take care of all your hypertext necessity
as I will let user to go wherever they want.

@docs view, Type

-}

import Element exposing (..)
import Element.Input as Input
import Html
import Html.Events
import Json.Decode


{-| `LiNewTab` => A link that open in a new tab.

`LiInternal` => A link that prevent the default behavior of the browser, to be used in SPA so that the browser doesn't refresh.

`Li` => Just a link.

`Bu` => Just a button.

-}
type Type msg
    = LiNewTab String
    | LiInternal String (String -> msg)
    | Li String
    | Bu (Maybe msg)


{-| -}
view :
    List (Attribute msg)
    -> { type_ : Type msg, label : Element msg }
    -> Element msg
view attrs args =
    case args.type_ of
        Li url ->
            Element.link
                attrs
                { label = args.label
                , url = url
                }

        LiNewTab url ->
            Element.newTabLink
                attrs
                { label = args.label
                , url = url
                }

        LiInternal url onClick ->
            let
                -- From https://github.com/elm/browser/blob/1.0.2/notes/navigation-in-elements.md
                preventDefault : msg -> Html.Attribute msg
                preventDefault msg =
                    Html.Events.preventDefaultOn "click" (Json.Decode.succeed ( msg, True ))
            in
            Element.link
                ((htmlAttribute <| preventDefault (onClick url)) :: attrs)
                { label = args.label
                , url = url
                }

        Bu onPress ->
            Input.button
                attrs
                { label = args.label
                , onPress = onPress
                }
