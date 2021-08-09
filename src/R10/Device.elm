module R10.Device exposing
    ( Browser
    , OS
    , UserAgent
    , constructor
    , decoder
    , deviceOSFromString
    , deviceOSToString
    , encodedValueToUserAgent
    , encoder
    , examples
    , isAndroid
    , isFirefoxAndroid
    , isInternetExplorer
    , isMobileOS
    )

import Json.Decode
import Json.Encode
import Regex


type OS
    = Android
    | IOS
    | WindowsPhone
    | Other


type Browser
    = Opera
    | Chrome
    | Safari
    | Firefox
    | IE
    | Unknown


type alias UserAgent =
    ( OS, Browser )


deviceOSDecoder : Json.Decode.Decoder OS
deviceOSDecoder =
    Json.Decode.string
        |> Json.Decode.andThen (deviceOSFromString >> Json.Decode.succeed)


deviceBrowserDecoder : Json.Decode.Decoder Browser
deviceBrowserDecoder =
    Json.Decode.string
        |> Json.Decode.andThen (deviceBrowserFromString >> Json.Decode.succeed)


decoder : Json.Decode.Decoder UserAgent
decoder =
    Json.Decode.map2 Tuple.pair
        (Json.Decode.index 0 deviceOSDecoder)
        (Json.Decode.index 1 deviceBrowserDecoder)


deviceOSEncoder : OS -> Json.Encode.Value
deviceOSEncoder =
    deviceOSToString >> Json.Encode.string


deviceBrowserEncoder : Browser -> Json.Encode.Value
deviceBrowserEncoder =
    deviceBrowserToString >> Json.Encode.string


encoder : UserAgent -> Json.Encode.Value
encoder ( os, browser ) =
    Json.Encode.list identity [ deviceOSEncoder os, deviceBrowserEncoder browser ]


deviceOSFromString : String -> OS
deviceOSFromString os =
    case os of
        "Android" ->
            Android

        "iOS" ->
            IOS

        "Windows Phone" ->
            WindowsPhone

        _ ->
            Other


deviceBrowserFromString : String -> Browser
deviceBrowserFromString os =
    case os of
        "Opera" ->
            Opera

        "Chrome" ->
            Chrome

        "Safari" ->
            Safari

        "Firefox" ->
            Firefox

        "IE" ->
            IE

        _ ->
            Unknown


deviceOSToString : OS -> String
deviceOSToString browser =
    case browser of
        Android ->
            "Android"

        IOS ->
            "iOS"

        WindowsPhone ->
            "Windows Phone"

        Other ->
            "Other"


deviceBrowserToString : Browser -> String
deviceBrowserToString browser =
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


encodedValueToUserAgent : Json.Decode.Value -> UserAgent
encodedValueToUserAgent device =
    Json.Decode.decodeValue decoder device
        |> Result.toMaybe
        |> Maybe.withDefault ( Other, Unknown )


constructor : String -> String -> Bool -> UserAgent
constructor userAgent platform isOntouchendInDocument =
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

        osRegex : String -> Regex.Regex
        osRegex string =
            Regex.fromStringWith { caseInsensitive = True, multiline = False } string |> Maybe.withDefault Regex.never

        ieRegex : Regex.Regex
        ieRegex =
            Regex.fromString "Trident.*rv:11\\." |> Maybe.withDefault Regex.never

        os : OS
        os =
            -- Windows Phone must come first because its UA also contains "Android"
            if Regex.contains (osRegex "windows phone") userAgent then
                WindowsPhone

            else if Regex.contains (osRegex "android") userAgent then
                Android

            else if List.any ((==) platform) iOSPlatformList || (String.contains "Mac" userAgent && isOntouchendInDocument) then
                -- https://stackoverflow.com/a/9039885
                IOS

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

            else if String.contains "MSIE " userAgent || Regex.contains ieRegex userAgent then
                IE

            else
                Unknown
    in
    ( os, browser )


isInternetExplorer : UserAgent -> Bool
isInternetExplorer ( _, browser ) =
    case browser of
        IE ->
            True

        _ ->
            False


isMobileOS : UserAgent -> Bool
isMobileOS ( os, _ ) =
    case os of
        Android ->
            True

        IOS ->
            True

        WindowsPhone ->
            True

        Other ->
            False


isAndroid : UserAgent -> Bool
isAndroid ( os, _ ) =
    case os of
        Android ->
            True

        IOS ->
            False

        WindowsPhone ->
            False

        Other ->
            False


isFirefoxAndroid : UserAgent -> Bool
isFirefoxAndroid userAgent =
    case userAgent of
        ( Android, Firefox ) ->
            True

        ( _, _ ) ->
            False


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
