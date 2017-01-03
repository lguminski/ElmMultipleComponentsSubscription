port module Parent exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import List
import Child

type alias Model =
  {
    children : List Child.Model
  }

init : ( Model, Cmd Msg )
init = { 
    children = [
      Child.initialize 1
      , Child.initialize 2
    ]
  } ! []

type Msg
  = NoOp
  | ChildMessage Child.Model Child.Msg

main =
  Html.program
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

view : Model -> Html Msg
view model =
  div [] []

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [ Sub.map ChildMessage (Child.subscriptions model.child) ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of

    NoOp ->
      model ! []

    ChildMessage childModel childMessage ->
      let
        (updatedChildModel, cmd) =
          Child.update childMessage childModel
      in
      { model | children = List.map (\x -> if x.id == childModel.id then updatedChildModel else x) model.children} ! [ Cmd.map (ChildMessage childModel) cmd ]
