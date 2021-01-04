port module Main exposing
    ( conf
    , main
    )

import Browser
import Browser.Events
import Color
import Dict
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html
import Html.Attributes
import Json.Decode
import Pages.Counter
import Pages.Form_Boilerplate
import Pages.Form_Entities
import Pages.Form_Example_CreditCard
import Pages.Form_Example_PhoneSelector
import Pages.Form_Example_Table
import Pages.Form_FieldType_Binary
import Pages.Form_FieldType_Single
import Pages.Form_FieldType_Text
import Pages.Form_Introduction
import Pages.Form_States
import Pages.Overview
import Pages.TableExample
import Pages.Top
import Pages.UIComponents
import R10.Card
import R10.Color
import R10.Color.AttrsBackground
import R10.Color.AttrsFont
import R10.Color.Svg
import R10.Color.Utils
import R10.Footer
import R10.Form
import R10.Header
import R10.I18n
import R10.Language
import R10.Libu
import R10.Link
import R10.Mode
import R10.Okaimonopanda
import R10.Svg.IconsExtra
import R10.Svg.LogosExtra
import R10.Theme
import Routes
import Starter.ConfMain
import Starter.Flags


heroColor : R10.Theme.Theme -> Color
heroColor theme =
    R10.Color.Utils.colorToElementColor <| R10.Color.Svg.primary theme


heroBackgroundColor : R10.Theme.Theme -> Attr decorative msg
heroBackgroundColor theme =
    Background.color <| heroColor theme


type alias Flags =
    { starter : Starter.Flags.Flags
    , width : Int
    , height : Int
    , languages : List String
    , locationHref : String
    }


positionDecoder : Json.Decode.Decoder Position
positionDecoder =
    Json.Decode.map2 Position
        (Json.Decode.field "pageX" Json.Decode.int)
        (Json.Decode.field "pageY" Json.Decode.int)


type alias Position =
    { x : Int, y : Int }


type alias Model =
    { route : Routes.Route
    , flags : Flags
    , windowSize : Position
    , mouse : Position
    , isTop : Bool
    , theme : R10.Theme.Theme
    , header : R10.Header.Header

    -- PAGES
    , pageOverview : Pages.Overview.Model
    , pageUIComponents : Pages.UIComponents.Model
    , pageForm_Introduction : Pages.Form_Introduction.Model
    , pageForm_Entities : Pages.Form_Entities.Model
    , pageForm_Boilerplate : Pages.Form_Boilerplate.Model
    , pageForm_Example_Table : Pages.Form_Example_Table.Model
    , pageForm_Example_CreditCard : Pages.Form_Example_CreditCard.Model
    , pageForm_Example_PhoneSelector : Pages.Form_Example_PhoneSelector.Model
    , pageForm_FieldType_Text : Pages.Form_FieldType_Text.Model
    , pageForm_FieldType_Single : Pages.Form_FieldType_Single.Model
    , pageForm_FieldType_Binary : Pages.Form_FieldType_Binary.Model
    , pageForm_States : Pages.Form_States.Model
    , pageCounter : Pages.Counter.Model
    , pageTableExample : Pages.TableExample.Model
    }


conf : Starter.ConfMain.Conf
conf =
    { urls = Routes.pathsForSSR
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
        debuggingMode : Bool
        debuggingMode =
            -- flags.locationHref
            --     |> Url.fromString
            --     |> Maybe.map (\url -> url.host == "localhost")
            --     |> Maybe.withDefault False
            False

        route : Routes.Route
        route =
            Routes.routeFromLocationHref flags.locationHref

        header : R10.Header.Header
        header =
            R10.Header.init
    in
    ( { route = route
      , flags = flags
      , windowSize = { x = flags.width, y = flags.height }
      , mouse = { x = flags.width // 2, y = flags.height // 2 }
      , isTop = True
      , theme = initTheme
      , header =
            { header
                | debuggingMode = debuggingMode
                , userMenuOpen = False
                , backgroundColor = Just <| heroColor initTheme
                , session = R10.Header.SessionNotRequired
                , supportedLanguageList = Routes.supportedLanguages
            }
      , pageOverview = Pages.Overview.init
      , pageForm_Entities = Pages.Form_Entities.init
      , pageForm_Example_CreditCard = Pages.Form_Example_CreditCard.init
      , pageForm_Boilerplate = Pages.Form_Boilerplate.init
      , pageForm_Example_Table = Pages.Form_Example_Table.init
      , pageForm_Example_PhoneSelector = Pages.Form_Example_PhoneSelector.init
      , pageForm_States = Pages.Form_States.init

      --
      , pageForm_FieldType_Text = Pages.Form_FieldType_Text.init
      , pageForm_FieldType_Single = Pages.Form_FieldType_Single.init
      , pageForm_FieldType_Binary = Pages.Form_FieldType_Binary.init

      --
      -- TODO - Add local storage
      , pageForm_Introduction = Pages.Form_Introduction.init { localStorage = Dict.empty }
      , pageUIComponents = Pages.UIComponents.init
      , pageCounter = Pages.Counter.init
      , pageTableExample = Pages.TableExample.init
      }
    , updateHtmlMeta flags.starter route
    )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        ([ onUrlChange (Routes.routeFromLocationHref >> UrlChanged)
         , Browser.Events.onResize WindowResize
         , onChangeIsTop OnChangeIsTop
         ]
            ++ R10.Header.subscriptions model.header Header
            ++ (case model.route of
                    Routes.Route_NotFound _ ->
                        -- Pages with Okaimonopanda need to have the mouse movement
                        -- detected to make the panda to move.
                        [ Browser.Events.onMouseMove (Json.Decode.map MouseMove positionDecoder) ]

                    Routes.Route_Overview _ ->
                        [ Browser.Events.onMouseMove (Json.Decode.map MouseMove positionDecoder) ]

                    Routes.Route_Counter _ ->
                        -- The counter need to subscribe to the onAnimationFrame
                        -- if the counter is animating
                        [ Sub.map MsgPage_Counter <| Pages.Counter.subscriptions model.pageCounter ]

                    _ ->
                        []
               )
        )



-- MESSAGES


type Msg
    = OnClick String
    | UrlChanged Routes.Route
    | WindowResize Int Int
    | OnChangeIsTop Bool
    | ChangePrimaryColor R10.Color.Primary
    | MouseMove Position
    | ToggleMode
    | Header R10.Header.Msg
      --
    | MsgPage_Overview Pages.Overview.Msg
    | MsgPage_UIComponents Pages.UIComponents.Msg
    | MsgPage_Form_Introduction Pages.Form_Introduction.Msg
    | MsgPage_Form_Entities Pages.Form_Entities.Msg
    | MsgPage_Form_Boilerplate Pages.Form_Boilerplate.Msg
    | MsgPage_Form_Example_Table Pages.Form_Example_Table.Msg
    | MsgPage_Form_Example_CreditCard Pages.Form_Example_CreditCard.Msg
    | MsgPage_Form_Example_PhoneSelector Pages.Form_Example_PhoneSelector.Msg
    | MsgPage_Form_FieldType_Text Pages.Form_FieldType_Text.Msg
    | MsgPage_Form_FieldType_Single Pages.Form_FieldType_Single.Msg
    | MsgPage_Form_FieldType_Binary Pages.Form_FieldType_Binary.Msg
    | MsgPage_Form_States Pages.Form_States.Msg
    | MsgPage_Counter Pages.Counter.Msg
    | MsgPage_PagesTable Pages.TableExample.Msg



-- UPDATE


updateHtmlMeta : Starter.Flags.Flags -> Routes.Route -> Cmd msg
updateHtmlMeta flagsStarter route =
    Cmd.batch
        [ changeMeta ( "title", "innerHTML", flagsStarter.nameLong )
        , changeMeta ( "meta[property='og:image']", "content", flagsStarter.homepage ++ Routes.routeToPathWithoutLanguage route ++ "/snapshot.jpg" )
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangePrimaryColor primaryColor ->
            let
                theme : R10.Theme.Theme
                theme =
                    model.theme

                newTheme : R10.Theme.Theme
                newTheme =
                    { theme | primaryColor = primaryColor }
            in
            ( { model | theme = newTheme }, Cmd.none )

        ToggleMode ->
            let
                theme : R10.Theme.Theme
                theme =
                    model.theme

                newTheme : R10.Theme.Theme
                newTheme =
                    { theme | mode = R10.Mode.toggle theme.mode }
            in
            ( { model | theme = newTheme }, Cmd.none )

        MsgPage_Overview pageMsg ->
            ( { model | pageOverview = Pages.Overview.update pageMsg model.pageOverview }, Cmd.none )

        MsgPage_Form_Entities pageMsg ->
            ( { model | pageForm_Entities = Pages.Form_Entities.update pageMsg model.pageForm_Entities }, Cmd.none )

        MsgPage_Form_Example_CreditCard pageMsg ->
            ( { model | pageForm_Example_CreditCard = Pages.Form_Example_CreditCard.update pageMsg model.pageForm_Example_CreditCard }, Cmd.none )

        MsgPage_Form_Boilerplate pageMsg ->
            ( { model | pageForm_Boilerplate = Pages.Form_Boilerplate.update pageMsg model.pageForm_Boilerplate }, Cmd.none )

        MsgPage_Form_Example_Table pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.Form_Example_Table.update pageMsg model.pageForm_Example_Table
            in
            ( { model | pageForm_Example_Table = modelPageExample }, Cmd.map MsgPage_Form_Example_Table cmdPageExample )

        MsgPage_Form_Example_PhoneSelector pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.Form_Example_PhoneSelector.update pageMsg model.pageForm_Example_PhoneSelector
            in
            ( { model | pageForm_Example_PhoneSelector = modelPageExample }, Cmd.map MsgPage_Form_Example_PhoneSelector cmdPageExample )

        MsgPage_Form_FieldType_Single pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.Form_FieldType_Single.update pageMsg model.pageForm_FieldType_Single
            in
            ( { model | pageForm_FieldType_Single = modelPageExample }, Cmd.map MsgPage_Form_FieldType_Single cmdPageExample )

        MsgPage_Form_States pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.Form_States.update pageMsg model.pageForm_States
            in
            ( { model | pageForm_States = modelPageExample }, Cmd.map MsgPage_Form_States cmdPageExample )

        MsgPage_Form_FieldType_Text pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.Form_FieldType_Text.update pageMsg model.pageForm_FieldType_Text
            in
            ( { model | pageForm_FieldType_Text = modelPageExample }, Cmd.map MsgPage_Form_FieldType_Text cmdPageExample )

        MsgPage_Form_FieldType_Binary pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.Form_FieldType_Binary.update pageMsg model.pageForm_FieldType_Binary
            in
            ( { model | pageForm_FieldType_Binary = modelPageExample }, Cmd.map MsgPage_Form_FieldType_Binary cmdPageExample )

        MsgPage_Form_Introduction pageMsg ->
            let
                ( modelPageExample, cmdPageExample ) =
                    Pages.Form_Introduction.update pageMsg model.pageForm_Introduction
            in
            ( { model | pageForm_Introduction = modelPageExample }, Cmd.map MsgPage_Form_Introduction cmdPageExample )

        MsgPage_UIComponents pageMsg ->
            let
                modelPageExample : Pages.UIComponents.Model
                modelPageExample =
                    Pages.UIComponents.update pageMsg model.pageUIComponents
            in
            ( { model | pageUIComponents = modelPageExample }, Cmd.none )

        MsgPage_Counter pageMsg ->
            let
                modelPageExample : Pages.Counter.Model
                modelPageExample =
                    Pages.Counter.update pageMsg model.pageCounter
            in
            ( { model | pageCounter = modelPageExample }, Cmd.none )

        MsgPage_PagesTable pageMsg ->
            let
                modelPageExample : Pages.TableExample.Model
                modelPageExample =
                    Pages.TableExample.update pageMsg model.pageTableExample
            in
            ( { model | pageTableExample = modelPageExample }, Cmd.none )

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


view : Model -> Html.Html Msg
view model =
    let
        language : R10.Language.Language
        language =
            Routes.routeToLanguage model.route
    in
    Html.div
        [ Html.Attributes.id "elm" ]
        [ Html.node "style" [] [ Html.text (css model.theme) ]
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
            , R10.Color.AttrsFont.normal model.theme
            , R10.Color.AttrsBackground.background model.theme
            , htmlAttribute <| Html.Attributes.style "transition" "background-color 1.2s"
            , inFront <| viewHeader model
            ]
          <|
            case model.route of
                Routes.Route_Top _ ->
                    column [ width fill ]
                        [ Pages.Top.view
                            model.theme
                            (Routes.routeToLanguage model.route)
                            model.windowSize
                            (heroBackgroundColor model.theme)
                            (links model.route language)
                            OnClick
                        , viewFooter model
                        ]

                Routes.Route_Overview _ ->
                    let
                        mouse : Position
                        mouse =
                            model.mouse

                        mouseCorrected : Position
                        mouseCorrected =
                            -- This correction depend on the vertical position
                            -- of the panda in the page
                            { mouse | y = mouse.y - 7000 }
                    in
                    mainLayout model (List.map (map MsgPage_Overview) (Pages.Overview.view model.pageOverview model.theme mouseCorrected model.windowSize))

                Routes.Route_Form_Entities _ ->
                    mainLayout model (List.map (map MsgPage_Form_Entities) (Pages.Form_Entities.view model.pageForm_Entities model.theme))

                Routes.Route_Form_Example_CreditCard _ ->
                    mainLayout model (List.map (map MsgPage_Form_Example_CreditCard) (Pages.Form_Example_CreditCard.view model.pageForm_Example_CreditCard model.theme))

                Routes.Route_Form_Boilerplate _ ->
                    mainLayout model (List.map (map MsgPage_Form_Boilerplate) (Pages.Form_Boilerplate.view model.pageForm_Boilerplate model.theme))

                Routes.Route_Form_Example_Table _ ->
                    mainLayout model (List.map (map MsgPage_Form_Example_Table) (Pages.Form_Example_Table.view model.pageForm_Example_Table model.theme))

                Routes.Route_Form_Example_PhoneSelector _ ->
                    mainLayout model (List.map (map MsgPage_Form_Example_PhoneSelector) (Pages.Form_Example_PhoneSelector.view model.pageForm_Example_PhoneSelector model.theme))

                Routes.Route_Form_FieldType_Single _ ->
                    mainLayout model (List.map (map MsgPage_Form_FieldType_Single) (Pages.Form_FieldType_Single.view model.pageForm_FieldType_Single model.theme))

                Routes.Route_Form_States _ ->
                    mainLayout model (List.map (map MsgPage_Form_States) (Pages.Form_States.view model.pageForm_States model.theme))

                Routes.Route_Form_FieldType_Text _ ->
                    mainLayout model (List.map (map MsgPage_Form_FieldType_Text) (Pages.Form_FieldType_Text.view model.pageForm_FieldType_Text model.theme))

                Routes.Route_Form_FieldType_Binary _ ->
                    mainLayout model (List.map (map MsgPage_Form_FieldType_Binary) (Pages.Form_FieldType_Binary.view model.pageForm_FieldType_Binary model.theme))

                Routes.Route_Form_Introduction _ ->
                    mainLayout model (List.map (map MsgPage_Form_Introduction) (Pages.Form_Introduction.view model.pageForm_Introduction model.theme))

                Routes.Route_UIComponents _ ->
                    mainLayout model (List.map (map MsgPage_UIComponents) (Pages.UIComponents.view model.pageUIComponents model.theme))

                Routes.Route_Counter _ ->
                    mainLayout model (List.map (map MsgPage_Counter) (Pages.Counter.view model.pageCounter model.theme))

                Routes.Route_TableExample _ ->
                    mainLayout model (List.map (map MsgPage_PagesTable) (Pages.TableExample.view model.pageTableExample model.theme))

                Routes.Route_NotFound _ ->
                    mainLayout model <|
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


headerPlaceholder : Element msg
headerPlaceholder =
    -- TODO - Make the height variable the same as the header
    el [ height <| px 80, width fill ] none


transitionOpacity : Attribute msg
transitionOpacity =
    htmlAttribute <| Html.Attributes.style "transition" "opacity 0.3s"


viewHeader : Model -> Element Msg
viewHeader model =
    R10.Header.view model.header (headerFooterArgs model)


logoOnDark : Element msg
logoOnDark =
    R10.Svg.LogosExtra.r10 [ moveUp 4 ] (Color.rgb 1 1 1) 24


logoOnLight : Element msg
logoOnLight =
    R10.Svg.LogosExtra.r10 [ moveUp 4 ] (Color.rgb 0 0 0) 24


colorsMenu : R10.Theme.Theme -> Element Msg
colorsMenu theme =
    row [ spacing 1, centerX ] <|
        List.map
            (\{ type_ } ->
                R10.Libu.view
                    [ width shrink
                    , padding 0
                    , htmlAttribute <| Html.Attributes.style "transition" "0.4s"
                    , Font.color <| R10.Color.Utils.colorToElementColor <| R10.Color.Svg.primary { theme | primaryColor = type_ }
                    , centerY
                    , moveUp <|
                        if theme.primaryColor == type_ then
                            2

                        else
                            0
                    , Font.size <|
                        if theme.primaryColor == type_ then
                            30

                        else
                            16
                    ]
                <|
                    { label = text "⬤"
                    , type_ = R10.Libu.Bu <| Just <| ChangePrimaryColor type_
                    }
            )
            (R10.Color.listPrimary theme)


responsive : number -> a -> a -> a
responsive x mobile desktop =
    if x < 600 then
        mobile

    else
        desktop


headerFooterArgs : Model -> R10.Header.ViewArgs Msg Routes.Route
headerFooterArgs model =
    { extraContent = links model.route (Routes.routeToLanguage model.route)
    , extraContentRightSide =
        [ row [ spacing 20 ]
            [ responsive model.windowSize.x none (colorsMenu model.theme)
            , R10.Libu.view
                [ alpha 0.8
                , transitionOpacity
                , mouseOver [ alpha 1 ]
                , htmlAttribute <| Html.Attributes.style "transition" "1s"
                , htmlAttribute <| Html.Attributes.attribute "aria-label" "Toggle Light/Dark Mode"
                , rotate
                    (if R10.Mode.isLight model.theme.mode then
                        pi

                     else
                        0
                    )
                ]
                { label = R10.Svg.IconsExtra.darkLight [] (Color.rgb 1 1 1) 28
                , type_ = R10.Libu.Bu <| Just ToggleMode
                }
            , R10.Libu.view
                [ alpha 0.8
                , transitionOpacity
                , mouseOver [ alpha 1 ]
                , htmlAttribute <| Html.Attributes.style "transition" "1s"
                , htmlAttribute <| Html.Attributes.attribute "aria-label" "R10 in github.com"
                ]
                { label = R10.Svg.LogosExtra.github [] (Color.rgb 1 1 1) 24
                , type_ = R10.Libu.LiNewTab "https://github.com/rakutentech/r10/"
                }
            , R10.Libu.view
                [ alpha 0.8
                , transitionOpacity
                , mouseOver [ alpha 1 ]
                , htmlAttribute <| Html.Attributes.style "transition" "1s"
                , htmlAttribute <| Html.Attributes.attribute "aria-label" "R10 in package.elm-lang.org"
                ]
                { label = R10.Svg.LogosExtra.elm_monochrome [] (Color.rgb 1 1 1) 24
                , type_ = R10.Libu.LiNewTab "https://package.elm-lang.org/packages/rakutentech/r10/latest/"
                }
            ]
        ]
    , msgMapper = Header
    , isTop = model.isTop
    , from = Routes.routeToPathWithoutLanguage model.route
    , isMobile = False
    , onClick = OnClick
    , urlTop = "/"
    , languageSystem =
        R10.Header.LanguageInRoute
            { routeToPath = Routes.routeToPath
            , route = model.route
            , routeToLanguage = Routes.routeToLanguage
            }
    , logoOnDark = logoOnDark
    , logoOnLight = logoOnLight
    , darkHeader = True
    , theme = model.theme
    }


initTheme : R10.Theme.Theme
initTheme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.primary.blueSky
    }


viewFooter : Model -> Element Msg
viewFooter model =
    R10.Footer.view model.header (headerFooterArgs model)


codeAvailable : R10.Theme.Theme -> String -> Element msg
codeAvailable theme fileName =
    paragraph []
        [ text "The source code of this page is available at "
        , newTabLink (R10.Link.attrs theme) { url = "https://github.com/rakutentech/r10/blob/master/examples/pwa/src/Pages/" ++ fileName, label = text fileName }
        , text "."
        ]


mainLayout :
    Model
    -> List (Element Msg)
    -> Element Msg
mainLayout model content =
    let
        title : R10.Language.Translations
        title =
            .title (Routes.routeDetails model.route)

        fileName : String
        fileName =
            .fileName (Routes.routeDetails model.route)
    in
    column [ width fill ]
        [ headerPlaceholder
        , el
            [ paddingEach { top = 40, right = 20, bottom = 40, left = 20 }
            , centerX
            , width fill
            ]
          <|
            column
                (R10.Card.normal model.theme
                    ++ [ centerX
                       , paddingXY 40 40
                       , Pages.Top.maxWidth
                       , spacing 40
                       ]
                )
                ([ paragraph [ Font.size 40 ] [ text <| R10.I18n.t (Routes.routeToLanguage model.route) title ]
                 , codeAvailable model.theme fileName
                 ]
                    ++ content
                )
        , viewFooter model
        ]


links : Routes.Route -> R10.Language.Language -> List (Element Msg)
links currentRoute currentLanguage =
    List.map
        (\route ->
            let
                label : Element msg
                label =
                    text <| R10.I18n.t currentLanguage (.title (Routes.routeDetails (route currentLanguage)))
            in
            if route currentLanguage == currentRoute then
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
                    , type_ = R10.Libu.LiInternal (Routes.routeToPathWithoutLanguage (route currentLanguage)) OnClick
                    }
        )
        Routes.routesList



-- CSS


css : R10.Theme.Theme -> String
css theme =
    String.join "\n"
        [ cssSkipLink
        , cssCommon
        , cssMarkdown theme
        , R10.Form.extraCss (Just <| R10.Form.themeToPalette theme)
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


cssMarkdown : R10.Theme.Theme -> String
cssMarkdown theme =
    let
        codeBorder : String
        codeBorder =
            case theme.mode of
                R10.Mode.Dark ->
                    "#444"

                R10.Mode.Light ->
                    "#ddd"
    in
    """.markdown {
    white-space: normal;
    line-height: 1.7em;}
.markdown p {margin: 20px 0 !important}

.markdown a {
    /* color: rgb(17, 123, 180); */
    /* Making the color darker for a11y */
    color: rgb(11, 104, 154);  
}

.markdown pre  {
    background-color: """ ++ R10.Color.Utils.toHex (R10.Color.Svg.surface2dp theme) ++ """; 
    margin: 0;
    line-height: 20px;
    overflow: scroll;
    white-space: pre-wrap;       /* css-3 */
    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
    white-space: -pre-wrap;      /* Opera 4-6 */
    white-space: -o-pre-wrap;    /* Opera 7 */
    word-wrap: break-word;       /* Internet Explorer 5.5+ */    
    font-size: 14px;
    border-radius: 10px;
    padding: 20px;
    box-sizing: border-box;
    border: 1px solid """ ++ codeBorder ++ """;
}

.markdown p code {
    background-color: """ ++ R10.Color.Utils.toHex (R10.Color.Svg.surface2dp theme) ++ """; 
    border: 1px solid """ ++ codeBorder ++ """;
    display: inline-block;
    padding: 0 8px;
    margin: 0 5px;
    border-radius: 8px;
}

.markdown img {
    width: 100%;
}

.markdown.whiteLinks a {
    color: white;
} """


cssCommon : String
cssCommon =
    ""
