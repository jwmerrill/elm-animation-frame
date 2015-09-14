module AnimationFrame where

{-| This library is modeled after Elm's time module. It provides Signals that
are synchronized with the monitor's frame rate by binding javascript's
requestAnimationFrame. `AnimationFrame.frame` and `AnimationFrame.frameWhen` are similar
to `(Time.fps 60)` and `(Time.fpsWhen 60)` respectively, but they more reliably
fire once per frame.

You can also use `wait` to synchronize tasks with the monitor's frame rate.

#Tickers
@docs frame, frameWhen

#Task
@docs wait
-}

import Native.AnimationFrame
import Signal
import Time exposing (Time)
import Task exposing (Task)


{-| Same as the frame function, but you can turn it on and off. Allows you
to do brief animations based on user input without major inefficiencies.
The first time delta after a pause is always zero, no matter how long
the pause was. This way summing the deltas will actually give the amount
of time that the output signal has been running.
-}
frameWhen : Signal.Signal Bool -> Signal.Signal Time.Time
frameWhen = Native.AnimationFrame.frameWhen


{-| Signal that fires once per frame with the time delta since the last frame.
Note that "once per frame" is an intent, not a guarantee.
-}
frame : Signal.Signal Time.Time
frame = frameWhen (Signal.constant True)


{-| A task which waits until an animation frame is needed, and then reports the
`Time` provided by the browser to the `requestAnimationFrame` callback. To use
this task, you would typically add an `andThen` to do something when the
animation frame is needed, possibly using the reported `Time`.
-}
wait : Task x Time
wait = Native.AnimationFrame.wait
