module R10.FormComponents.Internal.Single exposing
    ( Args
    , ArgsCustom
    , defaultSearchFn
    , defaultTrailingIcon
    , defaultViewOptionEl
    , extraCss
    , insertBold
    , normalizeString
    , view
    , viewCustom
    )

import Element exposing (..)
import Element.Events as Events
import Html.Attributes
import R10.Color.Utils
import R10.FormComponents.Internal.IconButton
import R10.FormComponents.Internal.Single.Combobox
import R10.FormComponents.Internal.Single.Common
import R10.FormComponents.Internal.Single.Radio
import R10.FormComponents.Internal.Single.Update
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.Utils
import R10.FormTypes
import R10.SimpleMarkdown
import String.Extra



-- todo implement disabled style
-- todo implement custom logic for Radio (remove Input.Radio due to lack of customization. eg cannot apply disabled style)
-- About best UX for Radio Buttons:
-- https://uxplanet.org/radio-buttons-ux-design-588e5c0a50dc
-- constants


extraCss : String
extraCss =
    ""


defaultSearchFn : String -> R10.FormComponents.Internal.Single.Common.FieldOption -> Bool
defaultSearchFn search opt =
    String.contains
        (search |> normalizeString)
        (opt.label |> normalizeString)


defaultViewOptionEl : { a | search : String, msgOnSelect : String -> msg } -> R10.FormComponents.Internal.Single.Common.FieldOption -> Element msg
defaultViewOptionEl { search, msgOnSelect } { label, value } =
    let
        insertPositions : List Int
        insertPositions =
            String.indexes (search |> normalizeString) (label |> normalizeString)
                |> List.concatMap (\idx -> [ idx, idx + String.length search ])

        withBold : String
        withBold =
            if List.isEmpty insertPositions then
                label

            else
                insertBold insertPositions label
    in
    row
        [ width fill
        , height fill
        , htmlAttribute <| Html.Attributes.style "z-index" "0"
        , Events.onClick <| msgOnSelect value
        , pointer
        , paddingXY 12 0

        -- gradient for label overflow
        , htmlAttribute <| Html.Attributes.style "mask-image" "linear-gradient(right, rgba(255,255,0,0), rgba(255,255,0, 1) 16px)"
        , htmlAttribute <| Html.Attributes.style "-webkit-mask-image" "-webkit-linear-gradient(right, rgba(255,255,0,0) 10px, rgba(255,255,0, 1) 16px)"
        ]
        (withBold |> R10.SimpleMarkdown.elementMarkdown)


defaultTrailingIcon : { a | opened : Bool, palette : R10.FormTypes.Palette } -> Element msg
defaultTrailingIcon { opened, palette } =
    R10.FormComponents.Internal.IconButton.view
        [ pointer ]
        { msgOnClick = Nothing
        , icon =
            R10.FormComponents.Internal.UI.icons.combobox_arrow
                [ rotate <|
                    degrees
                        (if opened then
                            180

                         else
                            0
                        )
                , htmlAttribute <| Html.Attributes.style "transition" "all 0.13s"
                ]
                (R10.FormComponents.Internal.UI.Color.label palette)
                24
        , palette = palette
        , size = 24
        }



--helpers Public


normalizeString : String -> String
normalizeString =
    -- use for filtering, search <-> label comparison
    String.toLower >> String.trim


insertBold : List Int -> String -> String
insertBold indexes string =
    string
        |> R10.FormComponents.Internal.Utils.stringInsertAtMulti "**" indexes


update : R10.FormComponents.Internal.Single.Common.Msg -> R10.FormComponents.Internal.Single.Common.Model -> ( R10.FormComponents.Internal.Single.Common.Model, Cmd R10.FormComponents.Internal.Single.Common.Msg )
update =
    R10.FormComponents.Internal.Single.Update.update


type alias Args msg =
    { label : String
    , helperText : Maybe String
    , disabled : Bool
    , requiredLabel : Maybe String
    , key : String
    , style : R10.FormComponents.Internal.Style.Style
    , palette : R10.FormTypes.Palette
    , singleType : R10.FormTypes.TypeSingle
    , fieldOptions : List R10.FormComponents.Internal.Single.Common.FieldOption
    , valid : Maybe Bool
    , toMsg : R10.FormComponents.Internal.Single.Common.Msg -> msg
    }


view :
    List (Attribute msg)
    -- Shared.Args msg - without [toOptionEl, searchFn]
    -> R10.FormComponents.Internal.Single.Common.Model
    -> Args msg
    -> Element msg
view attrs model conf =
    let
        args : R10.FormComponents.Internal.Single.Common.Args msg
        args =
            { valid = conf.valid
            , toMsg = conf.toMsg
            , label = conf.label
            , helperText = conf.helperText
            , disabled = conf.disabled
            , requiredLabel = conf.requiredLabel
            , style = conf.style
            , key = conf.key
            , palette = conf.palette
            , searchable = False
            , singleType = conf.singleType
            , fieldOptions = conf.fieldOptions
            , viewOptionEl =
                defaultViewOptionEl
                    { search = model.search
                    , msgOnSelect = R10.FormComponents.Internal.Single.Common.OnOptionSelect >> conf.toMsg
                    }
            , searchFn = defaultSearchFn
            , selectOptionHeight = 32
            , maxDisplayCount = 3
            , leadingIcon = Nothing
            , trailingIcon = Just <| defaultTrailingIcon { opened = model.opened, palette = conf.palette }
            }
    in
    case args.singleType of
        R10.FormTypes.SingleCombobox ->
            R10.FormComponents.Internal.Single.Combobox.view attrs model { args | searchable = True }

        R10.FormTypes.SingleSelect ->
            R10.FormComponents.Internal.Single.Combobox.view attrs model { args | searchable = False }

        R10.FormTypes.SingleRadio ->
            R10.FormComponents.Internal.Single.Radio.view attrs model args

        R10.FormTypes.SingleRadioRow ->
            R10.FormComponents.Internal.Single.Radio.viewRow attrs model args


type alias ArgsCustom msg =
    { label : String
    , helperText : Maybe String
    , requiredLabel : Maybe String
    , disabled : Bool
    , key : String
    , style : R10.FormComponents.Internal.Style.Style
    , palette : R10.FormTypes.Palette
    , singleType : R10.FormTypes.TypeSingle
    , fieldOptions : List R10.FormComponents.Internal.Single.Common.FieldOption
    , valid : Maybe Bool
    , toMsg : R10.FormComponents.Internal.Single.Common.Msg -> msg
    , searchFn : String -> R10.FormComponents.Internal.Single.Common.FieldOption -> Bool
    , viewOptionEl : R10.FormComponents.Internal.Single.Common.FieldOption -> Element msg
    , selectOptionHeight : Int
    , maxDisplayCount : Int
    , leadingIcon : Maybe (Element msg)
    , trailingIcon : Maybe (Element msg)
    }


viewCustom :
    List (Attribute msg)
    -> R10.FormComponents.Internal.Single.Common.Model
    -> ArgsCustom msg
    -> Element msg
viewCustom attrs model conf =
    let
        args : R10.FormComponents.Internal.Single.Common.Args msg
        args =
            { valid = conf.valid
            , toMsg = conf.toMsg
            , label = conf.label
            , helperText = conf.helperText
            , disabled = conf.disabled
            , requiredLabel = conf.requiredLabel
            , style = conf.style
            , key = conf.key
            , palette = conf.palette
            , searchable = False
            , searchFn = conf.searchFn
            , singleType = conf.singleType
            , fieldOptions = conf.fieldOptions
            , viewOptionEl = conf.viewOptionEl
            , selectOptionHeight = conf.selectOptionHeight
            , maxDisplayCount = conf.maxDisplayCount
            , leadingIcon = conf.leadingIcon
            , trailingIcon = conf.trailingIcon
            }
    in
    case args.singleType of
        R10.FormTypes.SingleCombobox ->
            R10.FormComponents.Internal.Single.Combobox.view attrs model { args | searchable = True }

        R10.FormTypes.SingleSelect ->
            R10.FormComponents.Internal.Single.Combobox.view attrs model { args | searchable = False }

        R10.FormTypes.SingleRadio ->
            R10.FormComponents.Internal.Single.Radio.view attrs model args

        R10.FormTypes.SingleRadioRow ->
            R10.FormComponents.Internal.Single.Radio.viewRow attrs model args
