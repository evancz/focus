import Focus (..)

x : Focus { r | x:a } a
x = create .x (\f r -> { r | x <- f r.x })

y : Focus { r | y:a } a
y = create .y (\f r -> { r | y <- f r.y })

position : Focus { r | position:a } a
position = create .position (\f r -> { r | position <- f r.position })

velocity : Focus { r | velocity:a } a
velocity = create .velocity (\f r -> { r | velocity <- f r.velocity })

object =
    { position = { x=3, y=4 }
    , velocity = { x=1, y=1 }
    }

physics dt object =
    object
      |> update (position => x) (\px -> px + object.velocity.x * dt)
      |> update (position => y) (\py -> py + object.velocity.y * dt)

main = asText (physics 1 object)