# AnimationFrame

This library provides time Signals that are synchronized to the monitor's frame rate, by binding javascript's requestAnimationFrame. Using `AnimationFrame.frame` or `AnimationFrame.frameWhen` instead of `(Time.fps 60)` or `(Time.fps 60)` makes it possible (but not guaranteed...) to achieve 60 fps animation without stutter in Elm.

## Example Usage

```elm
import AnimationFrame
import Text
import Signal

main = Signal.map Text.asText (Signal.foldp (+) 0 AnimationFrame.frame)
```

See `examples/counter.elm` for a minimal working example that uses both `AnimationFrame.frame` and `AnimationFrame.frameWhen`. You can build the example by running

```
elm-make --output=examlpes/counter.html examples/counter.elm
```

and then view it by opening the newly built `examples/counter.html`.