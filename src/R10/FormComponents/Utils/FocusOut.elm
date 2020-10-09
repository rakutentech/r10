module R10.FormComponents.Utils.FocusOut exposing (onFocusOut)

import Json.Decode as Decode


type DomNode
    = RootNode { id : String }
    | ChildNode { id : String, parentNode : DomNode }


outsideTarget : String -> String -> msg -> Decode.Decoder msg
outsideTarget targetName id closeMsg =
    Decode.field targetName domNodeDecoder
        |> Decode.andThen
            (\treeLeaf ->
                if treeContainsId id treeLeaf then
                    Decode.fail "inside dropdown"

                else
                    Decode.succeed closeMsg
            )


treeContainsId : String -> DomNode -> Bool
treeContainsId targetId node =
    case node of
        RootNode { id } ->
            if id == targetId then
                True

            else
                False

        ChildNode { id, parentNode } ->
            if id == targetId then
                True

            else
                treeContainsId targetId parentNode


domNodeDecoder : Decode.Decoder DomNode
domNodeDecoder =
    Decode.oneOf [ childNodeDecoder, rootNodeDecoder ]


rootNodeDecoder : Decode.Decoder DomNode
rootNodeDecoder =
    Decode.map (\x -> RootNode { id = x })
        (Decode.field "id" Decode.string)


childNodeDecoder : Decode.Decoder DomNode
childNodeDecoder =
    Decode.map2 (\id parentNode -> ChildNode { id = id, parentNode = parentNode })
        (Decode.field "id" Decode.string)
        (Decode.field "parentNode" (Decode.lazy (\_ -> domNodeDecoder)))


onFocusOut : String -> msg -> Decode.Decoder msg
onFocusOut id closeMsg =
    outsideTarget "relatedTarget" id closeMsg
