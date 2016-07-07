# Focus

A Focus is a way to work with particular parts of a large chunk of data. On the most basic level, it lets you `get` and `set` fields of a deeply nested record in a more composable way.


## Problems with this Idea

It is possible that the concept of a `Focus` is harmful to code quality in that it can help you to be lax with abstraction boundaries. By making it easy to look deep inside of data structures, it encourages you to stop thinking about how to make these substructures modular, perhaps leading to an architecture that is not as nice and has extra conceptual complexity.

The deeper problem may be that lenses are best when they are bidirectional, whereas a `Focus` is only in one direction. The issue is then that making proper lenses is not necessarily possible without changing the language itself.

Point is, I have yet to see any code that follows [The Elm Architecture](http://guide.elm-lang.org/architecture/index.html) that gets *better* by adding this library.


## Background

This API is inspired by the concept of Bidirectional Lenses as described by Nate Foster and seen in a modified form in Haskell as &ldquo;lenses&rdquo; and in ClojureScript as &ldquo;cursors&rdquo;. My personal opinions and understanding come primarily from [this talk][spj] by Simon Peyton Jones and [Nate Foster's PhD dissertation][dissertation] on *bidirectional* lenses. I chose the name &ldquo;Focus&rdquo; because it is sort of like a lens that only lets you see in one direction.

[spj]: https://skillsmatter.com/skillscasts/4251-lenses-compositional-data-access-and-manipulation
[dissertation]: http://www.cs.cornell.edu/~jnfoster/papers/jnfoster-dissertation.pdf
