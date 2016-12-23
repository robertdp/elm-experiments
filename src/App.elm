module App exposing (main)

import Html exposing (Html)
import Html.Events
import Data.Page as Page
import Pages.One
import Pages


type alias Model =
    { pages : Page.Stack Pages.Model
    }


type Msg
    = PageMsg Pages.Msg
    | AddPage
    | RemovePage


init : Model
init =
    { pages = Pages.init
    }


view : Model -> Html Msg
view model =
    Html.div []
        [ Page.peek model.pages
            |> Pages.viewPage
            |> Html.map PageMsg
        , Html.button [ Html.Events.onClick AddPage ]
            [ Html.text "Add page"
            ]
        , Html.button [ Html.Events.onClick RemovePage ]
            [ Html.text "Remove page"
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PageMsg msg ->
            let
                ( newPages, effects ) =
                    Pages.updateStack msg model.pages
            in
                ( { model | pages = newPages }, Cmd.map PageMsg effects )

        AddPage ->
            { model | pages = Page.push (Pages.OneModel (Pages.One.init { userId = 5 })) model.pages } ! []

        RemovePage ->
            { model | pages = Page.pop model.pages } ! []


main : Program Never Model Msg
main =
    Html.program
        { init = ( init, Cmd.none )
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
