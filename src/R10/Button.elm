module R10.Button exposing
    ( primary, secondary, tertiary, quaternary
    , Data, cssButtonStyle, numberPadding, withLimitedWidth
    )

{-| Buttons!

![Buttons](https://r10.netlify.app/images/buttons300.png)

@docs primary, secondary, tertiary, quaternary


# Others

@docs Data, cssButtonStyle, numberPadding, withLimitedWidth

-}

import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Html.Attributes
import R10.Color.Background
import R10.Color.Border
import R10.Color.CssRgba
import R10.Color.Font
import R10.FontSize
import R10.Libu
import R10.Paragraph
import R10.Theme


{-| Type of data required by buttons
-}
type alias Data msg =
    { label : Element msg
    , libu : R10.Libu.Type msg
    , theme : R10.Theme.Theme
    }


{-| Primary Button for Call to Actions

    R10.Button.primary []
        { label = text "Text"
        , libu = R10.Libu.Bu <| Just doSomething
        , theme =
            { mode = R10.Mode.Light
            , primaryColor = R10.Color.Primary.CrimsonRed
            }
        }

-}
primary : List (Attribute msg) -> Data msg -> Element msg
primary attrsExtra data =
    let
        attrs : R10.Theme.Theme -> List (Attribute msg)
        attrs =
            if data.libu == R10.Libu.Bu Nothing then
                attrsPrimaryDisabled

            else
                attrsPrimary
    in
    R10.Libu.view
        (attrs data.theme ++ attrsExtra)
        { label = data.label
        , type_ = data.libu
        }


{-| Secondary Button
-}
secondary : List (Attribute msg) -> Data msg -> Element msg
secondary attrsExtra data =
    let
        attrs : R10.Theme.Theme -> List (Attribute msg)
        attrs =
            if data.libu == R10.Libu.Bu Nothing then
                attrsSecondaryDisabled

            else
                attrsSecondary
    in
    R10.Libu.view
        (attrs data.theme ++ attrsExtra)
        { label = data.label
        , type_ = data.libu
        }


{-| Tertiary Button
-}
tertiary : List (Attribute msg) -> Data msg -> Element msg
tertiary attrsExtra data =
    R10.Libu.view
        (attrsTertiary data.theme ++ attrsExtra)
        { label = data.label
        , type_ = data.libu
        }


{-| Quaternary Button
-}
quaternary : List (Attribute msg) -> Data msg -> Element msg
quaternary attrsExtra data =
    R10.Libu.view
        (attrsQuaternary data.theme ++ attrsExtra)
        { label = data.label
        , type_ = data.libu
        }



--
-- Note: We set the padding of buttons, instead of the height, because the label
-- inside the buttons could wrap in two lines.
--
-- ATTRIBUTES


{-| Default padding value for buttons
-}
numberPadding : Int
numberPadding =
    18


{-| Attributes for buttons with limited width. By default buttons are `width fill`.
-}
withLimitedWidth : List (Attribute msg)
withLimitedWidth =
    [ width (fill |> maximum 250)
    , centerX
    ]


transition : Attribute msg
transition =
    htmlAttribute <| Html.Attributes.style "transition" "color .2s ease-out, background-color .2s ease-out"


attrsInCommon : List (Attribute msg)
attrsInCommon =
    [ padding numberPadding
    , width fill
    , transition
    , Border.rounded 5
    , Font.center
    ]


attrsPrimary : R10.Theme.Theme -> List (Attribute msg)
attrsPrimary theme =
    attrsInCommon
        ++ [ R10.Color.Background.backgroundButtonPrimary theme
           , R10.Color.Font.fontButtonPrimary theme
           , mouseOver [ R10.Color.Background.backgroundButtonPrimaryOver theme ]
           , focused [ R10.Color.Background.backgroundButtonPrimaryOver theme ]
           ]


attrsPrimaryDisabled : R10.Theme.Theme -> List (Attribute msg)
attrsPrimaryDisabled theme =
    attrsInCommon
        ++ [ R10.Color.Background.backgroundButtonPrimaryDisabled theme
           , R10.Color.Font.fontButtonPrimaryDisabled theme
           , mouseOver
                [ R10.Color.Background.backgroundButtonPrimaryDisabledOver theme
                , R10.Color.Font.fontButtonPrimaryDisabledOver theme
                ]
           , focused
                [ R10.Color.Background.backgroundButtonPrimaryDisabledOver theme
                , R10.Color.Font.fontButtonPrimaryDisabledOver theme
                ]
           , htmlAttribute <| Html.Attributes.style "cursor" "not-allowed"
           ]


attrsSecondary : R10.Theme.Theme -> List (Attribute msg)
attrsSecondary theme =
    attrsInCommon
        ++ [ mouseOver [ R10.Color.Background.backgroundButtonMinorOver theme ]
           , focused [ R10.Color.Background.backgroundButtonMinorOver theme ]
           , R10.Color.Border.borderButtonSecondary theme
           , Border.width 1
           ]


attrsSecondaryDisabled : R10.Theme.Theme -> List (Attribute msg)
attrsSecondaryDisabled theme =
    attrsInCommon
        ++ [ R10.Color.Background.backgroundButtonPrimaryDisabled theme
           , mouseOver [ R10.Color.Background.backgroundButtonMinorOver theme ]
           , focused [ R10.Color.Background.backgroundButtonMinorOver theme ]
           , R10.Color.Border.borderButtonSecondary theme
           , Border.width 1
           , htmlAttribute <| Html.Attributes.style "cursor" "not-allowed"
           ]


attrsTertiary : R10.Theme.Theme -> List (Attribute msg)
attrsTertiary theme =
    [ padding numberPadding
    , width fill
    , mouseOver [ R10.Color.Background.backgroundButtonMinorOver theme ]
    , focused [ R10.Color.Background.backgroundButtonMinorOver theme ]
    , transition
    , Border.rounded 5
    , Font.center
    , R10.FontSize.small
    ]


attrsQuaternary : R10.Theme.Theme -> List (Attribute msg)
attrsQuaternary theme =
    [ paddingXY (numberPadding - 4) (numberPadding - 8)
    , mouseOver [ R10.Color.Background.backgroundButtonMinorOver theme ]
    , focused [ R10.Color.Background.backgroundButtonMinorOver theme ]
    , transition
    , Border.rounded 5
    , Font.center
    , R10.FontSize.xxsmall
    , R10.Color.Font.fontNormalLighter theme
    ]



-- SPECIAL CASE FOR CSS BUTTONS


{-| Special case for CSS buttons, useful if a button must be built using the standard Html library instead of `elm-ui`.
-}
cssButtonStyle : R10.Theme.Theme -> String
cssButtonStyle theme =
    let
        primaryColorHex : String
        primaryColorHex =
            R10.Color.CssRgba.iconPrimaryHex theme
    in
    """
.form.btn {
    color: white !important;
    border: none;
    width: 240px;
    height: 44px;
    font-size: 16px;
    font-weight: lighter;
    border-radius: 3px;
    background-color: """ ++ primaryColorHex ++ """;
    outline: 0;
    transition: .2s;
    cursor: pointer;
}
/* .btn:hover {
    background-color: #FF1212;
}
*/
    """
