import AnimationFrame
import Signal
import Text
import Mouse
import Graphics.Element (flow, down)

display counter1 counter2 = flow down
    [ Text.asText counter1
    , Text.asText counter2
    ]

main = Signal.map2 display
    (Signal.foldp (+) 0 AnimationFrame.frame)
    (Signal.foldp (+) 0 (AnimationFrame.frameWhen Mouse.isDown))