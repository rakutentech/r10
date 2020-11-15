port module Main exposing (conf, main)

import Browser
import Browser.Events
import Color
import Dict
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html
import Html.Attributes
import Http
import Json.Decode
import Json.Encode
import Pages.Examples
import Pages.Shared.Utils
import Pages.Top
import Pages.UIComponents
import Pages.UIFormBoilerplate
import Pages.UIFormBoilerplate2
import Pages.UIFormComponentsPhoneSelect
import Pages.UIFormComponentsSingle
import Pages.UIFormComponentsStates
import Pages.UIFormComponentsText
import Pages.UIFormIntroduction
import Process
import R10.Footer
import R10.Form.MakerForView
import R10.Header
import R10.I18n
import R10.Language
import R10.Libu
import R10.Mode
import R10.Okaimonopanda
import R10.Svg.Icons
import R10.Svg.IconsExtra
import R10.Svg.Logos
import R10.Svg.LogosExtra
import R10.Translations
import Starter.ConfMain
import Starter.Flags
import Task
import Url
import Url.Parser exposing ((</>))


heroColor : Color
heroColor =
    -- R10.Color.Utils.colorToElementColor <|
    --     R10.Color.Internal.Primary.toColor { mode = R10.Mode.Light } R10.Color.Primary.Blue
    -- rgb255 18 147 216
    rgb255 17 123 180


heroBackgroundColor : Attr decorative msg
heroBackgroundColor =
    Background.color heroColor


type alias Flags =
    { starter : Starter.Flags.Flags
    , width : Int
    , height : Int
    , languages : List String
    , locationHref : String
    , isInternetExplorer : Bool
    , sessionCookieExists : Bool
    }


positionDecoder : Json.Decode.Decoder Position
positionDecoder =
    Json.Decode.map2 Position
        (Json.Decode.field "pageX" Json.Decode.int)
        (Json.Decode.field "pageY" Json.Decode.int)


type alias Position =
    { x : Int, y : Int }


type alias Model =
    { route : Route
    , flags : Flags
    , windowSize : Position
    , mouse : Position
    , isTop : Bool

    --
    , header : R10.Header.Model

    -- PAGES
    , pageExamples : Pages.Examples.Model
    , pageExample1 : Pages.UIFormBoilerplate.Model
    , pageExample2 : Pages.UIFormBoilerplate2.Model
    , pageExample3 : Pages.UIFormComponentsPhoneSelect.Model
    , pageExample4 : Pages.UIFormComponentsSingle.Model
    , pageExample5 : Pages.UIFormComponentsStates.Model
    , pageExample6 : Pages.UIFormComponentsText.Model
    , pageExample7 : Pages.UIFormIntroduction.Model
    , pageExample8 : Pages.UIComponents.Model
    }


conf : Starter.ConfMain.Conf
conf =
    { urls = listForSSR
    , assetsToCache = []
    }


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- INIT


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        debuggingMode =
            -- flags.locationHref
            --     |> Url.fromString
            --     |> Maybe.map (\url -> url.host == "localhost")
            --     |> Maybe.withDefault False
            False

        route =
            fromLocationHref flags.locationHref

        header =
            R10.Header.init
    in
    ( { route = route
      , flags = flags
      , windowSize = { x = flags.width, y = flags.height }
      , mouse = { x = flags.width // 2, y = flags.height // 2 }
      , isTop = True
      , header =
            { header
                | debuggingMode = debuggingMode
                , userMenuOpen = False
                , backgroundColor = Just heroColor
                , session = R10.Header.SessionNotRequired
                , supportedLanguageList = languageSupportedList
            }
      , pageExamples = Pages.Examples.init
      , pageExample1 = Pages.UIFormBoilerplate.init
      , pageExample2 = Pages.UIFormBoilerplate2.init
      , pageExample3 = Pages.UIFormComponentsPhoneSelect.init
      , pageExample4 = Pages.UIFormComponentsSingle.init
      , pageExample5 = Pages.UIFormComponentsStates.init
      , pageExample6 = Pages.UIFormComponentsText.init

      -- TODO - Add local storage
      , pageExample7 = Pages.UIFormIntroduction.init { localStorage = Dict.empty }
      , pageExample8 = Pages.UIComponents.init
      }
    , Cmd.batch
        [ updateHtmlMeta flags.starter route
        , if debuggingMode then
            Cmd.none

          else if flags.sessionCookieExists then
            Cmd.map Header (R10.Header.getSession 0)

          else
            -- If the cookie doesn't
            -- exsist we skeep the ajax call and we already assume
            -- that the user is not logged in.
            Cmd.none
        ]
    )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        ([ onUrlChange (fromLocationHref >> UrlChanged)
         , Browser.Events.onResize WindowResize
         , onChangeIsTop OnChangeIsTop
         ]
            ++ R10.Header.subscriptions model.header Header
            ++ (-- Pages with Okaimonopanda need to have the mouse muvement
                -- detected to make the panda to move.
                case model.route of
                    NotFound _ ->
                        [ Browser.Events.onMouseMove (Json.Decode.map MouseMove positionDecoder) ]

                    RouteExamples _ ->
                        [ Browser.Events.onMouseMove (Json.Decode.map MouseMove positionDecoder) ]

                    _ ->
                        []
               )
        )



-- MESSAGES


type Msg
    = OnClick String
    | UrlChanged Route
    | WindowResize Int Int
    | OnChangeIsTop Bool
    | MouseMove Position
    | Header R10.Header.Msg
    | PagesExamples Pages.Examples.Msg
    | PagesExample1 Pages.UIFormBoilerplate.Msg
    | PagesExample2 Pages.UIFormBoilerplate2.Msg
    | PagesExample3 Pages.UIFormComponentsPhoneSelect.Msg
    | PagesExample4 Pages.UIFormComponentsSingle.Msg
    | PagesExample5 Pages.UIFormComponentsStates.Msg
    | PagesExample6 Pages.UIFormComponentsText.Msg
    | PagesExample7 Pages.UIFormIntroduction.Msg
    | PagesExample8 Pages.UIComponents.Msg



-- UPDATE


updateHtmlMeta : Starter.Flags.Flags -> Route -> Cmd msg
updateHtmlMeta flagsStarter route =
    Cmd.batch
        [ changeMeta ( "title", "innerHTML", flagsStarter.nameLong )
        , changeMeta ( "meta[property='og:image']", "content", flagsStarter.homepage ++ routeToPathWithoutLanguage route ++ "/snapshot.jpg" )
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PagesExamples pageMsg ->
            ( { model | pageExamples = Pages.Examples.update pageMsg model.pageExamples }, Cmd.none )

        PagesExample1 pageMsg ->
            ( { model | pageExample1 = Pages.UIFormBoilerplate.update pageMsg model.pageExample1 }, Cmd.none )

        PagesExample2 pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.UIFormBoilerplate2.update pageMsg model.pageExample2
            in
            ( { model | pageExample2 = modelPageExample }, Cmd.map PagesExample2 cmdPageExample )

        PagesExample3 pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.UIFormComponentsPhoneSelect.update pageMsg model.pageExample3
            in
            ( { model | pageExample3 = modelPageExample }, Cmd.map PagesExample3 cmdPageExample )

        PagesExample4 pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.UIFormComponentsSingle.update pageMsg model.pageExample4
            in
            ( { model | pageExample4 = modelPageExample }, Cmd.map PagesExample4 cmdPageExample )

        PagesExample5 pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.UIFormComponentsStates.update pageMsg model.pageExample5
            in
            ( { model | pageExample5 = modelPageExample }, Cmd.map PagesExample5 cmdPageExample )

        PagesExample6 pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.UIFormComponentsText.update pageMsg model.pageExample6
            in
            ( { model | pageExample6 = modelPageExample }, Cmd.map PagesExample6 cmdPageExample )

        PagesExample7 pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.UIFormIntroduction.update pageMsg model.pageExample7
            in
            ( { model | pageExample7 = modelPageExample }, Cmd.map PagesExample7 cmdPageExample )

        PagesExample8 pageMsg ->
            let
                modelPageExample =
                    Pages.UIComponents.update pageMsg model.pageExample8
            in
            ( { model | pageExample8 = modelPageExample }, Cmd.none )

        MouseMove mouse ->
            ( { model | mouse = mouse }, Cmd.none )

        Header headerMsg ->
            ( { model | header = R10.Header.update headerMsg model.header }, Cmd.none )

        OnChangeIsTop isTop ->
            ( { model | isTop = isTop }, Cmd.none )

        WindowResize width height ->
            ( { model | windowSize = { x = width, y = height } }, Cmd.none )

        OnClick path ->
            ( model, pushUrl path )

        UrlChanged route ->
            ( { model
                | route = route
                , header = R10.Header.closeMenu model.header
              }
            , updateHtmlMeta model.flags.starter route
            )



-- PORTS


port onUrlChange : (String -> msg) -> Sub msg


port pushUrl : String -> Cmd msg


port changeMeta : ( String, String, String ) -> Cmd msg


port onChangeIsTop : (Bool -> msg) -> Sub msg



-- VIEW HELPERS


headerPlaceholder : Element msg
headerPlaceholder =
    el [ height <| px 80, Background.color <| rgb 1 1 1, width fill ] none


transition : Attribute msg
transition =
    htmlAttribute <| Html.Attributes.style "transition" "opacity 0.3s"


view : Model -> Html.Html Msg
view model =
    let
        language =
            routeToLanguage model.route
    in
    Html.div
        [ Html.Attributes.id "elm" ]
        [ Html.node "style" [] [ Html.text css ]
        , Html.a [ Html.Attributes.class "skip-link", Html.Attributes.href "#main" ]
            [ Html.text "Skip to main" ]
        , layoutWith
            { options =
                [ focusStyle
                    { borderColor = Nothing
                    , backgroundColor = Nothing
                    , shadow = Nothing
                    }
                ]
            }
            [ Font.family []
            , Font.size 18
            , Font.color <| rgb 0.2 0.2 0.2
            , Background.color <| rgb255 247 247 247
            , inFront <|
                R10.Header.view
                    model.header
                    { extraContent = links model.route language
                    , extraContentRightSide =
                        [ R10.Libu.view [ alpha 0.8, transition, mouseOver [ alpha 1 ] ]
                            { label = R10.Svg.LogosExtra.github (Color.rgb 1 1 1) 24
                            , type_ = R10.Libu.LiNewTab "https://github.com/rakutentech/r10/"
                            }
                        , R10.Libu.view [ alpha 0.8, transition, mouseOver [ alpha 1 ] ]
                            { label = R10.Svg.LogosExtra.elm_monocrome (Color.rgb 1 1 1) 24
                            , type_ = R10.Libu.LiNewTab "https://package.elm-lang.org/packages/rakutentech/r10/latest/"
                            }
                        ]
                    , msgMapper = Header
                    , isTop = model.isTop
                    , from = routeToPathWithoutLanguage model.route
                    , isMobile = False
                    , onClick = OnClick
                    , urlTop = "/"
                    , languageSystem =
                        R10.Header.LanguageInRoute
                            { routeToPath = routeToPath
                            , route = model.route
                            , routeToLanguage = routeToLanguage
                            }
                    }
            ]
          <|
            case model.route of
                RouteTop _ ->
                    let
                        content =
                            List.map
                                (\( route, title ) ->
                                    let
                                        url =
                                            routeToPathWithoutLanguage route
                                    in
                                    R10.Libu.view []
                                        { label =
                                            row [ spacing 10 ]
                                                [ el [ Font.size 35, moveUp 3, Font.bold ] <| text "•"
                                                , text <| R10.I18n.t (routeToLanguage model.route) title
                                                ]
                                        , type_ = R10.Libu.LiInternal (routeToPathWithoutLanguage route) OnClick
                                        }
                                )
                                (list R10.Language.EN_US)
                    in
                    column [ width fill ]
                        [ Pages.Top.view (routeToLanguage model.route) heroBackgroundColor content OnClick
                        , footer model
                        ]

                RouteExamples lang ->
                    let
                        mouse =
                            model.mouse

                        mouseCorrected =
                            -- This correction depend on the vertical position
                            -- of the panda in the page
                            { mouse | y = mouse.y - 7000 }
                    in
                    mainLayout model Pages.Examples.title (List.map (map PagesExamples) (Pages.Examples.view model.pageExamples mouseCorrected model.windowSize))

                RouteExample1 lang ->
                    mainLayout model Pages.UIFormBoilerplate.title (List.map (map PagesExample1) (Pages.UIFormBoilerplate.view model.pageExample1))

                RouteExample2 lang ->
                    mainLayout model Pages.UIFormBoilerplate2.title (List.map (map PagesExample2) (Pages.UIFormBoilerplate2.view model.pageExample2))

                RouteExample3 lang ->
                    mainLayout model Pages.UIFormComponentsPhoneSelect.title (List.map (map PagesExample3) (Pages.UIFormComponentsPhoneSelect.view model.pageExample3))

                RouteExample4 lang ->
                    mainLayout model Pages.UIFormComponentsSingle.title (List.map (map PagesExample4) (Pages.UIFormComponentsSingle.view model.pageExample4))

                RouteExample5 lang ->
                    mainLayout model Pages.UIFormComponentsStates.title (List.map (map PagesExample5) (Pages.UIFormComponentsStates.view model.pageExample5))

                RouteExample6 lang ->
                    mainLayout model Pages.UIFormComponentsText.title (List.map (map PagesExample6) (Pages.UIFormComponentsText.view model.pageExample6))

                RouteExample7 lang ->
                    mainLayout model Pages.UIFormIntroduction.title (List.map (map PagesExample7) (Pages.UIFormIntroduction.view model.pageExample7))

                RouteExample8 lang ->
                    mainLayout model Pages.UIComponents.title (List.map (map PagesExample8) (Pages.UIComponents.view model.pageExample8))

                NotFound lang ->
                    mainLayout model translationsError <|
                        [ row [ centerX, spacing 50 ]
                            [ el [] <|
                                html <|
                                    Html.div [] <|
                                        R10.Okaimonopanda.view
                                            { mouse = model.mouse
                                            , screen = model.windowSize
                                            }
                            , column [ alignTop ]
                                [ el
                                    [ Font.bold
                                    , Font.color <| rgb 0.8 0 0
                                    , Font.size 90
                                    ]
                                  <|
                                    text "404"
                                , paragraph [] [ text "Page not found" ]
                                ]
                            ]
                        ]
        ]


footer : Model -> Element Msg
footer model =
    R10.Footer.view model.header
        { extraContent = links model.route (routeToLanguage model.route)
        , extraContentRightSide = []
        , msgMapper = Header
        , isTop = model.isTop
        , from = routeToPathWithoutLanguage model.route
        , isMobile = False
        , onClick = OnClick
        , urlTop = "/"
        , languageSystem =
            R10.Header.LanguageInRoute
                { routeToPath = routeToPath
                , route = model.route
                , routeToLanguage = routeToLanguage
                }
        }


mainLayout :
    Model
    -> R10.Language.Translations
    -> List (Element Msg)
    -> Element Msg
mainLayout model title content =
    column [ width fill ]
        [ headerPlaceholder
        , column
            [ centerX
            , paddingXY 20 80
            , Pages.Shared.Utils.maxWidth
            , spacing 40
            ]
            ([ el [ Font.size 40 ] <| text <| R10.I18n.t (routeToLanguage model.route) title ]
                ++ content
            )
        , footer model
        ]


links : Route -> R10.Language.Language -> List (Element Msg)
links currentRoute currentLanguage =
    List.map
        (\( route, title ) ->
            let
                url =
                    routeToPathWithoutLanguage route

                label =
                    text <| R10.I18n.t currentLanguage title
            in
            if route == currentRoute then
                el
                    (R10.Header.attrsLink
                        ++ [ Font.bold
                           , htmlAttribute <| Html.Attributes.style "pointer-events" "none"
                           ]
                    )
                    label

            else
                R10.Libu.view R10.Header.attrsLink
                    { label = label
                    , type_ = R10.Libu.LiInternal (routeToPathWithoutLanguage route) OnClick
                    }
        )
        (list currentLanguage)



-- CSS


css : String
css =
    String.join "\n"
        [ cssSkipLink
        , cssCommon
        , cssMarkdown
        , R10.Form.MakerForView.extraCss (Just <| Pages.Shared.Utils.toFormPalette)
        ]


cssSkipLink : String
cssSkipLink =
    """.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  background: #000000;
  color: white;
  padding: 8px;
  z-index: 100;
}

.skip-link:focus {
  top: 0;
}
"""


cssMarkdown : String
cssMarkdown =
    """.markdown {
    white-space: normal;
    line-height: 1.7em;}
.markdown p {margin: 20px 0 !important}
.markdown pre {margin: 20px 0; line-height: 20px; background-color: #eee; padding: 20px;}
.markdown img {width: 100%;}

.markdown a {
    color: rgb(17, 123, 180);
}

.markdown pre {
    max-width: """ ++ String.fromInt Pages.Shared.Utils.maxWidthPx ++ """px;
    overflow: scroll;
}

.markdown.whiteLinks a {
    color: white;
} """


cssCommon : String
cssCommon =
    String.join "\n"
        [ -- This is to fix an issue with IE11
          "#elm * {-ms-overflow-style: -ms-autohiding-scrollbar;}"

        --
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
        , """
        @media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {

            .s {
                flex-basis: auto !important; 
            }

            .s.r > .s {
                flex-basis: 0% !important; 
                /* border: 1px solid red !important; */
            }

            /* Here we add a div so that we became more specific and we */
            /* can overwrite settings from elm-ui                       */

            #ie-flex-fix {
                flex-basis: 0% !important; 
                /* border: 1px solid green !important; */
            }
        }
        """

        -- This is to remove up and down button in an input field
        -- of type "number"
        -- To remove the “clear field” X button when Browser Mode
        , "#elm input::-ms-clear { display: none; }"

        -- Remove selecting icon inside the DropDown in IE
        , "#elm select::-ms-expand { display:none; }"
        ]



-- TRANSLATIONS


translationsError : R10.Language.Translations
translationsError =
    { key = "error"
    , en_us = "Error"
    , ja_jp = "Error"
    , zh_tw = "Error"
    , es_es = "Error"
    , fr_fr = "Error"
    , de_de = "Error"
    , it_it = "Error"
    , nl_nl = "Error"
    , pt_pt = "Error"
    , nb_no = "Error"
    , fi_fl = "Error"
    , da_dk = "Error"
    , sv_se = "Error"
    }


translationR10 : R10.Language.Translations
translationR10 =
    { key = "r10"
    , en_us = "R10"
    , ja_jp = "R10"
    , zh_tw = "R10"
    , es_es = "R10"
    , fr_fr = "R10"
    , de_de = "R10"
    , it_it = "R10"
    , nl_nl = "R10"
    , pt_pt = "R10"
    , nb_no = "R10"
    , fi_fl = "R10"
    , da_dk = "R10"
    , sv_se = "R10"
    }



-- LANGUAGE


languageDefault : R10.Language.Language
languageDefault =
    R10.Language.EN_US


languageSupportedList : List R10.Language.Language
languageSupportedList =
    [ R10.Language.EN_US
    , R10.Language.JA_JP
    ]



-- ROUTE


type Route
    = RouteTop R10.Language.Language
    | RouteExamples R10.Language.Language
    | RouteExample1 R10.Language.Language
    | RouteExample2 R10.Language.Language
    | RouteExample3 R10.Language.Language
    | RouteExample4 R10.Language.Language
    | RouteExample5 R10.Language.Language
    | RouteExample6 R10.Language.Language
    | RouteExample7 R10.Language.Language
    | RouteExample8 R10.Language.Language
    | NotFound R10.Language.Language


listForSSR : List String
listForSSR =
    let
        routes =
            RouteTop R10.Language.EN_US :: List.map (\( route, title ) -> route) (list R10.Language.EN_US)
    in
    List.map routeToPathWithoutLanguage routes


list : R10.Language.Language -> List ( Route, R10.Language.Translations )
list language =
    -- TODO - Remove this list and use list2 and routeDetails instead
    [ ( RouteExamples language, Pages.Examples.title )
    , ( RouteExample8 language, Pages.UIComponents.title )
    , ( RouteExample7 language, Pages.UIFormIntroduction.title )
    , ( RouteExample1 language, Pages.UIFormBoilerplate.title )
    , ( RouteExample2 language, Pages.UIFormBoilerplate2.title )
    , ( RouteExample3 language, Pages.UIFormComponentsPhoneSelect.title )
    , ( RouteExample4 language, Pages.UIFormComponentsSingle.title )
    , ( RouteExample6 language, Pages.UIFormComponentsText.title )
    ]


list2 : List (R10.Language.Language -> Route)
list2 =
    [ RouteExamples
    , RouteExample8
    , RouteExample7
    , RouteExample1
    , RouteExample2
    , RouteExample3
    , RouteExample4
    , RouteExample6
    ]


routeDetails :
    Route
    ->
        { title : R10.Language.Translations
        , language : R10.Language.Language
        , routeLabel : String
        }
routeDetails route =
    case route of
        RouteTop language ->
            { title = translationR10
            , routeLabel = ""
            , language = language
            }

        RouteExamples language ->
            { title = Pages.Examples.title
            , routeLabel = "examples"
            , language = language
            }

        RouteExample1 language ->
            { title = Pages.UIFormBoilerplate.title
            , routeLabel = "example1"
            , language = language
            }

        RouteExample2 language ->
            { title = Pages.UIFormBoilerplate2.title
            , routeLabel = "example2"
            , language = language
            }

        RouteExample3 language ->
            { title = Pages.UIFormComponentsPhoneSelect.title
            , routeLabel = "example3"
            , language = language
            }

        RouteExample4 language ->
            { title = Pages.UIFormComponentsSingle.title
            , routeLabel = "example4"
            , language = language
            }

        RouteExample5 language ->
            { title = Pages.UIFormComponentsStates.title
            , routeLabel = "example5"
            , language = language
            }

        RouteExample6 language ->
            { title = Pages.UIFormComponentsText.title
            , routeLabel = "example6"
            , language = language
            }

        RouteExample7 language ->
            { title = Pages.UIFormIntroduction.title
            , routeLabel = "example7"
            , language = language
            }

        RouteExample8 language ->
            { title = Pages.UIComponents.title
            , routeLabel = "example8"
            , language = language
            }

        NotFound language ->
            { title = translationsError
            , routeLabel = "notFound"
            , language = language
            }


routeToPathWithoutLanguage : Route -> String
routeToPathWithoutLanguage route =
    routeToPath (routeToLanguage route) route


routeToPath : R10.Language.Language -> Route -> String
routeToPath language route =
    let
        lang =
            if language == languageDefault then
                []

            else
                [ R10.Language.toStringShort language ]

        path =
            String.join "/" <|
                case route of
                    RouteTop _ ->
                        lang

                    _ ->
                        lang ++ [ .routeLabel (routeDetails route) ]
    in
    if String.isEmpty path then
        "/"

    else
        "/" ++ path ++ "/"


routeToLanguage : Route -> R10.Language.Language
routeToLanguage route =
    .language (routeDetails route)


urlToRoute : Url.Url -> Route
urlToRoute url =
    Maybe.withDefault (NotFound languageDefault) <| Url.Parser.parse routeParser url


fromLocationHref : String -> Route
fromLocationHref locationHref =
    locationHref
        |> Url.fromString
        |> Maybe.map urlToRoute
        |> Maybe.withDefault (NotFound languageDefault)


routeWithLanguage : (R10.Language.Language -> Route) -> Url.Parser.Parser (Route -> c) c
routeWithLanguage route =
    Url.Parser.map route (R10.Language.urlParser </> Url.Parser.s (.routeLabel (routeDetails (route languageDefault))))


routeWithDefaultLanguage : (R10.Language.Language -> Route) -> Url.Parser.Parser (Route -> c) c
routeWithDefaultLanguage route =
    Url.Parser.map (route languageDefault) (Url.Parser.s (.routeLabel (routeDetails (route languageDefault))))


routeParser : Url.Parser.Parser (Route -> b) b
routeParser =
    Url.Parser.oneOf
        -- The RouteTop is special because doesn't have any label
        ([ Url.Parser.map RouteTop R10.Language.urlParser
         , Url.Parser.map (RouteTop languageDefault) Url.Parser.top
         ]
            -- Routes with language
            ++ List.map routeWithLanguage list2
            -- Routes with default language
            ++ List.map routeWithDefaultLanguage list2
        )
