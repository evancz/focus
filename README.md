# Focus

A Focus is a way to work with particular parts of a large chunk of data. On the
most basic level, it lets you `get` and `set` fields of a record in a simple and
composable way. This means you could avoid writing special record update syntax
and use something that composes much more elegantly.

It gives you the ability to write stuff like `freeze` in the following snippet:

```elm
mario =
    { super = False
    , fire  = False
    , physics = { position = { x=3, y=4 }
                , velocity = { x=1, y=1 }
                }
    }

freeze object =
    set (physics => velocity) { x=0, y=0 } object
```

The *actual* goal of this library is to help architect large projects with many
independent widgets. If we have three widgets with some shared state, we do not
necassarily want to give each widget full access to that shared state. Instead
we can have them return a function that acts just on the state they care about,
and we can use a `Focus` to apply that change.

It is not yet clear if this will actually be any nicer than just using typical
record update syntax in a [well-architected][architecture] application, because
it is likely no one is actually dealing with particularly deep records. More
experimentation is needed to figure this out.

[architecture]: https://gist.github.com/evancz/2b2ba366cae1887fe621

## Possible Anti-Pattern?

It is possible that the concept of a `Focus` is harmful to code quality in that
it can help you to be lax with abstraction boundaries. By making it easy to
look deep inside of data structures, it encourages you to stop thinking about
how to make these substructures modular, perhaps leading to an architecture that
is not as nice and has extra conceptual complexity.

The deeper problem may be that lenses are best when they are bidirectional,
whereas a `Focus` is only in one direction. The issue is then that making proper
lenses is not necessarily possible without changing the language itself.

## Background

This API is inspired by the concept of Bidirectional Lenses as described by Nate
Foster and seen in a modified form in Haskell as "lenses" and in ClojureScript
as "cursors". My personal opinions and understanding come primarily from [this
talk][spj] by Simon Peyton Jones and [Nate Foster's PhD
dissertation][dissertation] on *bidirectional* lenses. I chose the name "Focus"
because it is sort of like a lens that only lets you see in one direction.

[spj]: https://skillsmatter.com/skillscasts/4251-lenses-compositional-data-access-and-manipulation
[dissertation]: http://www.cs.cornell.edu/~jnfoster/papers/jnfoster-dissertation.pdf

## Making Focus more convenient

Implementations of this idea in JS and Clojure rely heavily on the fact that the
languages are dynamically typed and you can do runtime introspection. Haskell
relies heavily on Template Haskell (a sort of macro system) to generate all of
the necessary code. In Elm, [type-directed macros][tdm] may make things more
convenient, but it is unclear exactly how this might work or if it is
worthwhile.

[tdm]: https://docs.google.com/document/d/11a7W5u2U6WkfVH5W8AMHz4I08cHnuJFtjVWjbcZtUO4/edit#heading=h.bw7ajrm0ql11
