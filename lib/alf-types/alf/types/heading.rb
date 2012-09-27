module Alf
  module Types
    #
    # Defines a Heading, that is, a set of attribute (name,domain) pairs.
    #
    class Heading
      extend Domain::Scalar.new(:attributes)
      include Enumerable

      coercions do |c|
        c.delegate :to_heading
        c.coercion(Array){|arg,_|
          Heading.new Hash[arg.each_slice(2).map{|k,v|
            [ AttrName.coerce(k), Support.coerce(v, Module) ]
          }]
        }
        c.coercion(Hash){|arg,_|
          Heading.new Hash[arg.map{|k,v|
            [ AttrName.coerce(k), Support.coerce(v, Module) ]
          }]
        }
      end

      class << self

        alias :[] :coerce

      end # class << self

      # Returns the type associated to the attribute `name`.
      #
      # @param [Symbol] name the name of an attribute
      # @return [Class] the associated type
      def [](name)
        attributes[name]
      end

      # Yields each (name,domain) pair in turn.
      def each(&block)
        attributes.each(&block)
      end

      # Returns heading's cardinality, i.e. the number of (name,type) pairs.
      #
      # @return [Integer] the number of pairs
      def cardinality
        attributes.size
      end
      alias :size  :cardinality
      alias :count :cardinality

      # Coerces a single tuple
      def coerce(tuple)
        coercer = lambda{|(k,v)|
          [k, attributes.has_key?(k) ? Support.coerce(v, self[k]) : v]
        }
        if tuple.is_a?(Hash)
          Tuple(tuple, &coercer)
        else
          tuple.map{|t| Tuple(t, &coercer)}
        end
      rescue CoercionError => ex
        raise CoercionError, "Unable to coerce `#{tuple.inspect}` to #{self.inspect} (#{ex.message})"
      end

      # Computes the intersection of this heading with another one.
      #
      # @param [Heading] other another heading
      # @return [Heading] the intersection of this heading with `other`
      def intersection(other)
        attrs = (to_attr_list & other.to_attr_list).to_a
        Heading.new Hash[attrs.map{|name|
          [name, Types.common_super_type(self[name], other[name])]
        }]
      end
      alias :& :intersection

      # Computes the union of this heading with `other`.
      #
      # When self and other have no common attribute names, compute the classical set
      # union on pairs. Otherwise, the type of a common attribute is returned as the
      # common super type (see `Types.common_super_type`).
      #
      # @param [Heading] other another heading
      # @return [Heading] the union of this heading with `other`
      def union(other)
        Heading.new attributes.merge(other.attributes){|k,t1,t2|
          Types.common_super_type(t1, t2)
        }
      end
      alias :+ :union
      alias :join :union

      # Computes the merge of this heading with `other`.
      #
      # When self and other have no common attribute names, compute the
      # classical set union on pairs. Otherwise, the type of a common attribute
      # is returned as the one of `other`
      #
      # @param [Heading] other another heading
      # @return [Heading] the merge of this heading with `other`
      def merge(other)
        Heading.new attributes.merge(Heading[other].attributes)
      end

      # Renames according to a Renaming instance.
      #
      # @param [Renaming] a renaming instance
      # @return [Heading] a renamed heading
      def rename(renaming)
        Heading.new renaming.rename_tuple(attributes)
      end

      # Projects this heading on specified names.
      #
      # @param [AttrList] names an enumerable of attribute names.
      # @param [Boolean] allbut apply a allbut projection?
      def project(names, allbut = false)
        Heading[AttrList.coerce(names).project_tuple(attributes, allbut)]
      end

      # Converts this heading to an attribute list.
      #
      # @return [AttrList] heading's attributes as an attribute list
      def to_attr_list
        AttrList.new attributes.keys
      end

      # Converts this heading to a Hash of (name,type) pairs
      #
      # @return [Hash] this heading as a Hash of (name, type) pairs
      def to_h
        attributes.dup
      end

      # Returns a Heading literal
      #
      # @return [String] a Heading literal
      def to_ruby_literal
        attributes.empty? ?
          "Alf::Heading::EMPTY" :
          "Alf::Heading[#{Support.to_ruby_literal(attributes)[1...-1]}]"
      end
      alias :inspect :to_ruby_literal

      EMPTY = Heading.new({})
    end # class Heading
  end # module Types
end # module Alf
