module Alf
  module Types
    #
    # Defines the computation of a tuple from expressions mapped to names.
    #
    # Example:
    #   computation = TupleComputation[
    #     :big? => lambda{ status > 20 }
    #     :who  => lambda{ "#{first} #{last}" }
    #   ]
    #   computation.call(:last => "Jones", :first => "Bill", :status => 10)
    #   # => {:big? => false, :who => "Bill Jones"}
    #
    class TupleComputation

      # @return [Hash] a computation hash, mapping AttrName -> TupleExpression
      attr_reader :computation

      #
      # Creates a TupleComputation instance
      #
      # @param [Hash] computation, a mappping AttrName -> TupleExpression
      #
      def initialize(computation)
        @computation = computation
      end

      class << self

        # Coerces `arg` to a tuple computation
        #
        # Implemented coercions are
        # - TupleComputation    -> self
        # - {name => expr, ...} -> {AttrName[name] => TupleExpression[expr], ...}
        # - [name, expr, ...]   -> {AttrName[name] => TupleExpression[expr], ...}
        #
        # @param [Object] arg the value to coerce to a tuple computation
        # @return [TupleComputation] the computation when the coercion succeeds
        def coerce(arg)
          case arg
          when TupleComputation
            arg
          when Hash
            TupleComputation.new Hash[arg.map{|k,v|
              if AttrName === k
                v = TupleExpression.coerce(v) if v.is_a?(Proc)
                [k, v]
              else
                [ Support.coerce(k, AttrName),
                  Support.coerce(v, TupleExpression) ]
              end
            }]
          when Array
            coerce(Hash[*arg])
          else
            raise ArgumentError, "Invalid argument `arg` for TupleComputation()"
          end
        end
        alias :[] :coerce

        # Convert commandline arguments to a tuple computation
        #
        # This method reuses `coerce(Array)` and therefore shares its spec.
        #
        # @param [Array] args commandline arguments
        # @param [Hash] opts coercion options (not used).
        # @return [TupleExpression] the expression if coercion succeeds
        # @raise [ArgumentError] if the coercion fails.
        def from_argv(argv, opts = {})
          coerce(argv)
        end

      end # class << self

      # Makes the computation in the context of a tuple
      #
      # This is a convenient method for the following, longer expression:
      #
      #     evaluate(TupleScope.new(tuple))
      #
      # Note, however, using a scope as in the example above is much more
      # efficient when evaluating the same computation on multiple tuples
      # in sequence.
      #
      # @param [Hash] tuple a Tuple instance
      # @return [Object] the resulting tuple
      def call(tuple)
        evaluate(Support::TupleScope.new(tuple))
      end
      alias :[] :call

      # Computes the resulting tuple when expressions are evaluated in the
      # context of `scope`
      #
      # @param [TupleScope] scope a tuple scope instance.
      # @return [Hash] the resulting tuple
      def evaluate(scope = nil)
        Hash[ @computation.map{|k,v|
          [k, v.is_a?(TupleExpression) ? v.evaluate(scope) : v]
        }]
      end

      # Returns a hash code.
      #
      # @return [Integer] a hash code for this expression
      def hash
        @computation.hash
      end

      # Checks equality with another computation
      #
      # @param [TupleComputation] another computation
      # @return [Boolean] true if self and other are equal, false otherwise
      def ==(other)
        other.is_a?(TupleComputation) && (computation == other.computation)
      end
      alias :eql? :==

      # Converts to a heading.
      #
      # @return [AttrList] a computed heading from static analysis of expressions
      def to_heading
        h = Hash[computation.map{|name,expr|
          [name, expr.is_a?(TupleExpression) ? expr.infer_type : expr.class]
        }]
        Heading[h]
      end

      # Converts to an attribute list.
      #
      # @return [AttrList] a list of computed attribute names
      def to_attr_list
        AttrList.new(computation.keys)
      end

      # Returns a ruby literal for this expression.
      #
      # @return [String] a literal s.t. `eval(self.to_ruby_literal) == self`
      def to_ruby_literal
        "Alf::TupleComputation[#{Support.to_ruby_literal(computation)}]"
      end
      alias :inspect :to_ruby_literal

    end # class TupleComputation
  end # module Types
end # module Alf