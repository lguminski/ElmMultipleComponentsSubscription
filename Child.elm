module Child exposing (..)

type alias Model =
  {
    id : ComponentId
  }

type alias ComponentId =
  Int

type Msg
  = NoOp
  | ProcessData String
  
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

    ProcessData data ->
      let
        _ =
          Debug.log "Data received : " data
      in
        model ! []

