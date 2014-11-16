Elm.Native.Monitor = {};
Elm.Native.Monitor.make = function(elm) {

  elm.Native = elm.Native || {};
  elm.Native.Monitor = elm.Native.Monitor || {};
  if (elm.Native.Monitor.values) return elm.Native.Monitor.values;

  var Signal = Elm.Signal.make(elm);
  var NS = Elm.Native.Signal.make(elm);

  // TODO Should be elm.requestAnimationFrame, and should be shimmed if we care
  // about IE9. Do we care about IE9?
  var requestAnimationFrame = window.requestAnimationFrame || function () {};
  var cancelAnimationFrame = window.cancelAnimationFrame || function () {};

  function refreshWhen(isOn) {
    var prev = 0, curr = prev, diff = 0, wasOn = true;
    var ticker = NS.input(diff);
    function tick(zero) {
      return function(curr) {
        diff = zero ? 0 : curr - prev;
        if (prev > curr) {
          diff = 0;
        }
        prev = curr;
        elm.notify(ticker.id, diff);
      };
    }
    var rafID = 0;
    function f(isOn, t) {
      if (isOn) {
        rafID = requestAnimationFrame(tick(!wasOn && isOn));
      } else if (wasOn) {
        cancelAnimationFrame(rafID);
      }
      wasOn = isOn;
      return t;
    }
    return A3( Signal.lift2, F2(f), isOn, ticker );
  }

  return elm.Native.Monitor.values = {
    refreshWhen : refreshWhen
  };

};
