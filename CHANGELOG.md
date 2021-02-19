# 3.0.0 (2021-02-19)

## Release Highlights

* Updates color system, making Element.Color the default color.
* Add single radio row.

## Differences

This is a MAJOR change.

---- R10.Color.Svg - MAJOR ----

    Added:
        fontHighEmphasis : R10.Theme.Theme -> Element.Color
        fontMediumEmphasis : R10.Theme.Theme -> Element.Color

    Removed:
        fontNormal : Theme -> Color
        logoHex : Theme -> Color
        mediumEmphasis : Theme -> Color


---- R10.Color.Utils - MAJOR ----

    Added:
        fromColorColor : Color.Color -> Element.Color
        fromHexToColorColor : String.String -> Color.Color
        toColorColor : Element.Color -> Color.Color
        toCssRgba : Element.Color -> String.String

    Removed:
        colorToElementColor : Color -> Color
        elementColorToColor : Color -> Color
        toHex : Color -> String


---- R10.Form - MINOR ----

    Added:
        type alias TextArgs msg = R10.FormComponents.Internal.Text.Args msg
        textView :
            List.List (Element.Attribute msg)
            -> List.List (Element.Attribute msg)
            -> R10.FormComponents.Internal.Text.Args msg
            -> Element.Element msg


---- R10.FormTypes - MAJOR ----

    Changed:
      - type TypeSingle  = SingleRadio | SingleCombobox | SingleSelect
      + type TypeSingle
            = SingleRadio
            | SingleRadioRow
            | SingleCombobox
            | SingleSelect

      - inputField :
            { binaryCheckbox : FieldType
            , binarySwitch : FieldType
            , multiCombobox : List FieldOption -> FieldType
            , singleCombobox : List FieldOption -> FieldType
            , singleSelect : List FieldOption -> FieldType
            , singleRadio : List FieldOption -> FieldType
            , textEmail : FieldType
            , textMultiline : FieldType
            , textPasswordCurrent : FieldType
            , textPasswordNew : FieldType
            , textPlain : FieldType
            , textUsername : FieldType
            , textWithPattern : String -> FieldType
            }
      + inputField :
            { binaryCheckbox : R10.FormTypes.FieldType
            , binarySwitch : R10.FormTypes.FieldType
            , multiCombobox :
                  List.List R10.FormTypes.FieldOption -> R10.FormTypes.FieldType
            , singleCombobox :
                  List.List R10.FormTypes.FieldOption -> R10.FormTypes.FieldType
            , singleSelect :
                  List.List R10.FormTypes.FieldOption -> R10.FormTypes.FieldType
            , singleRadio :
                  List.List R10.FormTypes.FieldOption -> R10.FormTypes.FieldType
            , singleRadioRow :
                  List.List R10.FormTypes.FieldOption -> R10.FormTypes.FieldType
            , textEmail : R10.FormTypes.FieldType
            , textMultiline : R10.FormTypes.FieldType
            , textPasswordCurrent : R10.FormTypes.FieldType
            , textPasswordNew : R10.FormTypes.FieldType
            , textPlain : R10.FormTypes.FieldType
            , textUsername : R10.FormTypes.FieldType
            , textWithPattern : String.String -> R10.FormTypes.FieldType
            }



---- R10.Svg.IconsExtra - MINOR ----

    Added:
        copy :
            List.List (Element.Attribute msg)
            -> Element.Color
            -> Basics.Int
            -> Element.Element msg