module Index exposing (htmlToReinject, index)

import Html.String exposing (..)
import Html.String.Attributes exposing (..)
import Html.String.Extra exposing (..)
import Main
import Starter.FileNames
import Starter.Flags
import Starter.Icon
import Starter.SnippetHtml
import Starter.SnippetJavascript


index : Starter.Flags.Flags -> Html msg
index flags =
    let
        relative : String
        relative =
            Starter.Flags.toRelative flags

        fileNames : Starter.FileNames.FileNames
        fileNames =
            Starter.FileNames.fileNames flags.version flags.commit
    in
    html
        [ lang "en" ]
        [ head []
            ([]
                ++ [ meta [ charset "utf-8" ] []
                   , title_ [] [ text flags.nameLong ]
                   , meta [ name "author", content flags.author ] []
                   , meta [ name "description", content flags.description ] []
                   , meta [ name "viewport", content "width=device-width, initial-scale=1, shrink-to-fit=no" ] []
                   , meta [ httpEquiv "x-ua-compatible", content "ie=edge" ] []
                   , meta [ name "google-site-verification", content "tGNSt1ck8wNsQPiRNpvQH1yfHT2orQANTOMUTca75Ek" ] []
                   , link [ rel "icon", href (Starter.Icon.iconFileName relative 64) ] []
                   , link [ rel "apple-touch-icon", href (Starter.Icon.iconFileName relative 152) ] []
                   , style_ []
                        [ text <| cssFonts relative
                        , text cssStyle
                        ]
                   ]
                ++ Starter.SnippetHtml.messagesStyle
                ++ Starter.SnippetHtml.pwa
                    { commit = flags.commit
                    , relative = relative
                    , themeColor = Starter.Flags.toThemeColor flags
                    , version = flags.version
                    }
                ++ Starter.SnippetHtml.previewCards
                    { commit = flags.commit
                    , flags = flags
                    , mainConf = Main.conf
                    , version = flags.version
                    }
            )
        , body []
            ([]
                -- Friendly message in case Javascript is disabled
                ++ (if flags.env == "dev" then
                        Starter.SnippetHtml.messageYouNeedToEnableJavascript

                    else
                        Starter.SnippetHtml.messageEnableJavascriptForBetterExperience
                   )
                -- "Loading..." message
                ++ Starter.SnippetHtml.messageLoading
                -- The DOM node that Elm will take over
                ++ [ div [ id "elm" ] [] ]
                -- Activating the "Loading..." message
                ++ Starter.SnippetHtml.messageLoadingOn
                -- Loading Elm code
                ++ [ script [ src (relative ++ fileNames.outputCompiledJsProd) ] [] ]
                -- Elm finished to load, de-activating the "Loading..." message
                ++ Starter.SnippetHtml.messageLoadingOff
                -- Signature "Made with ❤ and Elm"
                ++ [ script [] [ textUnescaped Starter.SnippetJavascript.signature ] ]
                -- Initializing "window.ElmStarter"
                ++ [ script [] [ textUnescaped <| Starter.SnippetJavascript.metaInfo flags ] ]
                -- Let's start Elm!
                ++ [ script []
                        [ textUnescaped
                            ("""
                            var node = document.getElementById('elm');
                            window.ElmApp = Elm.Main.init(
                                { node: node
                                , flags:
                                    { starter : window.ElmStarter
                                    , width: window.innerWidth
                                    , height: window.innerHeight
                                    , languages: window.navigator.userLanguages || window.navigator.languages || []
                                    , locationHref: location.href
                                    }
                                }
                            );"""
                                ++ Starter.SnippetJavascript.portOnUrlChange
                                ++ Starter.SnippetJavascript.portPushUrl
                                ++ Starter.SnippetJavascript.portChangeMeta
                            )
                        ]
                   ]
                -- Register the Service Worker, we are a PWA!
                ++ [ script [] [ textUnescaped (Starter.SnippetJavascript.registerServiceWorker relative) ] ]
            )
        ]


htmlToReinject : a -> List b
htmlToReinject _ =
    []


cssFonts : String -> String
cssFonts relative =
    """
/* Fonts */

@font-face
    { font-family: 'RakutenSansUI'
    ; src: url(\"""" ++ relative ++ """/fonts/RakutenSansUI_W_Lt.woff2") format("woff2"), url(\"""" ++ relative ++ """/fonts/RakutenSansUI_W_Lt.woff") format("woff")
    ; font-weight: lite
    ; font-weight: 300
    ; font-style: normal
    ; font-display: swap
    }

@font-face
    { font-family: 'RakutenSansUI'
    ; src: url(\"""" ++ relative ++ """/fonts/RakutenSansUI_W_Rg.woff2") format("woff2"), url(\"""" ++ relative ++ """/fonts/RakutenSansUI_W_Rg.woff") format("woff")
    ; font-weight: normal
    ; font-weight: 400
    ; font-style: normal
    ; font-display: swap
    }

@font-face 
    { font-family: 'RakutenSansUI'
    ; src: url(\"""" ++ relative ++ """/fonts/RakutenSansUI_W_Bd.woff2") format("woff2"), url(\"""" ++ relative ++ """/fonts/RakutenSansUI_W_Bd.woff") format("woff")
    ; font-weight: bold
    ; font-weight: 700
    ; font-style: normal
    ; font-display: swap
    }
    
@font-face
    { font-family: 'OCRA'
    ; src: url('""" ++ relative ++ """/fonts/OCRA.otf')
    ; font-weight: normal
    ; font-weight: 400
    ; font-style: normal
    ; font-display: swap
    }"""


cssStyle : String
cssStyle =
    """
body 
    { margin: 0
    ; background-color: #ffffff
    ; font-family: 'RakutenSansUI', Helvetica, Arial, sans-serif
    }"""
