# Alf - Relational Algebra at your fingertips (version 0.10.0)

[![Build Status](https://secure.travis-ci.org/blambeau/alf.png)](http://travis-ci.org/blambeau/alf)
[![Dependency Status](https://gemnasium.com/blambeau/alf.png)](https://gemnasium.com/blambeau/alf)

## Links

* http://blambeau.github.com/alf
* http://rubydoc.info/gems/alf
* http://github.com/blambeau/alf
* http://rubygems.org/gems/alf

## What & Why

Alf brings the relational algebra both in Shell and in Ruby. In Shell, because
manipulating any relation-like data source should be as straightforward as a one-liner.
In Ruby, because I've never understood why programming languages provide data structures
like arrays, hashes, sets, trees and graphs but not _relations_...

## Ruby Example

    # Load from .csv file
    r = Alf.load "suppliers.csv"

    # Those suppliers that live in london
    r.restrict :city => 'London'

    # Which suppliers by city?
    r.group([:sid, :name, :status], :suppliers)

## Shell Example

    % alf show suppliers.csv

    +------+-------+---------+--------+
    | :sid | :name | :status | :city  |
    +------+-------+---------+--------+
    | S1   | Smith |      20 | London |
    | S2   | Jones |      10 | Paris  |
    | S3   | Blake |      30 | Paris  |
    | S4   | Clark |      20 | London |
    | S5   | Adams |      30 | Athens |
    +------+-------+---------+--------+

    % alf group --allbut suppliers.csv -- city -- suppliers

    +--------+----------------------------+
    | :city  | :suppliers                 |
    +--------+----------------------------+
    | London | +------+-------+---------+ |
    |        | | :sid | :name | :status | |
    |        | +------+-------+---------+ |
    |        | | S1   | Smith |      20 | |
    |        | | S4   | Clark |      20 | |
    |        | +------+-------+---------+ |
    | Paris  | +------+-------+---------+ |
    |        | | :sid | :name | :status | |
    |        | +------+-------+---------+ |
    |        | | S2   | Jones |      10 | |
    | ...    | ...                        |
    +--------+----------------------------+

## Install, bundler, require

    % [sudo] gem install alf [fastercsv, ...]
    % alf --help

    # API is not considered stable enough for now, please use
    gem "alf", "= 0.13.0"

    # The following should not break your code, but is a bit less safe,
    # until 1.0.0 has been reached
    gem "alf", "~> 0.13.0"

## Related Work & Tools

- You should certainly have a look at the Third Manifesto website: {http://www.thethirdmanifesto.com/}
- Why not reading the {http://www.dcs.warwick.ac.uk/~hugh/TTM/DBE-Chapter01.pdf
  third manifesto paper} itself?
- Also have a look at {http://www.dcs.warwick.ac.uk/~hugh/TTM/Projects.html other
  implementation projects}, especially {http://dbappbuilder.sourceforge.net/Rel.php Rel}
  which provides an implementation of the **Tutorial D** language.
- {https://github.com/dkubb/veritas Dan Kubb's Veritas} project is worth considering
  also in the Ruby community. While very similar to Alf in providing a pure ruby
  algebra implementation, Veritas mostly provides a framework for manipulating
  and statically analyzing algebra expressions so as to be able to
  {https://github.com/dkubb/veritas-optimizer optimize them} and
  {https://github.com/dkubb/veritas-sql-generator compile them to SQL}. We are
  working together with Dan Kubb to see how Alf and Veritas could be closer from
  each other in the future, if not in their codebase, at least in using the very
  same terminology for the same concepts.

## Contributing

You know the rules:

* The code is on github https://github.com/blambeau/alf
* Please report any problem or bug in the issue tracker on github
* Don't hesitate to fork and send me a pull request for any contribution/idea!

Alf is distributed under a MIT licence. Please let me know if it does not fit
your needs and I'll see what I can do!

## Roadmap

Below is what I've imagined about Alf's future. However, this is to be interpreted
as my own wish list, while I would love hearing yours instead.

- Towards 1.0.0, I would like to stabilize and document Alf public APIs as well
  as internals (a few concepts are still unstable there). Alf also has a certain
  number of limitations that are worth overcoming for version 1.0.0. The latter
  include the semantically wrong way of applying joins on sub-relations, the
  impossibility to use Lispy expressions on sub-relations in extend, and the error
  management which is unspecific and unfriendly so far.
- I also would like starting collecting  Reader, Renderer and Environment
  contributions for common data sources (SQL, NoSQL, CSV, LOGS) and output
  formats (HTML, XML, JSON). Contributions could be either developped as different
  gem projects or distributed with Alf's gem and source code, I still need to
  decide the exact policy (suggestions are more than welcome here)
- Alf will remain a practical tool before everything else. In the middle term,
  I would like to complete the set of available operators (relational and non-
  relational ones). Some of them will be operators described in D & D books
  while others will be new suggestions of mine.
- In the long term Alf should be able to avoid loading tuples in memory (under
  a certain number of conditions on datasources) for almost all queries.
- Without targetting a fast tool at all, I also would like Alf to provide a basic
  optimizer that would be able to push equality restrictions down and materialize
  sub-expressions used more than once in with expressions.

## Versioning policy

Alf respects {http://semver.org/ semantic versioning}, which means that it has
a X.Y.Z version number and follows a few rules.

- The public API is made of the commandline tool, the Lispy dialect and the
  Relation datastructure. This API will become stable with version 1.0.0 in a
  near future.
- Currently, version 1.0.0 **has not been reached**. It means that **anything
  may change at any time**. Best effort will be done to upgrade Y when backward
  incompatible changes occur.
- Once 1.0.0 will be reached, the following rules will be followed:
  - Backward compatible bug fixes will increase Z.
  - New features and enhancements that do not break backward compatibility of
    the public API will increase the Y number.
  - Non backward compatible changes of the public API will increase the X
    number.

All classes and modules but Alf module, the Lispy DSL and Alf::Relation are part
of the private API and may change at any time. A best-effort strategy is followed
to avoid breaking internals on tiny (Z) version increases, especially extension
points like Reader and Renderer.

## Enjoy Alf!

- No problem dude!
