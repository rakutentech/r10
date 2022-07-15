module R10.Context exposing (ContextInternal, ContextR10, builder, isSmallScreen, default)

{-| Contains data that is automatically passed to all functions, based on `elm-ui-with-context`

@docs ContextInternal, ContextR10, builder, isSmallScreen, default

-}

import R10.Color
import R10.Color.Internal.Primary
import R10.Device
import R10.Language
import R10.Mode
import R10.Theme
import R10.When exposing (..)
import Url


{-| -}
type alias ContextInternal a =
    { a | contextR10 : ContextR10 }


{-| -}
type alias ContextR10 =
    { language : R10.Language.Language
    , theme : R10.Theme.Theme
    , device : R10.Device.Device
    , windowSize : { width : Int }
    , emailDomainList : List String
    , currentUrl : Url.Url
    , urlImageFlags : String

    -- Layout
    , inputFieldWithLargePattern_width : Int
    , inputFieldWithLargePattern_height : Int
    , inputFieldWithLargePattern_fontSize : Int
    , inputFieldWithLargePattern_letterSpacing : Int

    -- Debugging
    , debugger_transitionSpeed : Float

    -- URLs to be injected in messages. This stuff should be removed but it is
    -- a bit difficult, as it is used for Binary.elm (Check boxes to approve
    -- terms and conditions, policies, etc. This because the accepted type
    -- for the label is "String", but the label can contain also links.
    -- We will leave these here at the moment.
    -- A possibility for the future is to convert this field in markdown.
    --
    , urlTermsAndConditions : String
    , urlPrivacyPolicy : String
    , urlCookiePolicy : String
    , referenceExternalServiceName : String
    , clientName : String
    }


type alias Flags b =
    { b
        | mode : R10.Mode.Mode
        , primaryColor : R10.Color.Internal.Primary.Color
        , userAgent : String
        , platform : String
        , isOntouchendInDocument : Bool
        , emailDomainList : List String
        , urlTermsAndConditions : String
        , urlPrivacyPolicy : String
        , urlCookiePolicy : String
        , urlRegistration : String
        , urlLogin : String
        , debugger_transitionSpeed : Float
        , debugger_formStyleAsString : String
        , displayPromoArea : Bool
        , referenceExternalServiceName : String
        , clientName : String
    }


type alias WindowSize c =
    { c | width : Int }


type alias Model a b c =
    { a
        | flags : Flags b
        , language : R10.Language.Language
        , url : Url.Url
        , windowSize : WindowSize c
        , urlImageFlags : String
        , device : R10.Device.Device
    }


{-| -}
builder : { model : Model a b c } -> ContextR10
builder { model } =
    { language = model.language
    , theme = R10.Theme.fromFlags model.flags
    , device = model.device
    , windowSize = { width = model.windowSize.width }
    , emailDomainList = model.flags.emailDomainList
    , currentUrl = model.url
    , urlImageFlags = model.urlImageFlags

    --
    , urlTermsAndConditions = model.flags.urlTermsAndConditions
    , urlPrivacyPolicy = model.flags.urlPrivacyPolicy
    , urlCookiePolicy = model.flags.urlCookiePolicy
    , referenceExternalServiceName = model.flags.referenceExternalServiceName
    , clientName = model.flags.clientName

    --
    , inputFieldWithLargePattern_width = when (isSmallScreen model.windowSize.width) do 200 otherwise 240
    , inputFieldWithLargePattern_height = when (isSmallScreen model.windowSize.width) do 70 otherwise 80
    , inputFieldWithLargePattern_fontSize = when (isSmallScreen model.windowSize.width) do 35 otherwise 40
    , inputFieldWithLargePattern_letterSpacing = when (isSmallScreen model.windowSize.width) do 5 otherwise 10

    --
    , debugger_transitionSpeed = model.flags.debugger_transitionSpeed
    }


{-| -}
isSmallScreen : Int -> Bool
isSmallScreen width =
    width < 350


{-| -}
default : ContextInternal {}
default =
    { contextR10 =
        builder
            { model =
                { flags =
                    { mode = R10.Mode.Light
                    , primaryColor = R10.Color.primary.blueSky
                    , userAgent = ""
                    , platform = ""
                    , isOntouchendInDocument = False
                    , emailDomainList = [ "google.com" ]
                    , urlTermsAndConditions = ""
                    , urlPrivacyPolicy = ""
                    , urlCookiePolicy = ""
                    , urlRegistration = ""
                    , urlLogin = ""
                    , debugger_transitionSpeed = 1
                    , debugger_formStyleAsString = ""
                    , displayPromoArea = False
                    , referenceExternalServiceName = ""
                    , clientName = ""
                    }
                , language = R10.Language.EN_US
                , url =
                    { protocol = Url.Https
                    , host = ""
                    , port_ = Nothing
                    , path = ""
                    , query = Nothing
                    , fragment = Nothing
                    }
                , windowSize = { width = 1200 }
                , urlImageFlags = "https://example.com/flags.gif"
                , device = R10.Device.constructor "" "" False
                }
            }
    }
