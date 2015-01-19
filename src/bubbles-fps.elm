import Mouse
import Basics (..)
import Color (..)
import List (..)
import Signal
import Time
import Graphics.Collage (..)

type alias Spring =
  { x0 : Float
  , y0 : Float
  , x1 : Float
  , y1 : Float
  , vx : Float
  , vy : Float
  , ax : Float
  , ay : Float
  , w : Float
  , g : Float
  }

defaultSpring : Spring
defaultSpring =
  { x0 = 0
  , y0 = 0
  , x1 = 0
  , y1 = 0
  , vx = 0
  , vy = 0
  , ax = 0
  , ay = 0
  , w = 1
  , g = 0.4
  }

verlet : (Float, Float) -> Spring -> Spring
verlet (mx, my) s =
  let
    x0 = mx
    y0 = my
    x1 = s.x1 + s.vx + 0.5*s.ax
    y1 = s.y1 + s.vy + 0.5*s.ay
    ax = s.w^2 * 0.01 * (x0 - x1) - s.w * s.g * 0.1414 * s.vx
    ay = s.w^2 * 0.01 * (y0 - y1) - s.w * s.g * 0.1414 * s.vy
  in
    { s | x0 <- x0
        , y0 <- y0
        , x1 <- x1
        , y1 <- y1
        , vx <- s.vx + 0.5 * (s.ax + ax)
        , vy <- s.vy + 0.5 * (s.ay + ay)
        , ax <- ax
        , ay <- ay
    }

m2c : (Int, Int) -> (Float, Float)
m2c (xi, yi) = ((toFloat xi) - 300, 300 - (toFloat yi))

update mouse springs = map (verlet (m2c mouse)) springs

displaySpring s = move (s.x1, s.y1) (alpha 0.8 (filled lightOrange (circle (10/s.w))))

display springs = collage 600 600
  ((filled darkRed (square 600)) :: (map displaySpring springs))

input = Signal.sampleOn (Time.fps 60) Mouse.position

springs = map (\e -> { defaultSpring | w <- 2^(-0.5 * e) }) [ -4 .. 4 ]

main = Signal.map display (Signal.foldp update springs input)
