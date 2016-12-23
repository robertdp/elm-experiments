module Pages.One exposing (..)

import Html
import Html.Events
import Data.Page as Page


type Msg
    = Increment
    | Decrement


type alias Context =
    { userId : Int
    }


type alias Model =
    Int


type alias PageMsg =
    Page.Msg Context Msg


type alias PageModel =
    Page.Model Context Model


init : Context -> PageModel
init context =
    Page.toModel context 0


update : Context -> Msg -> Model -> ( Model, Cmd Msg )
update context msg model =
    case msg of
        Increment ->
            (model + 1) ! []

        Decrement ->
            (model - 1) ! []


view : Context -> Model -> Html.Html Msg
view context model =
    Html.div []
        [ Html.text <| toString model
        , Html.button
            [ Html.Events.onClick Increment ]
            [ Html.text "+" ]
        , Html.button
            [ Html.Events.onClick Decrement ]
            [ Html.text "-" ]
        ]
