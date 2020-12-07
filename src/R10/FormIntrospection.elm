module R10.FormIntrospection exposing (textTypeMetaData, binaryTypeMetaData, singleTypeMetaData)

{-| Only used for form debuggin

@docs textTypeMetaData, binaryTypeMetaData, singleTypeMetaData

-}

import R10.FormTypes


{-| -}
textTypeMetaData :
    R10.FormTypes.TypeText
    -> { next : R10.FormTypes.TypeText, string : String }
textTypeMetaData textType =
    case textType of
        R10.FormTypes.TextPasswordNew ->
            { string = "R10.FormTypes.TextPasswordNew"
            , next = R10.FormTypes.TextPasswordCurrent
            }

        R10.FormTypes.TextPasswordCurrent ->
            { string = "R10.FormTypes.TextPasswordCurrent"
            , next = R10.FormTypes.TextPlain
            }

        R10.FormTypes.TextPlain ->
            { string = "R10.FormTypes.TextPlain"
            , next = R10.FormTypes.TextEmail
            }

        R10.FormTypes.TextEmail ->
            { string = "R10.FormTypes.TextEmail"
            , next = R10.FormTypes.TextUsername
            }

        R10.FormTypes.TextUsername ->
            { string = "R10.FormTypes.TextUsername"
            , next = R10.FormTypes.TextMultiline
            }

        R10.FormTypes.TextMultiline ->
            { string = "R10.FormTypes.TextMultiline"
            , next = R10.FormTypes.TextWithPattern "YY/MMMM"
            }

        R10.FormTypes.TextWithPattern pattern ->
            { string = "R10.FormTypes.TextWithPattern " ++ pattern
            , next = R10.FormTypes.TextPasswordNew
            }


{-| -}
binaryTypeMetaData :
    R10.FormTypes.TypeBinary
    -> { next : R10.FormTypes.TypeBinary, string : String }
binaryTypeMetaData textType =
    case textType of
        R10.FormTypes.BinaryCheckbox ->
            { string = "R10.FormTypes.BinaryCheckbox"
            , next = R10.FormTypes.BinarySwitch
            }

        R10.FormTypes.BinarySwitch ->
            { string = "R10.FormTypes.BinarySwitch"
            , next = R10.FormTypes.BinaryCheckbox
            }


{-| -}
singleTypeMetaData :
    R10.FormTypes.TypeSingle
    -> { next : R10.FormTypes.TypeSingle, string : String }
singleTypeMetaData singleType =
    case singleType of
        R10.FormTypes.SingleRadio ->
            { string = "R10.FormTypes.SingleRadio"
            , next = R10.FormTypes.SingleCombobox
            }

        R10.FormTypes.SingleCombobox ->
            { string = "R10.FormTypes.SingleCombobox"
            , next = R10.FormTypes.SingleRadio
            }
