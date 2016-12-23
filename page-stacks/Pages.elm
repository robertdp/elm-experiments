module Pages exposing (..)

import Html
import Data.Page as Page
import Pages.One
import Pages.Two


type Msg
    = OneMsg Pages.One.PageMsg
    | TwoMsg Pages.Two.PageMsg


type Model
    = OneModel Pages.One.PageModel
    | TwoModel Pages.Two.PageModel


init : Page.Stack Model
init =
    Pages.One.init { userId = 1 }
        |> OneModel
        >> Page.stack


updateStack : Msg -> Page.Stack Model -> ( Page.Stack Model, Cmd Msg )
updateStack msg stack =
    let
        mapper model =
            if match msg model then
                let
                    ( newModel, effects ) =
                        updatePage msg model
                in
                    ( newModel, Just effects )
            else
                ( model, Nothing )
    in
        Page.update mapper stack


match : Msg -> Model -> Bool
match msg model =
    case ( msg, model ) of
        ( OneMsg msg, OneModel model ) ->
            Page.match msg model

        ( TwoMsg msg, TwoModel model ) ->
            Page.match msg model

        _ ->
            False


updatePage : Msg -> Model -> ( Model, Cmd Msg )
updatePage msg model =
    case ( msg, model ) of
        ( OneMsg msg, OneModel model ) ->
            Pages.One.update msg.context msg.msg model.model
                |> mapTo msg.context OneModel OneMsg

        _ ->
            ( model, Cmd.none )


viewPage : Model -> Html.Html Msg
viewPage model =
    case model of
        OneModel model ->
            Pages.One.view model.context model.model
                |> mapMsg model.context OneMsg

        _ ->
            Html.text "Missing viewPage entry"


mapTo : context -> (Page.Model context a -> b) -> (Page.Msg context c -> d) -> ( a, Cmd c ) -> ( b, Cmd d )
mapTo context f g ( a, b ) =
    ( (Page.toModel context >> f) a, Cmd.map (Page.toMsg context >> g) b )


mapMsg : context -> (Page.Msg context a -> b) -> Html.Html a -> Html.Html b
mapMsg context f =
    Html.map (Page.toMsg context >> f)
