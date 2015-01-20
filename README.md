# AnimationFrame

This library provides time Signals that are synchronized to the monitor's frame rate, by binding javascript's requestAnimationFrame. Using `AnimationFrame.frame` or `AnimationFrame.frameWhen` instead of `(Time.fps 60)` or `(Time.fpsWhen 60)` makes it possible (but not guaranteed...) to achieve 60 fps animation without stutter in Elm.

## Example Usage

```elm
import AnimationFrame
import Text
import Signal

main = Signal.map Text.asText (Signal.foldp (+) 0 AnimationFrame.frame)
```

See `examples/counter.elm` for a minimal working example that uses both `AnimationFrame.frame` and `AnimationFrame.frameWhen`. You can see this example in action [here](http://squishythinking.com/elm-animation-frame/examples/counter.html). The top counter uses `AnimationFrame.frame` to count continuously. The bottom counter uses `AnimationFrame.frameWhen` to count only when the mouse is down.

## Performance Comparison

The following simple animation demonstrates the performance difference between using core's `Time.fps`, and `AnimationFrame.frame`

* [Time.fps](http://squishythinking.com/elm-animation-frame/examples/bubbles-fps.html) ([source](https://github.com/jwmerrill/elm-animation-frame/blob/gh-pages/src/bubbles-fps.elm))
* [AnimationFrame.frame](http://squishythinking.com/elm-animation-frame/examples/bubbles-frame.html) ([source](https://github.com/jwmerrill/elm-animation-frame/blob/gh-pages/src/bubbles-frame.elm))

The difference between these is pretty impressive on my fancy laptop in Chrome, but not so impressive in Firefox. See this [bugzilla ticket](https://bugzilla.mozilla.org/show_bug.cgi?id=1111361) for information on ongoing work to improve Firefox's GC to allow animations like this to run smoothly.
