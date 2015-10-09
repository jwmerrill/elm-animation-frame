import AnimationFrame
import Signal
import Mouse
import Graphics.Element exposing (show, flow, down)

display counter1 counter2 = flow down
    [ show counter1
    , show counter2
    ]

main = Signal.map2 display
    (Signal.foldp (+) 0 AnimationFrame.frame)
    (Signal.foldp (+) 0 (AnimationFrame.frameWhen Mouse.isDown))