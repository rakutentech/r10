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
                ++ [ script [] [ textUnescaped <| jsSnippetToUpdateGlobalInfo flags ] ]
                -- Starter.SnippetJavascript.metaInfo flags ] ]
                -- Let's start Elm!
                ++ [ Html.String.Extra.script []
                        [ Html.String.textUnescaped
                            ("""
                            var node = document.getElementById('elm');
                            window.ElmApp = Elm.Main.init(
                                { node: node
                                , flags:
                                    { starter : window.R10.PWA
                                    , width: window.innerWidth
                                    , height: window.innerHeight
                                    , languages: window.navigator.userLanguages || window.navigator.languages || []
                                    , locationHref: location.href
                                    , isInternetExplorer: isInternetExplorer()
                                    , sessionCookieExists: doesHttpOnlyCookieExist("OAMS")
                                    }
                                }
                            );"""
                                ++ Starter.SnippetJavascript.portOnUrlChange
                                ++ Starter.SnippetJavascript.portPushUrl
                                ++ Starter.SnippetJavascript.portChangeMeta
                                ++ monitoringElements
                            )
                        ]
                   ]
                -- Register the Service Worker, we are a PWA!
                ++ [ script [] [ textUnescaped (Starter.SnippetJavascript.registerServiceWorker relative) ] ]
            )
        ]


info : Starter.Flags.Flags -> String
info flags =
    "R10-" ++ flags.version ++ "-" ++ flags.commit


jsSnippetToUpdateGlobalInfo : Starter.Flags.Flags -> String
jsSnippetToUpdateGlobalInfo flags =
    """
window.R10 = window.R10 || {};
window.R10.info = window.R10.info || [];
if (Array.isArray(window.R10.info)) {
    window.R10.info.push(\"""" ++ info flags ++ """");
}
window.R10.PWA = """ ++ Starter.SnippetJavascript.metaInfoData flags ++ """;"""


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
    }

.visibleDesktop {
    display: none !important;
}

@media only screen and (min-width: 600px) {
    .visibleDesktop {
        display: flex !important;
    }
    .visibleMobile {
        display: none !important;
    }
}

@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
    .visibleDesktop {
        display: none !important;
    }
    .visibleMobile {
        display: flex !important;
    }
}

/* div:lang(en) 
    { font-family: 'RakutenSansUI', Helvetica, Arial, sans-serif
    }

div:lang(ja-JP)
    { font-family: 'RakutenSansUI', 'Noto Sans JP', Helvetica, Arial, sans-serif
    ; letter-spacing: 0.02rem
    }

div:lang(zh-TW) 
    { font-family: 'RakutenSansUI', 'Noto Sans TC', Helvetica, Arial, sans-serif
    ; letter-spacing: 0.02rem
    }
*/   """


monitoringElements : String
monitoringElements =
    """
var elementsToMonitor = [];
var args = {
    limitUp: 0,
    limitDown: 650,
    limitActive: 20,
};
var activeSection = "";
var isSticky = "";
var isTop = true;

function sticky() {
    var element = document.getElementById(elementsToMonitor[elementsToMonitor.length - 1]);
    if (element) {
        var boundingFirst = element.getBoundingClientRect();
        if (boundingFirst.top > args.limitUp) {
            // Out if the first block, non sticky
            return "before-sticky";
        } else {
            var element = document.getElementById(elementsToMonitor[0]);
            if (element) {
                var boundingLast = element.getBoundingClientRect();
                if (boundingLast.bottom < args.limitDown) {
                    return "after-sticky";
                } else {
                    return "sticky";
                }
            }
        }
    } else {
        return "before-sticky";
    }
};

function reducer(acc, id) {
    if (acc !== "none") {
        return acc;
    } else {
        var element = document.getElementById(id);
        if (element) {
            var limit = (window.innerHeight / 2) + args.limitActive;
            var bounding = element.getBoundingClientRect()
            if (bounding.top < limit) {
                return id;
            } else {
                return acc;
            }
        }
    }
}

function sendIsTop (isTop) {
    if (ElmApp && ElmApp.ports && ElmApp.ports.onChangeIsTop && ElmApp.ports.onChangeIsTop.send) {
        ElmApp.ports.onChangeIsTop.send(isTop);
    }
}

function onScroll() {

    if (window.scrollY > 10 && isTop) {
        isTop = false;
        sendIsTop(isTop);
    } else if (window.scrollY <= 10 && ! isTop) {
        isTop = true;
        sendIsTop(isTop);
    }
    
    
    if (elementsToMonitor.length >= 1) {
        var newIsSticky = sticky();
        if (isSticky === newIsSticky) {} else {
            isSticky = newIsSticky;
            // console.log("isSticky:", isSticky);
            ElmApp.ports.onChangeIsSticky.send(String(isSticky));
        }

        var newActiveSession = elementsToMonitor.reduce(reducer, "none");
        if (activeSection === newActiveSession) {} else {
            activeSection = newActiveSession;
            // console.log("JS activeSession:", activeSection);
            ElmApp.ports.onChangeActiveSection.send(String(activeSection));
        }
    }
}
document.body.onscroll = onScroll;

if (ElmApp && ElmApp.ports && ElmApp.ports.setSections) {
    ElmApp.ports.setSections.subscribe(function (sections) {
        // console.log("JS setting sections: ", sections);    
        elementsToMonitor = sections;
        onScroll();
    });
}

function isInternetExplorer() {
    var ua = window.navigator.userAgent;
    var msie = ua.indexOf('MSIE ');
    return msie > 0 || !!navigator.userAgent.match(/Trident.*rv\\:11\\./);
}

// From https://stackoverflow.com/questions/9353630/check-if-httponly-cookie-exists-in-javascript
function doesHttpOnlyCookieExist(cookiename) {
    var d = new Date();
    d.setTime(d.getTime() + (1000));
    var expires = "expires=" + d.toUTCString();

    document.cookie = cookiename + "=new_value;path=/;" + expires;
    if (document.cookie.indexOf(cookiename + '=') == -1) {
        return true;
    } else {
        return false;
    }
}
 """
