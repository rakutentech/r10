module R10.Device exposing (Browser, OS, Device, constructor, osToString, examples, isAndroid, isChromeDesktop, isChromeAndroid, isFirefoxAndroid, isIOS, isInternetExplorer, isMobileOS, isSafari, isSafari10OrIOS10, toString)

{-| Information related to the device.

@docs Browser, OS, Device, constructor, osToString, examples, isAndroid, isChromeDesktop, isChromeAndroid, isFirefoxAndroid, isIOS, isInternetExplorer, isMobileOS, isSafari, isSafari10OrIOS10, toString

-}

import Regex


{-| -}
type OS
    = Android
    | IOS
    | MacOS
    | WindowsPhone
    | Other


{-| -}
type Browser
    = Opera
    | Chrome
    | Safari
    | Firefox
    | IE
    | Unknown


{-| -}
type alias Device =
    { os : OS
    , browser : Browser
    , userAgent : String
    , isSafari10OrIOS10 : Bool
    }


{-| -}
toString : Device -> String
toString device =
    osToString device.os ++ " " ++ browserToString device.browser


{-| -}
osToString : OS -> String
osToString browser =
    case browser of
        Android ->
            "Android"

        IOS ->
            "iOS"

        MacOS ->
            "macOS"

        WindowsPhone ->
            "WindowsPhone"

        Other ->
            "Other"


{-| -}
browserToString : Browser -> String
browserToString browser =
    case browser of
        Opera ->
            "Opera"

        Chrome ->
            "Chrome"

        Safari ->
            "Safari"

        Firefox ->
            "Firefox"

        IE ->
            "IE"

        Unknown ->
            "Unknown"


{-| -}
constructor : String -> String -> Bool -> Device
constructor userAgent platform isOntouchendInDocument =
    --
    -- From src-ts/main.ts
    --
    -- userAgent................: navigator.userAgent || navigator.vendor || (window as any).opera
    -- platform.................: navigator.platform
    -- isOntouchendInDocument...: 'ontouchend' in document
    --
    let
        iOSPlatformList : List String
        iOSPlatformList =
            [ "iPad Simulator"
            , "iPhone Simulator"
            , "iPod Simulator"
            , "iPad"
            , "iPhone"
            , "iPod"
            ]

        regex : String -> Regex.Regex
        regex string =
            string
                |> Regex.fromStringWith { caseInsensitive = True, multiline = False }
                |> Maybe.withDefault Regex.never

        os : OS
        os =
            -- Windows Phone must come first because its UA also contains "Android"
            if Regex.contains (regex "windows phone") userAgent then
                WindowsPhone

            else if Regex.contains (regex "android") userAgent then
                Android

            else if List.any ((==) platform) iOSPlatformList then
                -- https://stackoverflow.com/a/9039885
                IOS

            else if String.contains "Mac" userAgent then
                if isOntouchendInDocument then
                    -- https://stackoverflow.com/a/9039885
                    IOS

                else
                    MacOS

            else
                Other

        browser : Browser
        browser =
            if String.contains "Opera" userAgent || String.contains "OPR" userAgent then
                Opera

            else if String.contains "Chrome" userAgent then
                Chrome

            else if String.contains "Safari" userAgent then
                Safari

            else if String.contains "Firefox" userAgent then
                Firefox

            else if String.contains "MSIE " userAgent || Regex.contains (regex "Trident.*rv:11\\.") userAgent then
                IE

            else
                Unknown
    in
    { os = os
    , browser = browser
    , isSafari10OrIOS10 = Regex.contains (regex "Macintosh;.*Version\\/10\\.|iPhone OS 10_") userAgent
    , userAgent = userAgent
    }


{-| -}
isInternetExplorer : Device -> Bool
isInternetExplorer { browser } =
    case browser of
        IE ->
            True

        _ ->
            False


{-| -}
isMobileOS : Device -> Bool
isMobileOS { os } =
    case os of
        Android ->
            True

        IOS ->
            True

        MacOS ->
            False

        WindowsPhone ->
            True

        Other ->
            False


{-| -}
isIOS : Device -> Bool
isIOS { os } =
    case os of
        Android ->
            False

        IOS ->
            True

        MacOS ->
            False

        WindowsPhone ->
            False

        Other ->
            False


{-| -}
isAndroid : Device -> Bool
isAndroid { os } =
    case os of
        Android ->
            True

        IOS ->
            False

        MacOS ->
            False

        WindowsPhone ->
            False

        Other ->
            False


{-| -}
isFirefoxAndroid : Device -> Bool
isFirefoxAndroid { os, browser } =
    case ( os, browser ) of
        ( Android, Firefox ) ->
            True

        ( _, _ ) ->
            False


{-| -}
isChromeDesktop : Device -> Bool
isChromeDesktop device =
    not (isMobileOS device) && device.browser == Chrome


{-| -}
isChromeAndroid : Device -> Bool
isChromeAndroid { os, browser } =
    case ( os, browser ) of
        ( Android, Chrome ) ->
            True

        ( _, _ ) ->
            False


{-| -}
isSafari : Device -> Bool
isSafari { os, browser } =
    case ( os, browser ) of
        ( _, Safari ) ->
            True

        ( _, _ ) ->
            False


{-| -}
isSafari10OrIOS10 : Device -> Bool
isSafari10OrIOS10 device =
    device.isSafari10OrIOS10


{-| -}
examples :
    List
        { isOntouchendInDocument : Bool
        , nameLong : String
        , nameShort : String
        , platform : String
        , referenceUrl : String
        , userAgent : String
        }
examples =
    -- navigator.platform
    -- https://stackoverflow.com/questions/19877924/what-is-the-list-of-possible-values-for-navigator-platform-as-of-today
    --
    [ { userAgent = "Mozilla/5.0 (Android 9; Mobile; rv:68.0) Gecko/68.0 Firefox/68.0"
      , platform = ""
      , isOntouchendInDocument = True
      , nameLong = "Firefox 68 on Android (Pie)"
      , nameShort = "Firefox on Android"
      , referenceUrl = "https://developers.whatismybrowser.com/useragents/parse/1264052firefox-android-gecko"
      }
    , { userAgent = "Mozilla/5.0 (Linux; Android 6.0; vivo 1713 Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.124 Mobile Safari/537.36"
      , platform = ""
      , isOntouchendInDocument = True
      , nameLong = "Chrome 53 on Android (Marshmallow)"
      , nameShort = "Chrome on Android"
      , referenceUrl = "https://developers.whatismybrowser.com/useragents/parse/607007chrome-android-vivo-v5s-1713-blink"
      }
    , { userAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0"
      , platform = ""
      , isOntouchendInDocument = False
      , nameLong = "Firefox 54 on Windows 7"
      , nameShort = "Firefox on Windows"
      , referenceUrl = "https://developers.whatismybrowser.com/useragents/parse/324650firefox-windows-gecko"
      }
    , { userAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko"
      , platform = ""
      , isOntouchendInDocument = False
      , nameLong = "Internet Explorer 11 on Windows 7"
      , nameShort = "IE11"
      , referenceUrl = "https://developers.whatismybrowser.com/useragents/parse/38internet-explorer-windows-trident"
      }
    , { userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Mobile/15E148 Safari/604.1"
      , platform = ""
      , isOntouchendInDocument = False
      , nameLong = "Safari 14 on iOS 14.4"
      , nameShort = "Safari on iOS"
      , referenceUrl = "https://developers.whatismybrowser.com/useragents/parse/61099923safari-ios-iphone-webkit"
      }
    , { userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/18.17763"
      , platform = ""
      , isOntouchendInDocument = False
      , nameLong = "Edge 44 on Windows 10"
      , nameShort = "Edge"
      , referenceUrl = "https://developers.whatismybrowser.com/useragents/parse/743087edge-windows-edgehtml"
      }
    ]
