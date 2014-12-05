import Monitor
import Signal
import Text

main = Signal.map Text.asText (Signal.foldp (+) 0 Monitor.refresh)