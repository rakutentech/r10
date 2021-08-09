module R10.FormComponents.Internal.UI.Color exposing
    ( background
    , border
    , borderA
    , container
    , containerA
    , error
    , errorA
    , font
    , fontA
    , fromPalette
    , fromPaletteColor
    , label
    , labelA
    , mouseOverPrimary
    , mouseOverSurface
    , onPrimary
    , onPrimaryA
    , onSurface
    , onSurfaceA
    , primary
    , primaryA
    , primaryVariant
    , primaryVariantA
    , success
    , successA
    , surface
    , surfaceA
    , toCssString
    , transparent
    )

import Color
import Color.Blending
import Element.WithContext exposing (..)
import R10.FormComponents.Internal.UI.Palette
import R10.FormTypes
import R10.Context exposing (..)



-- helpers


fromPaletteColor : Color.Color -> Color
fromPaletteColor =
    Color.toRgba >> fromRgb


fromPalette : (R10.FormTypes.Palette -> Color.Color) -> R10.FormTypes.Palette -> Color
fromPalette mapper =
    mapper >> fromPaletteColor


toPaletteColor : Color -> Color.Color
toPaletteColor =
    toRgb >> Color.fromRgba


toCssString : Color -> String
toCssString =
    toPaletteColor >> Color.toCssString



-- Palette colors


primary : R10.FormTypes.Palette -> Color
primary =
    .primary >> fromPaletteColor


primaryVariant : R10.FormTypes.Palette -> Color
primaryVariant =
    .primaryVariant >> fromPaletteColor


success : R10.FormTypes.Palette -> Color
success =
    .success >> fromPaletteColor


error : R10.FormTypes.Palette -> Color
error =
    .error >> fromPaletteColor


onSurface : R10.FormTypes.Palette -> Color
onSurface =
    .onSurface >> fromPaletteColor


onPrimary : R10.FormTypes.Palette -> Color
onPrimary =
    .onPrimary >> fromPaletteColor


surface : R10.FormTypes.Palette -> Color
surface =
    .surface >> fromPaletteColor


background : R10.FormTypes.Palette -> Color
background =
    .background >> fromPaletteColor



-- Palette colors helpers


primaryA : Float -> R10.FormTypes.Palette -> Color
primaryA alpha palette =
    palette.primary
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


primaryVariantA : Float -> R10.FormTypes.Palette -> Color
primaryVariantA alpha palette =
    palette.primaryVariant
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


successA : Float -> R10.FormTypes.Palette -> Color
successA alpha palette =
    palette.success
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


errorA : Float -> R10.FormTypes.Palette -> Color
errorA alpha palette =
    palette.error
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


onSurfaceA : Float -> R10.FormTypes.Palette -> Color
onSurfaceA alpha palette =
    palette.onSurface
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


onPrimaryA : Float -> R10.FormTypes.Palette -> Color
onPrimaryA alpha palette =
    palette.onPrimary
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


surfaceA : Float -> R10.FormTypes.Palette -> Color
surfaceA alpha palette =
    palette.surface
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


backgroundA : Float -> R10.FormTypes.Palette -> Color
backgroundA alpha palette =
    palette.background
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor



-- color aliases


container : R10.FormTypes.Palette -> Color
container =
    onSurfaceA 0.54


containerA : Float -> R10.FormTypes.Palette -> Color
containerA alpha =
    onSurfaceA <| 0.54 * alpha


font : R10.FormTypes.Palette -> Color
font =
    onSurfaceA 0.87


fontA : Float -> R10.FormTypes.Palette -> Color
fontA alpha =
    onSurfaceA <| 0.87 * alpha


label : R10.FormTypes.Palette -> Color
label =
    -- TODO(This is a temporary fix for OMNI (The label color is too light))
    onSurfaceA 1


labelA : Float -> R10.FormTypes.Palette -> Color
labelA alpha =
    -- TODO(This is a temporary fix for OMNI)
    onSurfaceA <| 1 * alpha


mouseOverSurface : R10.FormTypes.Palette -> Color
mouseOverSurface =
    -- https://material.io/design/interaction/states.html#hover
    onSurfaceA 0.04


mouseOverPrimary : R10.FormTypes.Palette -> Color
mouseOverPrimary palette =
    -- https://material.io/design/interaction/states.html#hover
    Color.Blending.overlay (onPrimaryA 0.08 palette |> toPaletteColor) (primary palette |> toPaletteColor)
        |> fromPaletteColor



-- constant colors


transparent : Color
transparent =
    R10.FormComponents.Internal.UI.Palette.black
        |> R10.FormComponents.Internal.UI.Palette.withOpacity 0
        |> fromPaletteColor



-- border


border : R10.FormTypes.Palette -> Color
border palette =
    palette.border
        |> fromPaletteColor


borderA : Float -> R10.FormTypes.Palette -> Color
borderA alpha palette =
    palette.border
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor
