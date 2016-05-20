import Focus exposing (..)
import Html exposing (..)



-- OBJECTS


type alias Object =
  { position : Point
  , velocity : Point
  }


type alias Point =
  { x : Float
  , y : Float
  }



-- DO STUFF


main : Html msg
main =
  text (toString (step 1.5 object))


object : Object
object =
  Object (Point 3 4) (Point 1 1)


step : Float -> Object -> Object
step dt object =
  object
    |> update (position => x) (\px -> px + object.velocity.x * dt)
    |> update (position => y) (\py -> py + object.velocity.y * dt)



-- FOCI


x : Focus { r | x:a } a
x =
  create .x (\f r -> { r | x = f r.x })


y : Focus { r | y:a } a
y =
  create .y (\f r -> { r | y = f r.y })


position : Focus { r | position : a } a
position =
  create .position (\f r -> { r | position = f r.position })


velocity : Focus { r | velocity : a } a
velocity =
  create .velocity (\f r -> { r | velocity = f r.velocity })
