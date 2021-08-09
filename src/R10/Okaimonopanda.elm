module R10.Okaimonopanda exposing (view)

{-| Moving Okaimono Panda.

![Okaimono Panda](https://r10.netlify.app/images/okaimonopanda.gif)

@docs view

-}

import Browser
import Browser.Events
import Dict
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Svg
import Svg.Attributes as SA



-- BLACK 191919
-- shadow e7e7e7
-- lingua e84564


defaultCodeLanguage : String
defaultCodeLanguage =
    "en-US"


defaultCodeError : String
defaultCodeError =
    "GENERIC"


type alias Okaimonopanda =
    { mouse : Position
    , screen : Position
    , flags : Flags
    , codeLanguage : String
    , codeError : String
    }


init : Flags -> ( Okaimonopanda, Cmd Msg )
init flags =
    ( { mouse = { x = flags.x // 2, y = flags.y // 2 }
      , screen = { x = flags.x, y = flags.y }
      , flags = flags
      , codeLanguage = Maybe.withDefault defaultCodeLanguage flags.codeLanguage
      , codeError = Maybe.withDefault defaultCodeError flags.codeError
      }
    , Cmd.none
    )


type Msg
    = MouseMove Position
    | ScreenResize Int Int
    | ChangeCodeLanguage String
    | ChangeCodeError String


update : Msg -> Okaimonopanda -> ( Okaimonopanda, Cmd Msg )
update msg model =
    case msg of
        MouseMove mouse ->
            ( { model | mouse = mouse }, Cmd.none )

        ScreenResize x y ->
            ( { model | screen = { x = x, y = y } }, Cmd.none )

        ChangeCodeLanguage codeLanguage ->
            ( { model | codeLanguage = codeLanguage }, Cmd.none )

        ChangeCodeError codeError ->
            ( { model | codeError = codeError }, Cmd.none )


attrs : Float -> Float -> Float -> Float -> Float -> List (Html.Attribute msg)
attrs shiftX shiftY deltaX deltaY rate =
    [ Html.Attributes.style "position" "absolute"
    , Html.Attributes.style "pointer-events" "none"

    -- , Html.Attributes.style "border" "1px solid green"
    , Html.Attributes.style
        "transform"
        ("translate("
            ++ String.fromFloat (shiftX + ((deltaX * (rate * 6)) - (rate * 3)))
            ++ "px,"
            ++ String.fromFloat (shiftY + ((deltaY * (rate * 2)) - rate))
            ++ "px)"
        )
    ]


svgX : Int
svgX =
    7900


svgY : Int
svgY =
    8900


svgWidthOnScreen : Int
svgWidthOnScreen =
    400


backgroundX : number
backgroundX =
    580


backgroundY : number
backgroundY =
    400


backgroundRatio : Float
backgroundRatio =
    580 / 400


{-| -}
view :
    { c
        | mouse : { x : Int, y : Int }
        , screen : { x : Int, y : Int }
    }
    -> List (Html.Html msg)
view model =
    let
        deltaX =
            toFloat model.mouse.x / toFloat model.screen.x

        deltaY =
            toFloat model.mouse.y / toFloat model.screen.y

        svgWidth =
            Basics.max 180 (Basics.min (model.screen.x - 220) svgWidthOnScreen)
    in
    [ Html.div
        [ Html.Attributes.style "margin" "0 auto"
        , Html.Attributes.style "width" (String.fromInt svgWidth ++ "px")
        , Html.Attributes.style "height" (String.fromFloat (toFloat svgWidth * toFloat svgY / toFloat svgX) ++ "px")
        ]
        [ Html.div (attrs 0 0 deltaX deltaY 6) [ svgHeadStroke svgWidth ]
        , Html.div (attrs 0 0 deltaX deltaY 10) [ svgBodyStroke svgWidth ]
        , Html.div (attrs 0 0 deltaX deltaY 13) [ svgLegsStroke svgWidth ]
        , Html.div (attrs 0 0 deltaX deltaY 6) [ svgHead svgWidth ]
        , Html.div (attrs 0 0 deltaX deltaY 10) [ svgBody svgWidth ]
        , Html.div (attrs 0 0 deltaX deltaY 13) [ svgLegs svgWidth ]
        ]
    ]


viewFullPage : Okaimonopanda -> Html.Html Msg
viewFullPage model =
    let
        windowRatio =
            toFloat model.screen.x / toFloat model.screen.y

        deltaX =
            toFloat model.mouse.x / toFloat model.screen.x

        deltaY =
            toFloat model.mouse.y / toFloat model.screen.y

        svgWidth =
            Basics.max 180 (Basics.min (model.screen.x - 220) svgWidthOnScreen)

        dictTranslations =
            listToDict model.flags.translations .codeLanguage

        translation =
            getTranslation emptyTranslation defaultCodeLanguage model.codeLanguage dictTranslations

        dictErrors =
            listToDict translation.errors .codeError

        error =
            getTranslation emptyError defaultCodeError model.codeError dictErrors

        widthBackground =
            if backgroundRatio - windowRatio < 0 then
                model.screen.x

            else
                -- model.screen.y : backgroundY = ? : backgroundX
                round <| toFloat model.screen.y * backgroundX / toFloat backgroundY
    in
    Html.div [ Html.Attributes.class "meta" ]
        -- here we sliglty enlarge the background and we shift to the top left so that the borders are not showing
        [ Html.div (attrs (toFloat widthBackground * -0.05) (toFloat widthBackground * -0.05) deltaX deltaY -5 ++ [ Html.Attributes.style "position" "fixed" ]) [ back1 <| round (toFloat widthBackground * 1.1) ]
        , Html.div (attrs (toFloat widthBackground * -0.05) (toFloat widthBackground * -0.05) deltaX deltaY -10 ++ [ Html.Attributes.style "position" "fixed" ]) [ back2 <| round (toFloat widthBackground * 1.1) ]
        , Html.div (attrs (toFloat widthBackground * -0.05) (toFloat widthBackground * -0.05) deltaX deltaY -20 ++ [ Html.Attributes.style "position" "fixed" ]) [ back3 <| round (toFloat widthBackground * 1.1) ]
        , Html.div [ Html.Attributes.class "container" ]
            [ Html.div [ Html.Attributes.class "section left" ]
                -- Panda
                (view model)
            , Html.div [ Html.Attributes.class "section right" ]
                [ Html.h1 [ Html.Attributes.class "centerIfMobile", Html.Attributes.id "title" ] [ Html.text error.title ]
                , Html.h2 [ Html.Attributes.class "centerIfMobile", Html.Attributes.id "subTitle" ] [ Html.text error.subTitle ]
                , Html.hr [] []
                , Html.div [] [ Html.text translation.text1 ]
                , Html.div [] [ Html.text translation.text2 ]
                , Html.ul []
                    [ Html.li [] [ Html.text translation.point1 ]
                    , Html.li [] [ Html.text translation.point2 ]
                    , Html.li [] [ Html.text translation.point3 ]
                    ]
                , case ( translation.buttonHref, translation.buttonText ) of
                    ( Just "", _ ) ->
                        Html.text ""

                    ( _, Just "" ) ->
                        Html.text ""

                    ( Just buttonHref, Just buttonText ) ->
                        Html.div []
                            [ Html.a
                                [ Html.Attributes.class "button largeIfMobile centerIfMobile"
                                , Html.Attributes.href buttonHref
                                ]
                                [ Html.text buttonText ]
                            ]

                    _ ->
                        Html.text ""
                , if Dict.size dictTranslations < 2 then
                    Html.text ""

                  else
                    Html.div [ Html.Attributes.class "languageSelectorWrapper" ]
                        [ Html.select
                            [ Html.Events.on "change" (Json.Decode.map ChangeCodeLanguage Html.Events.targetValue)
                            , Html.Attributes.value model.codeLanguage
                            , Html.Attributes.class "select"
                            ]
                            (List.map
                                (\codeLanguage ->
                                    let
                                        translation_ =
                                            getTranslation emptyTranslation defaultCodeLanguage codeLanguage dictTranslations
                                    in
                                    Html.option
                                        ([ Html.Attributes.value codeLanguage ]
                                            ++ (if codeLanguage == model.codeLanguage then
                                                    [ Html.Attributes.selected True ]

                                                else
                                                    []
                                               )
                                        )
                                        [ Html.text translation_.language ]
                                )
                                (Dict.keys dictTranslations)
                            )
                        ]
                , Html.div [ Html.Attributes.class "codeError" ] [ Html.text <| model.codeError ]
                ]
            ]
        ]


getTranslation : v -> comparable -> comparable -> Dict.Dict comparable v -> v
getTranslation emptyValue defaultCode codeLanguage dictTranslations =
    Maybe.withDefault
        (Maybe.withDefault emptyValue (Dict.get defaultCode dictTranslations))
        (Dict.get codeLanguage dictTranslations)


emptyTranslation : Translation
emptyTranslation =
    { codeLanguage = ""
    , language = ""
    , errors = []
    , text1 = ""
    , text2 = ""
    , point1 = ""
    , point2 = ""
    , point3 = ""
    , buttonText = Nothing
    , buttonHref = Nothing
    }


emptyError : Error
emptyError =
    { codeError = ""
    , title = ""
    , subTitle = ""
    }


type alias Position =
    { x : Int, y : Int }


decoder : Json.Decode.Decoder Position
decoder =
    Json.Decode.map2 Position
        (Json.Decode.field "pageX" Json.Decode.int)
        (Json.Decode.field "pageY" Json.Decode.int)


subscriptions : a -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onMouseMove (Json.Decode.map MouseMove decoder)
        , Browser.Events.onResize ScreenResize
        ]


listToDict : List v -> (v -> comparable) -> Dict.Dict comparable v
listToDict translations f =
    Dict.fromList <| List.map (\translation -> ( f translation, translation )) translations


type alias Flags =
    { x : Int
    , y : Int
    , codeLanguage : Maybe String
    , codeError : Maybe String
    , translations : List Translation
    }


type alias Error =
    { codeError : String
    , title : String
    , subTitle : String
    }


type alias Translation =
    { codeLanguage : String
    , language : String
    , errors : List Error
    , text1 : String
    , text2 : String
    , point1 : String
    , point2 : String
    , point3 : String
    , buttonText : Maybe String
    , buttonHref : Maybe String
    }


main : Program Flags Okaimonopanda Msg
main =
    Browser.element
        { init = init
        , view = viewFullPage
        , update = update
        , subscriptions = subscriptions
        }


svgWrapper : String -> Int -> List (Svg.Svg msg) -> Svg.Svg msg
svgWrapper viewBox size listSvg =
    Svg.svg
        [ SA.xmlSpace "http://www.w3.org/2000/svg"
        , SA.viewBox <| viewBox
        , SA.width <| String.fromInt size
        , SA.preserveAspectRatio "xMinYMin slice"
        ]
        listSvg


svgWrapperWithFixedViewbox : Int -> List (Svg.Svg msg) -> Svg.Svg msg
svgWrapperWithFixedViewbox size listSvg =
    svgWrapper ("-150 -150 " ++ String.fromInt svgX ++ " " ++ String.fromInt svgY) size listSvg


darkColor : String
darkColor =
    "#191919"


legs : String
legs =
    "M5962 8606c-93-23-197-82-243-136a1327 1327 0 00-297-208c-15-11-58-36-97-57-114-61-313-198-419-287-54-46-106-87-115-92-32-17-81-93-92-144-17-71 1-161 55-280 82-181 166-251 309-259 65-4 83 0 187 38l225 80c61 22 130 50 155 63 71 36 155 59 177 48 20-11 43-53 98-181 86-202 212-369 312-413 68-30 227-37 308-13 89 25 153 61 215 121 164 156 158 352-22 789a5324 5324 0 00-197 530c-66 242-124 336-240 388-58 26-237 34-319 13zM1131 8494c-57-15-117-54-151-97-37-46-87-168-118-287-17-64-67-205-112-315-189-466-228-601-216-745 8-100 40-163 120-238 90-84 167-114 308-120 142-6 216 17 288 89 79 79 158 209 209 344 64 170 67 172 153 155 35-6 68-16 73-20 11-9 51-24 210-79 61-21 153-55 205-76 78-32 108-39 165-39 126-1 201 50 284 189a518 518 0 0182 346c-9 42-23 68-56 106-85 96-332 275-558 402a2351 2351 0 00-283 172c-33 23-76 62-98 86-99 112-338 172-505 127z"


body : String
body =
    "M2950 7979c-376-22-611-58-780-119-63-24-120-46-126-51s-32-15-57-23c-104-31-243-156-347-311a879 879 0 01-177-320c-40-134-8-296 114-584 5-10-2-12-28-8l-169 26c-328 51-411 56-858 54-385-2-427-4-460-20-47-23-64-56-59-114 5-64 42-132 104-190 97-91 213-128 405-129 140 0 314-47 473-128 79-40 193-87 415-171 82-32 189-58 356-86l246-45a974 974 0 01163-25c40-6 61-18 108-60 117-106 342-220 530-270 408-107 862-110 1372-9 88 17 261 71 370 114 90 36 201 99 289 163 63 47 75 52 160 64 50 7 120 20 156 28l200 41c240 46 476 127 640 219 165 93 304 132 512 145 223 15 289 35 384 115 96 82 145 205 110 273-34 66-34 66-516 66-445 1-543-5-815-49-44-7-82-11-84-9-2 1 20 54 47 116 207 464 242 594 189 691-13 23-29 58-37 77-15 41-78 137-128 197-63 75-158 125-346 180-129 38-159 44-386 68l-160 20c-38 11-355 46-547 60-229 16-1009 19-1263 4zm945-94c99-3 232-10 295-15l275-21c88-6 210-18 270-26 61-8 155-19 210-24 135-12 182-22 235-51 25-13 70-30 100-37a425 425 0 00321-502c-11-39-32-90-45-114-14-23-35-66-46-96-37-93-146-330-196-424-119-226-259-403-505-640-244-236-437-340-792-425-230-55-324-65-627-65-244 0-288 3-392 23-290 56-475 139-609 272-50 50-82 96-139 199-76 138-193 295-349 466a523 523 0 00-151 251c-56 146-80 275-80 422 0 185 28 251 164 391a1255 1255 0 00205 174c12 15 51 36 131 70 53 22 68 27 160 47l170 39c84 20 252 48 425 72 50 6 178 15 285 19 188 7 301 6 685-5z"


smoke : String
smoke =
    "M4039 3221c-86-18-154-80-185-170l-12-36-84-8c-318-29-444-190-289-371 57-67 118-95 176-80 36 9 31 33-15 78-48 48-67 101-54 154 20 83 171 137 316 113 95-16 157-51 232-132 63-69 98-92 153-102 39-8 63 12 63 51 1 35 41 132 71 171 36 45 95 71 162 71 69 0 97-21 97-75 0-38-28-103-54-124-20-17-21-45-1-61 8-6 35-18 61-26 60-18 88-6 132 60 25 38 32 59 32 98 0 62-18 97-72 141-79 64-209 92-344 73-50-7-51-7-64 23-16 40-91 108-143 131-50 22-128 31-178 21zm170-88c17-21 34-52 37-70 6-33-18-145-40-191l-12-22-34 26c-39 29-168 94-187 94-17 0-16 13 2 57 36 86 102 143 167 143 30 0 42-7 67-37zM5805 2310c-11-4-33-22-49-39-26-27-31-29-46-16-23 21-85 45-116 45-28 0-94-57-94-83 0-27 31-41 95-43 44-1 74-9 102-25l39-22-19-36c-23-46-19-128 9-148 22-16 77-17 107-2 12 6 44 32 70 58l48 46 30-33c35-39 37-58 6-66-64-16-158-115-136-143 30-36 139-24 207 22 27 18 39 22 49 13 25-20 13-38-32-49-55-14-143-70-206-131-142-138-87-345 107-404 191-57 399 52 513 270 51 95 38 170-36 221l-38 25h76c42 0 115-7 162-15 331-58 383-225 145-465-62-63-70-68-119-72-28-3-68-1-88 4-66 16-292 21-398 9-124-15-257-52-336-94-103-54-175-162-131-194 10-7 26-13 35-13 30 0 30-17 1-28l-107-36c-44-14-95-35-113-46-38-23-67-80-84-165-40-201 143-340 422-321 110 7 174 27 245 75 50 34 61 38 79 28 12-7 62-12 121-12 95 0 105 3 205 44l175 68c39 14 100 41 137 59 51 26 88 36 160 44 51 6 125 18 163 27 57 12 78 13 113 4 51-14 99-54 130-109l23-41-38-24C6946 215 6650 92 6345 61c-49-5-95-7-102-4-17 7 52 60 138 107 64 35 206 76 266 76 43 0 50 15 16 37-57 37-223 9-368-62-85-41-225-151-225-176 0-39 226-52 412-24 217 32 465 123 808 294 262 132 368 261 281 345-52 50-102 58-348 57l-222-1 11 30c5 17 8 48 6 69-3 36-1 41 39 66 80 50 104 105 83 184-17 65-77 117-166 143l-73 22 64 68c81 88 109 144 109 223 0 137-110 238-324 296-72 19-114 23-279 26l-193 3-28 43c-15 24-35 47-43 50-12 5-15 19-14 62 2 53 0 58-34 89-21 20-64 43-102 55-67 22-67 23-67 60 0 47-23 79-74 102-44 20-79 23-111 9zm39-141c-8-14-34-11-34 4 0 8 3 17 7 20 9 9 34-13 27-24zm518-471c28-14 40-46 33-88-8-49-64-142-118-197-39-40-44-43-97-43-142 1-260 36-282 85-15 34 3 89 45 139l33 39 34-18c23-12 58-19 100-19 79-1 124 23 159 84 20 35 26 39 49 34 15-4 35-11 44-16zm78-537c-80-27-289-107-447-172-72-29-146-38-158-18-4 6 15 32 43 59 36 34 71 56 128 78 77 29 244 61 335 63 24 1 55 5 69 9s45 8 70 8c44 1 42 0-40-27zm140-36c0-12-146-76-247-108-106-34-203-55-203-44 0 6 91 38 200 71 47 14 117 39 155 55 68 29 95 36 95 26zm135-72c18-26 18-27-14-55-17-15-42-28-55-28-89 0-397-113-523-193-78-48-103-79-103-125 0-29 8-43 44-78l45-43-56-47-55-47-121-5c-74-2-138 0-163 7-55 15-106 50-123 86-19 38-17 124 3 163 26 49 105 109 216 164 103 50 107 51 205 54 132 3 201 11 315 35 87 19 288 94 335 126 27 18 30 17 50-14zm208-62c57-32 66-40 53-50-12-10-19-9-38 3-13 8-42 19-65 26-36 9-43 15-43 35 0 33 13 31 93-14zm-20-78c4-2 7-8 7-12 0-10-518-283-530-279-5 1 29 28 76 58 216 138 262 170 304 209 43 41 47 42 90 36 25-4 48-9 53-12zm-323-30c0-5-24-21-53-37-48-28-109-69-213-146-23-16-44-30-49-30-4 0-20 11-36 24l-29 25 72 43c109 64 177 92 306 127 1 1 2-2 2-6zm286-147c-20-25-44-47-54-50-33-11-157-35-160-31-3 2 107 63 228 126 27 14 23 0-14-45z"


head : String
head =
    "M3440 6564c-14-2-126-9-250-15s-268-14-320-19l-235-19c-146-11-273-28-410-56l-165-31-135-26c-104-22-382-121-486-173-95-48-272-177-350-254a2145 2145 0 01-369-574c-194-445-234-920-110-1325 16-53 18-73 10-135-19-143-8-330 26-462 9-33 39-107 67-164 102-211 257-375 463-489a933 933 0 01485-127c71 0 122-5 130-12a3614 3614 0 01912-349c350-73 684-97 1060-73 519 31 895 108 1327 268 124 47 410 191 520 262 69 44 121 70 190 91 428 133 738 507 775 937 5 56 17 107 36 153 123 299 179 616 158 906-15 222-81 432-191 611-65 104-257 303-373 385-308 218-401 271-564 317a6732 6732 0 00-371 118l-195 65c-38 13-101 31-140 40-38 8-101 24-140 36-38 11-108 27-155 35-47 7-125 25-175 39-59 17-136 29-223 36-122 9-744 12-802 4zm470-152c182-10 389-34 411-48 5-3 56-10 112-15s136-18 177-28c41-11 106-22 144-26 100-10 255-50 344-89 42-18 119-43 170-55 52-12 126-36 166-55 40-18 104-41 144-50 39-10 115-40 169-68l186-94a984 984 0 00288-203c88-89 147-172 196-279l59-130c81-174 106-501 59-772-18-101-90-346-131-442a2511 2511 0 00-569-833 2167 2167 0 00-384-319c-314-213-628-332-1120-426-963-184-1644-120-2290 217a2685 2685 0 00-705 507 1902 1902 0 00-406 566l-46 105c-23 51-61 196-78 295-47 280-35 596 34 885 27 117 111 331 173 443 49 88 80 135 209 315 108 151 332 306 503 348 28 7 85 27 128 46 73 31 141 51 240 73 23 5 83 21 132 35 50 14 128 28 175 31s119 14 160 25c79 19 224 37 400 48 149 9 719 5 950-7z"


strokeWidth : String
strokeWidth =
    "300px"


strokeColor : String
strokeColor =
    "#fff"


svgLegs : Int -> Svg.Svg msg
svgLegs size =
    svgWrapperWithFixedViewbox size [ Svg.path [ SA.fill darkColor, SA.d legs ] [] ]


svgLegsStroke : Int -> Svg.Svg msg
svgLegsStroke size =
    svgWrapperWithFixedViewbox size [ Svg.path [ SA.stroke strokeColor, SA.strokeWidth strokeWidth, SA.d legs ] [] ]


svgBodyStroke : Int -> Svg.Svg msg
svgBodyStroke size =
    svgWrapperWithFixedViewbox size [ Svg.path [ SA.stroke strokeColor, SA.strokeWidth strokeWidth, SA.d body ] [] ]


svgHeadStroke : Int -> Svg.Svg msg
svgHeadStroke size =
    svgWrapperWithFixedViewbox
        size
        [ Svg.path [ SA.stroke strokeColor, SA.strokeWidth strokeWidth, SA.d head ] []
        , Svg.path [ SA.stroke strokeColor, SA.strokeWidth strokeWidth, SA.d smoke ] []
        ]


svgBody : Int -> Svg.Svg msg
svgBody size =
    svgWrapperWithFixedViewbox
        size
        [ Svg.path [ SA.fill "#bf0000", SA.d "M3140 6542c-95-50-120-67-120-79 0-10 124-13 584-13 544 0 616 3 594 25-3 4-118 15-463 45-127 11-264 24-305 30s-111 13-155 16c-74 5-84 3-135-24zM3197 6382c-3-4-7-160-8-345-2-307-1-340 15-355 15-15 42-17 219-17 255 0 345 20 431 96 107 94 101 233-15 315-27 20-49 40-47 44 3 7 39 39 187 165 46 40 80 77 79 85-3 12-27 16-129 18l-126 3-64-57-104-93c-67-63-84-71-152-71h-62l-3 108-3 107-107 3c-58 1-109-1-111-6zm442-390c80-39 80-110-1-150-36-18-65-24-130-25l-83-2-3 104-3 104 92-6c56-4 107-14 128-25z" ] []
        , Svg.path [ SA.fill "#e7e7e7", SA.d "M3210 7890c-107-4-235-13-285-19-173-24-341-52-425-72l-170-39c-92-20-107-25-160-47-147-63-154-70-148-160 3-45 12-80 27-103 11-19 21-42 21-51 0-21 100-116 137-130 52-20 266-50 378-52 60-1 171 6 245 15 400 50 968 53 1660 8 182-12 374-12 420-1 170 44 191 53 242 104 107 107 130 173 105 296-9 40-17 74-19 76l-53 30c-58 32-102 42-240 54-55 5-149 16-210 24-60 8-182 20-270 26l-275 21c-110 9-293 16-630 24-85 2-243 0-350-4z" ] []
        , Svg.path [ SA.fill darkColor, SA.d body ] []
        , Svg.path [ SA.fill "#fff", SA.d "M5244 7698l17-76c22-102-8-178-109-279-51-51-72-60-242-104-46-11-238-11-420 1-692 45-1260 42-1660-8-74-9-185-16-245-15-112 2-326 32-378 52-37 14-137 109-137 130 0 9-10 32-21 51-15 23-24 58-27 102l-5 68-38-22c-21-12-83-67-138-122-144-147-171-210-171-398 0-147 24-276 80-422 54-144 56-147 151-251 156-171 273-328 349-466 57-103 89-149 139-199 134-133 319-216 609-272 104-20 148-23 392-23 303 0 397 10 627 65 260 63 421 131 588 250 176 126 469 431 589 615 105 159 232 412 316 624 11 30 32 73 46 96 13 24 34 75 45 114 16 59 18 82 10 129-31 192-135 315-310 368-60 18-62 18-57-8zM3430 6550c41-6 178-19 305-30 345-30 460-41 463-45 22-22-50-25-594-25-618 0-626 1-551 44 125 73 138 77 222 72 44-3 114-10 155-16zm-12-272l3-108h62c68 0 85 8 152 71l104 93 64 57 126-3c102-2 126-6 129-18 1-8-33-45-79-85a2112 2112 0 01-187-165c-2-4 20-24 47-44 116-82 122-221 15-315-86-76-176-96-431-96-177 0-204 2-219 17-16 15-17 48-15 355 1 185 5 341 8 345 2 5 53 7 111 6l107-3 3-107z" ] []
        , Svg.path [ SA.fill "#fff", SA.d "M3422 5919l3-104 83 2c141 3 221 60 182 131-23 41-75 61-179 69l-92 6 3-104z" ] []
        ]


svgHead : Int -> Svg.Svg msg
svgHead size =
    svgWrapperWithFixedViewbox
        size
        [ Svg.path [ SA.fill "#e84564", SA.d "M4074 3151c-38-23-78-73-99-124-18-44-19-57-2-57 19 0 148-65 187-94l34-26 12 22c22 46 46 158 40 191-3 18-20 49-37 70-25 30-37 37-67 37-20 0-51-9-68-19z" ] []
        , Svg.path [ SA.fill "#e7e7e7", SA.d "M2960 6419c-176-11-321-29-400-48-41-11-113-22-160-25s-125-17-175-31c-49-14-109-30-132-35-99-22-167-42-240-73-43-19-100-39-128-46-171-42-395-197-503-348a2845 2845 0 01-209-315c-62-112-146-326-173-443-69-289-81-605-34-885 17-99 55-244 78-295l46-105c125-288 410-617 731-842 21-15 41-23 44-18s-19 43-50 85c-91 123-145 213-207 342-64 135-99 244-123 386a857 857 0 00327 850c165 134 318 176 554 156 110-10 479-93 634-144 117-38 391-105 545-132 118-22 173-26 350-27 402-2 522 39 1210 412a9846 9846 0 00668 336l142 59c79 33 323 103 405 116 87 14 163 13 232-3l56-13-8 23c-41 107-123 228-219 325a984 984 0 01-288 203l-186 94c-54 28-130 58-169 68-40 9-104 32-144 50-40 19-114 43-166 55-51 12-128 37-170 55-89 39-244 79-344 89-38 4-103 15-144 26-41 10-121 23-177 28s-107 12-112 15c-22 14-229 38-411 48-231 12-801 16-950 7z" ] []
        , Svg.path [ SA.fill darkColor, SA.d head ] []
        , Svg.path [ SA.fill darkColor, SA.d smoke ] []
        , Svg.path [ SA.fill "#fff", SA.d "M6152 5349c-74-12-323-85-397-116l-142-59a9846 9846 0 01-668-336c-689-374-808-414-1210-412-177 1-232 5-350 27-154 27-428 94-545 132-155 51-524 134-634 144-236 20-389-22-554-156a855 855 0 01-327-528c-61-298 61-685 330-1050 31-42 54-79 51-84-17-27 318-217 560-319 483-203 990-257 1675-177 212 24 639 111 818 166 330 101 611 247 872 455 94 74 318 298 391 390 229 289 353 518 451 835 58 185 77 298 84 484 8 225-30 444-97 557-18 30-28 37-77 47-64 13-154 13-231 0zM4217 3200c52-23 127-91 143-131 13-30 14-30 64-23 135 19 265-9 344-73 54-44 72-79 72-141 0-39-7-60-32-98-44-66-72-78-132-60-26 8-53 20-61 26-20 16-19 44 1 61 26 21 54 86 54 124 0 54-28 75-97 75-67 0-126-26-162-71-30-39-70-136-71-171 0-39-24-59-63-51-55 10-90 33-153 102a370 370 0 01-232 132c-145 24-296-30-316-113-13-53 6-106 54-154 46-45 51-69 15-78-58-15-119 13-176 80-128 150-69 284 151 348 30 9 93 19 138 23l84 8 12 36c31 90 99 152 185 170 50 10 128 1 178-21z" ] []
        ]


back1 : Int -> Svg.Svg msg
back1 size =
    svgWrapper
        "0 0 580 400"
        size
        [ Svg.path [ SA.fillOpacity ".04", SA.d "M483 123c-49 17-80 7-112 13-32 7-43 18-55 27s-21 28-28 38c-6 11-21 29-39 37-18 7-47 6-66 1s-33-11-51-30a98 98 0 01-24-62c-2-21 1-42 13-57 12-16 35-38 86-45s99-6 115-6c17 0 76 2 106-19 31-22 32-27 53-37 21-11 40-12 57-7s33 11 48 28c15 16 8 43-9 61-16 19-45 41-94 58z" ] []
        ]


back2 : Int -> Svg.Svg msg
back2 size =
    svgWrapper
        "0 0 580 400"
        size
        [ Svg.path [ SA.fillOpacity ".04", SA.d "M8 271c26-10 67-40 96-62 28-23 53-69 83-87 31-19 53-24 78-22 24 3 40 15 56 31 17 15 25 38 26 51 0 13-1 43-7 61-7 18-29 46-59 57s-80 16-119 8-91-5-127 12c-35 18-25 44-60 62-35 17-63 7-75-19-11-27 5-66 27-83 22-16 56 0 81-9z" ] []
        ]


back3 : Int -> Svg.Svg msg
back3 size =
    svgWrapper
        "0 0 580 400"
        size
        [ Svg.ellipse [ SA.cx "450.2", SA.cy "297.3", SA.fillOpacity ".04", SA.rx "102.6", SA.ry "100.2" ] []
        ]
