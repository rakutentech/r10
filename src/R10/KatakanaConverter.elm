module R10.KatakanaConverter exposing
    ( halfWidthKatakanaAndHiraganaToFullWidthKatakana
    , halfWidthKatakanaToFullWidthKatakana
    )

import Dict


type ConversionMode
    = ConvertHalfKatakanaAndHiragana
    | ConvertHalfKatakana


halfWidthKatakanaAndHiraganaToFullWidthKatakana : String -> String
halfWidthKatakanaAndHiraganaToFullWidthKatakana string =
    ( String.toList string, [] )
        |> convert ConvertHalfKatakanaAndHiragana
        |> Tuple.second
        |> List.reverse
        |> String.fromList


halfWidthKatakanaToFullWidthKatakana : String -> String
halfWidthKatakanaToFullWidthKatakana string =
    ( String.toList string, [] )
        |> convert ConvertHalfKatakana
        |> Tuple.second
        |> List.reverse
        |> String.fromList


convert : ConversionMode -> ( List Char, List Char ) -> ( List Char, List Char )
convert conversionMode ( remaining, partialResult ) =
    case remaining of
        [] ->
            ( [], partialResult )

        a :: lookahead :: xs ->
            convert conversionMode <| helper conversionMode a (Just lookahead) xs partialResult

        a :: xs ->
            convert conversionMode <| helper conversionMode a Nothing xs partialResult


helper : ConversionMode -> Char -> Maybe Char -> List Char -> List Char -> ( List Char, List Char )
helper conversionMode char maybeLookahead remaining partialResult =
    let
        code : Int
        code =
            Char.toCode char

        returnResult : Maybe Char -> Char -> ( List Char, List Char )
        returnResult maybeLookahead_ convertedChar =
            case maybeLookahead_ of
                Just lookahead ->
                    ( lookahead :: remaining, convertedChar :: partialResult )

                Nothing ->
                    ( remaining, convertedChar :: partialResult )

        replaceSingleHalfWidthKatakana : List Char -> ( List Char, List Char )
        replaceSingleHalfWidthKatakana listCharToLookup =
            case Dict.get (String.fromList listCharToLookup) halfWidthKatakanaToKatakanaConversionTable of
                Just v ->
                    returnResult maybeLookahead v

                Nothing ->
                    returnResult maybeLookahead char
    in
    if conversionMode == ConvertHalfKatakanaAndHiragana && code >= 12353 && code <= 12438 then
        -- Hiragana!
        returnResult maybeLookahead <| Char.fromCode (code + 96)

    else if code >= 65377 && code <= 65439 then
        -- Half-width Katakana!
        case maybeLookahead of
            Just lookahead ->
                -- We have to chars, so we attempt a two-chars substitution
                case Dict.get (String.fromList [ char, lookahead ]) halfWidthKatakanaToKatakanaConversionTable of
                    Just v ->
                        -- Found a match for a double char half-width katakana, for example ｶﾞ
                        returnResult Nothing v

                    Nothing ->
                        -- The search failed, we do a simple sostitution
                        replaceSingleHalfWidthKatakana [ char ]

            Nothing ->
                -- We have only one char, so we do a simple sostitution
                replaceSingleHalfWidthKatakana [ char ]

    else
        -- A char that doesn't need to be converted
        returnResult maybeLookahead char


halfWidthKatakanaToKatakanaConversionTable : Dict.Dict String Char
halfWidthKatakanaToKatakanaConversionTable =
    Dict.fromList
        [ ( "ｧ", 'ァ' )
        , ( "ｱ", 'ア' )
        , ( "ｨ", 'ィ' )
        , ( "ｲ", 'イ' )
        , ( "ｩ", 'ゥ' )
        , ( "ｳ", 'ウ' )
        , ( "ｪ", 'ェ' )
        , ( "ｴ", 'エ' )
        , ( "ｫ", 'ォ' )
        , ( "ｵ", 'オ' )
        , ( "ｶ", 'カ' )
        , ( "ｶﾞ", 'ガ' )
        , ( "ｷ", 'キ' )
        , ( "ｷﾞ", 'ギ' )
        , ( "ｸ", 'ク' )
        , ( "ｸﾞ", 'グ' )
        , ( "ｹ", 'ケ' )
        , ( "ｹﾞ", 'ゲ' )
        , ( "ｺ", 'コ' )
        , ( "ｺﾞ", 'ゴ' )
        , ( "ｻ", 'サ' )
        , ( "ｻﾞ", 'ザ' )
        , ( "ｼ", 'シ' )
        , ( "ｼﾞ", 'ジ' )
        , ( "ｽ", 'ス' )
        , ( "ｽﾞ", 'ズ' )
        , ( "ｾ", 'セ' )
        , ( "ｾﾞ", 'ゼ' )
        , ( "ｿ", 'ソ' )
        , ( "ｿﾞ", 'ゾ' )
        , ( "ﾀ", 'タ' )
        , ( "ﾀﾞ", 'ダ' )
        , ( "ﾁ", 'チ' )
        , ( "ﾁﾞ", 'ヂ' )
        , ( "ｯ", 'ッ' )
        , ( "ﾂ", 'ツ' )
        , ( "ﾂﾞ", 'ヅ' )
        , ( "ﾃ", 'テ' )
        , ( "ﾃﾞ", 'デ' )
        , ( "ﾄ", 'ト' )
        , ( "ﾄﾞ", 'ド' )
        , ( "ﾅ", 'ナ' )
        , ( "ﾆ", 'ニ' )
        , ( "ﾇ", 'ヌ' )
        , ( "ﾈ", 'ネ' )
        , ( "ﾉ", 'ノ' )
        , ( "ﾊ", 'ハ' )
        , ( "ﾊﾞ", 'バ' )
        , ( "ﾊﾟ", 'パ' )
        , ( "ﾋ", 'ヒ' )
        , ( "ﾋﾞ", 'ビ' )
        , ( "ﾋﾟ", 'ピ' )
        , ( "ﾌ", 'フ' )
        , ( "ﾌﾞ", 'ブ' )
        , ( "ﾌﾟ", 'プ' )
        , ( "ﾍ", 'ヘ' )
        , ( "ﾍﾞ", 'ベ' )
        , ( "ﾍﾟ", 'ペ' )
        , ( "ﾎ", 'ホ' )
        , ( "ﾎﾞ", 'ボ' )
        , ( "ﾎﾟ", 'ポ' )
        , ( "ﾏ", 'マ' )
        , ( "ﾐ", 'ミ' )
        , ( "ﾑ", 'ム' )
        , ( "ﾒ", 'メ' )
        , ( "ﾓ", 'モ' )
        , ( "ｬ", 'ャ' )
        , ( "ﾔ", 'ヤ' )
        , ( "ｭ", 'ュ' )
        , ( "ﾕ", 'ユ' )
        , ( "ｮ", 'ョ' )
        , ( "ﾖ", 'ヨ' )
        , ( "ﾗ", 'ラ' )
        , ( "ﾘ", 'リ' )
        , ( "ﾙ", 'ル' )
        , ( "ﾚ", 'レ' )
        , ( "ﾛ", 'ロ' )
        , ( "ﾜ", 'ワ' )
        , ( "ｦ", 'ヲ' )
        , ( "ﾝ", 'ン' )
        , ( "ｳﾞ", 'ヴ' )
        , ( "ﾜﾞ", 'ヷ' )
        , ( "ｦﾞ", 'ヺ' )
        , ( "･", '・' )
        , ( "ｰ", 'ー' )
        , ( "｡", '。' )
        , ( "｢", '「' )
        , ( "｣", '」' )
        , ( "､", '、' )
        ]
