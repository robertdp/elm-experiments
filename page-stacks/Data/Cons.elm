module Data.Cons
    exposing
        ( Cons
        , cons
        , nil
        , map
        , foldl
        , toList
        , fromList
        , length
        , filter
        , isEmpty
        )


type Cons a
    = Cons a (Cons a)
    | Nil


cons : a -> Cons a
cons x =
    Cons x Nil


nil : Cons a
nil =
    Nil


map : (a -> b) -> Cons a -> Cons b
map func cons =
    case cons of
        Cons x xs ->
            Cons (func x) (map func xs)

        Nil ->
            Nil


foldl : (a -> b -> b) -> b -> Cons a -> b
foldl func acc cons =
    case cons of
        Nil ->
            acc

        Cons x xs ->
            foldl func (func x acc) xs


toList : Cons a -> List a
toList cons =
    case cons of
        Nil ->
            []

        Cons x xs ->
            x :: (toList xs)


fromList : List a -> Cons a
fromList list =
    case list of
        [] ->
            Nil

        x :: xs ->
            Cons x (fromList xs)


length : Cons a -> Int
length =
    foldl (\_ count -> count + 1) 0


filter : (a -> Bool) -> Cons a -> Cons a
filter func cons =
    case cons of
        Nil ->
            Nil

        Cons x xs ->
            if func x then
                Cons x (filter func xs)
            else
                filter func xs


isEmpty : Cons a -> Bool
isEmpty cons =
    case cons of
        Nil ->
            True

        _ ->
            False
