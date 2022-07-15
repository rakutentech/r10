module R10.Alert exposing (Alert(..), view)

import Element.WithContext exposing (..)
import Element.WithContext.Border as Border
import R10.Color.AttrsBackground
import R10.Color.AttrsFont
import R10.Color.Svg
import R10.Context
import R10.FontSize
import R10.Svg.Icons


type Alert
    = Danger
    | Info
    | Warning
    | Success


view :
    Alert
    -> List (Attribute (R10.Context.ContextInternal z) msg)
    -> List (Element (R10.Context.ContextInternal z) msg)
    -> Element (R10.Context.ContextInternal z) msg
view alert attrs listOfElement =
    if List.isEmpty listOfElement then
        text ""

    else
        withContext <|
            \c ->
                let
                    ( colorFont, colorBackground, colorIcon ) =
                        case alert of
                            Danger ->
                                ( R10.Color.AttrsFont.fontAlertDanger
                                , R10.Color.AttrsBackground.backgroundAlertDanger
                                , R10.Color.Svg.fontAlertDanger c.contextR10.theme
                                )

                            Info ->
                                ( R10.Color.AttrsFont.fontAlertInfo
                                , R10.Color.AttrsBackground.backgroundAlertInfo
                                , R10.Color.Svg.fontAlertInfo c.contextR10.theme
                                )

                            Warning ->
                                ( R10.Color.AttrsFont.fontAlertWarning
                                , R10.Color.AttrsBackground.backgroundAlertWarning
                                , R10.Color.Svg.fontAlertWarning c.contextR10.theme
                                )

                            Success ->
                                ( R10.Color.AttrsFont.fontAlertSuccess
                                , R10.Color.AttrsBackground.backgroundAlertSuccess
                                , R10.Color.Svg.fontAlertSuccess c.contextR10.theme
                                )
                in
                column [ spacing 20, width fill ]
                    (List.map
                        (\section ->
                            row
                                [ colorFont
                                , colorBackground
                                , R10.FontSize.small
                                , Border.rounded 5
                                , padding 16
                                , spacing 16
                                , width fill
                                ]
                                [ (case alert of
                                    -- https://dev-cdn.rex.contents.rakuten.co.jp/rex-form/v1.7.0/components/alert.html
                                    Danger ->
                                        R10.Svg.Icons.sign_warning_l

                                    Info ->
                                        R10.Svg.Icons.sign_info_l

                                    Warning ->
                                        R10.Svg.Icons.sign_info_l

                                    Success ->
                                        R10.Svg.Icons.check
                                  )
                                    [ alignTop ]
                                    colorIcon
                                    16
                                , paragraph attrs [ section ]
                                ]
                        )
                        listOfElement
                    )
