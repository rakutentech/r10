module R10.FormComponents.Internal.UI.Color exposing
    ( background
    , backgroundA
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
import Element
import R10.FormComponents.Internal.UI.Palette
import R10.FormTypes



-- helpers


fromPaletteColor : Color.Color -> Element.Color
fromPaletteColor =
    Color.toRgba >> Element.fromRgb


fromPalette : (R10.FormTypes.Palette -> Color.Color) -> R10.FormTypes.Palette -> Element.Color
fromPalette mapper =
    mapper >> fromPaletteColor


toPaletteColor : Element.Color -> Color.Color
toPaletteColor =
    Element.toRgb >> Color.fromRgba


toCssString : Element.Color -> String
toCssString =
    toPaletteColor >> Color.toCssString



-- Palette colors


primary : R10.FormTypes.Palette -> Element.Color
primary =
    .primary >> fromPaletteColor


primaryVariant : R10.FormTypes.Palette -> Element.Color
primaryVariant =
    .primaryVariant >> fromPaletteColor


success : R10.FormTypes.Palette -> Element.Color
success =
    .success >> fromPaletteColor


error : R10.FormTypes.Palette -> Element.Color
error =
    .error >> fromPaletteColor


onSurface : R10.FormTypes.Palette -> Element.Color
onSurface =
    .onSurface >> fromPaletteColor


onPrimary : R10.FormTypes.Palette -> Element.Color
onPrimary =
    .onPrimary >> fromPaletteColor


surface : R10.FormTypes.Palette -> Element.Color
surface =
    .surface >> fromPaletteColor


background : R10.FormTypes.Palette -> Element.Color
background =
    .background >> fromPaletteColor



-- Palette colors helpers


primaryA : Float -> R10.FormTypes.Palette -> Element.Color
primaryA alpha palette =
    palette.primary
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


primaryVariantA : Float -> R10.FormTypes.Palette -> Element.Color
primaryVariantA alpha palette =
    palette.primaryVariant
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


successA : Float -> R10.FormTypes.Palette -> Element.Color
successA alpha palette =
    palette.success
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


errorA : Float -> R10.FormTypes.Palette -> Element.Color
errorA alpha palette =
    palette.error
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


onSurfaceA : Float -> R10.FormTypes.Palette -> Element.Color
onSurfaceA alpha palette =
    palette.onSurface
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


onPrimaryA : Float -> R10.FormTypes.Palette -> Element.Color
onPrimaryA alpha palette =
    palette.onPrimary
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


surfaceA : Float -> R10.FormTypes.Palette -> Element.Color
surfaceA alpha palette =
    palette.surface
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor


backgroundA : Float -> R10.FormTypes.Palette -> Element.Color
backgroundA alpha palette =
    palette.background
        |> R10.FormComponents.Internal.UI.Palette.withOpacity alpha
        |> fromPaletteColor



-- color aliases


container : R10.FormTypes.Palette -> Element.Color
container =
    onSurfaceA 0.54


containerA : Float -> R10.FormTypes.Palette -> Element.Color
containerA alpha =
    onSurfaceA <| 0.54 * alpha


font : R10.FormTypes.Palette -> Element.Color
font =
    onSurfaceA 0.87


fontA : Float -> R10.FormTypes.Palette -> Element.Color
fontA alpha =
    onSurfaceA <| 0.87 * alpha


label : R10.FormTypes.Palette -> Element.Color
label =
    onSurfaceA 0.6


labelA : Float -> R10.FormTypes.Palette -> Element.Color
labelA alpha =
    onSurfaceA <| 0.6 * alpha


mouseOverSurface : R10.FormTypes.Palette -> Element.Color
mouseOverSurface =
    -- https://material.io/design/interaction/states.html#hover
    onSurfaceA 0.04


mouseOverPrimary : R10.FormTypes.Palette -> Element.Color
mouseOverPrimary palette =
    -- https://material.io/design/interaction/states.html#hover
    Color.Blending.overlay (onPrimaryA 0.08 palette |> toPaletteColor) (primary palette |> toPaletteColor)
        |> fromPaletteColor



-- constant colors


transparent : Element.Color
transparent =
    R10.FormComponents.Internal.UI.Palette.black
        |> R10.FormComponents.Internal.UI.Palette.withOpacity 0
        |> fromPaletteColor
