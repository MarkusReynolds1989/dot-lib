# dot-lib

[![Build Actions Status](https://github.com/markusreynolds1989/dot-lib/workflows/Build/badge.svg)](https://github.com/markusreynolds1989/dot-lib/actions)

A project to take the standard library from .net, especially F#, and port it to Racket so it's easier to work with.

1. Racket is very fun and powerful to use, it's dynamically typed and interpreted so better for things like scripting or just for quick work.
2. It has unconventional naming for functionality, or functions aren't organized like one would think. i.e. missing simple things like groupby, sum, fold for arrays, etc.
3. Solution - Replace the standard library with my own, copy it from F#.


## This Version
This is for regular untyped racket, basically this means increased interpreter speeds. If you need faster compiled speeds you should checkout dot-lib-typed when it's done.
