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
import R10.Color.AttrsBackground
import R10.Color.AttrsBorder
import R10.Color.AttrsFont
import R10.Color.Svg
import R10.Color.Utils
import R10.FontSize
import R10.Libu
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
primary :
    List (Attribute msg)
    ->
        { label : Element msg
        , libu : R10.Libu.Type msg
        , theme : R10.Theme.Theme
        }
    -> Element msg
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
secondary :
    List (Attribute msg)
    ->
        { label : Element msg
        , libu : R10.Libu.Type msg
        , theme : R10.Theme.Theme
        }
    -> Element msg
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
tertiary :
    List (Attribute msg)
    ->
        { label : Element msg
        , libu : R10.Libu.Type msg
        , theme : R10.Theme.Theme
        }
    -> Element msg
tertiary attrsExtra data =
    R10.Libu.view
        (attrsTertiary data.theme ++ attrsExtra)
        { label = data.label
        , type_ = data.libu
        }


{-| Quaternary Button
-}
quaternary :
    List (Attribute msg)
    ->
        { label : Element msg
        , libu : R10.Libu.Type msg
        , theme : R10.Theme.Theme
        }
    -> Element msg
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
    , R10.FontSize.normal
    ]


attrsPrimary : R10.Theme.Theme -> List (Attribute msg)
attrsPrimary theme =
    attrsInCommon
        ++ [ R10.Color.AttrsBackground.buttonPrimary theme
           , R10.Color.AttrsFont.buttonPrimary theme
           , mouseOver [ R10.Color.AttrsBackground.buttonPrimaryOver theme ]
           , focused [ R10.Color.AttrsBackground.buttonPrimaryOver theme ]
           ]


attrsPrimaryDisabled : R10.Theme.Theme -> List (Attribute msg)
attrsPrimaryDisabled theme =
    attrsInCommon
        ++ [ R10.Color.AttrsBackground.buttonPrimaryDisabled theme
           , R10.Color.AttrsFont.buttonPrimaryDisabled theme
           , mouseOver
                [ R10.Color.AttrsBackground.buttonPrimaryDisabledOver theme
                , R10.Color.AttrsFont.buttonPrimaryDisabledOver theme
                ]
           , focused
                [ R10.Color.AttrsBackground.buttonPrimaryDisabledOver theme
                , R10.Color.AttrsFont.buttonPrimaryDisabledOver theme
                ]
           , htmlAttribute <| Html.Attributes.style "cursor" "not-allowed"
           ]


attrsSecondary : R10.Theme.Theme -> List (Attribute msg)
attrsSecondary theme =
    attrsInCommon
        ++ [ -- Font color is just "normal" so we omit
             R10.Color.AttrsBorder.buttonSecondary theme
           , Border.width 1
           , mouseOver [ R10.Color.AttrsBackground.buttonMinorOver theme ]
           , focused [ R10.Color.AttrsBackground.buttonMinorOver theme ]
           ]


attrsSecondaryDisabled : R10.Theme.Theme -> List (Attribute msg)
attrsSecondaryDisabled theme =
    attrsInCommon
        ++ [ R10.Color.AttrsBackground.buttonPrimaryDisabled theme
           , mouseOver [ R10.Color.AttrsBackground.buttonMinorOver theme ]
           , focused [ R10.Color.AttrsBackground.buttonMinorOver theme ]
           , R10.Color.AttrsBorder.buttonSecondary theme
           , Border.width 1
           , htmlAttribute <| Html.Attributes.style "cursor" "not-allowed"
           ]


attrsTertiary : R10.Theme.Theme -> List (Attribute msg)
attrsTertiary theme =
    [ padding numberPadding
    , width fill
    , mouseOver [ R10.Color.AttrsBackground.buttonMinorOver theme ]
    , focused [ R10.Color.AttrsBackground.buttonMinorOver theme ]
    , transition
    , Border.rounded 5
    , Font.center
    , R10.FontSize.small
    ]


attrsQuaternary : R10.Theme.Theme -> List (Attribute msg)
attrsQuaternary theme =
    [ paddingXY (numberPadding - 4) (numberPadding - 8)
    , mouseOver [ R10.Color.AttrsBackground.buttonMinorOver theme ]
    , focused [ R10.Color.AttrsBackground.buttonMinorOver theme ]
    , transition
    , Border.rounded 5
    , Font.center
    , R10.FontSize.xxsmall
    , R10.Color.AttrsFont.normalLighter theme
    ]



-- SPECIAL CASE FOR CSS BUTTONS


{-| Special case for CSS buttons, useful if a button must be built using the standard Html library instead of `elm-ui`.
-}
cssButtonStyle : R10.Theme.Theme -> String
cssButtonStyle theme =
    let
        primaryColorHex : String
        primaryColorHex =
            theme
                |> R10.Color.Svg.primary
                |> R10.Color.Utils.toCssRgba

        fontOnprimaryColorHex : String
        fontOnprimaryColorHex =
            theme
                |> R10.Color.Svg.fontButtonPrimary
                |> R10.Color.Utils.toCssRgba
    in
    -- Adding -webkit-appearance: none;
    -- because https://stackoverflow.com/questions/5449412/styling-input-buttons-for-ipad-and-iphone
    """
.form.btn {
    color: """ ++ fontOnprimaryColorHex ++ """ !important;
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
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;    
}
/* .btn:hover {
    background-color: #FF1212;
}
*/
    """
