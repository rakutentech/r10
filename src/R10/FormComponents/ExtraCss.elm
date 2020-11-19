module R10.FormComponents.ExtraCss exposing (extraCss)

import Element
import R10.FormComponents.Single
import R10.FormComponents.Text
import R10.FormComponents.UI.Color
import R10.FormComponents.UI.Palette
import R10.FormComponents.Validations


extraCss : R10.FormComponents.UI.Palette.Palette -> String
extraCss palette =
    R10.FormComponents.Text.extraCss
        ++ R10.FormComponents.Single.extraCss
        ++ R10.FormComponents.Validations.extraCss
        ++ ripple
            (R10.FormComponents.UI.Color.onSurface palette)
            (R10.FormComponents.UI.Color.primary palette)
            (R10.FormComponents.UI.Color.onPrimary palette)


ripple : Element.Color -> Element.Color -> Element.Color -> String
ripple onSurface primary onPrimary =
    let
        onSurfaceStr : String
        onSurfaceStr =
            onSurface |> R10.FormComponents.UI.Color.toCssString

        primaryStr : String
        primaryStr =
            primary |> R10.FormComponents.UI.Color.toCssString

        onPrimaryStr : String
        onPrimaryStr =
            onPrimary |> R10.FormComponents.UI.Color.toCssString
    in
    rippleStr_ "ripple" onSurfaceStr
        ++ rippleStr_ "ripple-primary" primaryStr
        ++ rippleStr_ "ripple-on-primary" onPrimaryStr


rippleStr_ : String -> String -> String
rippleStr_ className colorStr =
    """
    .""" ++ className ++ """ {
      position: relative;
      overflow: hidden;
      transform: translate3d(0, 0, 0);
    }
    .""" ++ className ++ """:after {
      content: "";
      display: block;
      position: absolute;
      width: 100%;
      height: 100%;
      top: 0;
      left: 0;
      pointer-events: none;
      background-image: radial-gradient(circle, """ ++ colorStr ++ """ 10%, transparent 10.01%);
      background-repeat: no-repeat;
      background-position: 50%;
      transform: scale(10, 10);
      opacity: 0;
      transition: transform .5s, opacity 1s;
    }
    .""" ++ className ++ """:active:after {
      transform: scale(0, 0);
      opacity: .2;
      transition: 0s;
    }
    """
