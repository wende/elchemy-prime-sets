module Hajto exposing (..)

{-| Does what Hajto wants
-}


{-| Prints "world!"

    return [1,2,3,4] [1,1,2,3,3,3,4] == [1,3]

-}
return : List Int -> List Int -> List Int
return a b =
    let
        isInList : List ( Int, Bool ) -> Int -> Bool
        isInList list a =
            list
                |> List.foldl
                    (\( num, isPrime ) acc ->
                        if num == a then
                            isPrime
                        else
                            acc
                    )
                    False

        primes =
            findPrimeOccurences b
    in
        List.filter (isInList primes) a


findPrimeOccurences : List Int -> List ( Int, Bool )
findPrimeOccurences list =
    let
        countEach : Int -> ( Int, Int, List ( Int, Int ) ) -> ( Int, Int, List ( Int, Int ) )
        countEach current ( prev, found, acc ) =
            if prev == current then
                ( current, found + 1, acc )
            else
                ( current, 1, ( prev, found ) :: acc )
    in
        list
            |> List.sort
            |> List.foldl countEach ( -1, 0, [] )
            |> \( _, _, acc ) -> acc |> List.map (Tuple.mapSecond isPrimeNaive)


{-| Prints "world!"

    isPrimeNaive 1 == False
    isPrimeNaive 2 == True
    isPrimeNaive 5 == True
    isPrimeNaive 10 == False

-}
isPrimeNaive : Int -> Bool
isPrimeNaive a =
    isPrimeNaive_ a a 0


isPrimeNaive_ : Int -> Int -> Int -> Bool
isPrimeNaive_ a b acc =
    if b == 0 then
        acc == 2
    else if a % b == 0 then
        isPrimeNaive_ a (b - 1) (acc + 1)
    else
        isPrimeNaive_ a (b - 1) acc
