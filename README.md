# Elm Monitor

This library provides time Signals that are synchronized to the monitor's refresh rate, by binding javascript's requestAnimationFrame. Using `Monitor.refresh` or `Monitor.refreshWhile` instead of `(fps 60)` makes it possible (but not guaranteed...) to achieve 60 fps animation without stutter in Elm.

## Example Usage

```elm
import Monitor

main = asText <~ (foldp (+) 0 Monitor.refresh)
```

## Status

This library is currently experimental. Elm's internal dom update routine also uses `requestAnimationFrame`, and has what is in my view a bug such that rendering can be delayed indefinitely by using `requestAnimationFrame` to schedule a new draw on each frame.

In my tests, this library works fine in Firefox, but in Chrome, it is necessary to use a modified runtime that fixes Elm's dom update scheduler. The updated runtime is available [as a gist](https://gist.github.com/jwmerrill/4d3816a118a65080ea12) ([diff with comments](https://gist.github.com/jwmerrill/5a4c789d17380966a420)).

## Performance comparison

* [Original animation](http://jsbin.com/mutage) using `(fps 60)` and the 0.13 runtime
* [Updated animation](http://jsbin.com/cimele) using `Monitor.refresh` and the modified runtime

The difference is more impressive in Chrome than it is in Firefox. Smooth animation in Firefox appears to be more strongly limited by garbage collection pauses.

The source code for the original animation is [available here](http://share-elm.com/sprout/54684d3de4b00800031feba0). The updated example just replaces `(fps 60)` with `Monitor.refresh`, but also uses the updated runtime.
