module R10.FormComponents.Internal.UI.Const exposing
    ( inputTextFilledDown
    , inputTextFontSize
    , inputTextHeight
    )

import R10.FontSize


inputTextHeight : number
inputTextHeight =
    -- This need to be at least 50 otherwise the
    -- Chrome auto-suggestion functionality
    -- is covering hiding the lower border
    --
    -- https://jira.rakuten-it.com/jira/browse/OMN-1936
    --
    50


inputTextFontSize : Int
inputTextFontSize =
    R10.FontSize.normalAsInt


inputTextFilledDown : number
inputTextFilledDown =
    8
