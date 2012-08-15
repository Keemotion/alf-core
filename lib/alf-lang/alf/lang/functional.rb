module Alf
  module Lang
    module Functional
      include Support

      class << self
        def def_aggregator_method(name, clazz)
          define_method(name) do |*args, &block|
            clazz.new(*args, &block)
          end
        end

        def def_operator_method(name, clazz)
          define_method(name) do |*args|
            operands, arguments = args[0...clazz.arity], args[clazz.arity..-1]
            _operator_output clazz.new(operands, *arguments)
          end
        end
      end

      def Heading(*args, &bl)
        Alf::Heading(*args, &bl)
      end

      def Tuple(*args, &bl)
        Alf::Tuple(*args, &bl)
      end

      def Relation(first, *args, &bl)
        if args.empty?
          Alf::Relation(first, &bl)
        else
          Alf::Relation[*args.unshift(first)]
        end
      end

      def var_ref(name)
        _operator_output Operator::VarRef.new(context, name)
      end

      Aggregator.listen do |name, clazz|
        def_aggregator_method(name, clazz)
      end

      Operator.listen do |name, clazz|
        def_operator_method(name, clazz)
      end

      def allbut(operand, attributes)
        project(operand, attributes, :allbut => true)
      end

      def to_relation(operand)
        Tools.to_relation(operand)
      end

      def to_tuple(operand)
        Tools.to_tuple(operand)
      end

    end
  end
end
