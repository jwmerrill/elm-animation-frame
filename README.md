# AnimationFrame

This library provides time Signals that are synchronized to the monitor's frame rate, by binding javascript's requestAnimationFrame. Using `AnimationFrame.frame` or `AnimationFrame.frameWhen` instead of `(Time.fps 60)` or `(Time.fpsWhen 60)` makes it possible (but not guaranteed...) to achieve 60 fps animation without stutter in Elm.

You can also use `AnimationFrame.wait` to synchronize Tasks with the monitor's frame rate.

## Example Usage

```elm
import AnimationFrame
import Text
import Signal

main = Signal.map Text.asText (Signal.foldp (+) 0 AnimationFrame.frame)
```

See `examples/counter.elm` for a minimal working example that uses both `AnimationFrame.frame` and `AnimationFrame.frameWhen`. You can see this example in action [here](http://squishythinking.com/elm-animation-frame/examples/counter.html). The top counter uses `AnimationFrame.frame` to count continuously. The bottom counter uses `AnimationFrame.frameWhen` to count only when the mouse is down.

See `examples/task.elm` for a minimal working example that uses `Animation.wait` to control when a task executes.

## Performance Comparison

The following simple animation demonstrates the performance difference between using core's `Time.fps`, and `AnimationFrame.frame`

* [Time.fps](http://squishythinking.com/elm-animation-frame/examples/bubbles-fps.html) ([source](https://github.com/jwmerrill/elm-animation-frame/blob/gh-pages/src/bubbles-fps.elm))
* [AnimationFrame.frame](http://squishythinking.com/elm-animation-frame/examples/bubbles-frame.html) ([source](https://github.com/jwmerrill/elm-animation-frame/blob/gh-pages/src/bubbles-frame.elm))

