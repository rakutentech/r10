module R10.Form.Internal.QtySubmitAttempted exposing
    ( QtySubmitAttempted
    , fromInt
    , increment
    , toInt
    )


type QtySubmitAttempted
    = QtySubmitAttempted Int


toInt : QtySubmitAttempted -> Int
toInt (QtySubmitAttempted int) =
    int


fromInt : Int -> QtySubmitAttempted
fromInt int =
    QtySubmitAttempted int


increment : QtySubmitAttempted -> QtySubmitAttempted
increment qtySubmitAttempted =
    fromInt (toInt qtySubmitAttempted + 1)
