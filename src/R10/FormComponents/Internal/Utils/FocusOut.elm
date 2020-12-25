module R10.FormComponents.Internal.Utils.FocusOut exposing (onFocusOut)

import Json.Decode as D


outsideTarget : String -> String -> msg -> D.Decoder msg
outsideTarget targetName dropdownId closeMsg =
    D.field targetName (isOutsideDropdown dropdownId)
        |> D.andThen
            (\isOutside ->
                if isOutside then
                    D.succeed closeMsg

                else
                    D.fail "inside dropdown"
            )


isOutsideDropdown : String -> D.Decoder Bool
isOutsideDropdown dropdownId =
    D.oneOf
        [ D.field "id" D.string
            |> D.andThen
                (\id ->
                    if dropdownId == id then
                        -- found match by id
                        D.succeed False

                    else
                        -- try next decoder
                        D.fail "check parent node"
                )
        , D.lazy
            (\_ ->
                isOutsideDropdown dropdownId |> D.field "parentNode"
            )

        -- fallback if all previous decoders failed
        , D.succeed True
        ]


onFocusOut : String -> msg -> D.Decoder msg
onFocusOut containerId closeMsg =
    -- Every target that should be allowed (element contained in `containerId`),
    -- should be focusable. Otherwise relatedTarget would be null and it would be
    -- impossible to check if relatedTarget is a child of a target
    outsideTarget "relatedTarget" containerId closeMsg
