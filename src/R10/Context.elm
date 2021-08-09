module R10.Context exposing (AttrC, AttributeC, Context, ContextForForm, DecorationC, ElementC, empty, fromModel, toContextForForm)

{-|


# Base

@docs AttrC, AttributeC, Context, ContextForForm, DecorationC, ElementC, empty, fromModel, toContextForForm

-}

import Dict
import Element.WithContext
import R10.Color.Internal.Primary
import R10.CountryCode
import R10.Device
import R10.Language
import R10.Mode
import R10.Theme
import R10.When exposing (..)
import Url


{-| -}
type alias Context =
    { language : R10.Language.Language
    , theme : R10.Theme.Theme
    , userAgent : R10.Device.UserAgent
    , emailDomainList : List String
    , countryCode : R10.CountryCode.CountryCode
    , currentUrl : Url.Url
    , seenAnnouncement : Maybe String

    -- URLs to be injected in messages
    , callCenterUrl : String
    , contactUsLanguageSupport : Dict.Dict String String
    , termsAndConditionsLink : String
    , privacyPolicyLink : String
    , cookiePolicyLink : String
    , urlStartOver : String

    -- Strings to be injected in messages
    , notifyText : String
    , clientName : String
    , referenceClientName : String
    , externalError : Maybe String
    , referenceExternalServiceName : String

    -- Layout
    , defaultWidgetWidth : Int
    , specialWidgetWidth : Int
    , verticalSpacingBetweenItems : Int
    , mainPadding : Int
    , inputFieldWithLargePattern_width : Int
    , inputFieldWithLargePattern_height : Int
    , inputFieldWithLargePattern_fontSize : Int
    , inputFieldWithLargePattern_letterSpacing : Int
    , displayPromoArea : Bool

    -- DEBUGGING
    , debugger_formStyleAsString : String
    , debugger_transitionSpeed : Float

    -- for international prefix phone change
    , disableInternationalPrefixPhoneChange : Bool
    }


{-| -}
emptyModel :
    { flags :
        { callCenterUrl : String
        , contactUsLanguageSupport : Dict.Dict String String
        , clientName : String
        , cookiePolicyLink : String
        , countryCode : R10.CountryCode.CountryCode
        , userAgent : String
        , platform : String
        , isOntouchendInDocument : Bool
        , emailDomainList : List b
        , isInternetExplorer : Bool
        , loginLink : String
        , mode : R10.Mode.Mode
        , notifyText : Maybe a3
        , primaryColor : R10.Color.Internal.Primary.Color
        , privacyPolicyLink : String
        , referenceClientName : String
        , referenceExternalServiceName : String
        , registrationLink : String
        , termsAndConditionsLink : String
        , urlStartOver : String
        , externalError : Maybe String
        , debugger_transitionSpeed : Float
        , debugger_formStyleAsString : String
        , displayPromoArea : Bool
        , disableInternationalPrefixPhoneChange : Bool
        , seenAnnouncement : Maybe String
        }
    , language : R10.Language.Language
    , url :
        { fragment : Maybe a2
        , host : String
        , path : String
        , port_ : Maybe a1
        , protocol : Url.Protocol
        , query : Maybe a
        }
    , windowSize : { width : number }
    }
emptyModel =
    { flags =
        { mode = R10.Mode.Light
        , primaryColor = R10.Color.Internal.Primary.CrimsonRed
        , isInternetExplorer = False
        , userAgent = ""
        , platform = ""
        , isOntouchendInDocument = False
        , emailDomainList = []
        , countryCode = R10.CountryCode.default
        , callCenterUrl = ""
        , contactUsLanguageSupport = Dict.empty
        , termsAndConditionsLink = ""
        , privacyPolicyLink = ""
        , cookiePolicyLink = ""
        , registrationLink = ""
        , loginLink = ""
        , urlStartOver = ""
        , notifyText = Nothing
        , clientName = ""
        , referenceClientName = ""
        , referenceExternalServiceName = ""
        , externalError = Nothing
        , debugger_transitionSpeed = 1
        , debugger_formStyleAsString = ""
        , displayPromoArea = False
        , disableInternationalPrefixPhoneChange = False
        , seenAnnouncement = Nothing
        }
    , language = R10.Language.EN_US
    , windowSize = { width = 800 }
    , url =
        { protocol = Url.Https
        , host = ""
        , port_ = Nothing
        , path = ""
        , query = Nothing
        , fragment = Nothing
        }
    }


{-| -}
empty : Context
empty =
    fromModel emptyModel


{-| -}
type alias ContextForForm =
    { language : R10.Language.Language
    , countryCode : R10.CountryCode.CountryCode
    , emailDomainList : List String
    }


{-| -}
toContextForForm : Context -> ContextForForm
toContextForForm c =
    { language = c.language
    , countryCode = c.countryCode
    , emailDomainList = c.emailDomainList
    }


{-| -}
fromModel :
    { d
        | flags :
            { a
                | mode : R10.Mode.Mode
                , primaryColor : R10.Color.Internal.Primary.Color
                , userAgent : String
                , platform : String
                , isOntouchendInDocument : Bool
                , emailDomainList : List String
                , countryCode : R10.CountryCode.CountryCode

                --
                , callCenterUrl : String
                , contactUsLanguageSupport : Dict.Dict String String
                , termsAndConditionsLink : String
                , privacyPolicyLink : String
                , cookiePolicyLink : String
                , registrationLink : String
                , loginLink : String
                , urlStartOver : String

                --
                , notifyText : Maybe String
                , clientName : String
                , referenceClientName : String
                , referenceExternalServiceName : String
                , externalError : Maybe String -- UNUSED
                , debugger_transitionSpeed : Float
                , debugger_formStyleAsString : String
                , displayPromoArea : Bool
                , disableInternationalPrefixPhoneChange : Bool
                , seenAnnouncement : Maybe String
            }
        , language : R10.Language.Language
        , windowSize : { c | width : Int }
        , url : Url.Url
    }
    -> Context
fromModel model =
    { language = model.language
    , theme = R10.Theme.fromFlags model.flags
    , userAgent = R10.Device.constructor model.flags.userAgent model.flags.platform model.flags.isOntouchendInDocument
    , emailDomainList = model.flags.emailDomainList
    , countryCode = model.flags.countryCode
    , currentUrl = model.url
    , seenAnnouncement = model.flags.seenAnnouncement

    --
    , callCenterUrl = matchCallCenterValue model
    , contactUsLanguageSupport = model.flags.contactUsLanguageSupport
    , termsAndConditionsLink = model.flags.termsAndConditionsLink
    , privacyPolicyLink = model.flags.privacyPolicyLink
    , cookiePolicyLink = model.flags.cookiePolicyLink
    , urlStartOver = model.flags.urlStartOver

    --
    , notifyText = Maybe.withDefault "" model.flags.notifyText
    , clientName = model.flags.clientName
    , referenceClientName =
        if model.flags.referenceClientName == "n/a (referenceClientName)" then
            ""

        else
            model.flags.referenceClientName
    , referenceExternalServiceName =
        if model.flags.referenceExternalServiceName == "n/a (referenceExternalServiceName)" then
            ""

        else
            model.flags.referenceExternalServiceName
    , externalError = model.flags.externalError -- UNUSED

    --
    , defaultWidgetWidth = 500
    , specialWidgetWidth = 775 -- For Newsletter
    , verticalSpacingBetweenItems = when (isSmallScreen model) do 20 otherwise 25
    , mainPadding = when (isSmallScreen model) do 10 otherwise 30
    , inputFieldWithLargePattern_width = when (isSmallScreen model) do 200 otherwise 240
    , inputFieldWithLargePattern_height = when (isSmallScreen model) do 70 otherwise 80
    , inputFieldWithLargePattern_fontSize = when (isSmallScreen model) do 35 otherwise 40
    , inputFieldWithLargePattern_letterSpacing = when (isSmallScreen model) do 5 otherwise 10
    , displayPromoArea = model.flags.displayPromoArea

    --
    , debugger_formStyleAsString = model.flags.debugger_formStyleAsString
    , debugger_transitionSpeed = model.flags.debugger_transitionSpeed
    , disableInternationalPrefixPhoneChange = model.flags.disableInternationalPrefixPhoneChange
    }


{-| -}
isSmallScreen : { b | windowSize : { a | width : Int } } -> Bool
isSmallScreen model =
    model.windowSize.width < 350



--
--
-- type alias ContextAttempt =
--     -- Context contain data that is needed to draw the views but it doesn't
--     -- change much. It include the entire configuration that doesn't change
--     -- at all during the life of the application.
--     --
--     --
--     --
--     -- This record contains stuff that apply to all views.
--     -- Do not add here stuff that change often, like the screen size.
--     -- For more info, read
--     -- https://elm.dmy.fr/packages/miniBill/elm-ui-with-context/latest/
--     --
--     { language : R10.Language.Language
--     , url : Url.Url
--     , isSmallScreen : Bool
--     , captchaUrl : Maybe String
--     , payVaultState : Result String PayVault.Types.StateFromJsToElm
--     , countryCode : String
--     , spinner : O.Spinner.Spinner
--     , theme : R10.Theme.Theme
--     , callCenterUrl : String
--     , termsAndConditionsLink : String
--     , urlStartOver : String
--     , loginLink : String
--     , userAgent : R10.Device.UserAgent
--     , clientName : String
--     , companyName : String
--     , cookiePolicyLink : String
--     , privacyPolicyLink : String
--     , display : Api.DataGenerated.DisplayType.DisplayType
--     , referenceClientName : String
--     , isLoginEnabled : Bool
--     , maybeOmniTokenFromFlags : Maybe O.OmniToken.OmniToken
--     , notifyText : Maybe String
--     , isResetPasswordEnabled : Bool
--     , isRegistrationEnabled : Bool
--     , emailDomainList : List String
--     , urlApiOmni : String
--     , registrationLink : String
--     , audience : String
--     , clientId : String
--     , codeChallenge : String
--     , codeChallengeMethod : String
--     , maxAge : Maybe Int
--     , nonce : String
--     , redirectUrl : String
--     , replay : String
--     , responseType : String
--     , scope : String
--     , state : String
--     , socialLoginProviders : List String
--     , isInternetExplorer : Bool
--     , profilingCancelUrl : String
--     , environment : O.Environment.Environment
--     , profilingClaims : List O.Claim.Claim
--
--     -- , promoAreaLogin : List O.PromoArea.PromoArea
--     -- , promoAreaRegistration : List O.PromoArea.PromoArea
--     }
--
--
-- captchaUrl : Maybe { a | challengerModel : Challenger.Model.Model } -> Maybe String
-- captchaUrl challenger_modelAndLatestPageId =
--     challenger_modelAndLatestPageId
--         |> Maybe.map .challengerModel
--         |> Maybe.andThen Challomni.Utils.getCaptchaUrl
--
--
-- fromModel : Main.Model.Model -> Context
--
--
-- fromModel :
--     { p1
--         | flags :
--             { k1
--                 | audience : a
--                 , callCenterUrl : b
--                 , clientId : c
--                 , clientName : d
--                 , codeChallenge : e
--                 , codeChallengeMethod : f
--                 , companyName : g
--                 , cookiePolicyLink : h
--                 , countryCode : i
--                 , userAgent : j
--                 , display : k
--                 , emailDomainList : l
--                 , environment : m
--                 , isInternetExplorer : n
--                 , isLoginEnabled : o
--                 , isRegistrationEnabled : p
--                 , isResetPasswordEnabled : q
--                 , loginLink : r
--                 , maxAge : s
--                 , mode : R10.Mode.Mode
--                 , nonce : t
--                 , notifyText : u
--                 , primaryColor : R10.Color.Internal.Primary.Color
--                 , privacyPolicyLink : v
--                 , profilingCancelUrl : w
--                 , profilingClaims : x
--                 , redirectUrl : y
--                 , referenceClientName : z
--                 , registrationLink : a1
--                 , replay : b1
--                 , responseType : c1
--                 , scope : d1
--                 , socialLoginProviders : e1
--                 , state : f1
--                 , termsAndConditionsLink : g1
--                 , token : h1
--                 , urlApiOmni : i1
--                 , urlStartOver : j1
--             }
--         , language : l1
--         , payVaultState : m1
--         , spinner : n1
--         , url : o1
--     }
--     -> ContextAttempt
--
--
-- fromModel model =
--     { language = model.language
--     , url = model.url
--
--     -- , isSmallScreen = Utils.Shared.isSmallScreen model.windowSize.width
--     , spinner = model.spinner
--     , theme = R10.Theme.fromFlags model.flags
--     , payVaultState = model.payVaultState
--
--     -- , captchaUrl = captchaUrl model.challenger_modelAndLatestPageId
--     , countryCode = model.flags.countryCode
--     , callCenterUrl = model.flags.callCenterUrl
--     , termsAndConditionsLink = model.flags.termsAndConditionsLink
--     , urlStartOver = model.flags.urlStartOver
--     , loginLink = model.flags.loginLink
--     , userAgent = model.flags.userAgent
--     , clientName = model.flags.clientName
--     , companyName = model.flags.companyName
--     , cookiePolicyLink = model.flags.cookiePolicyLink
--     , privacyPolicyLink = model.flags.privacyPolicyLink
--     , display = model.flags.display
--     , referenceClientName = model.flags.referenceClientName
--     , isLoginEnabled = model.flags.isLoginEnabled
--     , maybeOmniTokenFromFlags = model.flags.token
--     , notifyText = model.flags.notifyText
--     , isResetPasswordEnabled = model.flags.isResetPasswordEnabled
--     , isRegistrationEnabled = model.flags.isRegistrationEnabled
--     , emailDomainList = model.flags.emailDomainList
--     , urlApiOmni = model.flags.urlApiOmni
--     , registrationLink = model.flags.registrationLink
--     , audience = model.flags.audience
--     , clientId = model.flags.clientId
--     , codeChallenge = model.flags.codeChallenge
--     , codeChallengeMethod = model.flags.codeChallengeMethod
--     , maxAge = model.flags.maxAge
--     , nonce = model.flags.nonce
--     , redirectUrl = model.flags.redirectUrl
--     , replay = model.flags.replay
--     , responseType = model.flags.responseType
--     , scope = model.flags.scope
--     , state = model.flags.state
--     , socialLoginProviders = model.flags.socialLoginProviders
--     , isInternetExplorer = model.flags.isInternetExplorer
--     , profilingCancelUrl = model.flags.profilingCancelUrl
--     , environment = model.flags.environment
--     , profilingClaims = model.flags.profilingClaims
--
--     -- , promoAreaLogin = model.flags.promoAreaLogin
--     -- , promoAreaRegistration = model.flags.promoAreaRegistration
--     }
--


{-| -}
type alias ElementC msg =
    Element.WithContext.Element Context msg


{-| -}
type alias AttributeC msg =
    Element.WithContext.Attribute Context msg


{-| -}
type alias AttrC decorative msg =
    Element.WithContext.Attr Context decorative msg


{-| -}
type alias DecorationC =
    Element.WithContext.Decoration Context


{-| -}
matchCallCenterValue :
    { b
        | language : R10.Language.Language
        , flags :
            { a
                | callCenterUrl : String
                , contactUsLanguageSupport : Dict.Dict String String
                , countryCode : R10.CountryCode.CountryCode
            }
    }
    -> String
matchCallCenterValue model =
    let
        specialContactUrlForLanguage : String
        specialContactUrlForLanguage =
            Maybe.withDefault model.flags.callCenterUrl <|
                Dict.get (R10.Language.toString model.language) model.flags.contactUsLanguageSupport
    in
    if model.flags.countryCode == R10.CountryCode.JP then
        specialContactUrlForLanguage

    else
        model.flags.callCenterUrl
