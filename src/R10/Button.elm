module R10.Button exposing
    ( primary, secondary, tertiary, quaternary
    , Data, cssButtonStyle, numberPadding, withLimitedWidth, withId
    )

{-| Buttons!

![Buttons](https://r10.netlify.app/images/buttons300.png)

@docs primary, secondary, tertiary, quaternary


# Others

@docs Data, cssButtonStyle, numberPadding, withLimitedWidth, withId

-}

import Element.WithContext exposing (..)
import Element.WithContext.Border as Border
import Element.WithContext.Font as Font
import Html.Attributes
import R10.Color.AttrsBackground
import R10.Color.AttrsBorder
import R10.Color.AttrsFont
import R10.Color.Svg
import R10.Color.Utils
import R10.Context exposing (..)
import R10.FontSize
import R10.Language
import R10.Libu
import R10.Theme
import R10.Transition


{-| Type of data required by buttons
-}
type alias Data z msg =
    { label : Element (R10.Context.ContextInternal z) msg
    , libu : R10.Libu.Type msg
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
    List (Attribute (R10.Context.ContextInternal z) msg)
    ->
        { label : Element (R10.Context.ContextInternal z) msg
        , libu : R10.Libu.Type msg
        , translation : { a | key : String }
        }
    -> Element (R10.Context.ContextInternal z) msg
primary attrsExtra data =
    let
        id : Attribute context msg
        id =
            htmlAttribute <| Html.Attributes.id ("prim_" ++ data.translation.key)

        attrs : List (Attribute (R10.Context.ContextInternal z) msg)
        attrs =
            if data.libu == R10.Libu.Bu Nothing then
                attrsDisabled

            else
                id :: attrsPrimary
    in
    R10.Libu.view
        (attrs ++ attrsExtra)
        { label = data.label
        , type_ = data.libu
        }


{-| -}
withId : String -> Element (R10.Context.ContextInternal z) msg -> Element (R10.Context.ContextInternal z) msg
withId _ button =
    button


{-| Secondary Button
-}
secondary :
    List (Attribute (R10.Context.ContextInternal z) msg)
    ->
        { label : Element (R10.Context.ContextInternal z) msg
        , libu : R10.Libu.Type msg
        , translation : { a | key : String }
        }
    -> Element (R10.Context.ContextInternal z) msg
secondary attrsExtra data =
    let
        id : Attribute context msg
        id =
            htmlAttribute <| Html.Attributes.id ("seco_" ++ data.translation.key)

        attrs : List (Attribute (R10.Context.ContextInternal z) msg)
        attrs =
            if data.libu == R10.Libu.Bu Nothing then
                attrsDisabled

            else
                id :: attrsSecondary
    in
    R10.Libu.view
        (attrs ++ attrsExtra)
        { label = data.label
        , type_ = data.libu
        }


{-| Tertiary Button
-}
tertiary :
    List (Attribute (R10.Context.ContextInternal z) msg)
    ->
        { label : Element (R10.Context.ContextInternal z) msg
        , libu : R10.Libu.Type msg
        , translation : { a | key : String }
        }
    -> Element (R10.Context.ContextInternal z) msg
tertiary attrsExtra data =
    let
        id : Attribute context msg
        id =
            htmlAttribute <| Html.Attributes.id ("terz_" ++ data.translation.key)

        attrs : List (Attribute (R10.Context.ContextInternal z) msg)
        attrs =
            if data.libu == R10.Libu.Bu Nothing then
                attrsDisabled

            else
                id :: attrsTertiary
    in
    R10.Libu.view
        (attrs ++ attrsExtra)
        { label = data.label
        , type_ = data.libu
        }


{-| Quaternary Button
-}
quaternary :
    List (Attribute (R10.Context.ContextInternal z) msg)
    ->
        { label : Element (R10.Context.ContextInternal z) msg
        , libu : R10.Libu.Type msg
        , translation : { a | key : String }
        }
    -> Element (R10.Context.ContextInternal z) msg
quaternary attrsExtra data =
    let
        id : Attribute context msg
        id =
            htmlAttribute <| Html.Attributes.id ("quat_" ++ data.translation.key)
    in
    R10.Libu.view
        (id :: attrsQuaternary ++ attrsExtra)
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
withLimitedWidth : List (Attribute (R10.Context.ContextInternal z) msg)
withLimitedWidth =
    [ width (fill |> maximum 250)
    , centerX
    ]


transition : Attribute (R10.Context.ContextInternal z) msg
transition =
    R10.Transition.transition "color .2s ease-out, background-color .2s ease-out"


attrsInCommon : List (Attribute (R10.Context.ContextInternal z) msg)
attrsInCommon =
    [ padding numberPadding
    , width fill
    , transition
    , Border.rounded 5
    , Font.center
    , R10.FontSize.normal
    ]


attrsPrimary : List (Attribute (R10.Context.ContextInternal z) msg)
attrsPrimary =
    attrsInCommon
        ++ [ R10.Color.AttrsBackground.buttonPrimary
           , R10.Color.AttrsFont.buttonPrimary
           , mouseOver [ R10.Color.AttrsBackground.buttonPrimaryOver ]
           , focused [ R10.Color.AttrsBackground.buttonPrimaryOver ]
           ]


attrsSecondary : List (Attribute (R10.Context.ContextInternal z) msg)
attrsSecondary =
    attrsInCommon
        ++ [ -- Font color is just "normal" so we omit
             R10.Color.AttrsBorder.buttonSecondary
           , Border.width 1
           , mouseOver [ R10.Color.AttrsBackground.buttonMinorOver ]
           , focused [ R10.Color.AttrsBackground.buttonMinorOver ]
           ]


attrsDisabled : List (Attribute (R10.Context.ContextInternal z) msg)
attrsDisabled =
    attrsInCommon
        ++ [ R10.Color.AttrsBackground.buttonPrimaryDisabled
           , R10.Color.AttrsFont.buttonPrimaryDisabled
           , R10.Color.AttrsBorder.buttonSecondary
           , mouseOver [ R10.Color.AttrsBackground.buttonMinorOver ]
           , focused [ R10.Color.AttrsBackground.buttonMinorOver ]
           , Border.width 1
           , htmlAttribute <| Html.Attributes.style "cursor" "not-allowed"
           ]


attrsTertiary : List (Attribute (R10.Context.ContextInternal z) msg)
attrsTertiary =
    [ padding numberPadding
    , width fill
    , mouseOver [ R10.Color.AttrsBackground.buttonMinorOver ]
    , focused [ R10.Color.AttrsBackground.buttonMinorOver ]
    , transition
    , Border.rounded 5
    , Font.center
    , R10.FontSize.small
    ]


attrsQuaternary : List (Attribute (R10.Context.ContextInternal z) msg)
attrsQuaternary =
    [ paddingXY (numberPadding - 4) (numberPadding - 8)
    , mouseOver [ R10.Color.AttrsBackground.buttonMinorOver ]
    , focused [ R10.Color.AttrsBackground.buttonMinorOver ]
    , transition
    , Border.rounded 5
    , Font.center
    , R10.FontSize.xxsmall
    , R10.Color.AttrsFont.normalLighter
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
                |> R10.Color.Svg.fontHighEmphasisWithMaximumContrast
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
