Elm.Native.AnimationFrame = {};
Elm.Native.AnimationFrame.make = function(elm) {

  elm.Native = elm.Native || {};
  elm.Native.AnimationFrame = elm.Native.AnimationFrame || {};
  if (elm.Native.AnimationFrame.values) return elm.Native.AnimationFrame.values;

  var Signal = Elm.Signal.make(elm);
  var NS = Elm.Native.Signal.make(elm);

  // TODO Should be elm.requestAnimationFrame, and should be shimmed if we care
  // about IE9. Do we care about IE9?
  var requestAnimationFrame = window.requestAnimationFrame || function () {};
  var cancelAnimationFrame = window.cancelAnimationFrame || function () {};

  function frameWhen(isOn) {
    var prev = 0, curr = 0, wasOn = true;
    var ticker = NS.input(curr);
    function tick(curr) {
      var diff = (curr > prev) ? curr - prev : 0;
      prev = curr;
      elm.notify(ticker.id, diff);
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

  return elm.Native.AnimationFrame.values = {
    frameWhen : frameWhen
  };

};
