Elm.Native.AnimationFrame = {};
Elm.Native.AnimationFrame.make = function(localRuntime) {

  localRuntime.Native = localRuntime.Native || {};
  localRuntime.Native.AnimationFrame = localRuntime.Native.AnimationFrame || {};
  if (localRuntime.Native.AnimationFrame.values) return localRuntime.Native.AnimationFrame.values;

  var Signal = Elm.Signal.make(localRuntime);
  var NS = Elm.Native.Signal.make(localRuntime);

  // TODO Should be localRuntime.requestAnimationFrame, and should be shimmed if we care
  // about IE9. Do we care about IE9?
  var requestAnimationFrame = window.requestAnimationFrame || function () {};
  var cancelAnimationFrame = window.cancelAnimationFrame || function () {};

  function frameWhen(isOn) {
    var prev = 0, curr = 0, wasOn = true;
    var ticker = NS.input(curr);
    function tick(curr) {
      var diff = (curr > prev) ? curr - prev : 0;
      prev = curr;
      localRuntime.notify(ticker.id, diff);
    }
    // When we transition from off to on, reset prev so that the first tick will be 0.
    function zeroThenTick(curr) {
      prev = curr;
      tick(curr);
    }
    var rafID = 0;
    function f(isOn, t) {
      if (isOn) {
        rafID = requestAnimationFrame(wasOn ? tick : zeroThenTick);
      } else if (wasOn) {
        cancelAnimationFrame(rafID);
      }
      wasOn = isOn;
      return t;
    }
    return A3(Signal.map2, F2(f), isOn, ticker);
  }

  return localRuntime.Native.AnimationFrame.values = {
    frameWhen : frameWhen
  };

};
