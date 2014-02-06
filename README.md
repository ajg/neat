neat
====

A Fast Retargetable Template Engine written by [Alvaro J. Genial](http://alva.ro) in Haskell.

Synopsis
--------

Neat is a slightly unusual templating tool that does not interpret templates at runtime; rather, it compiles templates statically from the source (input) language into the target (output) language. In that sense `neat` can be thought of as a very flexible preprocessor masquerading as something fancier. Of course, the result can then be embedded or compiled in order to take data and transform it as desired, dynamically.

There are [advantages](#advantages) and [disadvantages](#disadvantages) to the approach taken by `neat`; one of the nice side-effects is that `neat` has the property of being [self-hosting](#self-hosting).

Dependencies
------------

A compatible version of GHC and `parsec`; details [to come](#future-work). (These are needed only to build the `neat` [command-line tool](#command-line-tool) itself; the generated output does not depend on them.)

Setup
-----

A Cabal package with automatic installation is [in the works](#future-work). For now, roll those sleeves up and e.g.:

```shell
$ git clone https://github.com/ajg/neat.git # Or download using wget/curl.
...
$ cd neat
$ ghc Main -o neat
...
```

Usage
-----

The [command-line tool](#command-line-tool) is very rudimentary at the moment.

 - `./neat --hs Foo.hs.neat` will produce a (Haskell) file named `Foo.hs`
 - `./neat --xml Foo.hs.neat` will produce an (XML) file named `Foo.hs.neat.xml`
 - `./neat --xslt Foo.hs.neat` will produce an (XSLT) file named `Foo.hs.xsl`

Examples
--------

 - [HTML page generator](./Example/HTML/Page.hs.neat)
 - [Java code emitter](./Example/Java/Emitter.hs.neat)
 - [Neat's own templates](#self-hosting)

Advantages
----------

 - Templates can be compiled directly in the target language, which can produce very fast output.
 - Templates can be verified and type-checked in the target language, eliminating a large class of errors.
 - Templates can be given data in its natural (often typed) form, with no need for an intermediary.
 - Template functionality can be extended easily and seamlessly using any facility (e.g. functions) available in the target language.

Disadvantages
-------------

 - Processing templates requires an additional compilation step (though any decent build system can mitigate the issue.)
 - Creating dynamic templates is difficult in statically-compiled languages.

Components
----------

### Command-line tool

The main executable is just a thin wrapper around the [library](#library); it does not require the use of Haskell—see the [usage section](#usage).

### Library

The library is a set of Haskell modules that can be combined to parse, manipulate and generate templates; the library can be used independently of the [command-line tool](#command-line-tool), though its use is limited to Haskell, whereas the rest of the system is not.

#### Text.Neat.Template

This module contains data types for a relatively abstract, low common denominator template specification; it's roughly what [XML Infoset](http://www.w3.org/TR/xml-infoset/) is to concrete XML.

#### Text.Neat.Input

This is a module with common utilities for input modules.

#### Text.Neat.Input.*

These are library modules that take text, parse it, and produce a template from it. There's only one parser currently:

 - Django: modeled after Django's template system.

#### Text.Neat.Output

This is a module with common utilities for output modules as well as the `Output` type class, which encapsulates the way values are output from Haskell.

(Note: At the moment the module contains a {flexible, overlapping, undecidable, possibly incoherent} instance of `Output` that automatically grandfathers anything with a `Show` instance into it for convenience. Since that behavior is probably overreaching in a lot of cases, it will likely be factored out and moved to an output-specific utility module.)

#### Text.Neat.Output.*

These are library modules that take a template and generate text from it. The current choices are:

 - Haskell: the result is Haskell code (typically either a module or the main program.)
 - XML: the result is an XML representation of the input template.
 - XSLT: the result is an (theoretical) XSLT equivalent of the input template.

Self-hosting
------------

Neat is built using itself: the original (hand-crafted) output generator, [`Haskell0.hs`](./Text/Neat/Output/Haskell0.hs), is replaced by a version generated from a `neat` template, [`Haskell.hs.neat`](./Text/Neat/Output/Haskell.hs.neat).

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
