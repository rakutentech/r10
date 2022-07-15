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

import Element.WithContext exposing (..)
import Element.WithContext.Events as Events
import Html.Attributes
import R10.Context exposing (..)
import R10.FormComponents.Internal.IconButton
import R10.FormComponents.Internal.Single.Combobox
import R10.FormComponents.Internal.Single.Common
import R10.FormComponents.Internal.Single.Radio
import R10.FormComponents.Internal.Style
import R10.FormComponents.Internal.UI
import R10.FormComponents.Internal.UI.Color
import R10.FormComponents.Internal.Utils
import R10.FormTypes
import R10.Palette
import R10.SimpleMarkdown
import R10.Transition



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


defaultViewOptionEl : { a | search : String, msgOnSelect : String -> msg } -> R10.FormComponents.Internal.Single.Common.FieldOption -> Element (R10.Context.ContextInternal z) msg
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


defaultTrailingIcon : { a | opened : Bool, palette : R10.Palette.Palette } -> Element (R10.Context.ContextInternal z) msg
defaultTrailingIcon { opened, palette } =
    R10.FormComponents.Internal.IconButton.view
        [ pointer
        ]
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
                , R10.Transition.transition "all 0.2s"
                ]
                (R10.FormComponents.Internal.UI.Color.label palette)
                24
        , palette = palette
        , size = 24
        }


viewOptionElForCountry : { a | search : String, msgOnSelect : String -> msg } -> R10.FormComponents.Internal.Single.Common.FieldOption -> Element (R10.Context.ContextInternal z) msg
viewOptionElForCountry { search, msgOnSelect } { label, value } =
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
        [ R10.FormComponents.Internal.Utils.getFlagIcon value
        , row [ moveRight 10 ] (withBold |> R10.SimpleMarkdown.elementMarkdown)
        ]



--helpers Public


normalizeString : String -> String
normalizeString =
    -- use for filtering, search <-> label comparison
    String.toLower >> String.trim


insertBold : List Int -> String -> String
insertBold indexes string =
    string
        |> R10.FormComponents.Internal.Utils.stringInsertAtMulti "**" indexes


type alias Args msg =
    { label : String
    , helperText : Maybe String
    , disabled : Bool
    , requiredLabel : Maybe String
    , key : String
    , style : R10.FormComponents.Internal.Style.Style
    , palette : R10.Palette.Palette
    , singleType : R10.FormTypes.TypeSingle
    , fieldOptions : List R10.FormComponents.Internal.Single.Common.FieldOption
    , maybeValid : Maybe Bool
    , toMsg : R10.FormComponents.Internal.Single.Common.Msg -> msg
    }


view :
    List (Attribute (R10.Context.ContextInternal z) msg)
    -> R10.FormComponents.Internal.Single.Common.Model
    -> Args msg
    -> Element (R10.Context.ContextInternal z) msg
view attrs model conf =
    let
        args : R10.FormComponents.Internal.Single.Common.Args z msg
        args =
            { maybeValid = conf.maybeValid
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
            , leadingIcon = []

            -- , trailingIcon = [ defaultTrailingIcon { opened = model.opened, palette = conf.palette } ]
            , trailingIcon = []
            , autocomplete = Nothing
            }

        argsForCountryPicker : R10.FormComponents.Internal.Single.Common.Args z msg
        argsForCountryPicker =
            { args
                | searchable = True
                , leadingIcon =
                    if String.isEmpty model.value then
                        []

                    else
                        [ el [ moveRight 19, moveDown 3 ] <| R10.FormComponents.Internal.Utils.getFlagIcon model.value ]
                , viewOptionEl =
                    viewOptionElForCountry
                        { search = model.search
                        , msgOnSelect = R10.FormComponents.Internal.Single.Common.OnOptionSelect >> conf.toMsg
                        }
            }

        attrsForCountryPicker : List (Attribute (R10.Context.ContextInternal z) msg)
        attrsForCountryPicker =
            attrs ++ [ moveRight 10 ]
    in
    case args.singleType of
        R10.FormTypes.SingleCombobox ->
            R10.FormComponents.Internal.Single.Combobox.view attrs model { args | searchable = True }

        R10.FormTypes.SingleComboboxForCountry ->
            R10.FormComponents.Internal.Single.Combobox.view
                attrsForCountryPicker
                model
                argsForCountryPicker

        R10.FormTypes.SingleSelect ->
            R10.FormComponents.Internal.Single.Combobox.view attrs model { args | searchable = False }

        R10.FormTypes.SingleRadio ->
            R10.FormComponents.Internal.Single.Radio.view attrs model args

        R10.FormTypes.SingleRadioRow ->
            R10.FormComponents.Internal.Single.Radio.viewRow attrs model args


type alias ArgsCustom z msg =
    { label : String
    , helperText : Maybe String
    , requiredLabel : Maybe String
    , disabled : Bool
    , key : String
    , style : R10.FormComponents.Internal.Style.Style
    , palette : R10.Palette.Palette
    , singleType : R10.FormTypes.TypeSingle
    , fieldOptions : List R10.FormComponents.Internal.Single.Common.FieldOption
    , maybeValid : Maybe Bool
    , toMsg : R10.FormComponents.Internal.Single.Common.Msg -> msg
    , searchFn : String -> R10.FormComponents.Internal.Single.Common.FieldOption -> Bool
    , viewOptionEl : R10.FormComponents.Internal.Single.Common.FieldOption -> Element (R10.Context.ContextInternal z) msg
    , selectOptionHeight : Int
    , maxDisplayCount : Int
    , leadingIcon : List (Element (R10.Context.ContextInternal z) msg)
    , trailingIcon : List (Element (R10.Context.ContextInternal z) msg)
    }


viewCustom :
    List (Attribute (R10.Context.ContextInternal z) msg)
    -> R10.FormComponents.Internal.Single.Common.Model
    -> ArgsCustom z msg
    -> Element (R10.Context.ContextInternal z) msg
viewCustom attrs model args =
    let
        args_ : R10.FormComponents.Internal.Single.Common.Args z msg
        args_ =
            { maybeValid = args.maybeValid
            , toMsg = args.toMsg
            , label = args.label
            , helperText = args.helperText
            , disabled = args.disabled
            , requiredLabel = args.requiredLabel
            , style = args.style
            , key = args.key
            , palette = args.palette
            , searchable = False
            , searchFn = args.searchFn
            , singleType = args.singleType
            , fieldOptions = args.fieldOptions
            , viewOptionEl = args.viewOptionEl
            , selectOptionHeight = args.selectOptionHeight
            , maxDisplayCount = args.maxDisplayCount
            , leadingIcon = args.leadingIcon
            , trailingIcon = args.trailingIcon
            , autocomplete = Nothing
            }
    in
    case args.singleType of
        R10.FormTypes.SingleCombobox ->
            R10.FormComponents.Internal.Single.Combobox.view attrs model { args_ | searchable = True }

        R10.FormTypes.SingleComboboxForCountry ->
            R10.FormComponents.Internal.Single.Combobox.view attrs model { args_ | searchable = True }

        R10.FormTypes.SingleSelect ->
            R10.FormComponents.Internal.Single.Combobox.view attrs model { args_ | searchable = False }

        R10.FormTypes.SingleRadio ->
            R10.FormComponents.Internal.Single.Radio.view attrs model args_

        R10.FormTypes.SingleRadioRow ->
            R10.FormComponents.Internal.Single.Radio.viewRow attrs model args_
