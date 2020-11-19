module R10.FormComponents.Utils.FocusOut exposing (onFocusOut)

import Json.Decode as Decode


outsideTarget : String -> String -> msg -> Decode.Decoder msg
outsideTarget targetName dropdownId closeMsg =
    Decode.field targetName (isOutsideDropdown dropdownId)
        |> Decode.andThen
            (\isOutside ->
                if isOutside then
                    Decode.succeed closeMsg

                else
                    Decode.fail "inside dropdown"
            )


isOutsideDropdown : String -> Decode.Decoder Bool
isOutsideDropdown dropdownId =
    Decode.oneOf
        [ Decode.field "id" Decode.string
            |> Decode.andThen
                (\id ->
                    if dropdownId == id then
                        -- found match by id
                        Decode.succeed False

                    else
                        -- try next decoder
                        Decode.fail "check parent node"
                )
        , Decode.lazy
            (\_ ->
                isOutsideDropdown dropdownId |> Decode.field "parentNode"
            )

        -- fallback if all previous decoders failed
        , Decode.succeed True
        ]


onFocusOut : String -> msg -> Decode.Decoder msg
onFocusOut containerId closeMsg =
    -- Every target that should be allowed (element contained in `containerId`),
    -- should be focusable. Otherwise relatedTarget would be null and it would be
    -- impossible to check if relatedTarget is a child of a target
    outsideTarget "relatedTarget" containerId closeMsg
