module R10.LanguageSelector exposing (view)

{-| Dropdown for the language selector

@docs view

-}

import Element exposing (..)
import R10.DropDown
import R10.Language


{-| -}
view :
    List (Attribute msg)
    ->
        { changeMsg : Result String R10.Language.Language -> msg
        , colorBackground : String
        , colorFont : String
        , currentLocale : R10.Language.Language
        , supportedLanguageList : List R10.Language.Language
        , withLanguageSelector : Bool
        }
    -> Element msg
view attrs args =
    if args.withLanguageSelector then
        let
            handleInputChange : String -> msg
            handleInputChange string =
                string
                    |> R10.Language.decoder args.supportedLanguageList
                    |> args.changeMsg

            optionList : List R10.DropDown.Option
            optionList =
                args.supportedLanguageList
                    |> List.map
                        (\locale ->
                            R10.DropDown.Option
                                (R10.Language.toString locale)
                                (R10.Language.toLongString R10.Language.Localization locale)
                        )
        in
        R10.DropDown.viewBorderLess attrs
            { colorBackground = args.colorBackground
            , colorFont = args.colorFont
            , currentValue =
                R10.Language.toString
                    args.currentLocale
            , inputHandler = handleInputChange
            , optionList = optionList
            }

    else
        none
