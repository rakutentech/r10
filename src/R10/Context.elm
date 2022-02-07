module R10.Context exposing (ContextInternal, ContextR10, builder, isShouldUseSimplePhoneInputWindowSize, isSmallScreen)

{-| Contains data that is automatically passed to all functions, based on `elm-ui-with-context`

@docs ContextInternal, ContextR10, builder, isShouldUseSimplePhoneInputWindowSize, isSmallScreen

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
type alias ContextInternal a =
    { a | contextR10 : ContextR10 }


{-| -}
type alias ContextR10 =
    { language : R10.Language.Language
    , theme : R10.Theme.Theme
    , userAgent : R10.Device.UserAgent
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
    , termsAndConditionsLink : String
    , privacyPolicyLink : String
    , cookiePolicyLink : String
    }


type alias Flags b =
    { b
        | mode : R10.Mode.Mode
        , primaryColor : R10.Color.Internal.Primary.Color
        , userAgent : String
        , platform : String
        , isOntouchendInDocument : Bool
        , emailDomainList : List String
        , termsAndConditionsLink : String
        , privacyPolicyLink : String
        , cookiePolicyLink : String
        , registrationLink : String
        , loginLink : String
        , debugger_transitionSpeed : Float
        , debugger_formStyleAsString : String
        , displayPromoArea : Bool
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
    }


{-| -}
builder : { model : Model a b c } -> ContextR10
builder { model } =
    { language = model.language
    , theme = R10.Theme.fromFlags model.flags
    , userAgent = R10.Device.constructor model.flags.userAgent model.flags.platform model.flags.isOntouchendInDocument
    , windowSize = { width = model.windowSize.width }
    , emailDomainList = model.flags.emailDomainList
    , currentUrl = model.url
    , urlImageFlags = model.urlImageFlags

    --
    , termsAndConditionsLink = model.flags.termsAndConditionsLink
    , privacyPolicyLink = model.flags.privacyPolicyLink
    , cookiePolicyLink = model.flags.cookiePolicyLink

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
isShouldUseSimplePhoneInputWindowSize : Int -> Bool
isShouldUseSimplePhoneInputWindowSize width =
    width < 700
