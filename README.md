# Elm Monitor

This library provides time Signals that are synchronized to the monitor's refresh rate, by binding javascript's requestAnimationFrame. Using `Monitor.refresh` or `Monitor.refreshWhile` instead of `(fps 60)` makes it possible (but not guaranteed...) to achieve 60 fps animation without stutter in Elm.
