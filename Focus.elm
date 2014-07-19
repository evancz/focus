module Focus (get, set, update, (=>), create) where
{-| Our goal is to update a field deep inside some nested records. For example,
if we want to add one to `object.physics.velocity.x` or set it to zero, we would
be writing code like this:

    update (physics => velocity => x) (\x -> x + 1) object

    set (physics => velocity => x) 0 object

This means you could avoid writing record update syntax which would be messier.

**Warning!** It is possible that the concept of a `Focus` is harmful to code
quality in that it can help you to be lax with abstraction boundaries. By making
it easy to look deep inside of data structures, it encourages you to stop
thinking about how to make these substructures modular, perhaps leading to an
architecture that is not as nice and has extra conceptual complexity. It may
also make your code slower by encouraging you to take many passes over data,
creating lots of intermediate data structures for no particular reason.

# Get, Set, Update
@docs get, set, update

# Compose Foci
@docs (=>)

# Create your own Focus
@docs create
-}

type Focus big small =
    { get : big -> small
    , update : (small -> small) -> big -> big
    }

{-| A `Focus` is a value. It describes a strategy for getting and updating
things. This function lets you define a `Focus` yourself by providing a `get`
function and an `update` function.
-}
create : (big -> small) -> ((small -> small) -> big -> big) -> Focus big small
create get update =
    { get=get, update=update }

{-| Get a small part of a big thing.

    type X r = { r | x:Float }

    x : Focus (X r) Float

    get x { x=3, y=4 } == 3

Seems sort of silly given that you can just say `.x` to do the same thing. It
will become much more useful when we can begin to compose foci, so keep reading!
-} 
get : Focus big small -> big -> small
get focus big =
    focus.get big

{-| Set a small part of a big thing.

    type X r = { r | x:Float }

    x : Focus (X r) Float

    set x 42 { x=3, y=4 } == { x=42, y=4 }
-}
set : Focus big small -> small -> big -> big
set focus small big =
    focus.update (always small) big

{-| Update a small part of a big thing.

    type X r = { r | x:Float }

    x : Focus (X r) Float

    update x sqrt { x=9, y=10 } == { x=3, y=10 }

This lets us chain updates without any special record syntax:

    type Y r = { r | y:Float }

    y : Focus (Y r) Float

    point
      |> update x sqrt
      |> update y sqrt

The downside of this approach is that this means we take two passes over the
record, whereas normal record syntax would only have required one.
-}
update : Focus big small -> (small -> small) -> big -> big
update focus f big =
    focus.update f big

-- COMPOSING FOCI

{-| The power of this library comes from the fact that you can compose many
foci. This means we can update a field deep inside some nested records. For
example, perhaps we want to add one to `object.physics.velocity.x` or set it to
zero.

    physics  : Focus { r | physics:a } a
    velocity : Focus { r | velocity:a } a
    x        : Focus { r | x:a } a
    y        : Focus { r | y:a } a

    update (physics => velocity => x) (\x -> x + 1) object

    set (physics => velocity => x) 0 object

This would be a lot messier with typical record update syntax! This is what
makes this library worthwhile, but also what makes it dangerous. You will be
doing a lot of silly work if you start writing code like this:

    object
      |> set (physics => velocity => x) 0
      |> set (physics => velocity => y) 0

It is pretty, but you pay for it in performance because you take two passes
over `object` instead of one.
-}
(=>) : Focus big medium -> Focus medium small -> Focus big small
largerFocus => smallerFocus =
    { get big = smallerFocus.get (largerFocus.get big)
    , update f big = largerFocus.update (smallerFocus.update f) big
    }