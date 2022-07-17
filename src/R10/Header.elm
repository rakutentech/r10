module R10.Header exposing (view, Header, LanguageSystem(..), Msg(..), Session(..), SessionData, ViewArgs, attrsLink, closeMenu, decodeSession, extraCss, getSession, init, languageMenu, urlLogin, logoutLink, menuSeparator, menuTitle, subscriptions, update, userExample, iconHamburger, cssHamburger)

{-| This create a generic header.

@docs view, Header, LanguageSystem, Msg, Session, SessionData, ViewArgs, attrsLink, closeMenu, decodeSession, extraCss, getSession, init, languageMenu, urlLogin, logoutLink, menuSeparator, menuTitle, subscriptions, update, userExample, iconHamburger, cssHamburger

-}

import Browser.Events
import Color
import Element.WithContext exposing (..)
import Element.WithContext.Background as Background
import Element.WithContext.Border as Border
import Element.WithContext.Events as Events
import Element.WithContext.Font as Font
import Element.WithContext.Input as Input
import Html
import Html.Attributes
import Http
import Json.Decode
import Process
import R10.Card
import R10.Color.AttrsBackground
import R10.Color.Internal.Primary
import R10.Color.Svg
import R10.Color.Utils
import R10.Context exposing (..)
import R10.FontSize
import R10.I18n
import R10.Language
import R10.Libu
import R10.Mode
import R10.Theme
import R10.Transition
import R10.Translations
import Task


{-| -}
userExample : { email : String, firstName : String, lastName : String }
userExample =
    { email = "taro@example.com"
    , firstName = "firstName"
    , lastName = "lastName"
    }


{-| -}
closeMenu : Header -> Header
closeMenu model =
    { model | sideMenuOpen = False }


{-| -}
type alias SessionData =
    { email : String
    , firstName : String
    , lastName : String
    }


{-| -}
type Session
    = SessionNotRequired
    | SessionNotRequested
    | SessionFetching
    | SessionSuccess SessionData
    | SessionError Http.Error


{-| -}
type alias Header =
    { sideMenuOpen : Bool
    , userMenuOpen : Bool
    , maxWidth : Int
    , padding : Int
    , supportedLanguageList : List R10.Language.Language
    , urlLogin : String
    , urlLogout : String
    , session : Session
    , debuggingMode : Bool
    , backgroundColor : Maybe Color
    }


{-| -}
type alias ViewArgs z msg route =
    { extraContent : List (Element (R10.Context.ContextInternal z) msg)
    , extraContentRightSide : List (Element (R10.Context.ContextInternal z) msg)
    , from : String
    , msgMapper : Msg -> msg
    , isTop : Bool
    , isMobile : Bool
    , onClick : String -> msg
    , urlTop : String
    , languageSystem : LanguageSystem route
    , logoOnDark : Element (R10.Context.ContextInternal z) msg
    , logoOnLight : Element (R10.Context.ContextInternal z) msg
    , darkHeader : Bool
    , theme : R10.Theme.Theme
    }


{-| -}
init : Header
init =
    { sideMenuOpen = False
    , userMenuOpen = False
    , maxWidth = 1000
    , padding = 20
    , supportedLanguageList = R10.Language.defaultSupportedLanguageList
    , urlLogin = "/api/session/redirect"
    , urlLogout = "/api/logout"
    , session = SessionNotRequested
    , debuggingMode = False
    , backgroundColor = Nothing
    }


{-| -}
type Msg
    = ToggleSideMenu
    | ToggleUserMenu
    | Logout
    | Login
    | CloseUserMenu
    | KeyDown KeyPressed
    | Click (List String)
    | GotSession (Result Http.Error SessionData)


{-| -}
getSession : Float -> Cmd Msg
getSession delay =
    Process.sleep delay
        |> Task.andThen (\_ -> getSessionTask)
        |> Task.attempt GotSession


{-| -}
getSessionTask : Task.Task Http.Error SessionData
getSessionTask =
    Http.task
        { method = "GET"
        , headers = []
        , url = "/api/session"
        , body = Http.emptyBody
        , resolver = Http.stringResolver responseToResult
        , timeout = Nothing
        }


{-| -}
responseToResult : Http.Response String -> Result Http.Error SessionData
responseToResult responseString =
    case responseString of
        Http.BadUrl_ url ->
            Err <| Http.BadUrl url

        Http.Timeout_ ->
            Err <| Http.Timeout

        Http.NetworkError_ ->
            Err <| Http.NetworkError

        Http.BadStatus_ metadata _ ->
            Err <| Http.BadStatus metadata.statusCode

        Http.GoodStatus_ _ body ->
            case Json.Decode.decodeString decodeSession body of
                Err err ->
                    Err <| Http.BadBody (Json.Decode.errorToString err)

                Ok ok ->
                    Ok ok


{-| -}
decodeSession : Json.Decode.Decoder SessionData
decodeSession =
    Json.Decode.map3 SessionData
        (Json.Decode.field "email" Json.Decode.string)
        (Json.Decode.field "first_name" Json.Decode.string)
        (Json.Decode.field "last_name" Json.Decode.string)


{-| -}
update : Msg -> Header -> Header
update msg model =
    case msg of
        Logout ->
            { model
                | session = SessionError Http.NetworkError
                , userMenuOpen = False
                , sideMenuOpen = False
            }

        Login ->
            { model
                | session = SessionSuccess userExample
                , userMenuOpen = False
                , sideMenuOpen = False
            }

        Click ids ->
            if model.userMenuOpen && not (List.member userMenuId ids) && not (List.member userMenuButtonId ids) then
                { model | userMenuOpen = False }

            else
                model

        ToggleUserMenu ->
            { model | userMenuOpen = not model.userMenuOpen }

        -- model
        ToggleSideMenu ->
            { model | sideMenuOpen = not model.sideMenuOpen }

        CloseUserMenu ->
            { model | userMenuOpen = False }

        KeyDown key ->
            case key of
                Escape ->
                    { model
                        | userMenuOpen = False
                        , sideMenuOpen = False
                    }

                _ ->
                    model

        GotSession result ->
            case result of
                Ok session ->
                    { model | session = SessionSuccess session }

                Err error ->
                    { model | session = SessionError error }


{-| -}
menuTitle : List (Element (R10.Context.ContextInternal z) msg) -> Element (R10.Context.ContextInternal z) msg
menuTitle elements =
    paragraph
        [ width fill
        , Font.light
        , paddingEach { top = 40, right = 20, bottom = 15, left = 20 }
        , Font.size 26

        -- , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
        -- , Border.color <| rgba 0 0 0 0.1
        ]
    <|
        elements


{-| -}
menuSeparator : List (Element (R10.Context.ContextInternal z) msg)
menuSeparator =
    [ el
        [ width fill
        , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
        , Border.color <| rgba 0.6 0.6 0.6 0.2
        , height <| px 10
        ]
      <|
        text ""
    , el [ height <| px 10 ] <| text ""
    ]


{-| -}
subscriptions : Header -> (Msg -> msg) -> List (Sub msg)
subscriptions model msgMapper =
    if model.userMenuOpen then
        [ Sub.map msgMapper <| Browser.Events.onClick (Json.Decode.map Click decoderPart1)
        , Sub.map msgMapper <| Browser.Events.onKeyDown (Json.Decode.map KeyDown keyDecoder)
        ]

    else if model.sideMenuOpen then
        [ Sub.map msgMapper <| Browser.Events.onKeyDown (Json.Decode.map KeyDown keyDecoder)
        ]

    else
        []


{-| -}
type LanguageSystem route
    = LanguageInRoute
        { routeToPath : R10.Language.Language -> route -> String
        , route : route
        , routeToLanguage : route -> R10.Language.Language
        }
      --
      -- TODO - Finish to implement "LanguageInModel"
      --
    | LanguageInModel


{-| Styles for the Hamburger icon
-}
cssHamburger : String -> String
cssHamburger color =
    """/*!
 * Hamburgers
 * @description Tasty CSS-animated hamburgers
 * @author Jonathan Suh @jonsuh
 * @site https://jonsuh.com/hamburgers
 * @link https://github.com/jonsuh/hamburgers
 */
.hamburger:focus {
  outline: -webkit-focus-ring-color auto 0px;
}
.hamburger {
  padding: 15px 15px;
  display: inline-block;
  cursor: pointer;
  transition-property: opacity, filter;
  transition-duration: 0.15s;
  transition-timing-function: linear;
  font: inherit;
  color: inherit;
  text-transform: none;
  background-color: transparent;
  border: 0;
  margin: 0;
  overflow: visible;
}
/* .hamburger:hover { opacity: 0.7 } */
/* .hamburger.is-active:hover { opacity: 0.7 } */
.hamburger.is-active .hamburger-inner,
.hamburger.is-active .hamburger-inner::before,
.hamburger.is-active .hamburger-inner::after {
  background-color: """ ++ color ++ """;
}
.hamburger-box {
  width: 30px;
  height: 24px;
  display: inline-block;
  position: relative;
}
.hamburger-inner {
  display: block;
  top: 50%;
  margin-top: -2px;
}
.hamburger-inner, .hamburger-inner::before, .hamburger-inner::after {
  width: 30px;
  height: 3px;
  background-color: """ ++ color ++ """;
  border-radius: 3px;
  position: absolute;
  transition-property: transform;
  transition-duration: 0.15s;
  transition-timing-function: ease;
}
.hamburger-inner::before, .hamburger-inner::after {
    content: "";
    display: block; 
}
.hamburger-inner::before {
    top: -10px;
}
.hamburger-inner::after {
    bottom: -10px;
}

/*
   * Elastic
   */
.hamburger--elastic .hamburger-inner {
  top: 2px;
  transition-duration: 0.275s;
  transition-timing-function: cubic-bezier(0.68, -0.55, 0.265, 1.55); }
  .hamburger--elastic .hamburger-inner::before {
    top: 10px;
    transition: opacity 0.125s 0.275s ease; }
  .hamburger--elastic .hamburger-inner::after {
    top: 20px;
    transition: transform 0.275s cubic-bezier(0.68, -0.55, 0.265, 1.55); }

.hamburger--elastic.is-active .hamburger-inner {
  transform: translate3d(0, 10px, 0) rotate(135deg);
  transition-delay: 0.075s; }
  .hamburger--elastic.is-active .hamburger-inner::before {
    transition-delay: 0s;
    opacity: 0; }
  .hamburger--elastic.is-active .hamburger-inner::after {
    transform: translate3d(0, -20px, 0) rotate(-270deg);
    transition-delay: 0.075s; }"""


fontColorHeader :
    { a
        | darkHeader : Bool
        , theme :
            { mode : R10.Mode.Mode
            , primaryColor : R10.Color.Internal.Primary.Color
            }
    }
    -> Color
fontColorHeader args =
    let
        theme =
            args.theme
    in
    if args.darkHeader then
        -- The header is always dark
        R10.Color.Svg.fontHighEmphasis { theme | mode = R10.Mode.Dark }

    else
        R10.Color.Svg.fontHighEmphasis theme


{-| -}
view : Header -> ViewArgs z msg route -> Element (R10.Context.ContextInternal z) msg
view model args =
    el
        [ padding 0
        , width fill
        , R10.Transition.transition "background 0.4s"
        , htmlAttribute <| Html.Attributes.style "z-index" "20"
        , if args.darkHeader then
            case model.backgroundColor of
                Nothing ->
                    R10.Color.AttrsBackground.buttonPrimary

                Just color ->
                    Background.color color

          else
            Background.color <|
                rgba 1
                    1
                    1
                    (if args.isTop then
                        0.6

                     else
                        1
                    )
        , let
            hamburgerColor =
                if model.sideMenuOpen then
                    R10.Color.Svg.fontHighEmphasis args.theme

                else
                    fontColorHeader args
          in
          inFront <| html <| Html.node "style" [] [ Html.text (cssHamburger <| R10.Color.Utils.toCssRgba hamburgerColor) ]
        , inFront <| cover model args
        , inFront <| sideMenu model args
        , inFront <| hambergAndLogo model args
        ]
    <|
        header model args


{-| -}
header : Header -> ViewArgs z msg route -> Element (R10.Context.ContextInternal z) msg
header model args =
    el
        [ width fill
        , centerX
        , R10.FontSize.normal
        , paddingXY 30 0
        , R10.Transition.transition "height 0.3s, box-shadow 0.5s"
        , Border.shadow
            { offset = ( 0, 0 )
            , size = 0
            , blur = 8
            , color =
                rgba 0
                    0
                    0
                    (if args.isTop then
                        0

                     else
                        0.3
                    )
            }
        , height <|
            px
                (if args.isTop then
                    80

                 else
                    60
                )
        ]
    <|
        row
            [ alignRight
            , moveDown (fromTop args.isTop + 10)
            , spacing 30
            ]
            (args.extraContentRightSide
                ++ userSection model args
            )


{-| -}
userSection : Header -> ViewArgs z msg route -> List (Element (R10.Context.ContextInternal z) msg)
userSection model args =
    [ el
        [ R10.Transition.transition "transform 0.2s"
        , inFront <|
            if model.userMenuOpen then
                userMenu model args

            else
                none
        ]
      <|
        let
            transition =
                R10.Transition.transition "opacity 0.5s"

            emptyButton =
                el [ alpha 0, transition ] none
        in
        case model.session of
            SessionNotRequired ->
                rightArea model args emptyButton

            SessionNotRequested ->
                rightArea model args emptyButton

            SessionFetching ->
                rightArea model args emptyButton

            SessionSuccess user ->
                rightArea model
                    args
                    (el
                        [ transition
                        , htmlAttribute <| Html.Attributes.class "visibleDesktop"
                        ]
                     <|
                        text user.email
                    )

            SessionError _ ->
                rightArea model
                    args
                    (el
                        [ transition
                        , htmlAttribute <| Html.Attributes.class "visibleDesktop"
                        ]
                     <|
                        loginButton model args
                    )
    ]


{-| -}
rightArea : Header -> ViewArgs z msg route -> Element (R10.Context.ContextInternal z) Msg -> Element (R10.Context.ContextInternal z) msg
rightArea _ args loginButtonElement =
    map args.msgMapper <|
        Input.button
            [ alignRight
            , htmlAttribute <| Html.Attributes.id userMenuId
            ]
            { label =
                row
                    []
                    [ loginButtonElement
                    , rightMenuButton args.darkHeader args.theme
                    ]
            , onPress = Just ToggleUserMenu
            }


{-| -}
rightMenuButton : Bool -> R10.Theme.Theme -> Element (R10.Context.ContextInternal z) msg
rightMenuButton darkHeader theme =
    el
        [ Font.size 26
        , paddingXY 14 6
        , Border.rounded 60
        , Font.bold
        , Font.color <| logoColor darkHeader theme
        , mouseOver [ Background.color <| rgba 0 0 0 0.05 ]
        , R10.Transition.transition "background 0.2s"
        ]
    <|
        text "⋮"


userMenuId : String
userMenuId =
    "5gwi9fvj5"


userMenuButtonId : String
userMenuButtonId =
    "gl49gncaq"


{-| -}
dontBreakOut : List (Attribute (R10.Context.ContextInternal z) msg)
dontBreakOut =
    --
    -- From https://css-tricks.com/snippets/css/prevent-long-urls-from-breaking-out-of-container/
    --
    -- /* These are technically the same, but use both */
    [ htmlAttribute <| Html.Attributes.style "overflow-wrap" "break-word"
    , htmlAttribute <| Html.Attributes.style "word-wrap" "break-word"
    , htmlAttribute <| Html.Attributes.style "-ms-word-break" "break-all"

    -- /* This is the dangerous one in WebKit, as it breaks things wherever */
    , htmlAttribute <| Html.Attributes.style "word-break" "break-all"

    -- /* Instead use this non-standard one: */
    , htmlAttribute <| Html.Attributes.style "word-break" "break-word"

    -- /* Adds a hyphen where the word breaks, if supported (No Blink) */
    -- -ms-hyphens: auto;
    -- -moz-hyphens: auto;
    -- -webkit-hyphens: auto;
    -- hyphens: auto;
    ]


{-| -}
userMenu : Header -> ViewArgs z msg route -> Element (R10.Context.ContextInternal z) msg
userMenu model args =
    let
        loginArea =
            [ map args.msgMapper <| el [ centerX, paddingXY 0 30 ] <| loginButton model args ]
    in
    el
        (R10.Card.normal
            ++ [ height <| px 320
               , width <| px 280
               , moveDown 40
               , moveRight 10
               , alignRight
               , R10.FontSize.normal
               , htmlAttribute <| Html.Attributes.id userMenuId
               , R10.Color.AttrsBackground.surface2dp
               , padding 0
               ]
        )
    <|
        column
            [ scrollbarY
            , width fill
            ]
        <|
            []
                -- TODO - change this so that it always work, also when user
                -- is not logged in
                --
                -- loginButton model args.from
                ++ (case model.session of
                        SessionNotRequired ->
                            [ none ]

                        SessionNotRequested ->
                            [ none ]

                        SessionFetching ->
                            [ none ]

                        SessionSuccess user ->
                            [ column
                                [ paddingXY 10 40
                                , Font.center
                                , width fill
                                , spacing 10
                                ]
                                [ paragraph
                                    ([ Font.size 24
                                     , spacing 0
                                     , width fill
                                     ]
                                        ++ dontBreakOut
                                    )
                                    [ text <|
                                        user.firstName
                                            ++ " "
                                            ++ user.lastName
                                    ]
                                , paragraph
                                    ([ width fill ] ++ dontBreakOut)
                                    [ text user.email
                                    ]
                                ]
                            ]
                                ++ menuSeparator

                        SessionError _ ->
                            loginArea
                   )
                ++ languageMenu model args
                ++ (case model.session of
                        SessionNotRequired ->
                            []

                        SessionNotRequested ->
                            []

                        SessionFetching ->
                            []

                        SessionSuccess _ ->
                            []
                                ++ menuSeparator
                                ++ [ map args.msgMapper <| logoutLink model args ]

                        SessionError _ ->
                            []
                   )


{-| -}
logoutLink : Header -> ViewArgs z msg route -> Element (R10.Context.ContextInternal z) Msg
logoutLink model args =
    if model.debuggingMode then
        Input.button
            attrsLink
            { label =
                R10.I18n.paragraph []
                    { renderingMode = R10.I18n.Normal
                    , tagReplacer = \_ string -> string
                    , translation = R10.Translations.signOut
                    }
            , onPress = Just Logout
            }

    else
        link
            attrsLink
            { label =
                R10.I18n.paragraph []
                    { renderingMode = R10.I18n.Normal
                    , tagReplacer = \_ string -> string
                    , translation = R10.Translations.signOut
                    }
            , url = model.urlLogout ++ "?from=" ++ args.from
            }


{-| -}
urlLogin : Header -> ViewArgs z msg route -> Element (R10.Context.ContextInternal z) Msg
urlLogin model args =
    if model.debuggingMode then
        Input.button
            attrsLink
            { label =
                R10.I18n.paragraph []
                    { renderingMode = R10.I18n.Normal
                    , tagReplacer = \_ string -> string
                    , translation = R10.Translations.signIn
                    }
            , onPress = Just Login
            }

    else
        link
            attrsLink
            { label =
                R10.I18n.paragraph []
                    { renderingMode = R10.I18n.Normal
                    , tagReplacer = \_ string -> string
                    , translation = R10.Translations.signIn
                    }
            , url = loginUrl model args
            }


{-| -}
loginUrl : Header -> ViewArgs z msg route -> String
loginUrl model args =
    model.urlLogin ++ "?from=" ++ args.from


{-| -}
loginButton : Header -> ViewArgs z msg route -> Element (R10.Context.ContextInternal z) Msg
loginButton model args =
    if model.debuggingMode then
        Input.button (attrsButton ++ [ alignRight ])
            { label =
                R10.I18n.paragraph []
                    { renderingMode = R10.I18n.Normal
                    , tagReplacer = \_ string -> string
                    , translation = R10.Translations.signIn
                    }
            , onPress = Just Login
            }

    else
        link (attrsButton ++ [ alignRight ])
            { label =
                R10.I18n.paragraph []
                    { renderingMode = R10.I18n.Normal
                    , tagReplacer = \_ string -> string
                    , translation = R10.Translations.signIn
                    }
            , url = loginUrl model args
            }


{-| -}
attrsLink : List (Attribute (R10.Context.ContextInternal z) msg)
attrsLink =
    [ mouseOver [ Background.color <| rgba 0 0 0 0.05 ]
    , R10.Transition.transition "background 0.2s"
    , width fill
    , paddingXY 20 13
    ]


{-| -}
attrsButton : List (Attribute (R10.Context.ContextInternal z) msg)
attrsButton =
    attrsLink
        ++ [ Border.width 1
           , Border.color <| rgba 0 0 0 0.3
           , Border.rounded 5
           , paddingXY 20 10
           , width shrink
           ]


{-| -}
fromTop : Bool -> number
fromTop isTop =
    if isTop then
        13

    else
        0


{-| -}
logoColorColor : Bool -> R10.Theme.Theme -> Color.Color
logoColorColor darkHeader theme =
    if darkHeader then
        Color.rgb 1 1 1

    else
        R10.Color.Internal.Primary.toColor theme theme.primaryColor


{-| -}
logoColor : Bool -> R10.Theme.Theme -> Color
logoColor darkHeader theme =
    R10.Color.Utils.fromColorColor <| logoColorColor darkHeader theme


{-| -}
hambergAndLogo : Header -> ViewArgs z msg route -> Element (R10.Context.ContextInternal z) msg
hambergAndLogo model args =
    row
        [ paddingXY 10 0
        , spacing 10
        ]
        [ map args.msgMapper <|
            el
                [ moveDown (fromTop args.isTop)
                , R10.Transition.transition "transform 0.2s"
                ]
            <|
                iconHamburger { isActive = model.sideMenuOpen, onPress = ToggleSideMenu }
        , R10.Libu.view
            [ moveDown (fromTop args.isTop + 2)
            , R10.Transition.transition "transform 0.2s"
            ]
            { label =
                logo
                    (if model.sideMenuOpen then
                        if R10.Mode.isLight args.theme.mode then
                            args.logoOnLight

                        else
                            args.logoOnDark

                     else
                        args.logoOnDark
                    )
            , type_ = R10.Libu.LiInternal args.urlTop args.onClick
            }
        ]


{-| -}
iconHamburger : { isActive : Bool, onPress : msg } -> Element (R10.Context.ContextInternal z) msg
iconHamburger args =
    -- From https://jonsuh.com/hamburgers/
    Input.button
        [ htmlAttribute <| Html.Attributes.class "hamburger"
        , htmlAttribute <| Html.Attributes.class "hamburger--elastic"
        , htmlAttribute <| Html.Attributes.classList [ ( "is-active", args.isActive ) ]
        , htmlAttribute <| Html.Attributes.attribute "aria-label" "Left Side Menu button"
        , Border.rounded 60
        , width <| px 55
        , height <| px 55
        , mouseOver [ Background.color <| rgba 0 0 0 0.05 ]
        , R10.Transition.transition "background 0.2s"
        , scale 0.7
        ]
        { label =
            html <|
                Html.span [ Html.Attributes.class "hamburger-box" ]
                    [ Html.span [ Html.Attributes.class "hamburger-inner" ] []
                    ]
        , onPress = Just args.onPress
        }


{-| -}
logo : Element (R10.Context.ContextInternal z) msg -> Element (R10.Context.ContextInternal z) msg
logo elementLogo =
    el
        [ spacing 20
        , htmlAttribute <| Html.Attributes.attribute "aria-label" "Top page"
        ]
    <|
        elementLogo


{-| -}
cover : { a | sideMenuOpen : Bool } -> { b | msgMapper : Msg -> msg } -> Element (R10.Context.ContextInternal z) msg
cover model args =
    map args.msgMapper <|
        el
            ([ width fill
             , Background.color <| rgba 0 0 0 0.5
             , htmlAttribute <| Html.Attributes.style "position" "fixed"
             , htmlAttribute <| Html.Attributes.style "height" "100vh"
             , R10.Transition.transition "opacity 0.2s, visibility 0.2s"
             , Events.onClick ToggleSideMenu
             ]
                ++ (if model.sideMenuOpen then
                        [ alpha 1
                        , htmlAttribute <| Html.Attributes.style "visibility" "visible"
                        ]

                    else
                        [ alpha 0
                        , htmlAttribute <| Html.Attributes.style "visibility" "hidden"
                        ]
                   )
            )
            none


{-| -}
argsToLanguage : ViewArgs z msg route -> R10.Language.Language
argsToLanguage args =
    case args.languageSystem of
        LanguageInRoute languageInRoute ->
            languageInRoute.routeToLanguage languageInRoute.route

        LanguageInModel ->
            -- TODO - finish this part
            R10.Language.default


{-| -}
sideMenu : Header -> ViewArgs z msg route -> Element (R10.Context.ContextInternal z) msg
sideMenu model args =
    column
        [ R10.Color.AttrsBackground.surface2dp
        , Border.shadow { offset = ( 0, 0 ), size = 0, blur = 12, color = rgba 0 0 0 0.3 }
        , R10.FontSize.normal
        , width <| px 300
        , paddingEach { top = 60, right = 0, bottom = 20, left = 0 }
        , R10.Transition.transition "transform 0.2s"
        , htmlAttribute <| Html.Attributes.style "position" "fixed"
        , htmlAttribute <| Html.Attributes.style "height" "100vh"
        , scrollbarY
        , moveLeft <|
            if model.sideMenuOpen then
                0

            else
                310
        ]
    <|
        []
            ++ args.extraContent
            ++ [ menuTitle
                    [ R10.I18n.paragraph []
                        { renderingMode = R10.I18n.Normal
                        , tagReplacer = \_ string -> string
                        , translation = R10.Translations.language
                        }
                    ]
               ]
            ++ menuSeparator
            ++ languageMenu model args
            ++ menuSeparator
            ++ [ case model.session of
                    SessionNotRequired ->
                        none

                    SessionNotRequested ->
                        none

                    SessionFetching ->
                        none

                    SessionSuccess _ ->
                        map args.msgMapper <| logoutLink model args

                    SessionError _ ->
                        map args.msgMapper <| urlLogin model args
               ]


{-| -}
languageMenu : Header -> ViewArgs z msg route -> List (Element (R10.Context.ContextInternal z) msg)
languageMenu model args =
    List.map
        (\language ->
            let
                int =
                    R10.Language.toStringLong R10.Language.International language

                loc =
                    R10.Language.toStringLong R10.Language.Localization language

                label =
                    text <|
                        if int == loc then
                            int

                        else
                            int ++ " (" ++ loc ++ ")"
            in
            -- Here we may need 2 ways for the language to work.
            --
            -- One where the language is stored in the url.
            --
            -- Another where the language is stored in the model
            --
            -- if language == (argsToLanguage args) then
            if language == argsToLanguage args then
                el
                    (attrsLink
                        ++ [ Font.bold
                           , htmlAttribute <| Html.Attributes.style "pointer-events" "none"
                           ]
                    )
                    label

            else
                case args.languageSystem of
                    LanguageInRoute languageInRoute ->
                        -- R10.Libu.view (attrsLink ++ [ map args.msgMapper <| Events.onClick CloseUserMenu ])
                        el [ mapAttribute args.msgMapper <| Events.onClick CloseUserMenu, width fill ] <|
                            R10.Libu.view attrsLink
                                -- R10.Libu.view attrsLink
                                { label = label
                                , type_ = R10.Libu.LiInternal (languageInRoute.routeToPath language languageInRoute.route) args.onClick
                                }

                    LanguageInModel ->
                        -- TODO - Finish this part
                        -- R10.Libu.view attrsLink
                        --     { label = label
                        --     , type_ = R10.Libu.Bu (Just <| languageInModel.changeLanguage language)
                        --     }
                        none
        )
        model.supportedLanguageList



-- EVENT DECODERS


{-| -}
keyDecoder : Json.Decode.Decoder KeyPressed
keyDecoder =
    Json.Decode.field "key" Json.Decode.string
        |> Json.Decode.map toKeyPressed



-- keyDecoder : Json.Decode.Decoder ( Msg, Bool )
-- keyDecoder =
--     Json.Decode.field "key" Json.Decode.string
--         |> Json.Decode.map toKeyPressed
--         |> Json.Decode.map
--             (\key ->
--                 ( KeyDown key, True )
--             )


{-| -}
type KeyPressed
    = Escape
    | Enter
    | Space
    | Other


{-| -}
toKeyPressed : String -> KeyPressed
toKeyPressed key =
    case key of
        "Escape" ->
            Escape

        "Enter" ->
            Enter

        " " ->
            Space

        _ ->
            Other



-- Here we decode recursive stuff like
-- [ "target", "parentNode", "parentNode", "parentNode", "parentNode", "id" ]


{-| -}
decoderPart1 : Json.Decode.Decoder (List String)
decoderPart1 =
    Json.Decode.field "target" (decoderPart2 [])


{-| -}
decoderPart2 : List String -> Json.Decode.Decoder (List String)
decoderPart2 acc =
    Json.Decode.oneOf
        [ Json.Decode.field "id" Json.Decode.string
            |> Json.Decode.andThen
                (\id ->
                    Json.Decode.lazy (\_ -> decoderPart2 (id :: acc) |> Json.Decode.field "parentNode")
                )
        , Json.Decode.succeed acc
        ]


{-| -}
extraCss : String
extraCss =
    String.join "\n"
        [ --
          -- "flext is a shorthand for the following CSS properties:
          --
          --     flex-grow     This property specifies how much of the remaining space in the flex container should be assigned to the item (the flex grow factor).
          --                   Default to 0
          --
          --                   flex-grow: inherit;
          --                   flex-grow: initial;
          --                   flex-grow: unset;
          --
          --     flex-shrink
          --     flex-basis
          --
          """
        @media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
            .s {
                flex-basis: auto !important;
            }

            .s.r > .s {
                flex-basis: 0% !important;
                /* border: 1px solid red !important; */
            }
        }
        """
        ]
