module Pages.Two exposing (..)

import Html
import Data.Page as Page


type Msg
    = None


type alias Model =
    String


type alias Context =
    { organisationId : Int }


type alias PageMsg =
    Page.Msg Context Msg


type alias PageModel =
    Page.Model Context Model


view : Html.Html msg
view =
    Html.text "Page two"
