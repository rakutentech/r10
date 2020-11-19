module R10.FormComponents.UI.Const exposing
    ( inputTextFilledDown
    , inputTextFontSize
    , inputTextHeight
    )


inputTextHeight : number
inputTextHeight =
    -- This need to be at least 50 otherwise the
    -- Chrome auto-suggestion functionality
    -- is covering hiding the lower border
    --
    -- https://jira.rakuten-it.com/jira/browse/OMN-1936
    --
    50


inputTextFontSize : number
inputTextFontSize =
    16


inputTextFilledDown : number
inputTextFilledDown =
    8
