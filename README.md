# Focus

A Focus is a way to work with particular parts of a large chunk of data. On the
most basic level, it lets you `get` and `set` fields of a record in a simple and
composable way. This means you could avoid writing special record update syntax
and use something that composes much more elegantly.

## Possible Anti-Pattern?

It is possible that the concept of a `Focus` is harmful to code quality in that
it can help you to be lax with abstraction boundaries. A modular architecture as
described [here](https://gist.github.com/evancz/2b2ba366cae1887fe621) happens
quite naturally in a world without `Focus`, but with the concept of `Focus`
there's a feeling that "maybe modularity is for suckers... Maybe I can get away
without it!"

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
the necessary code. In Elm, I think we'd need to implement [type-directed
macros][tdm] to make this truly pleasant in Elm, but the primary motivation for
doing that feature is still for serialization to JSON, XML, binary, etc.

[tdm]: https://docs.google.com/document/d/11a7W5u2U6WkfVH5W8AMHz4I08cHnuJFtjVWjbcZtUO4/edit#heading=h.bw7ajrm0ql11
