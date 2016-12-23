module Data.Page
    exposing
        ( Msg
        , Model
        , Stack
        , toMsg
        , toModel
        , match
        , stack
        , push
        , pop
        , peek
        , update
        )


type alias Msg context msg =
    { context : context
    , msg : msg
    }


type alias Model context model =
    { context : context
    , model : model
    }


type Stack page
    = Stack (List page)


toMsg : context -> msg -> Msg context msg
toMsg context msg =
    Msg context msg


toModel : context -> model -> Model context model
toModel context model =
    Model context model


match : Msg context msg -> Model context model -> Bool
match target subject =
    target.context == subject.context


stack : page -> Stack page
stack page =
    Stack [ page ]


push : page -> Stack page -> Stack page
push page (Stack pages) =
    Stack (page :: pages)


pop : Stack page -> Stack page
pop ((Stack pages) as stack) =
    case pages of
        x :: [] ->
            stack

        _ :: xs ->
            Stack xs

        [] ->
            Debug.crash "Page.pop: empty list is not possible"


peek : Stack page -> page
peek (Stack pages) =
    case pages of
        x :: _ ->
            x

        [] ->
            Debug.crash "Page.pop: empty list is not possible"


map : (a -> b) -> Stack a -> Stack b
map f (Stack pages) =
    Stack (List.map f pages)


update : (page -> ( page, Maybe (Cmd msg) )) -> Stack page -> ( Stack page, Cmd msg )
update mapper (Stack pages) =
    let
        ( newPages, maybeEffects ) =
            List.unzip <| List.map mapper pages

        newEffects =
            List.filterMap identity maybeEffects
    in
        ( Stack newPages, Cmd.batch newEffects )
