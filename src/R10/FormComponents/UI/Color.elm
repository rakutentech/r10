module FormComponents.UI.Color exposing
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
import FormComponents.UI.Palette



-- helpers


fromPaletteColor : Color.Color -> Element.Color
fromPaletteColor =
    Color.toRgba >> Element.fromRgb


fromPalette : (FormComponents.UI.Palette.Palette -> Color.Color) -> FormComponents.UI.Palette.Palette -> Element.Color
fromPalette mapper =
    mapper >> fromPaletteColor


toPaletteColor : Element.Color -> Color.Color
toPaletteColor =
    Element.toRgb >> Color.fromRgba


toCssString : Element.Color -> String
toCssString =
    toPaletteColor >> Color.toCssString



-- Palette colors


primary : FormComponents.UI.Palette.Palette -> Element.Color
primary =
    .primary >> fromPaletteColor


primaryVariant : FormComponents.UI.Palette.Palette -> Element.Color
primaryVariant =
    .primaryVariant >> fromPaletteColor


success : FormComponents.UI.Palette.Palette -> Element.Color
success =
    .success >> fromPaletteColor


error : FormComponents.UI.Palette.Palette -> Element.Color
error =
    .error >> fromPaletteColor


onSurface : FormComponents.UI.Palette.Palette -> Element.Color
onSurface =
    .onSurface >> fromPaletteColor


onPrimary : FormComponents.UI.Palette.Palette -> Element.Color
onPrimary =
    .onPrimary >> fromPaletteColor


surface : FormComponents.UI.Palette.Palette -> Element.Color
surface =
    .surface >> fromPaletteColor


background : FormComponents.UI.Palette.Palette -> Element.Color
background =
    .background >> fromPaletteColor



-- Palette colors helpers


primaryA : Float -> FormComponents.UI.Palette.Palette -> Element.Color
primaryA alpha palette =
    palette.primary
        |> FormComponents.UI.Palette.withOpacity alpha
        |> fromPaletteColor


primaryVariantA : Float -> FormComponents.UI.Palette.Palette -> Element.Color
primaryVariantA alpha palette =
    palette.primaryVariant
        |> FormComponents.UI.Palette.withOpacity alpha
        |> fromPaletteColor


successA : Float -> FormComponents.UI.Palette.Palette -> Element.Color
successA alpha palette =
    palette.success
        |> FormComponents.UI.Palette.withOpacity alpha
        |> fromPaletteColor


errorA : Float -> FormComponents.UI.Palette.Palette -> Element.Color
errorA alpha palette =
    palette.error
        |> FormComponents.UI.Palette.withOpacity alpha
        |> fromPaletteColor


onSurfaceA : Float -> FormComponents.UI.Palette.Palette -> Element.Color
onSurfaceA alpha palette =
    palette.onSurface
        |> FormComponents.UI.Palette.withOpacity alpha
        |> fromPaletteColor


onPrimaryA : Float -> FormComponents.UI.Palette.Palette -> Element.Color
onPrimaryA alpha palette =
    palette.onPrimary
        |> FormComponents.UI.Palette.withOpacity alpha
        |> fromPaletteColor


surfaceA : Float -> FormComponents.UI.Palette.Palette -> Element.Color
surfaceA alpha palette =
    palette.surface
        |> FormComponents.UI.Palette.withOpacity alpha
        |> fromPaletteColor


backgroundA : Float -> FormComponents.UI.Palette.Palette -> Element.Color
backgroundA alpha palette =
    palette.background
        |> FormComponents.UI.Palette.withOpacity alpha
        |> fromPaletteColor



-- color aliases


container : FormComponents.UI.Palette.Palette -> Element.Color
container =
    onSurfaceA 0.54


containerA : Float -> FormComponents.UI.Palette.Palette -> Element.Color
containerA alpha =
    onSurfaceA <| 0.54 * alpha


font : FormComponents.UI.Palette.Palette -> Element.Color
font =
    onSurfaceA 0.87


fontA : Float -> FormComponents.UI.Palette.Palette -> Element.Color
fontA alpha =
    onSurfaceA <| 0.87 * alpha


label : FormComponents.UI.Palette.Palette -> Element.Color
label =
    onSurfaceA 0.6


labelA : Float -> FormComponents.UI.Palette.Palette -> Element.Color
labelA alpha =
    onSurfaceA <| 0.6 * alpha


mouseOverSurface : FormComponents.UI.Palette.Palette -> Element.Color
mouseOverSurface =
    -- https://material.io/design/interaction/states.html#hover
    onSurfaceA 0.04


mouseOverPrimary : FormComponents.UI.Palette.Palette -> Element.Color
mouseOverPrimary palette =
    -- https://material.io/design/interaction/states.html#hover
    Color.Blending.overlay (onPrimaryA 0.08 palette |> toPaletteColor) (primary palette |> toPaletteColor)
        |> fromPaletteColor



-- constant colors


transparent : Element.Color
transparent =
    FormComponents.UI.Palette.black
        |> FormComponents.UI.Palette.withOpacity 0
        |> fromPaletteColor
