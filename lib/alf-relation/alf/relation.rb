module Alf
  #
  # Defines an in-memory relation data structure.
  #
  # A relation is a set of tuples; a tuple is a set of attribute (name, value) pairs. The
  # class implements such a data structure with full relational algebra installed as
  # instance methods.
  #
  # Relation values can be obtained in various ways, for example by invoking a relational
  # operator on an existing relation. Relation literals are simply constructed as follows:
  #
  #     Alf::Relation[
  #       # ... a comma list of ruby hashes ...
  #     ]
  #
  # See main Alf documentation about relational operators.
  #
  class Relation
    extend Domain::Reuse.new(::Set)
    include Algebra::Operand
    include Enumerable
    include Lang::ObjectOriented

    coercions do |c|
      c.delegate :to_relation
      c.coercion(Hash) do |v,_|
        throw :next_rule unless v.size==1 and v.values.first.is_a?(Array)
        key, values = v.to_a.first
        tuples      = values.map{|value| Tuple.new(key.to_sym => value) }.to_set
        Relation.new(tuples)
      end
      c.coercion(Hash) do |v,_|
        Relation.new(Set.new << Tuple.coerce(v))
      end
      c.coercion(Tuple) do |v,_|
        Relation.new(Set.new << v)
      end
      c.upon(Enumerable) do |v,_|
        Relation.new(v.map{|t| Tuple.coerce(t)}.to_set)
      end
      c.coercion(Path.like) do |v,_|
        Relation.new Alf.reader(v).map{|t| Tuple.new(t)}.to_set
      end
    end
    def self.[](*args); coerce(args); end

    def self.type(heading)
      Class.new(Relation).extend(DomainMethods.new(Heading.coerce(heading)))
    end

    class DomainMethods < Module

      def initialize(heading)
        define_method(:heading){
          heading
        }
        define_method(:===){|value|
          super(value) || (value.is_a?(Relation) && value.all?{|t| heading===t})
        }
        define_method(:==){|other|
          other.is_a?(Class) && other.superclass==Relation && other.heading==heading
        }
      end
    end # module DomainMethods

    reuse :each, :size, :empty?
    alias_method :tuples, :reused_instance
    alias_method :cardinality, :size

    # Returns the relation heading
    def heading
      @heading ||= Heading.new Engine::InferHeading.new(self).first
    end

    # Returns the attribute list, provided the relation contains at least one tuple.
    def attribute_list
      AttrList.new tuples.first.keys
    end

    # Returns a ReadOnly relvar
    def to_relvar
      Relvar::ReadOnly.new(self)
    end

    # Returns an engine Cog
    def to_cog
      Engine::Leaf.new(self)
    end

    # Returns a textual representation of this relation
    def to_s
      to_text
    end

    # Returns a  literal representation of this relation
    def to_ruby_literal
      "Alf::Relation[" +
        tuples.map{|t| Support.to_ruby_literal(t) }.join(', ') + "]"
    end
    alias :inspect :to_ruby_literal

    DEE = Relation.new(Set.new << Tuple.new({}))
    DUM = Relation.new(Set.new)

  private

    def _operator_output(op)
      Engine::Compiler.new.call(op).to_relation
    end

    def _self_operand
      self
    end

  end # class Relation
end # module Alf