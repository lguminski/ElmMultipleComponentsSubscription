port module Child exposing (..)

type alias Model =
  {
    id : ComponentId
  }

type alias ComponentId =
  Int

type Msg
  = NoOp
  | ProcessData String
  | RouteData (ComponentId, String)
  
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [ sendData RouteData ]

port sendData : ((ComponentId, String) -> msg) -> Sub msg

initialize : ComponentId -> Model
initialize componentId =
  {
    id = componentId
  } 

init : ( Model, Cmd Msg )
init =
  {
    id = 0
  } ! []

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of

    NoOp ->
      model ! []

    RouteData (componentId, val) ->
      if componentId == model.id then
        update (ProcessData val) model
      else
        model ! []

    ProcessData data ->
      let
        _ =
          Debug.log "Data received : " data
      in
        model ! []

