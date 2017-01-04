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
  | ChildMessage Child.ComponentId Child.Msg
  | RouteData (Child.ComponentId, String)

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
  Sub.batch [ sendData RouteData ]

port sendData : ((Child.ComponentId, String) -> msg) -> Sub msg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of

    NoOp ->
      model ! []

    ChildMessage componentId childMessage ->
        let
            childUpdates =
                List.map (\c -> if c.id == componentId then updateChild c else c ! []) model.children

            updateChild child =
                let
                    (updatedChildModel, cmd) =
                        Child.update childMessage child
                in
                    updatedChildModel ! [ Cmd.map (ChildMessage child.id) cmd ]

        in
            { model | children = List.map Tuple.first childUpdates }
                ! (List.map Tuple.second childUpdates)

    RouteData (componentId, val) ->
        update (ChildMessage componentId (Child.ProcessData val)) model

