module R10.When exposing (do, otherwise, when)

-- To be used as
--
-- x = 10 == 10
--
-- when x do ... otherwise ...


type Do
    = Do


type Otherwise
    = Otherwise


do : Do
do =
    Do


otherwise : Otherwise
otherwise =
    Otherwise


when : Bool -> Do -> b -> Otherwise -> b -> b
when a _ b _ c =
    if a then
        b

    else
        c
