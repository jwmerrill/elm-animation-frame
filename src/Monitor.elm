module Monitor where
{-| This library is modeled after Elm's time module. It provides Signals that
are synchronized with the monitor's refresh rate by binding javascript's
requestAnimationFrame. `Monitor.refresh` and `Monitor.refreshWhen` are similar
to `(Time.fps 60)` and `(Time.fpsWhen 60)` respectively, but they more reliably
fire once per frame.

#Tickers
@docs refresh refreshWhen
-}


import Native.Monitor
import Signal
import Time

{-| Same as the refresh function, but you can turn it on and off. Allows you
to do brief animations based on user input without major inefficiencies.
The first time delta after a pause is always zero, no matter how long
the pause was. This way summing the deltas will actually give the amount
of time that the output signal has been running.
-}
refreshWhen : Signal.Signal Bool -> Signal.Signal Time.Time
refreshWhen = Native.Monitor.refreshWhen


{-| Signal that fires once per frame with the time delta since the last frame.
Note that "once per frame" is an intent, not a guarantee.
-}
refresh : Signal.Signal Time.Time
refresh = refreshWhen (Signal.constant True)