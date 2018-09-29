neat
====

A Fast Retargetable Template Engine written by [Alvaro J. Genial](http://alva.ro) in Haskell.

[![Build Status](https://travis-ci.org/ajg/neat.png?branch=master)](https://travis-ci.org/ajg/neat)
[![Hackage](http://img.shields.io/hackage/v/neat.svg)](https://hackage.haskell.org/package/neat)
[![MIT license](http://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Synopsis
--------

Neat is a slightly unusual templating tool that does not interpret templates at runtime; rather, it compiles templates statically from the source (input) language into the target (output) language. In that sense `neat` can be thought of as a very flexible preprocessor masquerading as something fancier. Of course, the result can then be embedded or compiled directly in order to accept arbitrary data at runtime and transform it as desired, dynamically.

There are [advantages](#advantages) and [disadvantages](#disadvantages) to this approach; one of the nice side-effects is that `neat` has the property of being [self-hosting](#self-hosting).

Status
------

Neat is still experimental and likely to change in the future.

Motivation
----------

Syntax matters.

Templates can bridge the gap between different audiences understanding a shared output specification. Neat is an attempt to broaden the set of choices available in this endeavor while offering the opportunity for increased type safety and performance.

Dependencies
------------

The only requirements are the `base`, `filepath` and `parsec` packages. It is tested with GHC 7.4 and 7.6, but in theory doesn't require them—please open an issue for compatibility problems.

Setup
-----

### Using Cabal

```shell
$ cabal install neat
...
```

### Using Git

```shell
$ git clone https://github.com/ajg/neat.git
...
$ cd neat
$ ghc Main -o neat
...
```

### Using Curl

```shell
$ curl -LOk https://github.com/ajg/neat/archive/master.zip
...
$ unzip master.zip
...
$ cd neat-master
$ ghc Main -o neat
...
```

Usage
-----

The [command-line tool](#command-line-tool) is very rudimentary at the moment.

 - `neat --hs Foo.hs.neat` will produce a (Haskell) file named `Foo.hs`
 - `neat --xml Foo.hs.neat` will produce an (XML) file named `Foo.hs.neat.xml`
 - `neat --xslt Foo.hs.neat` will produce an (XSLT) file named `Foo.hs.xsl`

Examples
--------

 - [HTML page generator](./Example/HTML/Page.hs.neat)
 - [Java code emitter](./Example/Java/Emitter.hs.neat)
 - [Neat's own templates](#self-hosting)

Advantages
----------

 - Templates can be compiled directly in the target language, which can produce very fast output.
 - Templates can be verified and type-checked in the target language, eliminating a large class of errors.
 - Templates can be given data in its natural (however typed) form, with no need for an intermediary.
 - Template functionality can be extended easily and seamlessly using any facility (e.g. functions) available in the target language.

Disadvantages
-------------

 - Processing templates requires an additional compilation step (though any decent build system can mitigate the issue.)
 - Creating dynamic templates is difficult in statically-compiled languages.

Components
----------

### Command-line tool

The main executable is just a thin wrapper around the [library](#library); what it produces does not itself rely on Haskell—see the [usage section](#usage).

### Library

The library is a set of Haskell modules that can be combined to parse, manipulate and generate templates; the library can be used independently of the [command-line tool](#command-line-tool), though its use is limited to Haskell, whereas the rest of the system is not.

#### Text.Neat.Input

This is a module with common utilities for input modules.

#### Text.Neat.Input.*

These are library modules that take text, parse it, and produce a template from it. There's only one parser currently:

 - Django: modeled after Django's template system.

#### Text.Neat.Output

This is a module with common utilities for output modules as well as the `Output` type class, which encapsulates the way values are output from Haskell, and the `Zero` type class, which determines what values are considered "false/empty/null/nil."

(Note: At the moment the module contains a {flexible, overlapping, undecidable, possibly incoherent} instance of `Output` that automatically grandfathers anything with a `Show` instance into it for convenience. Since that behavior is probably overreaching in a lot of cases, it will likely be factored out and moved to an output-specific utility module. Possibly the same goes for `Zero`.)

#### Text.Neat.Output.*

These are library modules that take a template and generate text from it. The current choices are:

 - Haskell: the result is Haskell code (typically either a module or the main program.)
 - XML: the result is an XML representation of the input template.
 - XSLT: the result is a (theoretical) XSLT parallel of the input template.

#### Text.Neat.Template

This module contains data types for a relatively abstract, low common denominator template specification; it's roughly what [XML Infoset](http://www.w3.org/TR/xml-infoset/) is to concrete XML.

Self-hosting
------------

Neat is built using itself: the original (hand-crafted) output generator, [`Haskell0.hs`](./Text/Neat/Output/Haskell0.hs), is replaced by a version generated from a `neat` template, [`Haskell.hs.neat`](./Text/Neat/Output/Haskell.hs.neat). Similarly, other output generators use neat templates to produce executable Haskell.

Extensibility
-------------

Neat can be extended in various ways. In ascending order of difficulty:

 - Add an output module: copy one of the existing ones and go from there; then run `./neat --hs` on it (if it's a Neat template—it doesn't have to be); finally, choose a flag & extension and add it to [`Main.hs`](./Main.hs).
 - Add an input module: copy the existing [`Django`](./Text/Neat/Input/Django.hs) module and alter the syntax (built on `parser`) to suit the desired input format (or use a different parsing mechanism); then add a way to use it to [`Main.hs`](./Main.hs).
 - Extend and/or modify the generic [`Template`](./Text/Neat/Template.hs) schema; this will require changes to all output generators at a mininum (including re-running `./neat --hs` on the template-based ones), otherwise there's a high chance of inexhaustive patterns (i.e. nasty partial functions) or outright compilation errors due to missing `Output` instances; it may require changes to input parsers as well, depending on the change.

Future Work
-----------

 - More intelligent and/or precise whitespace/newline elision
 - Escape transliterated comments
 - Clean up emitted code so that hlint doesn't complain
 - `ByteString` / `Data.Text` support
 - Proper parsing of bindings and values
 - Proper parsing of command line flags
 - More documentation
 - Tests
 - Use type singletons or data kinds to make Output language-dependent

License
-------

This library is distributed under the MIT [LICENSE](./LICENSE.md).
