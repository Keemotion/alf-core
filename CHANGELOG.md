# 0.12.0 / 2012-02-09

* Add a Relation() toplevel method that mimics Array(), Integer(), and so on.
  That method uses Tools::ToRelation which is a set of Myrrha coercion rules.
  The Relation() method helps building relation "literals" (say) for common 
  cases, such as the following:

      Relation(:name => "Alf")  
      # => (Relation (Tuple :name => "Alf"))

      Relation([{:name => "Alf"}, {:name => "Myrrha"}])
      # => (Relation (Tuple :name => "Alf"), (Tuple :name => "Myrrha"))

      Relation(:name => ["Alf", "Myrrha"])
      # => (Relation (Tuple :name => "Alf"), (Tuple :name => "Myrrha"))

# 0.11.1 / 2012-01-25

## Bugfixes

* Fix Aggregator.stddev and Lispy.stddev that were missing

# 0.11.0 / 2012-01-25

## Broken APIs (private sections only)

* All pipe() methods have been removed and replaced by arguments taken at
  construction time. This affects the implementation of operators and may
  require changes to contributed readers and renderers.
* Alf::Operator::Base    -> Alf::Operator::InstanceMethods
* Alf::Reader::Base      -> Alf::Reader::InstanceMethods
* Alf::Rendered::Base    -> Alf::Rendered::InstanceMethods
* Alf::Environment::Base -> Alf::Environment::InstanceMethods
* Alf::Aggregator::Base  -> Alf::Aggregator::InstanceMethods
* Alf::Buffer has been removed as well as the Sorted specialization.
* Alf::Environment::Explicit has been removed as well as associated tools.
* Ordering#order_of has been removed
* Ordering#order_by has been removed
* Alf::Tools.coerce now raise a Alf::CoercionError instead of a Myrrha::Error
  in case of coercion failure

## On the development side

* Bumped ruby.noe to 1.7.0
* Bumped rspec to 2.8.0
* Bumped sequel to 3.30.0

# 0.10.1 / 2011-08-31

## Miscellaneous enhancements

* Added Variance and Stddev aggregation operators; they are available under 
  Aggregator.variance{} and Aggregator.stddev{}, respectively
* Added a --pretty option to 'alf', whose semantics is delegated to the output 
  renderer. Same option is available on 'alf show'.
* 'alf show' now accepts an optional ordering argument. This avoids explicitely
  including non-relational sort invocations in your pipe (sorting should be 
  seen as a displaying issue)
* Added an options hash to text renderer, :float_format among others
* Added a --ff option to 'alf show', for float format in text rendering

## Bugfixes

* Alf::Environment::(Folder/Explicit)#dataset now correctly raises a 
  NoSuchDatasetError when the dataset cannot be found, as required by the
  specification.
* Alf::Reader.reader now correctly returns a Rash reader when invoked on a 
  StringIO

# 0.10.0 / 2011-08-15

## New recognized data sources

* Alf now provides an Environment implementation on top of a SQL database. 
  This means that SQL tables can now be used as data-sources. This feature 
  relies on the sequel gem ('gem install sequel' is required), that drives 
  recognized SQL servers. Then (don't forget that ALF_OPTS also exists):

      % alf --env=postgres://user:password@host/database show table

* Alf now recognizes and allows manipulating .csv files as first-class data
  sources. CSV output is also supported of course. Under ruby <= 1.9, the
  fastercsv gem is required ('gem install fastercsv' is required). Then:

      % alf restrict suppliers.csv -- "city == 'Paris'"    (input)
      % alf show suppliers --csv                           (output)
  
* Alf now recognizes and allows manipulating .log files as first-class data
  sources. This feature relies on request-log-analyzer gem that provides the
  parsers that Alf uses, and the log formats it recognizes 
  ('gem install request-log-analyzer' is required). See examples/logs.
  
## New operators and enhancements

* A GENERATOR operator is introduced. It allows generating a relation with one
  auto-number attribute, up to a given size.

* A COERCE operator is introduced. It provides a quick way to obtain type-safe
  relations from type-unsafe sources like .csv files. For example:
  
      % alf coerce mydirtyfile.csv -- name String  price Float  at Time
      
  The coerce operator is of course available in Ruby as well:
  
      (coerce "mydirtyfile.csv", :name => String, :price => Float, :at => Time)
      
* The DEFAULTS (non-relational) operator now accepts default values as tuple
  expressions. When used in shell, provided default values are now evaluated
  that way. This allows specifying default values as being computed on the 
  current tuple.

* Aggregations in the Lispy DSL must not be prefixed by Agg:: anymore.

## Miscellaneous enhancements

* Added 'alf --input-reader' to specify $stdin format (csv, rash, etc.)
* Added 'alf -Ipath' that mimics ruby's -I (add path to $LOAD_PATH before run)
* Lispy#run supports command arguments to be passed as a string
* Lispy#run supports piped commands, with '|' as in shell

## Hurting changes to Lispy DSL (and therefore to Relation)

* The attribute-name syntax of aggregation operators has been removed. The Agg::
  prefix must not be specified anymore.

      Agg::sum(:qty)    # !! error !!
      Agg::sum{ qty }   # !! error !!
      sum{ qty }        # simply, and only!

* The group aggregation operator has been removed. It will probably be replaced 
  in a future version. In the meantime, the GROUP relational operator allows 
  obtaining similar results.

* Lispy syntax of CLIP has changed (when used with --allbut option)

      (clip :suppliers, [:name, :city], true)                           (before)
      (clip :suppliers, [:name, :city], :allbut => true)                (after)

* Lispy syntax of DEFAULTS has changed (when used with --strict option)

      (defaults :suppliers, {:country => 'Belgium'}, true)              (before)
      (defaults :suppliers, {:country => 'Belgium'}, :strict => true)   (after)

* Lispy syntax of GROUP has changed (when used with --allbut option)

      (group :supplies, [:sid], :supplying, true)                       (before)
      (group :supplies, [:sid], :supplying, :allbut => true)            (after)

* Lispy syntax of PROJECT has changed (when used with --allbut option)

      (project :suppliers, [:name, :city], true)                        (before)
      (project :suppliers, [:name, :city], :allbut => true)             (after)

* Lispy syntax of SUMMARIZE has changed (when used with --allbut option)

      (summarize :supplies, [:qty, :pid], {...}, true)                  (before)
      (summarize :supplies, [:qty, :pid], {...}, :allbut => true)       (after)

## Hurting changes in shell

* The attribute-name syntax of aggregation operators has been removed

      sum(:qty)   # !! error !!
      sum{ qty }  # works

* Shell syntax of GROUP has changed (option separator before introduced name)

      % alf --text group supplies  -- pid qty supplying                 (before)
      % alf --text group supplies  -- pid qty -- supplying              (after)

* Shell syntax of WRAP has changed (option separator before introduced name)

      % alf --text wrap suppliers -- city status loc_and_status         (before) 
      % alf --text wrap suppliers -- city status -- loc_and_status      (after) 

* Shell syntax of QUOTA has changed (--by and --order become pure arguments)

      % alf quota supplies --by=sid --order=qty -- position count sum_qty "sum{ qty }" (before)
      % alf quota supplies -- sid -- qty -- position count sum_qty "sum{ qty }"        (after)

* Shell syntax of RANK has changed (--order becomes a pure argument)

      % alf rank parts --order=weight,desc,pid,asc -- position          (before)
      % alf rank parts -- weight desc pid asc -- position               (after)

* Shell syntax of SUMMARIZE has changed (--by becomes a pure argument)

      % alf summarize supplies --by=sid -- total_qty "sum{ qty }"        (before)
      % alf summarize supplies -- sid -- total_qty "sum{ qty }"          (after)

## Bug fixes 

* [In shell] Options are now correctly parsed in presence of option separators. 
  That is, every argument after a '--' separator is considered a non-option 
  argument. 

# 0.9.3 / 2011-07-23

## New operators (available both in shell and in Lispy DSL)

* Added MATCHING and NOT MATCHING operators. These operators are useful 
  shortcuts for the following expressions.
  
      (matching     l, r) := (project (join l, r), [l's attributes])
      (not_matching l, r) := (minus l, (matching l, r))
    
  For example: 
  
      # Give suppliers who supply at least one part
      (matching suppliers, supplies)

      # Give suppliers who don't supply any part
      (not_matching suppliers, supplies)

* Added RANK operator, which is useful for for computing quota queries as 
  illustrated below. See 'alf help rank' for details.
  
      # Give the three heaviest parts
      (restrict (rank :parts, [[:weight, :desc]], :pos), lambda{ pos < 3 })

## Enhancements when using Alf in shell

* added 'alf -r', that mimics 'ruby -r' (require library before run)

* When alf is invoked in shell (and only in this case), ALF_OPTS is used as 
  global options to apply as if they were specified inline: 
  
      % export ALF_OPTS="--env=. --yaml" 
      % alf show suppliers
      
  is the same as 
  
      % alf --env=. --yaml show suppliers
      
* 'alf --help' now distinguishes experimental operators (quota in particular) 
  from those coming from the (much more stable) **Tutorial D** specification. The 
  former should be used with care as their specification may change at any 
  time.  

## Enhancements when using Alf in Ruby 

* Alf.lispy now accepts any argument recognized by Environment.autodetect; it
  obtains its working Environment that way. Among others:
  
      Alf.lispy(Alf::Environment.folder("path/to/an/existing/folder"))
      
  is the same as: 
  
      Alf.lispy("path/to/an/existing/folder")

* Added Relation::DUM and Relation::DEE constants (relations of empty heading
  with no and one tuple, respectively). They are also available as DUM and DEE 
  in Lispy functional expressions.

* Added a Heading abstraction, as a set of attribute (name, type) pairs.

## Internal enhancements (extension points)

* The Reader and Renderer classes accept a Hash of options as third 
  constructor argument. These options can be used by extension points. 
  
* The Environment class now provides a class-based registering mechanism 'ala'
  Reader and Renderer. This allows auto-detecting the target environment when
  --env=... is used in shell. See Environment.autodetect and 
  Environment#recognizes? for contributing to this extension point. 
  
* Internals now rely on Myrrha for code generation. This means that all 
  datatypes can now be safely used in relations and dumped to .rash files in
  particular.  

## Bug fixes

* Added Relation#allbut, forgotten in two previous releases 
* Fixed (join xxx, DEE) and (join xxx, DUM)
* Fixed scoping bug when using attributes named :path, :expr or :block in
  Lispy compiled expressions (coming from .alf files)
* Fixed 'alf --yaml show suppliers' that renderer a --text table instead of
  a yaml output
* Fixed bugs when using Date and Time attributes with .rash files
* Fixed bugs when using Date and Time attributes in restrict expressions 
  compiled from the commandline
* Fixed a few bugs when using attribute names that are ruby keywords 
  (restrict & extend)  

# 0.9.2 / 2011.07.13

# Bug fixes

* Fixed the "alf show" command (undefined method `chain') 

# 0.9.1 / 2011.07.13

## Enhancements (public APIs)

* Added the in-memory Alf::Relation data structure and associated tooling.
  This allows using Alf in a object-oriented usual way, in addition to the
  functional DSL:
  
      Alf.lispy.evaluate {
        (join (restrict :suppliers, lambda{ status > 10 }), :cities)
      }
  
  is equivalent to
  
      suppliers, cities = [...], [...] 
      suppliers.restrict(lambda{ status > 10 }).join(cities)
      
  see README about how to obtain suppliers and cities relations in the first 
  place.

* Summarize now accepts a --allbut option, to specify 'by' attributes from an
  exclusion perspective

* .alf files are now evaluated in such a way that backtraces are "traceability
  friendly"

## Non backward-compatible changes to public APIs

* Lispy#with has been removed because not being stable enough. The clean way 
  of reusing sub-queries is as follows (non purely functional, so far)
  
      kept_suppliers = (restrict :suppliers, lambda{ status > 10 })
      with_countries = (join kept_suppliers, :cities)
      supplying      = (join with_countries, :supplies)
      (summarize supplying,
                 [:country],
                 :which => Agg::group(:pid),
                 :total => Agg::sum{ qty })
                 
* As a consequence, named data sources (Symbols, like :suppliers above) are 
  now resolved at compile time, which is less powerful, yet much simpler and
  sound.

* Nest and Unnest have been renamed to Wrap and Unwrap respectively. This is
  to better conform to **Tutorial D**'s terminology.
  
* Lispy#chain was kept public in 0.9.0 by error and has been entirely removed 
  from the DSL.

## Enhancements (internals)

* Reader.reader delegates to Reader.coerce when its first argument is not 
  a String. This allows calling Reader.reader(args.first || $stdin) in quickl
  commands for example.
  
* Operator, Operator::Relational and Operator::NonRelational have a .each 
  class method that yields operator classes
    
## Bug fixes

* Fixed a bug that led to an Nil error when using unary operators on $stdin
* Fixed a bug when summarizing or sorting on Symbol attributes with ruby 1.8
* Fixed numerous crashes under rubinius

# 0.9.0 / 2011.06.19

## Enhancements

* Birthday!
