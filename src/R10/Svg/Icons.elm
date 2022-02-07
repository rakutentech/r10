module R10.Svg.Icons exposing (arrow_down_l, arrow_left_l, arrow_link_l, arrow_right_l, arrow_up_l, barcode_f, barcode_l, blockquote_left, blockquote_right, browsing_history_f, browsing_history_l, building_f, building_l, bus_f, bus_l, button_chevron_left_f, button_chevron_left_l, button_chevron_right_f, button_chevron_right_l, button_minus_f, button_minus_l, button_plus_f, button_plus_l, calculator_f, calculator_l, calendar_f, calendar_l, campaign_f, campaign_l, car_f, car_l, cart_f, cart_l, change_order_l, check, chevron_left, chevron_right, cloud_f, cloud_l, code_f, code_l, comment_f, comment_l, compare_f, compare_l, coupon_f, coupon_l, credit_card_f, credit_card_l, currency_f, currency_l, delete_f, delete_l, delivery_f, delivery_l, desktop_f, desktop_l, domestic_area_f, domestic_area_l, download_f, download_l, eye_ban_f, eye_ban_l, eye_f, eye_l, favorite_f, favorite_half_f, favorite_l, ferry_f, ferry_l, fill_color_f, fill_color_l, folder_f, folder_l, gift_f, gift_l, heart_f, heart_l, home_f, home_l, image_f, image_l, keyboard_f, keyboard_l, language_f, language_l, laptop_f, laptop_l, like_f, like_l, list_f, list_l, loading_l, location_f, location_l, login_l, logout_l, lucky_kuji_f, lucky_kuji_l, mail_f, mail_l, map_f, map_l, menu, minus, mobile_phone_f, mobile_phone_l, movie_f, movie_l, new_user_f, new_window_l, notice_generic_f, notice_generic_l, notice_user_f, notice_user_l, paint_f, paint_l, paper_plane_f, paper_plane_l, pdf_f, pdf_l, phone_f, phone_l, photograph_f, photograph_l, pin_f, pin_l, plane_f, plane_l, plus, point_f, point_l, price_f, price_l, print_f, print_l, purchase_history_f, purchase_history_l, qrcode_f, qrcode_l, rakuten_account_f, rakuten_account_l, rakuten_registration_f, rakuten_registration_l, ranking_f, ranking_l, refresh, review_comment_f, review_comment_l, review_edit_f, review_edit_l, rss_symbol_l, rss_text_f, rss_text_l, save_f, save_l, search, search_history_f, search_history_l, security_f, security_l, server_f, server_l, settings_f, settings_l, share_f, share_l, shop_f, shop_l, sign_ban_f, sign_ban_l, sign_help_f, sign_help_l, sign_info_f, sign_info_l, sign_warning_f, sign_warning_l, sliders_f, sliders_l, smartphone_f, smartphone_l, survey_f, survey_l, switch_language_f, switch_language_l, tablet_f, tablet_l, tag_f, tag_l, time_f, time_l, train_f, train_l, upload_f, upload_l, voice_input_f, voice_input_l, walking_f, world_f, world_l, x, zip_f, zip_l, zoom_in_f, zoom_in_l, zoom_out_f, zoom_out_l)

{-|

@docs arrow_down_l, arrow_left_l, arrow_link_l, arrow_right_l, arrow_up_l, barcode_f, barcode_l, blockquote_left, blockquote_right, browsing_history_f, browsing_history_l, building_f, building_l, bus_f, bus_l, button_chevron_left_f, button_chevron_left_l, button_chevron_right_f, button_chevron_right_l, button_minus_f, button_minus_l, button_plus_f, button_plus_l, calculator_f, calculator_l, calendar_f, calendar_l, campaign_f, campaign_l, car_f, car_l, cart_f, cart_l, change_order_l, check, chevron_left, chevron_right, cloud_f, cloud_l, code_f, code_l, comment_f, comment_l, compare_f, compare_l, coupon_f, coupon_l, credit_card_f, credit_card_l, currency_f, currency_l, delete_f, delete_l, delivery_f, delivery_l, desktop_f, desktop_l, domestic_area_f, domestic_area_l, download_f, download_l, eye_ban_f, eye_ban_l, eye_f, eye_l, favorite_f, favorite_half_f, favorite_l, ferry_f, ferry_l, fill_color_f, fill_color_l, folder_f, folder_l, gift_f, gift_l, heart_f, heart_l, home_f, home_l, image_f, image_l, keyboard_f, keyboard_l, language_f, language_l, laptop_f, laptop_l, like_f, like_l, list_f, list_l, loading_l, location_f, location_l, login_l, logout_l, lucky_kuji_f, lucky_kuji_l, mail_f, mail_l, map_f, map_l, menu, minus, mobile_phone_f, mobile_phone_l, movie_f, movie_l, new_user_f, new_window_l, notice_generic_f, notice_generic_l, notice_user_f, notice_user_l, paint_f, paint_l, paper_plane_f, paper_plane_l, pdf_f, pdf_l, phone_f, phone_l, photograph_f, photograph_l, pin_f, pin_l, plane_f, plane_l, plus, point_f, point_l, price_f, price_l, print_f, print_l, purchase_history_f, purchase_history_l, qrcode_f, qrcode_l, rakuten_account_f, rakuten_account_l, rakuten_registration_f, rakuten_registration_l, ranking_f, ranking_l, refresh, review_comment_f, review_comment_l, review_edit_f, review_edit_l, rss_symbol_l, rss_text_f, rss_text_l, save_f, save_l, search, search_history_f, search_history_l, security_f, security_l, server_f, server_l, settings_f, settings_l, share_f, share_l, shop_f, shop_l, sign_ban_f, sign_ban_l, sign_help_f, sign_help_l, sign_info_f, sign_info_l, sign_warning_f, sign_warning_l, sliders_f, sliders_l, smartphone_f, smartphone_l, survey_f, survey_l, switch_language_f, switch_language_l, tablet_f, tablet_l, tag_f, tag_l, time_f, time_l, train_f, train_l, upload_f, upload_l, voice_input_f, voice_input_l, walking_f, world_f, world_l, x, zip_f, zip_l, zoom_in_f, zoom_in_l, zoom_out_f, zoom_out_l

-}

import Element.WithContext exposing (..)
import R10.Color.Utils
import R10.Svg.Utils
import R10.Context exposing (..)
import Svg
import Svg.Attributes as SA


{-| -}
arrow_down_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
arrow_down_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M28 18l-1.4-1.4-9.6 9.6V2h-2v24.2l-9.6-9.6L4 18l12 12 12-12z" ] []
        , Svg.path [ SA.fill "none", SA.d "M32 0v32H0V0z" ] []
        ]


{-| -}
arrow_left_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
arrow_left_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M14 28l1.4-1.4L5.8 17H30v-2H5.8l9.6-9.6L14 4 2 16l12 12z" ] []
        , Svg.path [ SA.fill "none", SA.d "M32 32H0V0h32z" ] []
        ]


{-| -}
arrow_right_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
arrow_right_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M18 4l-1.4 1.4 9.6 9.6H2v2h24.2l-9.6 9.6L18 28l12-12L18 4z" ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
arrow_link_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
arrow_link_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M16 4l-1.4 1.4 9.6 9.6H4v2h20.2l-9.6 9.6L16 28l12-12L16 4z" ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
arrow_up_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
arrow_up_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M4 14l1.4 1.4L15 5.8V30h2V5.8l9.6 9.6L28 14 16 2 4 14z" ] []
        , Svg.path [ SA.fill "none", SA.d "M0 32V0h32v32z" ] []
        ]


{-| -}
barcode_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
barcode_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M4 24H2v6h6v-2H4v-4zM4 4h4V2H2v6h2V4zm24 24h-4v2h6v-6h-2v4zM24 2v2h4v4h2V2h-6z" ] []
            , Svg.path [ SA.d "M6 26h20V6H6zM20 9h2v14h-2zm-4 0h2v14h-2zm-6 0h4v14h-4z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
barcode_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
barcode_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M4 24H2v6h6v-2H4v-4zM2 8h2V4h4V2H2v6zm26 20h-4v2h6v-6h-2v4zM24 2v2h4v4h2V2h-6zM10 9h4v14h-4zm6 0h2v14h-2zm4 0h2v14h-2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
blockquote_left : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
blockquote_left attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M13.53 8.61a1.91 1.91 0 0 0 1.17-1.65 1.43 1.43 0 0 0-.4-1.03 1.36 1.36 0 0 0-1.01-.42q-1.54 0-4.25 1.91a17.36 17.36 0 0 0-5.09 5.46 12.46 12.46 0 0 0-1.9 6.34 8.73 8.73 0 0 0 .53 2.95A7.67 7.67 0 0 0 4 24.67a5.7 5.7 0 0 0 4.49 2.2 5.6 5.6 0 0 0 4.46-2.01 6.34 6.34 0 0 0 1.12-1.96 6.58 6.58 0 0 0 .42-2.26 6.7 6.7 0 0 0-1.23-4.06 4.72 4.72 0 0 0-3.23-1.97l-.5-.03-.36-.07c-.61-.09-.92-.34-.92-.76a4.15 4.15 0 0 1 1.2-2.08 15.9 15.9 0 0 1 4.08-3.06zm15.24 0a1.91 1.91 0 0 0 1.17-1.65 1.43 1.43 0 0 0-.4-1.03 1.36 1.36 0 0 0-1.02-.42q-1.54 0-4.25 1.91a17.57 17.57 0 0 0-5.12 5.46 12.37 12.37 0 0 0-1.9 6.34 8.73 8.73 0 0 0 .52 2.95 7.68 7.68 0 0 0 1.41 2.5 5.75 5.75 0 0 0 4.53 2.2 5.67 5.67 0 0 0 4.47-2.01 6.34 6.34 0 0 0 1.13-1.95 6.88 6.88 0 0 0-.83-6.31 4.94 4.94 0 0 0-3.26-2l-.46-.03-.4-.06c-.62-.09-.93-.34-.93-.76a4.12 4.12 0 0 1 1.23-2.08 14.84 14.84 0 0 1 4.1-3.06z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
blockquote_right : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
blockquote_right attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M0 0h32v32H0z", SA.fill "none" ] []
        , Svg.path [ SA.d "M18.47 23.77a1.91 1.91 0 0 0-1.17 1.65 1.43 1.43 0 0 0 .4 1.04 1.36 1.36 0 0 0 1.01.4q1.54 0 4.25-1.9a17.36 17.36 0 0 0 5.09-5.46 12.46 12.46 0 0 0 1.9-6.34 8.73 8.73 0 0 0-.53-2.95A7.67 7.67 0 0 0 28 7.72a5.7 5.7 0 0 0-4.49-2.2 5.6 5.6 0 0 0-4.46 2 6.34 6.34 0 0 0-1.12 1.97 6.58 6.58 0 0 0-.42 2.25 6.7 6.7 0 0 0 1.23 4.06 4.72 4.72 0 0 0 3.23 1.97l.5.04.36.06c.61.1.92.34.92.76a4.15 4.15 0 0 1-1.2 2.08 15.9 15.9 0 0 1-4.08 3.06zm-15.24 0a1.91 1.91 0 0 0-1.17 1.65 1.43 1.43 0 0 0 .4 1.04 1.36 1.36 0 0 0 1.02.4q1.54 0 4.25-1.9a17.57 17.57 0 0 0 5.12-5.46 12.37 12.37 0 0 0 1.9-6.34 8.73 8.73 0 0 0-.52-2.95 7.68 7.68 0 0 0-1.41-2.49 5.75 5.75 0 0 0-4.53-2.2 5.67 5.67 0 0 0-4.47 2 6.34 6.34 0 0 0-1.13 1.95 6.54 6.54 0 0 0-.42 2.28 6.54 6.54 0 0 0 1.25 4.03 4.94 4.94 0 0 0 3.26 2l.46.03.4.06c.62.1.93.34.93.76a4.12 4.12 0 0 1-1.24 2.08 14.84 14.84 0 0 1-4.1 3.06z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
browsing_history_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
browsing_history_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M19 2A10.98 10.98 0 0 0 8.43 16H16v7.58A11 11 0 1 0 19 2zm7 12h-8V7h2v5h6zM2 18h3v2H2zm0 5h3v2H2z" ] []
            , Svg.path [ SA.d "M7 18h7v2H7zm0 5h7v2H7zm-5 5h3v2H2zm5 0h7v2H7z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
browsing_history_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
browsing_history_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M17 8v7h8v-2h-6V8h-2zM2 18h3v2H2zm0 5h3v2H2zm5-5h7v2H7zm0 5h7v2H7zm-5 5h3v2H2zm5 0h7v2H7z" ] []
            , Svg.path [ SA.d "M19 2A10.98 10.98 0 0 0 8.43 16h2.1A9.04 9.04 0 1 1 16 21.48v2.1A11 11 0 1 0 19 2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
building_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
building_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M16 25a2.5 2.5 0 0 0-2.5 2.5V30h5v-2.5A2.5 2.5 0 0 0 16 25z" ] []
            , Svg.path [ SA.d "M25 2H7a2 2 0 0 0-2 2v24a2 2 0 0 0 2 2h4.5v-2.5a4.5 4.5 0 0 1 9 0V30H25a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2zM12 20h-2v-3h2zm0-5h-2v-3h2zm0-5h-2V7h2zm5 10h-2v-3h2zm0-5h-2v-3h2zm0-5h-2V7h2zm5 10h-2v-3h2zm0-5h-2v-3h2zm0-5h-2V7h2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
building_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
building_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M16 23a4 4 0 0 0-4 4v3h8v-3a4 4 0 0 0-4-4zm2 5h-4v-1a2 2 0 0 1 4 0zM10 7h2v3h-2zm5 0h2v3h-2zm5 0h2v3h-2zm-10 5h2v3h-2zm5 0h2v3h-2zm5 0h2v3h-2zm-10 5h2v3h-2zm5 0h2v3h-2zm5 0h2v3h-2z" ] []
            , Svg.path [ SA.d "M25 2H7a2 2 0 0 0-2 2v24a2 2 0 0 0 2 2h3v-2H7V4h18v24h-3v2h3a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
bus_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
bus_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M24 2H8a4 4 0 0 0-4 4v18a2 2 0 0 0 2 2v2a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-2h10v2a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-2a2 2 0 0 0 2-2V6a4 4 0 0 0-4-4zM9.5 22a1.5 1.5 0 1 1 1.5-1.5A1.5 1.5 0 0 1 9.5 22zm13 0a1.5 1.5 0 1 1 1.5-1.5 1.5 1.5 0 0 1-1.5 1.5zm3.5-7H6V7h20z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
bus_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
bus_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M24 2H8a4 4 0 0 0-4 4v18a2 2 0 0 0 2 2v2a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-2h10v2a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-2a2 2 0 0 0 2-2V6a4 4 0 0 0-4-4zm2 22H6v-7h20zm0-9H6V9h20zm0-8H6V6a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2z" ] []
            , Svg.circle [ SA.cx "9.5", SA.cy "20.5", SA.r "1.5" ] []
            , Svg.circle [ SA.cx "22.5", SA.cy "20.5", SA.r "1.5" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
button_chevron_left_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
button_chevron_left_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 0a16 16 0 1 0 16 16A16 16 0 0 0 16 0zm4.21 24.29L18.8 25.7 9.09 16l9.71-9.71 1.41 1.41-8.3 8.3z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
button_chevron_left_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
button_chevron_left_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 0a16 16 0 1 0 16 16A16 16 0 0 0 16 0zm0 30a14 14 0 1 1 14-14 14 14 0 0 1-14 14z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M18.79 6.29L9.09 16l9.7 9.71 1.42-1.42-8.3-8.29 8.3-8.29-1.42-1.42z" ] []
        ]


{-| -}
button_chevron_right_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
button_chevron_right_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 0a16 16 0 1 0 16 16A16 16 0 0 0 16 0zm-2.79 25.71L11.8 24.3l8.29-8.3-8.3-8.29L13.2 6.3l9.71 9.7z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
button_chevron_right_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
button_chevron_right_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 0a16 16 0 1 0 16 16A16 16 0 0 0 16 0zm0 30a14 14 0 1 1 14-14 14 14 0 0 1-14 14z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M11.79 7.71l8.3 8.29-8.3 8.29 1.42 1.42 9.7-9.71-9.7-9.71-1.42 1.42z" ] []
        ]


{-| -}
button_minus_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
button_minus_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 0a16 16 0 1 0 16 16A16 16 0 0 0 16 0zm9 17H7v-2h18z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
button_minus_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
button_minus_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 0a16 16 0 1 0 16 16A16 16 0 0 0 16 0zm0 30a14 14 0 1 1 14-14 14 14 0 0 1-14 14z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M7 15h18v2H7z" ] []
        ]


{-| -}
button_plus_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
button_plus_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 0a16 16 0 1 0 16 16A16 16 0 0 0 16 0zm9 17h-8v8h-2v-8H7v-2h8V7h2v8h8z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
button_plus_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
button_plus_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 0a16 16 0 1 0 16 16A16 16 0 0 0 16 0zm0 30a14 14 0 1 1 14-14 14 14 0 0 1-14 14z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M17 7h-2v8H7v2h8v8h2v-8h8v-2h-8V7z" ] []
        ]


{-| -}
calculator_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
calculator_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M3 25a4 4 0 0 0 4 4h8V17H3zm3.04-3.54l1.42-1.42L9 21.6l1.55-1.56 1.42 1.42L10.42 23l1.56 1.55-1.42 1.42-1.55-1.56-1.55 1.56-1.42-1.42 1.56-1.55zM3 7v8h12V3H7a4 4 0 0 0-4 4zm5-1h2v2h2v2h-2v2H8v-2H6V8h2zm9 23h8a4 4 0 0 0 4-4v-8H17zm3-9h6v2h-6zm0 4h6v2h-6zm5-21h-8v12h12V7a4 4 0 0 0-4-4zm1 7h-6V8h6z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
calculator_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
calculator_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M25 3H7a4 4 0 0 0-4 4v18a4 4 0 0 0 4 4h18a4 4 0 0 0 4-4V7a4 4 0 0 0-4-4zM15 27H7a2 2 0 0 1-2-2v-8h10zm0-12H5V7a2 2 0 0 1 2-2h8zm12 10a2 2 0 0 1-2 2h-8V17h10zm0-10H17V5h8a2 2 0 0 1 2 2z" ] []
            , Svg.path [ SA.d "M7 11h2v2h2v-2h2V9h-2V7H9v2H7v2zm12-2h6v2h-6zm0 10h6v2h-6zm0 4h6v2h-6zM8.46 24.98L10 23.42l1.55 1.56 1.42-1.42-1.56-1.55 1.56-1.55-1.42-1.42-1.55 1.56-1.55-1.56-1.42 1.42L8.6 22l-1.56 1.55 1.42 1.42z" ] []
            ]
        ]


{-| -}
calendar_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
calendar_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M27 5h-3V3h-2v2H10V3H8v2H5a2 2 0 0 0-2 2v5h26V7a2 2 0 0 0-2-2zM3 27a2 2 0 0 0 2 2h22a2 2 0 0 0 2-2V14H3zm13-8v-2h6v2l-3.75 7H16l3.73-7zm-5-2h3v9h-2v-7h-1z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
calendar_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
calendar_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M27 27H5V16H3v11a2 2 0 0 0 2 2h22a2 2 0 0 0 2-2V16h-2zm0-22h-3V3h-2v2H10V3H8v2H5a2 2 0 0 0-2 2v7h26V7a2 2 0 0 0-2-2zm0 7H5V7h3v3h2V7h12v3h2V7h3z" ] []
            , Svg.path [ SA.d "M14 25v-9h-3v2h1v7h2zm4.25 0L22 18v-2h-6v2h3.73L16 25h2.25z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
campaign_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
campaign_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M13.2 5.57A1.93 1.93 0 0 0 11.85 5a1.95 1.95 0 0 0-1.85 1.3L4.52 20.95l-1.89 1.89a2.18 2.18 0 0 0 0 3.07l3.44 3.44a2.16 2.16 0 0 0 3.06 0L11 27.48l1.13-.42.34.95a3 3 0 0 0 3.86 1.8l3.18-1.16a3.01 3.01 0 0 0 1.78-3.83l-.35-1 4.76-1.75a1.96 1.96 0 0 0 .72-3.23zm5.63 21.2l-3.18 1.17a1 1 0 0 1-1.29-.6l-.34-.97 5.05-1.86.35.98a1 1 0 0 1-.6 1.28zM18 2h2v5h-2zm7 10H30v2h-5zM22.3 8.29l4-4 1.4 1.42-3.99 4z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
campaign_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
campaign_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M13.2 5.6a2 2 0 0 0-1.4-.6A2 2 0 0 0 10 6.3L4.5 21l-1.9 1.8a2.2 2.2 0 0 0 0 3.1l3.5 3.5a2.2 2.2 0 0 0 3 0l2-2 1-.3.4 1a3 3 0 0 0 3.8 1.7l3.2-1.2a3 3 0 0 0 1.8-3.8l-.4-1 4.8-1.7a2 2 0 0 0 .7-3.3zM7.7 27.9a.2.2 0 0 1-.2 0L4 24.5a.2.2 0 0 1 0-.2L5.2 23 9 26.8zm11.1-1.1l-3.2 1.1a1 1 0 0 1-1.2-.6l-.4-1 5-1.8.4 1a1 1 0 0 1-.6 1.3zm-8.3-1.3l-4-4L11.8 7 25 20.2zM18 2h2v5h-2zm7 10h5v2h-5zm-2.7-3.7l4-4 1.4 1.4-4 4z" ] []
        ]


{-| -}
car_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
car_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M29.66 15.5l-1.07-1.6a1.99 1.99 0 0 0-.92-.74L26.3 5.64A2 2 0 0 0 24.33 4H7.67A2 2 0 0 0 5.7 5.64l-1.36 7.52a1.99 1.99 0 0 0-.93.73l-1.07 1.6A2 2 0 0 0 2 16.62V24a2 2 0 0 0 2 2v2a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-2h14v2a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-2a2 2 0 0 0 2-2v-7.4a2 2 0 0 0-.34-1.1zM7.5 21A1.5 1.5 0 1 1 9 19.5 1.5 1.5 0 0 1 7.5 21zM19 24h-6v-3h6zM6.4 13l1.27-7h16.66l1.28 7zm18.1 8a1.5 1.5 0 1 1 1.5-1.5 1.5 1.5 0 0 1-1.5 1.5z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
car_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
car_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.circle [ SA.cx "7.5", SA.cy "19.5", SA.r "1.5" ]
                []
            , Svg.circle
                [ SA.cx "24.5", SA.cy "19.5", SA.r "1.5" ]
                []
            , Svg.path [ SA.d "M29.66 15.5l-1.07-1.6a1.99 1.99 0 0 0-.92-.74L26.3 5.64A2 2 0 0 0 24.33 4H7.67A2 2 0 0 0 5.7 5.64l-1.36 7.52a1.99 1.99 0 0 0-.93.73l-1.07 1.6A2 2 0 0 0 2 16.62V24a2 2 0 0 0 2 2v2a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-2h14v2a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-2a2 2 0 0 0 2-2v-7.4a2 2 0 0 0-.34-1.1zM7.67 6h16.66l1.28 7H6.4zM18 24h-4v-2h4zm10 0h-8v-4h-8v4H4v-7.4L5.07 15h21.86L28 16.6z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
cart_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
cart_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.circle [ SA.cx "11", SA.cy "28", SA.r "2" ]
                []
            , Svg.circle
                [ SA.cx "25", SA.cy "28", SA.r "2" ]
                []
            , Svg.path [ SA.d "M10.73 21.15L8.24 4.55A2.98 2.98 0 0 0 5.28 2H2v2h3.28a1 1 0 0 1 .99.85l2.49 16.6A2.98 2.98 0 0 0 11.72 24H27v-2H11.72a1 1 0 0 1-.99-.85z" ] []
            , Svg.path [ SA.d "M10.34 5l2.1 14h10.84a4 4 0 0 0 3.99-3.71L28 5z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
cart_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
cart_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.circle [ SA.cx "11", SA.cy "28", SA.r "2" ] []
            , Svg.circle [ SA.cx "25", SA.cy "28", SA.r "2" ] []
            , Svg.path [ SA.d "M10.73 21.15L8.24 4.55A2.98 2.98 0 0 0 5.28 2H2v2h3.28a1 1 0 0 1 .99.85l2.49 16.6A2.98 2.98 0 0 0 11.72 24H27v-2H11.72a1 1 0 0 1-.99-.85z" ] []
            , Svg.path [ SA.d "M10.34 5l.3 2h15.21l-.58 8.14a2 2 0 0 1-2 1.86H12.15l.3 2h10.84a4 4 0 0 0 3.99-3.71L28 5z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
change_order_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
change_order_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M32 32H0V0h32z" ] []
        , Svg.path [ SA.d "M22.99 4L16 10.99l1.37 1.37L22 7.72V28h2V7.75l4.6 4.6L29.99 11l-7-6.99zM9.98 24.28V4h-2v20.25l-4.61-4.6L2 21 8.99 28l6.99-6.99-1.37-1.37-4.63 4.64z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
check : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
check attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.fillRule "evenodd", SA.d "M30 7l-1.41-1.41L11 23.17 3.41 15.6 2 17l9 9L30 7z" ] []
        ]


{-| -}
chevron_left : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
chevron_left attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M32 32H0V0h32z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.fillRule "evenodd", SA.d "M21.8 29l1.4-1.41L11.63 16 23.21 4.41 21.79 3l-13 13 13 13z" ] []
        ]


{-| -}
chevron_right : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
chevron_right attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.fillRule "evenodd", SA.d "M10.2 3L8.8 4.41 20.37 16 8.79 27.59 10.21 29l13-13-13-13z" ] []
        ]


{-| -}
cloud_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
cloud_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M30 22a5.99 5.99 0 0 0-2.2-4.65A4.95 4.95 0 0 0 28 16a5 5 0 0 0-5-5 4.95 4.95 0 0 0-1.5.25A8 8 0 0 0 6 14c0 .23.01.45.03.67A7 7 0 0 0 9 28h15.5v-.03A6 6 0 0 0 30 22z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
cloud_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
cloud_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M14 8a6.02 6.02 0 0 1 5.63 3.94l.66 1.8 1.82-.58A2.96 2.96 0 0 1 23 13a2.93 2.93 0 0 1 2.87 3.8l-.36 1.27 1.02.83a4 4 0 0 1-2.2 7.08l-.19.02H9a5 5 0 0 1-2.12-9.52l1.26-.6-.11-1.38A6.07 6.07 0 0 1 8 14a6 6 0 0 1 6-6m0-2a8 8 0 0 0-8 8c0 .23.01.45.03.67A7 7 0 0 0 9 28h15.5v-.03a6 6 0 0 0 3.3-10.62A4.95 4.95 0 0 0 28 16a5 5 0 0 0-5-5 4.95 4.95 0 0 0-1.5.25A8 8 0 0 0 14 6z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
code_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
code_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M28 7H16l-1.37-2.86A2 2 0 0 0 12.83 3H5.5a2 2 0 0 0-1.92 1.45L2 10v17a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.d "M10.7 22.7L6 18l4.7-4.7 1.42 1.4-3.3 3.3 3.3 3.3-1.41 1.4zm10.6 0l-1.42-1.4 3.3-3.3-3.3-3.3 1.41-1.4L26 18l-4.7 4.7zM14.91 25L13 24.42 17.08 11l1.92.58L14.92 25z", SA.fill "#fff" ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
code_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
code_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M10.7 22.7L6 18l4.7-4.7 1.42 1.4-3.3 3.3 3.3 3.3-1.41 1.4zm10.6 0l-1.42-1.4 3.3-3.3-3.3-3.3 1.41-1.4L26 18l-4.7 4.7zM14.91 25L13 24.42 17.08 11l1.92.58L14.92 25z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.d "M28 7H16l-1.37-2.86A2 2 0 0 0 12.83 3H5.5a2 2 0 0 0-1.92 1.45L2 10v17a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zm0 20H4V10.28L5.5 5h7.33l1.36 2.86.55 1.14H28z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
comment_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
comment_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 2H10a2 2 0 0 0-2 2v2h14a4 4 0 0 1 4 4v10h2a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2z" ] []
            , Svg.path [ SA.d "M22 8H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h5l4 4 4-4h5a2 2 0 0 0 2-2V10a2 2 0 0 0-2-2zm-9 13H7v-2h6zm6-5H7v-2h12z" ] []
            ]
        ]


{-| -}
comment_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
comment_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M22 8H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h5l4 4 4-4h5a2 2 0 0 0 2-2V10a2 2 0 0 0-2-2zm0 16h-5.83l-.58.59L13 27.17l-2.59-2.58-.58-.59H4V10h18z" ] []
            , Svg.path [ SA.d "M7 14h12v2H7zm0 5h6v2H7z" ] []
            , Svg.path [ SA.d "M28 2H10a2 2 0 0 0-2 2v2h2V4h18v14h-2v2h2a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2z" ] []
            ]
        ]


{-| -}
compare_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
compare_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M9.66 11.89h1.68l-.84-2.44-.84 2.44zm12.94-1.75a.58.58 0 0 0-.58-.58h-1.96v1.16h1.96a.58.58 0 0 0 .58-.58zm.34 2.72a.58.58 0 0 0-.58-.58h-2.3v1.16h2.3a.58.58 0 0 0 .59-.58z" ] []
        , Svg.path [ SA.d "M25 3H7a4.01 4.01 0 0 0-4 4v18a4.01 4.01 0 0 0 4 4h18a4.01 4.01 0 0 0 4-4V7a4.01 4.01 0 0 0-4-4zm-6.5 5h3.6a1.98 1.98 0 0 1 2.06 1.97 1.48 1.48 0 0 1-1.05 1.44 1.55 1.55 0 0 1 1.39 1.58A1.92 1.92 0 0 1 22.44 15H18.5zM14 24H7v-2h7zm0-4H7v-2h7zm-1.6-5l-.53-1.56H9.13L8.59 15H7l2.4-7h2.2l2.4 7zM25 24h-7v-2h7zm0-4h-7v-2h7z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
compare_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
compare_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M11 8H9.4L7 15h1.6l.53-1.56h2.74l.54 1.56H14l-2.4-7zm-1.34 3.89l.84-2.44.84 2.44z" ] []
            , Svg.path [ SA.d "M25 3H7a4.01 4.01 0 0 0-4 4v18a4.01 4.01 0 0 0 4 4h18a4.01 4.01 0 0 0 4-4V7a4.01 4.01 0 0 0-4-4zm2 22a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2h18a2 2 0 0 1 2 2z" ] []
            , Svg.path [ SA.d "M24.5 12.99a1.55 1.55 0 0 0-1.39-1.58 1.48 1.48 0 0 0 1.05-1.44A1.98 1.98 0 0 0 22.1 8h-3.6v7h3.94a1.92 1.92 0 0 0 2.06-2.01zm-4.45-3.44h1.97a.58.58 0 1 1 0 1.17h-1.96zm0 3.9v-1.17h2.31a.58.58 0 1 1 0 1.16zM7 18h7v2H7zm0 4h7v2H7zm11-4h7v2h-7zm0 4h7v2h-7z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
coupon_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
coupon_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M30 13V6a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v7a3 3 0 0 1 0 6v7a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2v-7a3 3 0 0 1 0-6zm-17 5h-2v-4h2zm0-6h-2V8h2zm0 12h-2v-4h2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
coupon_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
coupon_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M30 14V6a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v8a2 2 0 0 1 0 4v8a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2v-8a2 2 0 0 1 0-4zm-2-1.46a4 4 0 0 0 0 6.92V26H4v-6.54a4 4 0 0 0 0-6.92V6h24z" ] []
            , Svg.path [ SA.d "M10 14h2v4h-2zm0-6h2v4h-2zm0 12h2v4h-2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
credit_card_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
credit_card_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M2 25a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V14H2zm10.5-5a1.5 1.5 0 1 1-1.5 1.5 1.5 1.5 0 0 1 1.5-1.5zm-5 0A1.5 1.5 0 1 1 6 21.5 1.5 1.5 0 0 1 7.5 20zM28 5H4a2 2 0 0 0-2 2v3h28V7a2 2 0 0 0-2-2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
credit_card_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
credit_card_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.circle [ SA.cx "7.5", SA.cy "21.5", SA.r "1.5" ]
                []
            , Svg.circle
                [ SA.cx "12.5", SA.cy "21.5", SA.r "1.5" ]
                []
            , Svg.path [ SA.d "M28 5H4a2 2 0 0 0-2 2v7h28V7a2 2 0 0 0-2-2zm0 5H4V7h24zm0 15H4v-9H2v9a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2v-9h-2z" ] []
            ]
        ]


{-| -}
currency_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
currency_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M9.97 13.41a12.05 12.05 0 0 1 1.08-1.38c-1.36-.36-3.2-.96-3.2-2.97A2.77 2.77 0 0 1 9.6 6.72a3.43 3.43 0 0 1 .41-.16V5h1.99v1.48a6.46 6.46 0 0 1 2.79 1.38l-1.27 1.5c-1.14-.9-2.24-1.24-3.03-.9a1.01 1.01 0 0 0-.62.6c0 .52.38.75 1.96 1.17.28.08.58.16.88.26a11.94 11.94 0 0 1 6.79-2.46A9 9 0 1 0 8.02 19.49a11.98 11.98 0 0 1 1.02-4.35A9.04 9.04 0 0 1 7 13.92l1.25-1.51a6.97 6.97 0 0 0 1.72 1z" ] []
            , Svg.path [ SA.d "M20 10a10 10 0 1 0 10 10 10 10 0 0 0-10-10zm5 8.5V20h-3.83l-.17.27v1.23h4V23h-4v3h-2v-3h-4v-1.5h4v-1.23l-.17-.27H15v-1.5h2.87L15 14h2.31L20 18.15 22.69 14H25l-2.87 4.5z" ] []
            ]
        ]


{-| -}
currency_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
currency_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M4 11a7 7 0 0 1 13.48-2.64 11.9 11.9 0 0 1 2.04-.25 9 9 0 1 0-11.4 11.4 11.9 11.9 0 0 1 .24-2.03A7 7 0 0 1 4 11z" ] []
            , Svg.path [ SA.d "M7 13.92a9 9 0 0 0 2.12 1.25 11.9 11.9 0 0 1 .94-1.72 6.91 6.91 0 0 1-1.8-1.04zm3.48-5.47c.78-.33 1.89 0 3.02.91l1.27-1.5A6.46 6.46 0 0 0 12 6.48V5H10v1.56a3.43 3.43 0 0 0-.41.16 2.77 2.77 0 0 0-1.73 2.34c0 2.05 1.92 2.63 3.28 3a11.99 11.99 0 0 1 1.67-1.54c-.34-.11-.68-.2-1-.29-1.57-.42-1.95-.65-1.95-1.17a1.01 1.01 0 0 1 .62-.6zM20 10.1A9.91 9.91 0 1 0 29.91 20 9.91 9.91 0 0 0 20 10.09zm0 17.82A7.91 7.91 0 1 1 27.91 20 7.92 7.92 0 0 1 20 27.91z" ] []
            , Svg.path [ SA.d "M22.7 14.47L20 18.62l-2.7-4.15H15l2.87 4.5H15v1.5h3.83l.17.27v1.23h-4v1.5h4v3h2v-3h4v-1.5h-4v-1.23l.17-.27H25v-1.5h-2.87l2.87-4.5h-2.3z" ] []
            ]
        ]


{-| -}
delete_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
delete_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M6 28.17A1.92 1.92 0 0 0 8 30h16a1.92 1.92 0 0 0 2-1.83V9H6zM20 12h2v15h-2zm-5 0h2v15h-2zm-5 0h2v15h-2zm9-7a3 3 0 0 0-6 0H4v2h24V5z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
delete_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
delete_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M24 28H8V9H6v19a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V9h-2z" ] []
            , Svg.path [ SA.d "M11 11h2v15h-2zm8 0h2v15h-2zm-4 0h2v15h-2zm4-6a3 3 0 0 0-6 0H4v2h24V5z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
delivery_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
delivery_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ]
            []
        , Svg.circle
            [ SA.cx "10", SA.cy "26", SA.r "1", SA.fill "none" ]
            []
        , Svg.circle [ SA.cx "25", SA.cy "26", SA.r "1", SA.fill "none" ] []
        , Svg.path [ SA.d "M17 4H5a2 2 0 0 0-2 2v19a2 2 0 0 0 2 2h2.18a2.98 2.98 0 0 0 5.64 0H19V6a2 2 0 0 0-2-2zm-7 23a1 1 0 1 1 1-1 1 1 0 0 1-1 1zM25 8h-4v19h1.18a2.98 2.98 0 0 0 5.64 0H28a2 2 0 0 0 2-2v-7zm0 19a1 1 0 1 1 1-1 1 1 0 0 1-1 1zm-2-9v-6h1.76l3 6z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
delivery_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
delivery_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M25 8h-4v2h2.76l1 2H23v6h4.76l.24.47V25h-.18a2.98 2.98 0 0 0-5.64 0H21v2h1.18a2.98 2.98 0 0 0 5.64 0H28a2 2 0 0 0 2-2v-7zm0 19a1 1 0 1 1 1-1 1 1 0 0 1-1 1zM17 4H5a2 2 0 0 0-2 2v19a2 2 0 0 0 2 2h2.18a2.98 2.98 0 0 0 5.64 0H19V6a2 2 0 0 0-2-2zm-7 23a1 1 0 1 1 1-1 1 1 0 0 1-1 1zm7-2h-4.18a2.98 2.98 0 0 0-5.64 0H5V6h12z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
desktop_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
desktop_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M4 6h20v2h2V6a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h9v2H8v2h10v-2h-3v-2h3v-6H4z" ] []
            , Svg.path [ SA.d "M28 10h-6a2 2 0 0 0-2 2v16h10V12a2 2 0 0 0-2-2zm0 8h-6v-2h6zm0-4h-6v-2h6z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
desktop_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
desktop_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M4 6h20v2h2V6a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h9v2H8v2h10v-2h-3v-2h3v-2H4v-2h14v-2H4z" ] []
            , Svg.path [ SA.d "M28 10h-6a2 2 0 0 0-2 2v16h10V12a2 2 0 0 0-2-2zm0 16h-6v-6h6zm0-8h-6v-2h6zm0-4h-6v-2h6z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
domestic_area_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
domestic_area_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 2h-4a2 2 0 0 0-2 2v4h8V4a2 2 0 0 0-2-2zm-6 15h-9v6h10v7h5a2 2 0 0 0 2-2V10h-8z" ] []
            , Svg.path [ SA.d "M13 28a2 2 0 0 0 2 2h6v-5h-8zM2 21a2 2 0 0 0 2 2h1v5a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2V17H2zM7 4a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v3h5z" ] []
            , Svg.path [ SA.d "M10 10H2v2h10V2h-2v8z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
domestic_area_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
domestic_area_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 2h-5a2 2 0 0 0-2 2v4h9V4a2 2 0 0 0-2-2zm0 4h-5V4h5zm-7 10h-8v6h10v8h5a2 2 0 0 0 2-2V10h-9zm2-4h5v16h-3v-8H15v-2h8z" ] []
            , Svg.path [ SA.d "M13 28a2 2 0 0 0 2 2h6v-6h-8zm2-2h4v2h-4zM2 21a2 2 0 0 0 2 2h1v5a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2V16H2zm2-3h5v10H7v-7H4zM8 4a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v4h6zM6 6H4V4h2z" ] []
            , Svg.path [ SA.d "M10 10H2v2h10V2h-2v8z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
download_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
download_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 21v5H4v-5H2v5a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2v-5z" ] []
            , Svg.path [ SA.d "M16.73 22.68L24 15h-4V7h-8v8H8l7.25 7.67a1 1 0 0 0 1.48 0zM12 3h8v2h-8z" ] []
            ]
        ]


{-| -}
download_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
download_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 21v5H4v-5H2v5a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2v-5z" ] []
            , Svg.path [ SA.d "M15.99 23a1 1 0 0 0 .74-.32L24 15h-4V7h-8v8H8l7.25 7.67A1 1 0 0 0 16 23zM14 17V9h4v8h1.35l-3.36 3.54L12.64 17zM12 3h8v2h-8z" ] []
            ]
        ]


{-| -}
eye_ban_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
eye_ban_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M24.5 23.09A18.85 18.85 0 0 0 30 16S26 6 16 6a13.55 13.55 0 0 0-6.8 1.78L3.2 1.8 1.8 3.2l5.7 5.7A18.85 18.85 0 0 0 2 16s4 10 14 10a13.55 13.55 0 0 0 6.8-1.78l5.99 5.98 1.41-1.41zM16 20a3.98 3.98 0 0 1-3.43-6.02l5.45 5.45A3.96 3.96 0 0 1 16 20zm3.43-1.98l-5.45-5.45a3.98 3.98 0 0 1 5.45 5.45z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
eye_ban_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
eye_ban_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M24.5 23.09A18.85 18.85 0 0 0 30 16S26 6 16 6a13.55 13.55 0 0 0-6.8 1.78L3.2 1.8 1.8 3.2l5.7 5.7A18.85 18.85 0 0 0 2 16s4 10 14 10a13.55 13.55 0 0 0 6.8-1.78l5.99 5.98 1.41-1.41zM16 24c-7.1 0-10.72-5.88-11.8-8a16.43 16.43 0 0 1 4.72-5.66l2.91 2.9a5 5 0 0 0 6.92 6.93l2.57 2.57A11.65 11.65 0 0 1 16 24zm1.28-5.3A2.97 2.97 0 0 1 16 19a3 3 0 0 1-3-3 2.97 2.97 0 0 1 .3-1.28zm-2.57-5.4A2.97 2.97 0 0 1 16 13a3 3 0 0 1 3 3 2.97 2.97 0 0 1-.3 1.28l-2-1.99zm5.46 5.45a5 5 0 0 0-6.92-6.92l-2.57-2.57A11.65 11.65 0 0 1 16 8c7.1 0 10.72 5.88 11.8 8a16.43 16.43 0 0 1-4.72 5.66z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
eye_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
eye_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 6C6 6 2 16 2 16s4 10 14 10 14-10 14-10S26 6 16 6zm0 14a4 4 0 1 1 4-4 4 4 0 0 1-4 4z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
eye_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
eye_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M16 6C6 6 2 16 2 16s4 10 14 10 14-10 14-10S26 6 16 6zm0 18c-7.1 0-10.71-5.87-11.8-8C5.3 13.9 8.96 8 16 8c7.1 0 10.72 5.87 11.8 8-1.09 2.1-4.75 8-11.8 8z" ] []
            , Svg.path [ SA.d "M16 11a5 5 0 1 0 5 5 5 5 0 0 0-5-5zm0 8a3 3 0 1 1 3-3 3 3 0 0 1-3 3z" ] []
            ]
        ]


{-| -}
favorite_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
favorite_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28.05 12.05L20.3 11 17 3.65a1.09 1.09 0 00-1.997-.007L15 3.65 11.7 11 4 12.05a1.101 1.101 0 00-.63 1.87L9 19.62l-1.39 8.09a1.09 1.09 0 001.625 1.137l-.005.003L16 25l6.77 3.89a1.09 1.09 0 001.619-1.147l.001.007L23 19.62l5.72-5.7a1.1 1.1 0 00-.665-1.87h-.005z" ] [] ]
        ]


{-| -}
favorite_half_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
favorite_half_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M28.05 12.05l-7.75-1.06L17 3.65a1.1 1.1 0 0 0-2 0l-3.3 7.34-7.75 1.06a1.1 1.1 0 0 0-.63 1.87l5.72 5.7-1.43 8.09a1.1 1.1 0 0 0 1.62 1.14L16 24.96l6.77 3.9a1.1 1.1 0 0 0 1.62-1.15l-1.43-8.09 5.72-5.7a1.1 1.1 0 0 0-.63-1.87zm-6.5 6.16l-.74.73.18 1.03 1.1 6.18-5.1-2.92-.99-.58V6.3l2.48 5.5.45 1.02 1.1.15 5.95.81z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
favorite_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
favorite_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M28.05 12.05l-7.75-1.06L17 3.65a1.1 1.1 0 0 0-2 0l-3.3 7.34-7.75 1.06a1.1 1.1 0 0 0-.63 1.87l5.72 5.7-1.43 8.09A1.1 1.1 0 0 0 8.69 29a1.09 1.09 0 0 0 .54-.15L16 24.96l6.77 3.9a1.09 1.09 0 0 0 .55.14 1.1 1.1 0 0 0 1.08-1.3l-1.44-8.08 5.72-5.7a1.1 1.1 0 0 0-.63-1.87zm-6.5 6.16l-.74.73.18 1.03 1.1 6.18-5.1-2.92-.99-.58-1 .58-5.09 2.92 1.1-6.18.18-1.03-.74-.73-4.43-4.43 5.95-.81 1.1-.15.45-1.01L16 6.3l2.48 5.5.46 1.02 1.1.15 5.94.81z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
ferry_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
ferry_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M16.59 12.09L27 15.29V11a2 2 0 0 0-2-2h-1V6a2 2 0 0 0-2-2h-5V2h-2v2h-5a2 2 0 0 0-2 2v3H7a2 2 0 0 0-2 2v4.3l10.41-3.21a2 2 0 0 1 1.18 0zM18 7h2v3h-2zm-4 3h-2V7h2zm14 17a1.77 1.77 0 0 1-1.6 1.02 1.81 1.81 0 0 1-1.6-.98l-2-.04a1.77 1.77 0 0 1-1.6 1.02 1.81 1.81 0 0 1-1.6-.98l-2-.04a1.77 1.77 0 0 1-1.6 1.02 1.81 1.81 0 0 1-1.6-.98l-2-.04a1.77 1.77 0 0 1-1.6 1.02 1.81 1.81 0 0 1-1.6-.98l-2-.04A1.77 1.77 0 0 1 4 27v.04H2A3.54 3.54 0 0 0 5.6 30a3.8 3.8 0 0 0 2.6-1.03 3.8 3.8 0 0 0 5.2 0 3.8 3.8 0 0 0 5.2 0 3.8 3.8 0 0 0 5.2 0A3.8 3.8 0 0 0 26.4 30a3.54 3.54 0 0 0 3.6-2.96z" ] []
            , Svg.path [ SA.d "M5.33 25H15V14.3L4.96 17.4a2 2 0 0 0-1.31 2.54zM17 25h9.67l1.68-5.06a2 2 0 0 0-1.3-2.54L17 14.3z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
ferry_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
ferry_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M7 13.7l-.02-2.67h3l-.01-5 12-.05.01 5 3-.01.01 2.68 2 .6v-3.29a2 2 0 0 0-2.01-1.99h-1l-.01-3a2 2 0 0 0-2.01-1.99l-5 .02V2h-2v2l-5 .02a2 2 0 0 0-2 2l.02 3-1 .01a2 2 0 0 0-2 2l.01 3.3z" ] []
            , Svg.path [ SA.d "M11.97 8.01h2l.01 3h-2zm6-.02h2l.01 3h-2zm10.07 18.97a1.77 1.77 0 0 1-1.6 1.03 1.81 1.81 0 0 1-1.6-.98l-2-.03a1.77 1.77 0 0 1-1.6 1.03 1.81 1.81 0 0 1-1.6-.98l-2-.03a1.77 1.77 0 0 1-1.6 1.03 1.81 1.81 0 0 1-1.6-.99l-2-.03a1.77 1.77 0 0 1-1.6 1.03 1.81 1.81 0 0 1-1.6-.98l-2-.03a1.77 1.77 0 0 1-3.2.01v.04h-2a3.54 3.54 0 0 0 3.6 2.96A3.8 3.8 0 0 0 8.25 29a3.8 3.8 0 0 0 5.2-.02 3.8 3.8 0 0 0 5.2-.02 3.8 3.8 0 0 0 5.2-.01 3.8 3.8 0 0 0 2.6 1.02 3.54 3.54 0 0 0 3.6-2.98zM5.7 25.03h2.1l-2.25-6.69L15 15.4l.03 9.6h2L17 15.4l9.46 2.87-2.2 6.7h2.1l2-6.07a2 2 0 0 0-1.32-2.54l-10.46-3.18a2 2 0 0 0-1.18 0L4.96 16.44a2 2 0 0 0-1.3 2.54z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M-.05.06l32-.11.1 32-32 .1z" ] []
        ]


{-| -}
fill_color_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
fill_color_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M24 27a3 3 0 0 1 .29-1.3C24.78 24.7 27 21 27 21s2.22 3.7 2.71 4.7A3 3 0 1 1 24 27zM16 3l-2 2-2-2a3.58 3.58 0 0 0-5 0 3.5 3.5 0 0 0 0 5l2 2-5 5a4 4 0 0 0 0 5.66L10.33 27A4 4 0 0 0 16 27l12-12zm-1.14 10.57a2 2 0 0 1-1.93-2.51l-2.47-2.48-2-2a1.5 1.5 0 0 1 0-2.12 1.54 1.54 0 0 1 2.11 0l2 2-.68.68 2.48 2.48a2 2 0 1 1 .51 3.93z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
fill_color_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
fill_color_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M29.7 25.7c-.5-1-2.7-4.7-2.7-4.7s-2.2 3.7-2.7 4.7a3 3 0 1 0 5.4 0zm-2.3 2.2c-.5.2-1.1 0-1.3-.5-.1-.3-.1-.6 0-.9.1-.3.5-.9.9-1.6.4.7.8 1.3.9 1.6.2.6 0 1.2-.5 1.4zM16 3l-2.1 2.1-2-2a3.5 3.5 0 0 0-5 0C5.7 4.4 5.7 6.6 7 8l2 2-5 5a3.98 3.98 0 0 0 0 5.7l6.3 6.3c1.6 1.6 4.1 1.6 5.7 0l12-12L16 3zM8.4 6.6c-.6-.6-.6-1.6 0-2.2s1.5-.6 2.1 0l2 2-2.1 2.1-2-1.9zm6.2 19c-.8.8-2 .8-2.8 0l-6.3-6.3c-.8-.8-.8-2 0-2.8l5-5 2.1 2.1c0 .2-.1.3-.1.5 0 1.1.9 2 2 2s2-.9 2-2-.9-2-2-2c-.2 0-.4 0-.5.1L11.9 10 16 5.8l9.2 9.2-10.6 10.6z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
folder_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
folder_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M28 8H16l-1.37-2.86A2 2 0 0 0 12.83 4H5.5a2 2 0 0 0-1.92 1.45L2 11v15a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V10a2 2 0 0 0-2-2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
folder_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
folder_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M28 8H16l-1.37-2.86A2 2 0 0 0 12.83 4H5.5a2 2 0 0 0-1.92 1.45L2 11v15a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V10a2 2 0 0 0-2-2zm0 18H4V11.28L5.5 6h7.33l1.37 2.86.54 1.14H28z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
gift_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
gift_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M5 27a2 2 0 0 0 2 2h6V18H5zm10-9h2v11h-2zm4 11h6a2 2 0 0 0 2-2v-9h-8zM15 9h2v7h-2zm-4-6a4 4 0 0 0-4 4 3.96 3.96 0 0 0 .56 2H5a2 2 0 0 0-2 2v5h10V9h-2a2 2 0 1 1 2-2v2h2V7a4 4 0 0 0-4-4zm16 6h-2.56A3.96 3.96 0 0 0 25 7a4 4 0 0 0-8 0v2h2V7a2 2 0 1 1 2 2h-2v7h10v-5a2 2 0 0 0-2-2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
gift_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
gift_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M29 16v-5a2 2 0 0 0-2-2h-2.56A3.96 3.96 0 0 0 25 7a4 4 0 0 0-8 0v2h-2V7a4 4 0 0 0-8 0 3.96 3.96 0 0 0 .56 2H5a2 2 0 0 0-2 2v5h10v11H7v-9H5v9a2 2 0 0 0 2 2h18a2 2 0 0 0 2-2v-9h-2v9h-6V16zM19 7a2 2 0 1 1 2 2h-2zm0 4h8v3h-8zm-6 3H5v-3h8zm0-5h-2a2 2 0 1 1 2-2zm4 18h-2V16h2zm0-13h-2v-3h2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
heart_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
heart_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M30 10.58A7.53 7.53 0 0 0 16 6.7a7.53 7.53 0 0 0-14 3.9C2 20.32 16 29 16 29s14-8.67 14-18.42z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
heart_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
heart_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M22.6 3.07a7.52 7.52 0 0 0-6.5 3.62 7.53 7.53 0 0 0-14.04 3.74C1.96 20.18 15.86 29 15.86 29s14.1-8.52 14.2-18.27a7.56 7.56 0 0 0-7.46-7.66zm-1 18.95a46.06 46.06 0 0 1-5.71 4.58 46.06 46.06 0 0 1-5.61-4.7C7.4 19.06 4 14.77 4.06 10.46a5.57 5.57 0 0 1 5.6-5.53 5.49 5.49 0 0 1 4.71 2.77l1.69 2.9 1.75-2.87a5.49 5.49 0 0 1 4.77-2.66 5.57 5.57 0 0 1 5.48 5.64c-.05 4.32-3.54 8.53-6.46 11.31z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
home_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
home_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M16 3L2 17h4v10a2 2 0 0 0 2 2h3.5v-6.09A2.92 2.92 0 0 1 14.41 20h3.18a2.92 2.92 0 0 1 2.91 2.91V29H24a2 2 0 0 0 2-2V17h4z" ] []
            , Svg.path [ SA.d "M17.59 22H14.4a.91.91 0 0 0-.91.91V29h5v-6.09a.91.91 0 0 0-.91-.91z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
home_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
home_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M16 3L2 17h4v10a2 2 0 0 0 2 2h2v-2H8V15H6.83L16 5.83 25.17 15H24v12h-2v2h2a2 2 0 0 0 2-2V17h4z" ] []
            , Svg.path [ SA.d "M18 19h-4a2 2 0 0 0-2 2v8h8v-8a2 2 0 0 0-2-2zm0 8h-4v-6h4z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
image_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
image_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M24 21.4l-3.56-3.55-1.58 1.59 1.13 1.12-1.42 1.42-6.13-6.13L8 20.3V23h16v-1.6z" ] []
            , Svg.path [ SA.d "M17.45 18.02l3-3L24 18.58V9H8v8.47l4.45-4.45zM20.5 11a1.5 1.5 0 1 1-1.5 1.5 1.5 1.5 0 0 1 1.5-1.5z" ] []
            , Svg.path [ SA.d "M28 3H4a2 2 0 0 0-2 2v22a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zm-2 22H6V7h20z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
image_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
image_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 3H4a2 2 0 0 0-2 2v22a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zm0 24H4V5h24z" ]
                []
            , Svg.circle
                [ SA.cx "20.5", SA.cy "12.5", SA.r "1.5" ]
                []
            , Svg.path [ SA.d "M26 7H6v18h20zm-2 16H8v-2.7l4.45-4.45 6.12 6.13L20 20.56l-1.13-1.12 1.59-1.59L24 21.41zm0-4.42l-3.56-3.56-3 3-5-5L8 17.47V9h16z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
keyboard_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
keyboard_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M28 6H4a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V8a2 2 0 0 0-2-2zm-9 5h2v2h-2zm0 4h2v2h-2zm-4-4h2v2h-2zm0 4h2v2h-2zm-4-4h2v2h-2zm0 4h2v2h-2zm-4-4h2v2H7zm0 4h2v2H7zm16 6H9v-2h14zm2-4h-2v-2h2zm0-4h-2v-2h2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
keyboard_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
keyboard_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 6H4a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V8a2 2 0 0 0-2-2zm0 18H4V8h24z" ] []
            , Svg.path [ SA.d "M9 19h14v2H9zm-2-8h2v2H7zm0 4h2v2H7zm4-4h2v2h-2zm0 4h2v2h-2zm4-4h2v2h-2zm0 4h2v2h-2zm4-4h2v2h-2zm0 4h2v2h-2zm4-4h2v2h-2zm0 4h2v2h-2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
language_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
language_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M21.5 14.09A7.19 7.19 0 0 0 23.13 12h-3.26a7.19 7.19 0 0 0 1.63 2.09zM8.92 14h2.16L10 10.87 8.92 14z" ] []
            , Svg.path [ SA.d "M28 2H4a2 2 0 0 0-2 2v19a2 2 0 0 0 2 2h7.5l4.5 5 4.5-5H28a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2zM12.45 18l-.69-2H8.24l-.7 2H5.5l3.1-9h2.8l3.1 9zm14.05-6h-1.22a8.27 8.27 0 0 1-2.08 3.24 7.4 7.4 0 0 0 3.3.76v2a9.37 9.37 0 0 1-5-1.43 9.37 9.37 0 0 1-5 1.43v-2a7.4 7.4 0 0 0 3.3-.76A8.27 8.27 0 0 1 17.72 12H16.5v-2h4V8h2v2h4z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
language_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
language_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M8.74 16h3.52l.7 2H15l-3.1-9H9.1L6 18h2.05zm1.76-5.13L11.58 14H9.42zM26 18v-2a7.4 7.4 0 0 1-3.3-.76A8.27 8.27 0 0 0 24.78 12H26v-2h-4V8h-2v2h-4v2h1.22a8.27 8.27 0 0 0 2.08 3.24A7.4 7.4 0 0 1 16 16v2a9.37 9.37 0 0 0 5-1.43A9.37 9.37 0 0 0 26 18zm-6.63-6h3.26A7.19 7.19 0 0 1 21 14.09 7.19 7.19 0 0 1 19.37 12z" ] []
            , Svg.path [ SA.d "M28 2H4a2 2 0 0 0-2 2v19a2 2 0 0 0 2 2h7.5l4.5 5 4.5-5H28a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2zm0 21h-8.39l-.6.66L16 27.01l-3.01-3.35-.6-.66H4V4h24z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
laptop_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
laptop_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M27 5a2 2 0 0 0-2-2H7a2 2 0 0 0-2 2v12h22zm-2 10H7V5h18zm3.94 11.52L27.41 19H4.59l-1.53 7.51A1.99 1.99 0 0 0 4.94 29h22.12a1.99 1.99 0 0 0 1.88-2.48zM17 21h2v2h-2zm-4 0h2v2h-2zm-2 2H9v-2h2zm9 4h-8v-2h8zm3-4h-2v-2h2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
laptop_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
laptop_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M9 19h2v2H9zm4 0h2v2h-2zm4 0h2v2h-2zm4 0h2v2h-2zm6-14a2 2 0 0 0-2-2H7a2 2 0 0 0-2 2v12h22zm-2 10H7V5h18z" ] []
            , Svg.path [ SA.d "M28.94 26.52L27.41 19h-2.04l1.61 7.92V27H21v-4H11v4H5a.02.02 0 0 0 0-.01l.01-.04v-.04L6.64 19H4.6l-1.53 7.51A1.99 1.99 0 0 0 4.94 29h22.12a1.99 1.99 0 0 0 1.88-2.48zM19 27h-6v-2h6z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
like_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
like_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M5 14H2v16h3a2 2 0 0 0 2-2V16a2 2 0 0 0-2-2zm23 0h-9s2-6 2-8V3.5A1.5 1.5 0 0 0 19.5 2H19c-.53 0-1 1-1 1l-2 4-6.41 6.41A2 2 0 0 0 9 14.83V26a4 4 0 0 0 4 4h10.17a2 2 0 0 0 1.42-.59l4.82-4.82a2 2 0 0 0 .59-1.42V16a2 2 0 0 0-2-2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
like_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
like_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M5 14H2v2h3v12H2v2h3a2 2 0 0 0 2-2V16a2 2 0 0 0-2-2zm23 0h-8s2-6 2-8V5a2.94 2.94 0 0 0-2.5-3H18c-.53 0-1 1-1 1l-2 4-5.41 6.41A2 2 0 0 0 9 14.83V26a4 4 0 0 0 4 4h10.17a2 2 0 0 0 1.42-.59l4.82-4.82a2 2 0 0 0 .59-1.42V16a2 2 0 0 0-2-2zm0 9.17L23.17 28H13a2 2 0 0 1-2-2V14.83l.06-.06.05-.07 5.42-6.41.15-.18.1-.22L18.75 4h.65A1.05 1.05 0 0 1 20 5v1a41.18 41.18 0 0 1-1.9 7.37L17.23 16H28z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
list_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
list_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M20 2v7h7l-7-7z" ] []
            , Svg.path [ SA.d "M27 11h-7a2 2 0 0 1-2-2V2H7a2 2 0 0 0-2 2v24a2 2 0 0 0 2 2h18a2 2 0 0 0 2-2V11zM12 25h-2v-2h2zm0-5h-2v-2h2zm0-5h-2v-2h2zm10 10h-8v-2h8zm0-5h-8v-2h8zm0-5h-8v-2h8z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
list_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
list_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M14 12h8v2h-8zm-4 0h2v2h-2zm4 5h8v2h-8zm-4 0h2v2h-2zm4 5h8v2h-8zm-4 0h2v2h-2zm11-12h6l-8-8v6a2 2 0 0 0 2 2z" ] []
            , Svg.path [ SA.d "M25 28H7V4h10V2H7a2 2 0 0 0-2 2v24a2 2 0 0 0 2 2h18a2 2 0 0 0 2-2V12h-2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
loading_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
loading_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.fillRule "evenodd", SA.d "M18.46 2.7A13.55 13.55 0 0 1 29.54 16a13.55 13.55 0 0 1-27.08 0 13.5 13.5 0 0 1 4.8-10.32 13.52 13.52 0 0 1 6.28-2.98V.2A15.99 15.99 0 1 0 32 16C32 8 26.13 1.4 18.46.2v2.5z" ] []
        ]


{-| -}
location_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
location_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 3A10 10 0 0 0 6 13c0 7 10 16 10 16s10-9 10-16A10 10 0 0 0 16 3zm0 13a3 3 0 1 1 3-3 3 3 0 0 1-3 3z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
location_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
location_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M16 9a4 4 0 1 0 4 4 4 4 0 0 0-4-4zm0 6a2 2 0 1 1 2-2 2 2 0 0 1-2 2z" ] []
            , Svg.path [ SA.d "M16 3A10 10 0 0 0 6 13c0 7 10 16 10 16s10-9 10-16A10 10 0 0 0 16 3zm0 23.19C12.94 23.02 8 17.05 8 13a8 8 0 0 1 16 0c0 4.05-4.94 10.02-8 13.19z" ] []
            ]
        ]


{-| -}
login_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
login_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 3H13a2 2 0 0 0-2 2v8h2V5h15v22H13v-8h-2v8a2 2 0 0 0 2 2h15a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2z" ] []
            , Svg.path [ SA.d "M16 21l7-5-7-5v4H2v2h14v4z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
logout_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
logout_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M18 27H4V5h14v8h2V5a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v22a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-8h-2z" ] []
            , Svg.path [ SA.d "M30 16l-7-5v4H9v2h14v4l7-5z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
lucky_kuji_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
lucky_kuji_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M8.76 16.54l4.36-1.87 3 3a1.1 1.1 0 0 0 1.55-1.55l-3-3 1.87-4.36L9.78 2l-1.9 4.46L6.2 4.79 4.79 6.21l1.67 1.66L2 9.78zm1.77-10.68l3.4 3.4-.93 2.18-3.4-3.4zm-2.5 3.73l3.41 3.4-2.18.94-3.4-3.4z" ] []
            , Svg.path [ SA.d "M17 4a13.03 13.03 0 0 0-2.19.2l3.98 3.98A9 9 0 1 1 8.18 18.79L4.2 14.81A13 13 0 1 0 17 4z" ] []
            , Svg.path [ SA.d "M16.9 20a3.08 3.08 0 0 1-2.2-.91l-2.04-2.04-2.56 1.1a7 7 0 1 0 8.04-8.05l-1.1 2.56 2.05 2.04a3.1 3.1 0 0 1-2.2 5.3z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
lucky_kuji_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
lucky_kuji_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M8.76 16.54l4.36-1.87 3 3a1.1 1.1 0 0 0 1.55-1.55l-3-3 1.87-4.36L9.78 2l-1.9 4.46L6.2 4.79 4.79 6.21l1.67 1.66L2 9.78zm1.77-10.68l3.4 3.4-.93 2.18-3.4-3.4zm-2.5 3.73l3.41 3.4-2.18.94-3.4-3.4z" ] []
            , Svg.path [ SA.d "M17 4a13.03 13.03 0 0 0-2.19.2l1.82 1.82L17 6A11 11 0 1 1 6 17l.02-.37-1.82-1.82A13 13 0 1 0 17 4z" ] []
            , Svg.path [ SA.d "M17 22a5 5 0 0 1-4.97-4.68l-1.93.82a7 7 0 1 0 8.04-8.04l-.83 1.93A4.99 4.99 0 0 1 17 22z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
mail_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
mail_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M18.12 19a3 3 0 0 1-4.24 0L3 8.12V25a2 2 0 0 0 2 2h22a2 2 0 0 0 2-2V8.12z" ] []
            , Svg.path [ SA.d "M16.7 17.59L28.56 5.75A1.99 1.99 0 0 0 27 5H5a1.99 1.99 0 0 0-1.55.75L15.3 17.59a1 1 0 0 0 1.42 0z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
mail_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
mail_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M13.88 17.3a3 3 0 0 0 4.24 0L28.71 6.7l.22-.21A2 2 0 0 0 27 5H5a2 2 0 0 0-1.93 1.49l.22.22zM25.58 7l-8.87 8.88a1 1 0 0 1-1.42 0L6.41 7z" ] []
            , Svg.path [ SA.d "M27 11.24V25H5V11.24l-2-2V25a2 2 0 0 0 2 2h22a2 2 0 0 0 2-2V9.24z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
map_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
map_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M2 11.6v13.98a2.02 2.02 0 0 0 1.43 1.93l6.57 2V11.3L4.58 9.65A2 2 0 0 0 2 11.6zm21 11.23l-1.41-1.42a40.6 40.6 0 0 1-.59-.6v6.6l5.37 1.82A2 2 0 0 0 29 27.3V16a45.17 45.17 0 0 1-4.59 5.41zM12 12v18l7-2.54v-8.88a24.5 24.5 0 0 1-4.63-7.5z" ] []
            , Svg.path [ SA.d "M30 9a7 7 0 0 0-14 0c0 4 7 11 7 11s7-7 7-11zm-9.5 0a2.5 2.5 0 1 1 2.5 2.5A2.5 2.5 0 0 1 20.5 9z" ] []
            ]
        ]


{-| -}
map_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
map_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M27 27.33l-5.69-1.92c-.1-.04-.2-.05-.31-.08v-4.52a48.16 48.16 0 0 1-2-2.23v6.78c-.12.03-.25.05-.37.1L13 27.6V13.64l.34-.1 1.76-.67a12.65 12.65 0 0 1-.75-1.85l-1.72.65a1.98 1.98 0 0 1-1.28.04L4.57 9.66A1.99 1.99 0 0 0 4 9.57a2.01 2.01 0 0 0-2 2.03v13.97a2.02 2.02 0 0 0 1.43 1.94l7.92 2.4a1.98 1.98 0 0 0 1.28-.04l6.7-2.54a1.98 1.98 0 0 1 1.34-.03l5.7 1.92a1.99 1.99 0 0 0 .63.1 2.01 2.01 0 0 0 2-2.02V16a39.05 39.05 0 0 1-2 2.58zm-16 .39l-7-2.15v-14l6.77 2.06.23.05z" ] []
            , Svg.path [ SA.d "M30 9a7 7 0 0 0-14 0c0 4 7 11 7 11s7-7 7-11zm-7-5a5 5 0 0 1 5 5c0 1.81-2.6 5.4-5 8.09-2.4-2.7-5-6.27-5-8.09a5 5 0 0 1 5-5z" ]
                []
            , Svg.circle
                [ SA.cx "23", SA.cy "9", SA.r "2.5" ]
                []
            ]
        ]


{-| -}
menu : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
menu attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M4 6h24v2H4zm0 9h24v2H4zm0 9h24v2H4z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
minus : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
minus attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M4 15h24v2H4z" ] []
        ]


{-| -}
mobile_phone_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
mobile_phone_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M22 5H11V3a1 1 0 0 0-2 0v2.19A3 3 0 0 0 7 8v19a3 3 0 0 0 3 3h12a3 3 0 0 0 3-3V8a3 3 0 0 0-3-3zm-10 5h8v6h-8zm1 16h-2v-2h2zm0-4h-2v-2h2zm4 4h-2v-2h2zm0-4h-2v-2h2zm4 4h-2v-2h2zm0-4h-2v-2h2z", SA.fill <| R10.Color.Utils.toCssRgba cl, SA.fillRule "evenodd" ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
mobile_phone_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
mobile_phone_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M22 5H11V3a1 1 0 0 0-2 0v2.19A3 3 0 0 0 7 8v19a3 3 0 0 0 3 3h12a3 3 0 0 0 3-3V8a3 3 0 0 0-3-3zm1 22a1 1 0 0 1-1 1H10a1 1 0 0 1-1-1V8a1.01 1.01 0 0 1 1-1h12a1.01 1.01 0 0 1 1 1z", SA.fillRule "evenodd" ] []
            , Svg.path [ SA.d "M11 18h10V9H11zm2-7h6v5h-6z", SA.fillRule "evenodd" ] []
            , Svg.path [ SA.d "M11 20h2v2h-2zm4 0h2v2h-2zm-4 4h2v2h-2zm4 0h2v2h-2zm4-4h2v2h-2zm0 4h2v2h-2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
movie_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
movie_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M28 4H4a2 2 0 0 0-2 2v20a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2zM12 8h3v2h-3zm-2 16H7v-2h3zm0-14H7V8h3zm5 14h-3v-2h3zm5 0h-3v-2h3zm-7-4v-8l7 4zm7-10h-3V8h3zm5 14h-3v-2h3zm0-14h-3V8h3z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
movie_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
movie_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 4H4a2 2 0 0 0-2 2v20a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2zm0 22H4V6h24z" ] []
            , Svg.path [ SA.d "M7 8h3v2H7zm0 14h3v2H7zm5-14h3v2h-3zm0 14h3v2h-3zm5-14h3v2h-3zm0 14h3v2h-3zm5-14h3v2h-3zm0 14h3v2h-3zm-9-2l7-4-7-4v8z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
new_user_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
new_user_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M8 3a2 2 0 0 0-2 2v16.87a2 2 0 0 0 .97 1.71L14 27.8v-2.33l-6-3.6V5l6 3.6V6.27L9.03 3.3A1.98 1.98 0 0 0 8 3zm16 0a1.98 1.98 0 0 0-1.03.29L16 7.47V29l9.03-5.42a2 2 0 0 0 .97-1.71V5a2 2 0 0 0-2-2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
new_window_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
new_window_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M21 27H5V11h8V9H5a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2v-8h-2z" ] []
            , Svg.path [ SA.d "M27 3H17v2h8.59L13 17.59 14.41 19 27 6.41V15h2V3h-2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
notice_generic_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
notice_generic_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 30a4 4 0 0 0 4-4h-8a4 4 0 0 0 4 4zm10-10v-8a10 10 0 0 0-20 0v8a2 2 0 0 1-2 2v2h24v-2a2 2 0 0 1-2-2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
notice_generic_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
notice_generic_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 28a2 2 0 0 1-2-2h-2a4 4 0 0 0 8 0h-2a2 2 0 0 1-2 2zm10-8v-8a10 10 0 0 0-20 0v8a2 2 0 0 1-2 2v2h24v-2a2 2 0 0 1-2-2zM7.46 22A3.98 3.98 0 0 0 8 20v-8a8 8 0 0 1 16 0v8a3.98 3.98 0 0 0 .54 2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
notice_user_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
notice_user_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M27 3H5a2 2 0 0 0-2 2v18a2 2 0 0 0 2 2h6l5 5 5-5h6a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zM15 7h2v9h-2zm1 14a1.5 1.5 0 1 1 1.5-1.5A1.5 1.5 0 0 1 16 21z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
notice_user_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
notice_user_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M27 3H5a2 2 0 0 0-2 2v18a2 2 0 0 0 2 2h6l5 5 5-5h6a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zm0 20h-6.83L16 27.17 11.83 23H5V5h22z" ] []
            , Svg.path [ SA.d "M15 7h2v9h-2z" ]
                []
            , Svg.circle
                [ SA.cx "16", SA.cy "19.5", SA.r "1.5" ]
                []
            ]
        ]


{-| -}
paint_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
paint_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M29.7 25.7c-.48-1-2.7-4.7-2.7-4.7s-2.22 3.7-2.7 4.7a3 3 0 1 0 5.4 0zM16.1 3.02l-1.31 1.3-1.13-1.19a3.87 3.87 0 0 0-5.48 5.48l1.16 1.17-5.18 5.17a3.97 3.97 0 0 0 0 5.62l6.29 6.28a3.97 3.97 0 0 0 5.61 0L28 14.92zM16 14a2 2 0 0 1-1.96-2.4l-3.26-3.26-.02.02L9.59 7.2a1.88 1.88 0 0 1 2.63-2.67l1.16 1.21-1.19 1.19 3.18 3.18A1.98 1.98 0 0 1 16 10a2 2 0 0 1 0 4z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
paint_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
paint_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M29.7 25.7c-.48-1-2.7-4.7-2.7-4.7s-2.22 3.7-2.7 4.7a3 3 0 1 0 5.4 0zM27 28a1 1 0 0 1-1-1 .99.99 0 0 1 .1-.43 34 34 0 0 1 .9-1.63 34 34 0 0 1 .9 1.63.99.99 0 0 1 .1.43 1 1 0 0 1-1 1zM16.1 3.02l-1.31 1.3-1.13-1.19a3.87 3.87 0 0 0-5.48 5.48l1.16 1.17-5.18 5.17a3.97 3.97 0 0 0 0 5.62l6.29 6.28a3.97 3.97 0 0 0 5.61 0L28 14.92zM9.6 4.54a1.87 1.87 0 0 1 2.62-.01l1.15 1.21-2.62 2.62L9.6 7.2a1.88 1.88 0 0 1 0-2.65zm5.05 20.9a1.97 1.97 0 0 1-2.79 0l-6.28-6.28a1.97 1.97 0 0 1 0-2.8l5.18-5.17 2.31 2.31a2.04 2.04 0 1 0 1.4-1.42l-2.3-2.3 3.93-3.93 9.07 9.07z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
paper_plane_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
paper_plane_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M28.01 5a2.06 2.06 0 0 0-.43.05l-24 5.14a2 2 0 0 0-.77 3.56L4.51 15l20-7.25L9.23 16 8 16.66V27l6.36-4.74 4.74 3.5a2 2 0 0 0 3-.8l7.72-17.14A2 2 0 0 0 28 5z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M32 32H0V0h32z" ] []
        ]


{-| -}
paper_plane_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
paper_plane_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M28.01 5a2.06 2.06 0 0 0-.43.05l-24 5.14a2 2 0 0 0-.77 3.56l2.7 1.99 1.94-1.05L4 12.14l20.5-4.39L9.24 16 8 16.66V27l6.36-4.74 4.74 3.5a2 2 0 0 0 3-.8l7.72-17.14A2 2 0 0 0 28 5zM10 23.02v-3.97l2.68 1.97zm10.28 1.12l-9.27-6.83 16.31-8.8z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M32 32H0V0h32z" ] []
        ]


{-| -}
pdf_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
pdf_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M21 2v7h7l-7-7zm-5 13.4h-.6v4.2h.6a1.6 1.6 0 0 0 1.6-1.6v-1a1.6 1.6 0 0 0-1.6-1.6zm-5.3 0H9.4v1.8h1.3a.9.9 0 1 0 0-1.8z" ] []
            , Svg.path [ SA.d "M19 9V2H6a2 2 0 0 0-2 2v24a2 2 0 0 0 2 2h20a2 2 0 0 0 2-2V11h-7a2 2 0 0 1-2-2zm-8.3 9.6H9.4V21H8v-7h2.7a2.3 2.3 0 1 1 0 4.6zM19 18a3 3 0 0 1-3 3h-2v-7h2a3 3 0 0 1 3 3zm5-4v1.4h-2.6V17h2.2v1.4h-2.2V21H20v-7h4z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
pdf_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
pdf_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M26 28H6V4h12V2H6a2 2 0 0 0-2 2v24a2 2 0 0 0 2 2h20a2 2 0 0 0 2-2V12h-2z" ] []
            , Svg.path [ SA.d "M22 10h6l-8-8v6a2 2 0 0 0 2 2zM8 14v7h1.4v-2.4h1.3a2.3 2.3 0 1 0 0-4.6zm3.6 2.3a.9.9 0 0 1-.9.9H9.4v-1.8h1.3a.9.9 0 0 1 .9.9zM14 14v7h2a3 3 0 0 0 3-3v-1a3 3 0 0 0-3-3zm3.6 3v1a1.6 1.6 0 0 1-1.6 1.6h-.6v-4.2h.6a1.6 1.6 0 0 1 1.6 1.6zm3.8 1.4h2.2V17h-2.2v-1.6H24V14h-4v7h1.4v-2.6z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
phone_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
phone_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M29.35 23.9l-4.62-4.63a2.22 2.22 0 0 0-3.13 0l-2.4 2.39a1.1 1.1 0 0 1-1.2.24 15.5 15.5 0 0 1-4.84-3.06A15.5 15.5 0 0 1 10.1 14a1.1 1.1 0 0 1 .24-1.2l2.4-2.38a2.22 2.22 0 0 0 0-3.14L8.1 2.65a2.22 2.22 0 0 0-3.14 0L2.65 4.97A2.22 2.22 0 0 0 2 6.6a22.61 22.61 0 0 0 6.65 16.75A22.61 22.61 0 0 0 25.4 30a2.22 2.22 0 0 0 1.63-.65l2.32-2.32a2.22 2.22 0 0 0 0-3.14z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
phone_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
phone_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M29.35 23.9l-4.62-4.63a2.22 2.22 0 0 0-3.13 0l-2.4 2.39a1.1 1.1 0 0 1-.78.33 1.1 1.1 0 0 1-.41-.08 15.5 15.5 0 0 1-4.85-3.07A15.5 15.5 0 0 1 10.1 14a1.1 1.1 0 0 1 .24-1.2l2.4-2.38a2.22 2.22 0 0 0 0-3.14L8.1 2.65a2.22 2.22 0 0 0-3.14 0L2.65 4.97A2.22 2.22 0 0 0 2 6.6a22.61 22.61 0 0 0 6.65 16.75A22.61 22.61 0 0 0 25.4 30h.05a2.22 2.22 0 0 0 1.58-.65l2.32-2.32a2.22 2.22 0 0 0 0-3.14zm-1.41 1.71l-2.33 2.33a.23.23 0 0 1-.16.06h-.28a20.57 20.57 0 0 1-15.1-6.07A20.57 20.57 0 0 1 4 6.83L4 6.55a.23.23 0 0 1 .06-.16L6.4 4.06a.22.22 0 0 1 .3 0l4.63 4.63a.22.22 0 0 1 0 .3l-2.4 2.4a3.1 3.1 0 0 0-.67 3.36 17.47 17.47 0 0 0 3.5 5.5 17.47 17.47 0 0 0 5.5 3.5 3.1 3.1 0 0 0 3.37-.68L23 20.68a.22.22 0 0 1 .3 0l4.63 4.63a.22.22 0 0 1 0 .3z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
photograph_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
photograph_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 7h-5l-1.45-2.9A2 2 0 0 0 19.76 3h-7.52a2 2 0 0 0-1.8 1.1L9 7H4a2 2 0 0 0-2 2v18a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zM16 25a7.5 7.5 0 1 1 7.5-7.5A7.5 7.5 0 0 1 16 25z" ]
                []
            , Svg.circle
                [ SA.cx "16", SA.cy "17.5", SA.r "5.5" ]
                []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
photograph_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
photograph_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 7h-6l-1.45-2.9A2 2 0 0 0 18.76 3h-5.52a2 2 0 0 0-1.8 1.1L10 7H4a2 2 0 0 0-2 2v18a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zm0 20H4V9h7.24l2-4h5.52l2 4H28z" ] []
            , Svg.path [ SA.d "M8.5 17.5A7.5 7.5 0 1 0 16 10a7.5 7.5 0 0 0-7.5 7.5zm13 0A5.5 5.5 0 1 1 16 12a5.5 5.5 0 0 1 5.5 5.5z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
pin_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
pin_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M27.4 11.1l-6.5-6.5a2.07 2.07 0 0 0-2.93 0l-.22.23a1.97 1.97 0 0 0-.6 1.43c.02.8-.27 2.22-2.08 4.03-1.95 1.95-4.77 1.58-6.3 1.19a2.05 2.05 0 0 0-1.96.55l-.2.21a2.07 2.07 0 0 0 0 2.92L16.82 25.4a2.07 2.07 0 0 0 2.93 0l.2-.2a2.05 2.05 0 0 0 .56-1.97c-.4-1.52-.76-4.34 1.18-6.29 1.81-1.8 3.24-2.1 4.04-2.07a1.97 1.97 0 0 0 1.44-.6l.21-.23a2.07 2.07 0 0 0 0-2.92zM4 26v2h2l5.3-5.3-2-2L4 26z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
pin_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
pin_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M27.4 11.1l-6.5-6.5a2.07 2.07 0 0 0-2.93 0l-.22.23a1.97 1.97 0 0 0-.6 1.43c.02.8-.27 2.22-2.08 4.03a5.43 5.43 0 0 1-3.96 1.5 9.45 9.45 0 0 1-2.34-.31 1.97 1.97 0 0 0-.5-.06 2.08 2.08 0 0 0-1.45.61l-.21.21a2.07 2.07 0 0 0 0 2.92L16.84 25.4a2.07 2.07 0 0 0 2.92 0l.2-.2a2.05 2.05 0 0 0 .56-1.97c-.4-1.52-.76-4.34 1.19-6.3 1.74-1.73 3.12-2.07 3.94-2.07h.14a1.98 1.98 0 0 0 1.39-.6l.22-.22a2.07 2.07 0 0 0 0-2.92zm-1.42 1.52l-.25.24h-.08c-1.23 0-3.16.46-5.36 2.66-1.97 1.96-2.57 4.88-1.7 8.2a.1.1 0 0 1-.04.05l-.2.21a.06.06 0 0 1-.05.02.06.06 0 0 1-.05-.02L8.02 13.75a.07.07 0 0 1 0-.1l.21-.2a.23.23 0 0 1 .04-.03 11.33 11.33 0 0 0 2.84.37 7.4 7.4 0 0 0 5.37-2.08c2.24-2.24 2.7-4.19 2.67-5.45l.02-.02.21-.22a.06.06 0 0 1 .05-.02.06.06 0 0 1 .05.02l6.5 6.5a.07.07 0 0 1 0 .1zM4 26v2h2l5.3-5.3-2-2L4 26z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
plane_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
plane_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M23.73 12.07l2.33-2.33c1.52-1.52 5.32-5.32 3.42-7.22s-5.7 1.9-7.22 3.42l-2.33 2.33L4.74 5.74a2.15 2.15 0 0 0-1.87.6l-.56.56a1.07 1.07 0 0 0 .18 1.66L12.9 15.3l-3.02 3.02-4.29-1.07a2.15 2.15 0 0 0-2.04.56l-.49.5a1.07 1.07 0 0 0 .16 1.65l3.47 2.31.17-.16a2.56 2.56 0 0 0 .6 2.44 2.56 2.56 0 0 0 2.43.6l-.16.16 2.31 3.47a1.07 1.07 0 0 0 1.65.16l.5-.5a2.15 2.15 0 0 0 .56-2.03l-1.07-4.3 3.02-3.01 6.74 10.41a1.07 1.07 0 0 0 1.66.18l.56-.56a2.15 2.15 0 0 0 .6-1.87z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
plane_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
plane_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M29.3 2.7A2.3 2.3 0 0 0 27.6 2c-2.14 0-4.69 2.55-5.86 3.72l-2.59 2.59-14.43-2.4a2.13 2.13 0 0 0-1.86.59l-.56.55A1.07 1.07 0 0 0 2.5 8.7l9.88 6.4-3.14 3.15-3.66-.92a2.13 2.13 0 0 0-2.03.56l-.49.5a1.07 1.07 0 0 0 .17 1.63l3.27 2.19a3.19 3.19 0 0 0 3.19 3.31h.11l2.18 3.26a1.07 1.07 0 0 0 1.65.17l.48-.5a2.13 2.13 0 0 0 .57-2.02l-.92-3.66 3.15-3.14 6.4 9.88a1.07 1.07 0 0 0 1.65.18l.55-.56a2.13 2.13 0 0 0 .6-1.86l-2.41-14.43 2.59-2.59c1.5-1.5 5.28-5.28 3.01-7.54zm-7.03 8.72l-.72.73.17 1.02 2.3 13.77-5.44-8.4-1.35-2.08-1.75 1.75-4.95 4.96a1.2 1.2 0 1 1-1.7-1.7l4.96-4.95 1.75-1.75-2.08-1.35L5.06 8l13.77 2.3 1.02.16.73-.72 2.58-2.6C25.25 5.07 26.74 4 27.61 4a.31.31 0 0 1 .27.12c.14.14.66 1.03-3.02 4.72z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
plus : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
plus attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M28 15H17V4h-2v11H4v2h11v11h2V17h11v-2z" ] []
        ]


{-| -}
point_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
point_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm1.05 16.29h-2.02v3.8h-2.25V10.3h4.27a4 4 0 1 1 0 8z" ] []
            , Svg.path [ SA.d "M16.9 12.39h-1.87v3.8h1.88a1.85 1.85 0 0 0 1.81-1.93 1.8 1.8 0 0 0-1.81-1.87z" ] []
            ]
        ]


{-| -}
point_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
point_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M17.05 10.29h-4.27v11.8h2.25v-3.8h2.02a4 4 0 1 0 0-8zm-.15 5.9h-1.87v-3.8h1.88a1.8 1.8 0 0 1 1.81 1.88 1.85 1.85 0 0 1-1.81 1.92z" ] []
            , Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm0 26a12 12 0 1 1 12-12 12.01 12.01 0 0 1-12 12z" ] []
            ]
        ]


{-| -}
price_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
price_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm6 12v2h-4.72l-.28.41V18h5v2h-5v4h-2v-4h-5v-2h5v-1.59l-.28-.41H10v-2h3.37L10 9h2.41L16 14.32 19.59 9H22l-3.37 5z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
price_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
price_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm0 26a12 12 0 1 1 12-12 12.01 12.01 0 0 1-12 12z" ] []
            , Svg.path [ SA.d "M19.59 9L16 14.32 12.41 9H10l3.37 5H10v2h4.72l.28.41V18h-5v2h5v4h2v-4h5v-2h-5v-1.59l.28-.41H22v-2h-3.37L22 9h-2.41z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
print_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
print_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M24 4a2 2 0 0 0-2-2H10a2 2 0 0 0-2 2v4h16zm2 6H6a4 4 0 0 0-4 4v11h4v-7h20v7h4V14a4 4 0 0 0-4-4zM8 15H6v-2h2z" ] []
            , Svg.path [ SA.d "M8 28a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8H8z" ] []
            ]
        ]


{-| -}
print_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
print_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M8 27.6a2.23 2.23 0 0 0 2 2.4h12a2.23 2.23 0 0 0 2-2.4V18H8zm2-7.2h12v7.2H10zM6 14h2v2H6zm4-10h12v4h2V4a2 2 0 0 0-2-2H10a2 2 0 0 0-2 2v4h2z" ] []
            , Svg.path [ SA.d "M26 10H6a4 4 0 0 0-4 4v11h4v-2H4v-9a2 2 0 0 1 2-2h20a2 2 0 0 1 2 2v9h-2v2h4V14a4 4 0 0 0-4-4z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
purchase_history_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
purchase_history_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.circle [ SA.cx "7.5", SA.cy "28.5", SA.r "1.5" ]
                []
            , Svg.circle
                [ SA.cx "14.5", SA.cy "28.5", SA.r "1.5" ]
                []
            , Svg.path [ SA.d "M6 14H2v2h2.34L6 25h10l1-7H6.73L6 14z" ] []
            , Svg.path [ SA.d "M19 2A11 11 0 0 0 8 13a11.12 11.12 0 0 0 .06 1.17l.27 1.45.1.38H19.3l-.33 2.28-.81 5.68c.27.02.55.04.83.04a11 11 0 0 0 0-22zm7 12h-8V7h2v5h6z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
purchase_history_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
purchase_history_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.circle [ SA.cx "7.5", SA.cy "28.5", SA.r "1.5" ] []
            , Svg.circle [ SA.cx "14.5", SA.cy "28.5", SA.r "1.5" ] []
            , Svg.path [ SA.d "M6 14H2v2h2.34L6 25h10l1-8H6.55zm8.73 5l-.5 4h-6.6l-.72-4z" ] []
            , Svg.path [ SA.d "M19 2A10.99 10.99 0 0 0 8.06 14.17l.15.83h2.02A9 9 0 1 1 19 22l-.6-.03-.25 1.99c.28.02.56.04.85.04a11 11 0 0 0 0-22z" ] []
            , Svg.path [ SA.d "M17 8v7h8v-2h-6V8h-2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
qrcode_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
qrcode_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M4 24H2v6h6v-2H4v-4zM4 4h4V2H2v6h2V4zm24 24h-4v2h6v-6h-2v4zM24 2v2h4v4h2V2h-6z" ] []
            , Svg.path [ SA.d "M6 26h20V6H6zm12-2h-2v-2h2zm0-16h6v10h-2v-4h-4zM8 18h2v-2h2v2h4v-2h-2v-2H8V8h6v2h2v2h-2v2h2v2h4v4h4v2h-2v2h-2v-4h-2v-2h-2v2h-2v4H8z" ] []
            , Svg.path [ SA.d "M20 10h2v2h-2zM10 20h2v2h-2zm0-10h2v2h-2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
qrcode_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
qrcode_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M4 24H2v6h6v-2H4v-4zM4 4h4V2H2v6h2V4zm24 24h-4v2h6v-6h-2v4zM24 2v2h4v4h2V2h-6zM12 18v-2h-2v2H8v6h6v-4h2v-2h-4zm0 4h-2v-2h2zm4-10v-2h-2V8H8v6h6v-2zm-4 0h-2v-2h2zm8 4h-4v2h2v2h2v-4zm4 4h-4v4h2v-2h2v-2zm-8 2h2v2h-2z" ] []
            , Svg.path [ SA.d "M22 16v2h2V8h-6v6h4zm-2-4v-2h2v2zm-6 2h2v2h-2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
rakuten_account_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
rakuten_account_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M25 19a24.28 24.28 0 0 0-4.85-3.39.99.99 0 0 1-.23-1.54C21.3 12.57 22 11.32 22 8a5.76 5.76 0 0 0-6-6 5.76 5.76 0 0 0-6 6c0 3.33.7 4.58 2.08 6.07a.99.99 0 0 1-.23 1.54A24.28 24.28 0 0 0 7 19c-1.68 1.68-1.95 5.46-2 9a1.99 1.99 0 0 0 2 2h18a1.99 1.99 0 0 0 2-2c-.05-3.54-.32-7.32-2-9z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
rakuten_account_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
rakuten_account_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M25 19a24.28 24.28 0 0 0-4.85-3.39.99.99 0 0 1-.23-1.54C21.3 12.57 22 11.32 22 8a5.76 5.76 0 0 0-6-6 5.76 5.76 0 0 0-6 6c0 3.33.7 4.58 2.08 6.07a.99.99 0 0 1-.23 1.54A24.28 24.28 0 0 0 7 19c-1.68 1.68-1.95 5.46-2 9a1.99 1.99 0 0 0 2 2h18a1.99 1.99 0 0 0 2-2c-.05-3.54-.32-7.32-2-9zM7 28.02c.03-1.56.09-6.28 1.41-7.6a21.44 21.44 0 0 1 4.42-3.06 2.99 2.99 0 0 0 .71-4.66C12.56 11.65 12 10.9 12 8a3.76 3.76 0 0 1 4-4 3.76 3.76 0 0 1 4 4c0 2.91-.56 3.65-1.54 4.7a2.99 2.99 0 0 0 .71 4.66 21.44 21.44 0 0 1 4.42 3.05C24.9 21.74 24.97 26.46 25 28z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
rakuten_registration_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
rakuten_registration_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M17.15 15.61a.99.99 0 0 1-.23-1.54C18.3 12.57 19 11.32 19 8a5.76 5.76 0 0 0-6-6 5.76 5.76 0 0 0-6 6c0 3.33.7 4.58 2.08 6.07a.99.99 0 0 1-.23 1.54A24.28 24.28 0 0 0 4 19c-1.68 1.68-1.95 5.46-2 9a1.99 1.99 0 0 0 2 2h18a1.99 1.99 0 0 0 2-2c-.05-3.54-.32-7.32-2-9a24.28 24.28 0 0 0-4.85-3.39zM26 6V2h-2v4h-4v2h4v4h2V8h4V6h-4z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
rakuten_registration_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
rakuten_registration_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M17.15 15.61a.99.99 0 0 1-.23-1.54C18.3 12.57 19 11.32 19 8a5.76 5.76 0 0 0-6-6 5.76 5.76 0 0 0-6 6c0 3.33.7 4.58 2.08 6.07a.99.99 0 0 1-.23 1.54A24.28 24.28 0 0 0 4 19c-1.68 1.68-1.95 5.46-2 9a1.99 1.99 0 0 0 2 2h18a1.99 1.99 0 0 0 2-2c-.05-3.54-.32-7.32-2-9a24.28 24.28 0 0 0-4.85-3.39zM4 28.01c.02-1.55.08-6.27 1.4-7.6a21.44 21.44 0 0 1 4.42-3.05 2.99 2.99 0 0 0 .71-4.66C9.56 11.65 9 10.9 9 8a3.76 3.76 0 0 1 4-4 3.76 3.76 0 0 1 4 4c0 2.91-.56 3.65-1.54 4.7a2.99 2.99 0 0 0 .71 4.66 21.44 21.44 0 0 1 4.42 3.05C21.9 21.74 21.97 26.46 22 28zM26 6V2h-2v4h-4v2h4v4h2V8h4V6h-4z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
ranking_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
ranking_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M4.84 27.17a2 2 0 0 0 2 1.83h18.33a2 2 0 0 0 1.99-1.83l.2-2.17H4.64zM22 12l-6-9-6 9-7-5 1.46 16h23.08L29 7l-7 5z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
ranking_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
ranking_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M22 12l-6-9-6 9-7-5 1.46 16h23.08L29 7zm3.71 9H6.3l-.9-9.84 3.45 2.47 1.68 1.2 1.14-1.72L16 6.6l4.34 6.5 1.14 1.72 1.68-1.2 3.45-2.47zm-.54 6H6.83l-.18-2h-2l.2 2.17A2 2 0 0 0 6.82 29h18.34a2 2 0 0 0 1.99-1.83l.2-2.17h-2.01z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
refresh : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
refresh attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M27 16a11.04 11.04 0 1 1-2.94-7.47L21.59 11H28V4.59l-2.53 2.53A12.98 12.98 0 1 0 29 16z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
review_comment_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
review_comment_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M27 3H5a2 2 0 0 0-2 2v18a2 2 0 0 0 2 2h7l4 4 4-4h7a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zM16 19H9v-2h7zm7-4H9v-2h14zm0-4H9V9h14z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
review_comment_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
review_comment_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M27 3H5a2 2 0 0 0-2 2v18a2 2 0 0 0 2 2h7l4 4 4-4h7a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zm0 20h-7.83l-.58.59L16 26.17l-2.59-2.58-.58-.59H5V5h22z" ] []
            , Svg.path [ SA.d "M9 9h14v2H9zm0 4h14v2H9zm0 4h7v2H9z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
review_edit_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
review_edit_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M24.56 9.43l1.41 1.42 1.44-1.45a2 2 0 0 0 0-2.83l-3.98-3.98a2 2 0 0 0-2.83 0l-1.45 1.44 1.42 1.41zm0 2.83l-1.42-1.42-3.99-3.98-1.4-1.41-11.8 11.79L4 26l8.76-1.95zM6.63 23.36l1-4.43 3.45 3.45zM4 28h24v2H4z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
review_edit_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
review_edit_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M22.01 4L26 7.99l-1.44 1.44 1.41 1.41 1.44-1.44a2 2 0 0 0 0-2.83l-3.98-3.98a2 2 0 0 0-2.83 0l-1.45 1.44 1.42 1.41zm2.55 8.26l-1.42-1.41-5.4-5.4-11.8 11.79L4 26l8.76-1.95zM6.63 23.36l1-4.43 3.45 3.45zm2.14-6.12l8.97-8.97 3.99 3.99-8.97 8.97zM4 28h24v2H4z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
rss_symbol_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
rss_symbol_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.circle [ SA.cx "7", SA.cy "25", SA.r "4" ] []
            , Svg.path [ SA.d "M3 11v4a14.02 14.02 0 0 1 14 14h4A18.02 18.02 0 0 0 3 11z" ] []
            , Svg.path [ SA.d "M3 3v4a22.02 22.02 0 0 1 22 22h4A26.03 26.03 0 0 0 3 3z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
rss_text_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
rss_text_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M9.01 12.74h-1.3v3.33h1.3a1.67 1.67 0 0 0 0-3.33z" ] []
            , Svg.path [ SA.d "M28 6H4a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V8a2 2 0 0 0-2-2zM11.19 20.85l-.02-.03-1.86-3.15H7.7v3.18H6v-9.7h3.01a3.33 3.33 0 0 1 3.45 3.27 2.68 2.68 0 0 1-1.45 2.64l-.09.04 2.44 3.75zM16 21a4.18 4.18 0 0 1-3.25-1.54l-.03-.03 1.06-1.17.03.04a3 3 0 0 0 2.2 1.12c.97 0 1.6-.49 1.6-1.24a1.12 1.12 0 0 0-.64-1.1 5.13 5.13 0 0 0-1.2-.45c-2.07-.65-2.88-1.45-2.88-2.86A2.94 2.94 0 0 1 16.1 11a4.01 4.01 0 0 1 2.82 1.11l.04.03-1.1 1.26-.03-.04a2.38 2.38 0 0 0-1.72-.78 1.28 1.28 0 0 0-1.38 1.2 1.01 1.01 0 0 0 .62.9 9.5 9.5 0 0 0 1.35.5l-.01.05.01-.04c1.94.65 2.73 1.5 2.73 2.98 0 1.66-1.4 2.83-3.42 2.83zm6.57 0a4.18 4.18 0 0 1-3.25-1.54l-.03-.03 1.06-1.17.04.04a3 3 0 0 0 2.2 1.12c.96 0 1.58-.49 1.58-1.24a1.12 1.12 0 0 0-.63-1.1 5.13 5.13 0 0 0-1.2-.45c-2.07-.65-2.88-1.45-2.88-2.86a2.94 2.94 0 0 1 3.2-2.77 4.01 4.01 0 0 1 2.82 1.11l.04.03-1.09 1.26-.04-.04a2.38 2.38 0 0 0-1.72-.78 1.28 1.28 0 0 0-1.38 1.2 1.01 1.01 0 0 0 .62.9 9.5 9.5 0 0 0 1.35.5l-.01.05.01-.04c1.94.65 2.73 1.5 2.73 2.97 0 1.67-1.4 2.84-3.42 2.84z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
rss_text_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
rss_text_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M7.72 17.67H9.3l1.86 3.15.02.03h2.17l-2.44-3.75.09-.04a2.68 2.68 0 0 0 1.45-2.64 3.33 3.33 0 0 0-3.45-3.27H6v9.7h1.72zm0-4.92h1.3a1.67 1.67 0 0 1 0 3.32h-1.3z" ] []
            , Svg.path [ SA.d "M16.02 19.42a3 3 0 0 1-2.2-1.12l-.03-.04-1.06 1.17.02.03A4.18 4.18 0 0 0 16.01 21c2.01 0 3.42-1.17 3.42-2.84 0-1.46-.79-2.32-2.73-2.97l-.01.04.01-.04a9.5 9.5 0 0 1-1.35-.5 1.01 1.01 0 0 1-.62-.91 1.28 1.28 0 0 1 1.38-1.2 2.38 2.38 0 0 1 1.72.78l.04.04 1.08-1.26-.03-.03A4.01 4.01 0 0 0 16.1 11a2.94 2.94 0 0 0-3.2 2.77c0 1.4.8 2.2 2.88 2.86a5.13 5.13 0 0 1 1.2.45 1.12 1.12 0 0 1 .63 1.1c0 .75-.62 1.24-1.59 1.24z" ] []
            , Svg.path [ SA.d "M22.36 16.63a5.13 5.13 0 0 1 1.19.45 1.12 1.12 0 0 1 .63 1.1c0 .75-.62 1.24-1.59 1.24a3 3 0 0 1-2.2-1.12l-.03-.04-1.06 1.17.03.03A4.18 4.18 0 0 0 22.58 21C24.6 21 26 19.83 26 18.16c0-1.46-.79-2.32-2.72-2.97l-.02.04.01-.04a9.5 9.5 0 0 1-1.35-.5 1.01 1.01 0 0 1-.62-.91 1.28 1.28 0 0 1 1.38-1.2 2.38 2.38 0 0 1 1.72.78l.04.04 1.09-1.26-.04-.03A4.01 4.01 0 0 0 22.67 11a2.94 2.94 0 0 0-3.2 2.77c0 1.4.81 2.2 2.89 2.86z" ] []
            , Svg.path [ SA.d "M28 6H4a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V8a2 2 0 0 0-2-2zm0 18H4V8h24z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
save_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
save_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M23 3H5a2 2 0 0 0-2 2v22a2 2 0 0 0 2 2h22a2 2 0 0 0 2-2V9zM10 5h7v4h2V5h3v5a2 2 0 0 1-2 2h-8a2 2 0 0 1-2-2zm13 22H9v-6a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
save_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
save_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M23 3H5a2 2 0 0 0-2 2v22a2 2 0 0 0 2 2h22a2 2 0 0 0 2-2V9zM11 5h6v4h2V5h2v6H11zm11 22H10v-7h12zm5 0h-3v-7a2 2 0 0 0-2-2H10a2 2 0 0 0-2 2v7H5V5h4v6a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V5.83l4 4z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
search_history_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
search_history_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M13 21.5a5.5 5.5 0 1 0-2.45 4.58L14.48 30 16 28.48l-3.92-3.93A5.47 5.47 0 0 0 13 21.5zM7.5 25a3.5 3.5 0 1 1 3.5-3.5A3.5 3.5 0 0 1 7.5 25z" ] []
            , Svg.path [ SA.d "M19 2A11 11 0 0 0 8 13c0 .35.02.69.05 1.03a7.46 7.46 0 0 1 6.75 9.14A11 11 0 1 0 19 2zm7 12h-8V7h2v5h6z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
search_history_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
search_history_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M17 8v7h8v-2h-6V8h-2zm-4 13.5a5.5 5.5 0 1 0-2.45 4.58L14.48 30 16 28.48l-3.92-3.93A5.47 5.47 0 0 0 13 21.5zM7.5 25a3.5 3.5 0 1 1 3.5-3.5A3.5 3.5 0 0 1 7.5 25z" ] []
            , Svg.path [ SA.d "M19 2A11 11 0 0 0 8 13c0 .35.02.69.05 1.03a7.45 7.45 0 0 1 2.08.46 9.02 9.02 0 1 1 4.85 6.55l.02.46a7.5 7.5 0 0 1-.2 1.67A11 11 0 1 0 19 2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
search : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
search attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M13 2a11 11 0 1 0 11 11A11 11 0 0 0 13 2zm0 20a9 9 0 1 1 9-9 9.01 9.01 0 0 1-9 9zm9.86-.55a13.11 13.11 0 0 1-1.41 1.41L28.59 30 30 28.59z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
security_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
security_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M11.07 8a4 4 0 0 1 4-4h1.86a4 4 0 0 1 4 4v4h2V8a6.02 6.02 0 0 0-6-6h-1.86a6.02 6.02 0 0 0-6 6v4h2zM24 14H8a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V16a2 2 0 0 0-2-2zm-7 7.72V25h-2v-3.28a2 2 0 1 1 2 0z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
security_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
security_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M24 14H8a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V16a2 2 0 0 0-2-2zm0 14H8V16h16zM11.07 8a4 4 0 0 1 4-4h1.86a4 4 0 0 1 4 4v4h2V8a6.02 6.02 0 0 0-6-6h-1.86a6.02 6.02 0 0 0-6 6v4h2z" ] []
            , Svg.path [ SA.d "M15 21.72V25h2v-3.28a2 2 0 1 0-2 0z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
server_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
server_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M3 22.13V25a2.5 2.5 0 0 0 .07.59l.02.05C3.8 28.27 8.8 30 16 30s12.21-1.73 12.91-4.36l.02-.05A2.5 2.5 0 0 0 29 25v-2.87A29.48 29.48 0 0 1 16 25a29.48 29.48 0 0 1-13-2.87zM16 2C9.54 2 3 3.72 3 7v5.84A27 27 0 0 0 16 16a27 27 0 0 0 13-3.16V7c0-3.28-6.54-5-13-5zm0 8C8.18 10 5.01 7.88 5.01 7 5.01 5.98 8.9 4 16 4s10.99 1.98 10.99 3c0 .88-3.16 3-10.99 3z" ] []
            , Svg.path [ SA.d "M3 15.13v4.71A27 27 0 0 0 16 23a27 27 0 0 0 13-3.16v-4.7A29.48 29.48 0 0 1 16 18a29.48 29.48 0 0 1-13-2.87z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
server_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
server_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M16 2C9.54 2 3 3.72 3 7v18a2.5 2.5 0 0 0 .07.59l.02.05C3.8 28.27 8.8 30 16 30s12.21-1.73 12.91-4.36l.02-.05A2.5 2.5 0 0 0 29 25V7c0-3.28-6.54-5-13-5zm0 2c7.1 0 10.99 1.98 10.99 3 0 .88-3.16 3-10.99 3S5.01 7.88 5.01 7C5.01 5.98 8.9 4 16 4zm11 21h-.01a.51.51 0 0 1-.05.19.99.99 0 0 1-.05.1 1.01 1.01 0 0 1-.07.11l-.06.07C25.86 26.52 22.14 28 16 28s-9.86-1.48-10.76-2.53l-.06-.07a.97.97 0 0 1-.07-.12.94.94 0 0 1-.05-.1A.51.51 0 0 1 5 25H5v-3.15C7.2 23.2 11.09 24 16 24s8.8-.8 11-2.15zm0-7v1h-.01c0 .88-3.16 3-10.99 3S5.01 19.88 5.01 19H5v-3.15C7.2 17.2 11.09 18 16 18s8.8-.8 11-2.15zm0-5h-.01c0 .88-3.16 3-10.99 3S5.01 13.88 5.01 13H5V9.85C7.2 11.2 11.09 12 16 12s8.8-.8 11-2.15z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
settings_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
settings_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M28 13h-.91a11.42 11.42 0 0 0-1.13-2.72l.65-.64a2 2 0 0 0 0-2.83l-1.42-1.42a2 2 0 0 0-2.83 0l-.64.64A11.41 11.41 0 0 0 19 4.91V4a2 2 0 0 0-2-2h-2a2 2 0 0 0-2 2v.91a11.41 11.41 0 0 0-2.72 1.12l-.64-.64a2 2 0 0 0-2.83 0L5.39 6.81a2 2 0 0 0 0 2.83l.64.64A11.42 11.42 0 0 0 4.91 13H4a2 2 0 0 0-2 2v2a2 2 0 0 0 2 2h.91a11.42 11.42 0 0 0 1.13 2.72l-.65.64a2 2 0 0 0 0 2.83l1.42 1.42a2 2 0 0 0 2.83 0l.64-.64A11.4 11.4 0 0 0 13 27.09V28a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2v-.91a11.4 11.4 0 0 0 2.72-1.13l.64.65a2 2 0 0 0 2.83 0l1.42-1.42a2 2 0 0 0 0-2.83l-.64-.64A11.42 11.42 0 0 0 27.09 19H28a2 2 0 0 0 2-2v-2a2 2 0 0 0-2-2zm-12 9a6 6 0 1 1 6-6 6 6 0 0 1-6 6z", SA.fill <| R10.Color.Utils.toCssRgba cl, SA.fillRule "evenodd" ] []
        ]


{-| -}
settings_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
settings_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 13h-.91a11.42 11.42 0 0 0-1.13-2.72l.65-.64a2 2 0 0 0 0-2.83l-1.42-1.42a2 2 0 0 0-2.83 0l-.64.64A11.41 11.41 0 0 0 19 4.91V4a2 2 0 0 0-2-2h-2a2 2 0 0 0-2 2v.91a11.41 11.41 0 0 0-2.72 1.12l-.64-.64a2 2 0 0 0-2.83 0L5.39 6.81a2 2 0 0 0 0 2.83l.64.64A11.42 11.42 0 0 0 4.91 13H4a2 2 0 0 0-2 2v2a2 2 0 0 0 2 2h.91a11.42 11.42 0 0 0 1.13 2.72l-.65.64a2 2 0 0 0 0 2.83l1.42 1.42a2 2 0 0 0 2.83 0l.64-.64A11.4 11.4 0 0 0 13 27.09V28a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2v-.91a11.4 11.4 0 0 0 2.72-1.13l.64.65a2 2 0 0 0 2.83 0l1.42-1.42a2 2 0 0 0 0-2.83l-.64-.64A11.42 11.42 0 0 0 27.09 19H28a2 2 0 0 0 2-2v-2a2 2 0 0 0-2-2zm0 4h-2.44l-.4 1.48a9.43 9.43 0 0 1-.93 2.24l-.76 1.33 1.08 1.09.64.64-1.41 1.41-.64-.64-1.09-1.08-1.33.76a9.42 9.42 0 0 1-2.24.93l-1.48.4V28h-2v-2.44l-1.48-.4a9.42 9.42 0 0 1-2.24-.93l-1.33-.76-1.09 1.08-.64.64-1.41-1.41.64-.64 1.08-1.09-.76-1.33a9.43 9.43 0 0 1-.93-2.24L6.44 17H4v-2h2.44l.4-1.48a9.43 9.43 0 0 1 .93-2.24l.76-1.33-1.08-1.09-.64-.64 1.41-1.41.64.64 1.09 1.08 1.33-.76a9.42 9.42 0 0 1 2.24-.93l1.48-.4V4h2v2.44l1.48.4a9.42 9.42 0 0 1 2.24.93l1.33.76 1.09-1.08.64-.64 1.41 1.41-.64.64-1.08 1.09.76 1.32a9.43 9.43 0 0 1 .93 2.25l.4 1.48H28z" ] []
            , Svg.path [ SA.d "M16 9.5a6.5 6.5 0 1 0 6.5 6.5A6.5 6.5 0 0 0 16 9.5zm0 11a4.5 4.5 0 1 1 4.5-4.5 4.5 4.5 0 0 1-4.5 4.5z" ] []
            ]
        ]


{-| -}
share_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
share_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M25 21a3.97 3.97 0 0 0-3 1.38l-11.1-5.54a3.9 3.9 0 0 0 0-1.68L22 9.62a3.94 3.94 0 1 0-.9-1.78L10 13.38a4 4 0 1 0 0 5.24l11.09 5.54A4 4 0 1 0 25 21z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
share_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
share_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M24.5 20a4.48 4.48 0 0 0-3.6 1.83l-9.1-4.55a4.05 4.05 0 0 0 0-2.56l9.1-4.55a4.52 4.52 0 1 0-.81-1.83l-9.28 4.64a4.5 4.5 0 1 0 0 6.04l9.28 4.64A4.5 4.5 0 1 0 24.5 20zm0-15A2.5 2.5 0 1 1 22 7.5 2.5 2.5 0 0 1 24.5 5zm-17 13.5A2.5 2.5 0 1 1 10 16a2.5 2.5 0 0 1-2.5 2.5zm17 8.5a2.5 2.5 0 1 1 2.5-2.5 2.5 2.5 0 0 1-2.5 2.5z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
shop_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
shop_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M22.01 17.19a5.99 5.99 0 0 1-6.01 0 5.99 5.99 0 0 1-6.01 0A5.83 5.83 0 0 1 6 17.9V27a2 2 0 0 0 2 2h3.5v-4.5a4.5 4.5 0 0 1 9 0V29H24a2 2 0 0 0 2-2v-9.09a5.83 5.83 0 0 1-3.99-.72z" ] []
            , Svg.path [ SA.d "M16 22a2.5 2.5 0 0 0-2.5 2.5V29h5v-4.5A2.5 2.5 0 0 0 16 22zm9.7-18H6.3L3 12a3.99 3.99 0 0 0 6.97 2.66l.03-.02a4 4 0 0 0 6 0 4 4 0 0 0 6 0l.03.02A3.99 3.99 0 0 0 29 12z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
shop_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
shop_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M16 19a4 4 0 0 0-4 4v6h8v-6a4 4 0 0 0-4-4zm2 8h-4v-4a2 2 0 0 1 4 0z" ] []
            , Svg.path [ SA.d "M25.7 4H6.3L3 12.82V13a4 4 0 0 0 3 3.86V27a2 2 0 0 0 2 2h2v-2H8V16.86a4 4 0 0 0 2-1.22 4 4 0 0 0 6 0 4 4 0 0 0 6 0 4 4 0 0 0 2 1.22V27h-2v2h2a2 2 0 0 0 2-2V16.86A4 4 0 0 0 29 13v-.18zM25 15a2 2 0 0 1-2-2h-2a2 2 0 0 1-4 0h-2a2 2 0 0 1-4 0H9a2 2 0 0 1-4 .16L7.7 6h16.6l2.7 7.16A2 2 0 0 1 25 15z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
sign_ban_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
sign_ban_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm6.33 21.73L8.28 9.67a10.1 10.1 0 0 1 1.4-1.4l14.06 14.07a10.1 10.1 0 0 1-1.4 1.4z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
sign_ban_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
sign_ban_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm0 26a12 12 0 1 1 12-12 12.01 12.01 0 0 1-12 12z" ] []
            , Svg.path [ SA.d "M8.27 9.66l14.06 14.07a10.1 10.1 0 0 0 1.4-1.4L9.66 8.27a10.1 10.1 0 0 0-1.39 1.4z" ] []
            ]
        ]


{-| -}
sign_help_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
sign_help_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm0 22a1.5 1.5 0 1 1 1.5-1.5A1.5 1.5 0 0 1 16 24zm1-7.12V19h-2v-3a1 1 0 0 1 1-1 2.5 2.5 0 1 0-2.5-2.5v.5h-2v-.5a4.5 4.5 0 1 1 5.5 4.38z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
sign_help_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
sign_help_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.circle [ SA.cx "16", SA.cy "22.5", SA.r "1.5" ] []
            , Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm0 26a12 12 0 1 1 12-12 12.01 12.01 0 0 1-12 12z" ] []
            , Svg.path [ SA.d "M16 8a4.5 4.5 0 0 0-4.5 4.5v.5h2v-.5A2.5 2.5 0 1 1 16 15a1 1 0 0 0-1 1v3h2v-2.12A4.5 4.5 0 0 0 16 8z" ] []
            ]
        ]


{-| -}
sign_info_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
sign_info_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm1 21h-2v-9h2zm-1-11a1.5 1.5 0 1 1 1.5-1.5A1.5 1.5 0 0 1 16 12z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
sign_info_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
sign_info_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M15 14h2v9h-2z" ]
                []
            , Svg.circle
                [ SA.cx "16", SA.cy "10.5", SA.r "1.5" ]
                []
            , Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm0 26a12 12 0 1 1 12-12 12.01 12.01 0 0 1-12 12z" ] []
            ]
        ]


{-| -}
sign_warning_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
sign_warning_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M29.82 25.94L17.25 3.72a1.45 1.45 0 0 0-2.5 0L2.18 25.94A1.4 1.4 0 0 0 3.43 28h25.14a1.4 1.4 0 0 0 1.25-2.06zM15 10h2v9h-2zm1 14a1.5 1.5 0 1 1 1.5-1.5A1.5 1.5 0 0 1 16 24z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
sign_warning_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
sign_warning_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M29.82 25.94L17.25 3.72a1.45 1.45 0 0 0-2.5 0L2.18 25.94A1.4 1.4 0 0 0 3.43 28h25.14a1.4 1.4 0 0 0 1.25-2.06zM4.44 26L16 5.57 27.56 26z" ] []
            , Svg.path [ SA.d "M15 10h2v9h-2z" ]
                []
            , Svg.circle
                [ SA.cx "16", SA.cy "22.5", SA.r "1.5" ]
                []
            ]
        ]


{-| -}
sliders_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
sliders_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M24 6a2 2 0 0 0-2-2h-2a2 2 0 0 0-2 2H3v2h15a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2h5V6zm-2 16h-2a2 2 0 0 0-2 2H3v2h15a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2h5v-2h-5a2 2 0 0 0-2-2zm-11-9H9a2 2 0 0 0-2 2H3v2h4a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2h16v-2H13a2 2 0 0 0-2-2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
sliders_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
sliders_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M24 6a2 2 0 0 0-2-2h-2a2 2 0 0 0-2 2H3v2h15a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2h5V6zm-2 2h-2V6h2zm0 14h-2a2 2 0 0 0-2 2H3v2h15a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2h5v-2h-5a2 2 0 0 0-2-2zm0 4h-2v-2h2zM11 13H9a2 2 0 0 0-2 2H3v2h4a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2h16v-2H13a2 2 0 0 0-2-2zm0 4H9v-2h2z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
smartphone_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
smartphone_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M22 3H10a3 3 0 0 0-3 3v20a3 3 0 0 0 3 3h12a3 3 0 0 0 3-3V6a3 3 0 0 0-3-3zm1 20H9V8h14z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
smartphone_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
smartphone_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M22 3H10a3 3 0 0 0-3 3v20a3 3 0 0 0 3 3h12a3 3 0 0 0 3-3V6a3 3 0 0 0-3-3zm1 23a1 1 0 0 1-1 1H10a1 1 0 0 1-1-1v-2h14zm0-4H9V9h14zm0-15H9V6a1.01 1.01 0 0 1 1-1h12a1.01 1.01 0 0 1 1 1z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
survey_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
survey_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M26 5h-3v5H9V5H6a2 2 0 0 0-2 2v21a2 2 0 0 0 2 2h20a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2zm-4 19H10v-2h12zm0-4H10v-2h12zm0-4H10v-2h12z" ] []
            , Svg.path [ SA.d "M11 8h10V4a2 2 0 0 0-2-2h-6a2 2 0 0 0-2 2z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
survey_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
survey_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M26 5h-2v2h2v21H6V7h2V5H6a2 2 0 0 0-2 2v21a2 2 0 0 0 2 2h20a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2z" ] []
            , Svg.path [ SA.d "M10 10h12V4a2 2 0 0 0-2-2h-8a2 2 0 0 0-2 2zm2-6h8v4h-8zm-2 10h12v2H10zm0 4h12v2H10zm0 4h12v2H10z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
switch_language_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
switch_language_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M21.5 14.09A7.18 7.18 0 0 0 23.13 12h-3.26a7.18 7.18 0 0 0 1.63 2.09zM8.92 14h2.16L10 10.87 8.92 14z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.d "M28 2H4a2 2 0 0 0-2 2v19a2 2 0 0 0 2 2h7.5l4.5 5 4.5-5H28a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2zM12.45 18l-.69-2H8.24l-.7 2H5.5l3.1-9h2.8l3.1 9zm14.05-6h-1.22a8.27 8.27 0 0 1-2.08 3.24 7.4 7.4 0 0 0 3.3.76v2a9.37 9.37 0 0 1-5-1.43 9.37 9.37 0 0 1-5 1.43v-2a7.4 7.4 0 0 0 3.3-.76A8.27 8.27 0 0 1 17.72 12H16.5v-2h4V8h2v2h4z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
switch_language_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
switch_language_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M8.74 16h3.52l.7 2H15l-3.1-9H9.1L6 18h2.05zm1.76-5.13L11.58 14H9.42zM26 18v-2a7.4 7.4 0 0 1-3.3-.76A8.27 8.27 0 0 0 24.78 12H26v-2h-4V8h-2v2h-4v2h1.22a8.27 8.27 0 0 0 2.08 3.24A7.4 7.4 0 0 1 16 16v2a9.37 9.37 0 0 0 5-1.43A9.37 9.37 0 0 0 26 18zm-6.63-6h3.26A7.18 7.18 0 0 1 21 14.09 7.18 7.18 0 0 1 19.37 12z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.d "M28 2H4a2 2 0 0 0-2 2v19a2 2 0 0 0 2 2h7.5l4.5 5 4.5-5H28a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2zm0 21h-8.39l-.6.66L16 27.01l-3.01-3.35-.6-.66H4V4h24z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
tablet_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
tablet_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M25 2H7a3 3 0 0 0-3 3v22a3 3 0 0 0 3 3h18a3 3 0 0 0 3-3V5a3 3 0 0 0-3-3zm-2 22H9V7h14z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
tablet_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
tablet_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M25 2H7a3 3 0 0 0-3 3v22a3 3 0 0 0 3 3h18a3 3 0 0 0 3-3V5a3 3 0 0 0-3-3zm1 25a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V5a1.01 1.01 0 0 1 1-1h18a1.01 1.01 0 0 1 1 1z" ] []
            , Svg.path [ SA.d "M8 25h16V6H8zm2-17h12v15H10z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
tag_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
tag_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M25.2 14.63L14.63 25.2 25.2 14.63z" ] []
        , Svg.path [ SA.d "M15.4 2H4.06A2.06 2.06 0 0 0 2 4.06V15.4L13.21 26.6l13.4-13.4zM9 11a2 2 0 1 1 2-2 2 2 0 0 1-2 2zm20.4 5l-1.37-1.37-13.4 13.4L16 29.4a2.06 2.06 0 0 0 2.92 0L29.4 18.92a2.06 2.06 0 0 0 0-2.92z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
tag_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
tag_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M9 6a3 3 0 1 0 3 3 3 3 0 0 0-3-3zm0 4a1 1 0 1 1 1-1 1 1 0 0 1-1 1zm20.4 6l-1.37-1.37-1.42 1.41 1.37 1.37a.06.06 0 0 1 0 .09L17.5 27.98h-.09l-1.37-1.37-1.41 1.41L16 29.4a2.06 2.06 0 0 0 2.91 0L29.4 18.92a2.06 2.06 0 0 0 0-2.92z" ] []
            , Svg.path [ SA.d "M25.2 14.63l1.41-1.42-1.41-1.4L15.4 2H4.06A2.06 2.06 0 0 0 2 4.06V15.4L13.21 26.6l1.42-1.41zM4 14.57V4.06A.06.06 0 0 1 4.06 4h10.5l9.22 9.21-10.56 10.57z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
time_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
time_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm6.6 17.92L15 16.66V7h2v8.34l6.4 2.74z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        ]


{-| -}
time_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
time_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm0 26a12 12 0 1 1 12-12 12.01 12.01 0 0 1-12 12z" ] []
            , Svg.path [ SA.d "M17 7h-2v9.66l7.6 3.26.8-1.84-6.4-2.74V7z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
train_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
train_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M25 2H7a2 2 0 0 0-2 2v15.33a2 2 0 0 0 .4 1.2l2 2.67a2 2 0 0 0 1.58.8L6 29.97h2.23L9.21 28h13.57l.98 1.97H26L23.02 24a2 2 0 0 0 1.58-.8l2-2.67a2 2 0 0 0 .4-1.2V4a2 2 0 0 0-2-2zM7 13V7h8v6zm2 5.5a1.5 1.5 0 1 1 1.5 1.5A1.5 1.5 0 0 1 9 18.5zm1.21 7.5l1-2h9.58l1 2zm11.29-6a1.5 1.5 0 1 1 1.5-1.5 1.5 1.5 0 0 1-1.5 1.5zm3.5-7h-8V7h8z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
train_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
train_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M25 2H7a2 2 0 0 0-2 2v16.12a2 2 0 0 0 .65 1.47L7.4 23.2a2 2 0 0 0 1.58.8L6 29.97h2.23L9.21 28h13.57l.98 1.97H26L23.02 24a2 2 0 0 0 1.58-.8l1.75-1.6a2 2 0 0 0 .65-1.48V4a2 2 0 0 0-2-2zM7 8h8v5H7zm3.21 18l1-2h9.58l1 2zM25 20.12l-1.75 1.6-.14.13L23 22H9l-.11-.15-.14-.12L7 20.12V15h18zM25 13h-8V8h8zm0-7H7V4h18z" ]
                []
            , Svg.circle
                [ SA.cx "10.5", SA.cy "18.5", SA.r "1.5" ]
                []
            , Svg.circle
                [ SA.cx "21.5", SA.cy "18.5", SA.r "1.5" ]
                []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
upload_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
upload_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 21v5H4v-5H2v5a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2v-5zm-16-2h8v-8h4l-7.25-7.67a1 1 0 0 0-1.48 0L8 11h4z" ] []
            , Svg.path [ SA.d "M12 21h8v2h-8z" ] []
            ]
        ]


{-| -}
upload_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
upload_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 21v5H4v-5H2v5a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2v-5zm-16-2h8v-8h4l-7.25-7.67a1 1 0 0 0-1.48 0L8 11h4zm4.01-13.54L19.36 9H18v8h-4V9h-1.35z" ] []
            , Svg.path [ SA.d "M12 21h8v2h-8z" ] []
            ]
        ]


{-| -}
voice_input_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
voice_input_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M26 16h-2a8 8 0 0 1-16 0H6a10 10 0 0 0 9 9.95V28h-3v2h8v-2h-3v-2.05A10 10 0 0 0 26 16z" ] []
            , Svg.path [ SA.d "M16 22a6 6 0 0 0 6-6V8a6 6 0 0 0-12 0v8a6 6 0 0 0 6 6z" ] []
            ]
        ]


{-| -}
voice_input_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
voice_input_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M26 16h-2a8 8 0 0 1-16 0H6a10 10 0 0 0 9 9.95V28h-3v2h8v-2h-3v-2.05A10 10 0 0 0 26 16z" ] []
            , Svg.path [ SA.d "M16 22a6 6 0 0 0 6-6V8a6 6 0 0 0-12 0v8a6 6 0 0 0 6 6zM12 8a4 4 0 0 1 8 0v8a4 4 0 0 1-8 0z" ] []
            ]
        ]


{-| -}
walking_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
walking_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.circle [ SA.cx "15", SA.cy "5", SA.r "3" ] []
            , Svg.path [ SA.d "M7 27v3c3.56 0 7.21-2.2 7.88-5.96L12 22.81C12 25.43 9.46 27 7 27z" ] []
            , Svg.path [ SA.d "M19.96 16.09A9.88 9.88 0 0 0 27 19v-3a6.9 6.9 0 0 1-4.91-2.04l-2.94-2.94A3.48 3.48 0 0 0 16.67 10h-2.94a3.5 3.5 0 0 0-.97.14l-1.39.4A8.85 8.85 0 0 0 5 19h3a5.83 5.83 0 0 1 4-5.5v7.13l3.94 1.69.34.18A8.33 8.33 0 0 1 21 30h3a11.34 11.34 0 0 0-6-10.01v-5.87z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
world_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
world_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M19.12 23h-6.24c.88 3.2 2.23 5 3.12 5s2.24-1.8 3.12-5zM12.88 9h6.24C18.24 5.8 16.9 4 16 4s-2.24 1.8-3.12 5zm-.46 12h7.16a27.88 27.88 0 0 0 .4-4h-7.96a27.88 27.88 0 0 0 .4 4zm0-10a27.88 27.88 0 0 0-.4 4h7.96a27.88 27.88 0 0 0-.4-4z" ] []
            , Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm10.9 19a12 12 0 0 1-1.17 2h-4.54a16.09 16.09 0 0 1-1.78 4.5 11.87 11.87 0 0 1-6.83 0 16.09 16.09 0 0 1-1.77-4.5H6.27a12 12 0 0 1-1.16-2h5.29a30.47 30.47 0 0 1-.38-4H4.05a12.24 12.24 0 0 1 0-2h5.97a30.47 30.47 0 0 1 .38-4H5.1a12 12 0 0 1 1.17-2h4.54a16.09 16.09 0 0 1 1.77-4.5 11.87 11.87 0 0 1 6.83 0A16.09 16.09 0 0 1 21.2 9h4.54a12 12 0 0 1 1.16 2h-5.3a30.47 30.47 0 0 1 .39 4h5.97a11.78 11.78 0 0 1 0 2h-5.97a30.47 30.47 0 0 1-.38 4z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
world_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
world_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M16 2a14 14 0 1 0 14 14A14 14 0 0 0 16 2zm10.9 9a11.88 11.88 0 0 1 1.05 4h-5.97a30.47 30.47 0 0 0-.38-4zm-1.17-2h-4.54a16.06 16.06 0 0 0-1.77-4.5 12.03 12.03 0 0 1 6.3 4.5zm-13.71 6a27.88 27.88 0 0 1 .4-4h7.16a27.88 27.88 0 0 1 .4 4zm7.96 2a27.88 27.88 0 0 1-.4 4h-7.16a27.88 27.88 0 0 1-.4-4zM16 4c.89 0 2.24 1.8 3.12 5h-6.24c.88-3.2 2.23-5 3.12-5zm-3.42.5A16.06 16.06 0 0 0 10.81 9H6.27a12.03 12.03 0 0 1 6.31-4.5zM5.11 11h5.29a30.47 30.47 0 0 0-.38 4H4.05a11.88 11.88 0 0 1 1.05-4zm0 10a11.88 11.88 0 0 1-1.06-4h5.97a30.47 30.47 0 0 0 .38 4zm1.16 2h4.54a16.06 16.06 0 0 0 1.77 4.5 12.03 12.03 0 0 1-6.3-4.5zM16 28c-.89 0-2.24-1.8-3.12-5h6.24c-.88 3.2-2.23 5-3.12 5zm3.42-.5a16.06 16.06 0 0 0 1.77-4.5h4.54a12.03 12.03 0 0 1-6.31 4.5zm7.47-6.5h-5.3a30.47 30.47 0 0 0 .39-4h5.97a11.88 11.88 0 0 1-1.06 4z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
x : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
x attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.path [ SA.fill <| R10.Color.Utils.toCssRgba cl, SA.d "M27 6.45L25.55 5 16 14.55 6.45 5 5 6.45 14.55 16 5 25.55 6.45 27 16 17.45 25.55 27 27 25.55 17.45 16 27 6.45z" ] []
        ]


{-| -}
zip_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
zip_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M21.7 15.4h-1.3v1.8h1.3a.9.9 0 1 0 0-1.8z" ] []
            , Svg.path [ SA.d "M28 7H16l-1.37-2.86A2 2 0 0 0 12.83 3H5.5a2 2 0 0 0-1.92 1.45L2 10v17a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zm-15 8l-3.05 4.6H13V21H8v-1l3.05-4.6H8V14h5zm3.7 6h-1.4v-7h1.4zm5-2.4h-1.3V21H19v-7h2.7a2.3 2.3 0 1 1 0 4.6z" ] []
            ]
        ]


{-| -}
zip_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
zip_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        , Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M28 7H16l-1.37-2.86A2 2 0 0 0 12.83 3H5.5a2 2 0 0 0-1.92 1.45L2 10v17a2 2 0 0 0 2 2h24a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zm0 20H4V10.28L5.5 5h7.33l1.36 2.86.55 1.14H28z" ] []
            , Svg.path [ SA.d "M8 15.4h3.05L8 20v1h5v-1.4H9.95L13 15v-1H8v1.4zm7.3-1.4h1.4v7h-1.4zm5.1 4.6h1.3a2.3 2.3 0 1 0 0-4.6H19v7h1.4zm0-3.2h1.3a.9.9 0 1 1 0 1.8h-1.3z" ] []
            ]
        ]


{-| -}
zoom_in_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
zoom_in_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M22.86 21.45a13.11 13.11 0 0 1-1.41 1.41L28.59 30 30 28.59zM13 2a11 11 0 1 0 11 11A11 11 0 0 0 13 2zm4 12h-3v3h-2v-3H9v-2h3V9h2v3h3z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
zoom_in_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
zoom_in_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M14 9h-2v3H9v2h3v3h2v-3h3v-2h-3V9z" ] []
            , Svg.path [ SA.d "M13 2a11 11 0 1 0 11 11A11 11 0 0 0 13 2zm0 20a9 9 0 1 1 9-9 9.01 9.01 0 0 1-9 9zm9.86-.55a13.11 13.11 0 0 1-1.41 1.41L28.59 30 30 28.59z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
zoom_out_f : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
zoom_out_f attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.path [ SA.d "M22.86 21.45a13.11 13.11 0 0 1-1.41 1.41L28.59 30 30 28.59zM13 2a11 11 0 1 0 11 11A11 11 0 0 0 13 2zm4 12H9v-2h8z", SA.fill <| R10.Color.Utils.toCssRgba cl ] []
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]


{-| -}
zoom_out_l : List (Attribute (R10.Context.ContextInternal z) msg) -> Color -> Int -> Element (R10.Context.ContextInternal z) msg
zoom_out_l attrs cl size =
    R10.Svg.Utils.wrapper32 attrs
        size
        [ Svg.g [ SA.fill <| R10.Color.Utils.toCssRgba cl ]
            [ Svg.path [ SA.d "M9 12h8v2H9z" ] []
            , Svg.path [ SA.d "M13 2a11 11 0 1 0 11 11A11 11 0 0 0 13 2zm0 20a9 9 0 1 1 9-9 9.01 9.01 0 0 1-9 9zm9.86-.55a13.11 13.11 0 0 1-1.41 1.41L28.59 30 30 28.59z" ] []
            ]
        , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
        ]
