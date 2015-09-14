import AnimationFrame
import Signal exposing (Mailbox, mailbox, message)
import Time exposing (Time)
import Graphics.Element exposing (Element, flow, down, show)
import Graphics.Input exposing (button)
import Task exposing (Task, andThen)


type Action
    = RequestTick
    | ReceiveTick Time
    | NoOp


type alias Model = List Time


actions : Mailbox Action
actions = Signal.mailbox NoOp


update : Action -> Model -> Model
update action model =
    case action of
        ReceiveTick interval ->
            interval :: model

        _ ->
            model


reaction : Action -> Maybe (Task () ())
reaction action =
    case action of
        RequestTick ->
            Just <|
                AnimationFrame.wait
                    `andThen` (Signal.send actions.address << ReceiveTick)

        _ ->
            Nothing


view : Model -> Element
view model =
    flow down <|
        button (message actions.address RequestTick) "Request Animation Frame"
        ::
        List.map show model


models : Signal Model
models = Signal.foldp update [] actions.signal


main : Signal Element
main = Signal.map view models


port reactions : Signal (Task () ())
port reactions = Signal.filterMap reaction (Task.succeed ()) actions.signal 
