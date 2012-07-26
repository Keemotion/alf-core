module Alf
  module Operator
    module Relational
      class Rename
        include Operator, Relational, Unary

        signature do |s|
          s.argument :renaming, Renaming, {}
        end

        def heading
          @heading ||= operand.heading.rename(renaming)
        end

        def keys
          @keys ||= operand.keys.rename(renaming)
        end

      end # class Rename
    end # module Relational
  end # module Operator
end # module Alf
