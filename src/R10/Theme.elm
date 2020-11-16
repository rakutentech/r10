module R10.Theme exposing (Theme, fromFlags)

{-| This is how we store information about the primary color used and if the site is in light or dark mode.

Most of the application use only one primary color but some are configurable and can be used with different colors.

@docs Theme, fromFlags

-}

import R10.Color.Internal.Primary
import R10.Mode


{-| -}
type alias Theme =
    { mode : R10.Mode.Mode
    , primaryColor : R10.Color.Internal.Primary.Color
    }


{-| Usually `mode` and `primaryColor` are stored in the flags. Use this helper to create a `Theme` from flags.
-}
fromFlags :
    { a
        | mode : R10.Mode.Mode
        , primaryColor : R10.Color.Internal.Primary.Color
    }
    -> Theme
fromFlags flags =
    { mode = flags.mode
    , primaryColor = flags.primaryColor
    }
