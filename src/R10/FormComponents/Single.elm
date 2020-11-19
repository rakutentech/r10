module FormComponents.Single exposing
    ( defaultSearchFn
    , defaultToOptionEl
    , defaultTrailingIcon
    , extraCss
    , insertBold
    , normalizeString
    , view
    , viewCustom
    )

import Element exposing (..)
import Element.Background as Background
import FormComponents.IconButton
import FormComponents.Single.Combobox
import FormComponents.Single.Common as Common
import FormComponents.Single.Radio
import FormComponents.Single.Update
import FormComponents.Style
import FormComponents.UI
import FormComponents.UI.Color
import FormComponents.UI.Palette
import FormComponents.Utils
import FormComponents.Utils.SimpleMarkdown
import FormComponents.Validations
import Html.Attributes
import String.Extra



-- todo implement disabled style
-- todo implement custom logic for Radio (remove Input.Radio due to lack of customization. eg cannot apply disabled style)
-- About best UX for Radio Buttons:
-- https://uxplanet.org/radio-buttons-ux-design-588e5c0a50dc
-- constants


extraCss : String
extraCss =
    ""


defaultSearchFn : String -> Common.FieldOption -> Bool
defaultSearchFn search opt =
    String.contains
        (search |> normalizeString)
        (opt.label |> normalizeString)


defaultToOptionEl : { a | search : String, msgOnSelect : String -> msg } -> Common.FieldOption -> Element msg
defaultToOptionEl { search, msgOnSelect } { label, value } =
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
        , FormComponents.UI.onClickWithStopPropagation <| msgOnSelect value
        , htmlAttribute <| Html.Attributes.style "z-index" "0"
        , pointer
        , paddingXY 12 0

        -- gradient for label overflow
        , htmlAttribute <| Html.Attributes.style "mask-image" "linear-gradient(right, rgba(255,255,0,0), rgba(255,255,0, 1) 16px)"
        , htmlAttribute <| Html.Attributes.style "-webkit-mask-image" "-webkit-linear-gradient(right, rgba(255,255,0,0) 10px, rgba(255,255,0, 1) 16px)"
        ]
        (withBold |> FormComponents.Utils.SimpleMarkdown.elementMarkdown)


defaultTrailingIcon : { a | opened : Bool, palette : FormComponents.UI.Palette.Palette } -> Element msg
defaultTrailingIcon { opened, palette } =
    FormComponents.IconButton.view []
        { msgOnClick = Nothing
        , icon =
            el
                [ rotate <|
                    degrees
                        (if opened then
                            180

                         else
                            0
                        )
                , htmlAttribute <| Html.Attributes.style "transition" "all 0.13s"
                ]
            <|
                html <|
                    FormComponents.UI.icons.combobox_arrow_
                        (FormComponents.UI.Color.label palette |> FormComponents.UI.Color.toCssString)
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
        |> FormComponents.Utils.stringInsertAtMulti "**" indexes
        |> String.Extra.surround "**"


update : Common.Msg -> Common.Model -> ( Common.Model, Cmd Common.Msg )
update =
    FormComponents.Single.Update.update


view :
    List (Attribute msg)
    -- Shared.Args msg - without [toOptionEl, searchFn]
    -> Common.Model
    ->
        { label : String
        , helperText : Maybe String
        , disabled : Bool
        , requiredLabel : Maybe String
        , key : String
        , style : FormComponents.Style.Style
        , palette : FormComponents.UI.Palette.Palette
        , singleType : Common.TypeSingle
        , fieldOptions : List Common.FieldOption
        , validation : FormComponents.Validations.Validation
        , toMsg : Common.Msg -> msg
        }
    -> Element msg
view attrs model conf =
    let
        args : Common.Args msg
        args =
            { validation = conf.validation
            , toMsg = conf.toMsg
            , label = conf.label
            , helperText = conf.helperText
            , disabled = conf.disabled
            , requiredLabel = conf.requiredLabel
            , style = conf.style
            , key = conf.key
            , palette = conf.palette
            , singleType = conf.singleType
            , fieldOptions = conf.fieldOptions
            , searchFn = defaultSearchFn
            , toOptionEl =
                defaultToOptionEl
                    { search = model.search
                    , msgOnSelect = Common.OnOptionSelect >> conf.toMsg
                    }
            , selectOptionHeight = 36
            , maxDisplayCount = 5
            , leadingIcon = Nothing
            , trailingIcon = Just <| defaultTrailingIcon { opened = model.opened, palette = conf.palette }
            }
    in
    case args.singleType of
        Common.SingleCombobox ->
            FormComponents.Single.Combobox.view attrs model args

        Common.SingleRadio ->
            FormComponents.Single.Radio.viewRadio attrs model args


viewCustom :
    List (Attribute msg)
    -- Shared.Args msg - without [toOptionEl, searchFn]
    -> Common.Model
    ->
        { label : String
        , helperText : Maybe String
        , disabled : Bool
        , requiredLabel : Maybe String
        , key : String
        , style : FormComponents.Style.Style
        , palette : FormComponents.UI.Palette.Palette
        , singleType : Common.TypeSingle
        , fieldOptions : List Common.FieldOption
        , validation : FormComponents.Validations.Validation
        , toMsg : Common.Msg -> msg
        , searchFn : String -> Common.FieldOption -> Bool
        , toOptionEl : Common.FieldOption -> Element msg
        , selectOptionHeight : Int
        , maxDisplayCount : Int
        , leadingIcon : Maybe (Element msg)
        , trailingIcon : Maybe (Element msg)
        }
    -> Element msg
viewCustom attrs model conf =
    let
        args : Common.Args msg
        args =
            { validation = conf.validation
            , toMsg = conf.toMsg
            , label = conf.label
            , helperText = conf.helperText
            , disabled = conf.disabled
            , requiredLabel = conf.requiredLabel
            , style = conf.style
            , key = conf.key
            , palette = conf.palette
            , singleType = conf.singleType
            , fieldOptions = conf.fieldOptions
            , searchFn = conf.searchFn
            , toOptionEl = conf.toOptionEl
            , selectOptionHeight = conf.selectOptionHeight
            , maxDisplayCount = conf.maxDisplayCount
            , leadingIcon = conf.leadingIcon
            , trailingIcon = conf.trailingIcon
            }
    in
    case args.singleType of
        Common.SingleCombobox ->
            FormComponents.Single.Combobox.view attrs model args

        Common.SingleRadio ->
            FormComponents.Single.Radio.viewRadio attrs model args
