# AnimationFrame

This library provides time Signals that are synchronized to the monitor's frame rate, by binding javascript's requestAnimationFrame. Using `AnimationFrame.frame` or `AnimationFrame.frameWhen` instead of `(Time.fps 60)` or `(Time.fps 60)` makes it possible (but not guaranteed...) to achieve 60 fps animation without stutter in Elm.

## Example Usage

```elm
import AnimationFrame
import Text
import Signal

main = Signal.map Text.asText (Signal.foldp (+) 0 AnimationFrame.frame)
```

## Performance comparison

* [Original animation](http://jsbin.com/mutage) using `(fps 60)` and the 0.13 runtime
* [Updated animation](http://jsbin.com/cimele) using `AnimationFrame.frame` and the modified runtime

The difference is more impressive in Chrome than it is in Firefox. Smooth animation in Firefox appears to be more strongly limited by garbage collection pauses.

The source code for the original animation is [available here](http://share-elm.com/sprout/54684d3de4b00800031feba0). The updated example just replaces `(fps 60)` with `AnimationFrame.frame`, but also uses the updated runtime.
