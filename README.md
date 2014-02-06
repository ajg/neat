neat
====

A Fast Retargetable Template Engine written by [Alvaro J. Genial](http://alva.ro) in Haskell.

Synopsis
--------

Neat is a slightly unusual templating tool that does not interpret templates at runtime; rather, it compiles templates statically from the source (input) language into the target (output) language. In that sense `neat` can be thought of as a very flexible preprocessor masquerading as something fancier. Of course, the result can then be embedded or compiled in order to take data and transform it as desired, dynamically.

There are [advantages](#advantages) and [disadvantages](#disadvantages) to the approach taken by `neat`, including the nice side-effect of being [self-hosting](#self-hosting).

Dependencies
------------

A compatible version of GHC and `parsec`; details [to come](#future-work). (The generated output does not rely either of these.)

Setup
-----

A Cabal package with automatic installation is [in the works](#future-work). For now, roll those sleeves up and do something like:

```shell
$ git clone https://github.com/ajg/neat.git # Or download using wget/curl.
...
$ cd neat
$ ghc Main -o neat
```

Usage
-----

The [command-line tool](#command-line-tool) is very rudimentary at the moment.

 - `./neat -h Foo.hs.neat` will produce a (Haskell) file called `Foo.hs`
 - `./neat -x Foo.hs.neat` will produce an (XML) file called `Foo.hs.neat.xml`

Examples
--------

 - [HTML page generator](./Example/HTML/Page.hs.neat)
 - [Java code emitter](./Example/Java/Emitter.hs.neat)
 - [Neat's own templates](#self-hosting)

Advantages
----------

 - Templates can be compiled directly in the target language, which can produce very fast output.
 - Templates can be verified and type-checked in the target language, which can eliminate a large class of errors.
 - Templates can be given data in its natural (often typed) form, with no need for an intermediary.
 - Template functionality can be extended easily using any tool (e.g. functions) available in the target language.

Disadvantages
-------------

 - Processing templates requires an additional compilation step (though any decent build system mitigates the issue.)
 - Creating dynamic templates is difficult in statically-compiled languages.

Components
----------

### Command-line tool

The main executable is just a thin wrapper around the [library](#library); it does not require the use of Haskell—see the [usage section](#usage).

### Library

The library is a set of Haskell modules that can be combined to parse, manipulate and generate templates; the library can be used independently of the [command-line tool](#command-line-tool), though its use is limited to Haskell, whereas the rest of the system is not.

### Inputs

These are library modules that take text, parse it, and produce a template from it. There's only one parser currently:

 - Django: modeled after Django's template system.

### Outputs

These are library modules that take a template and generate text from it. The current choices are:

 - Haskell: the result is Haskell code (can be either a module or the main program.)
 - XML: the result is an XML representation of the input template.

Self-hosting
------------

Neat is built using itself: the original (hand-crafted) output generator ([`Haskell0.hs`](./Text/Neat/Outputs/Haskell0.hs)) is replaced by a version generated from a `neat` template ([`Haskell.hs.neat`](./Text/Neat/Outputs/Haskell.hs.neat)).

Future Work
-----------

 - More intelligent and/or precise whitespace/newline elision
 - Escape transliterated comments
 - Clean up & speed up emitted code
 - Proper parsing of bindings and values
 - Proper parsing of command line flags
 - Figure out mininum dependencies
 - Cabalify
 - More documentation
 - Tests
 - Travis config
 - Use type singletons or data kinds to make Output language-dependent

License
-------

This library is distributed under the MIT [LICENSE](./LICENSE).


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/ajg/neat/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
