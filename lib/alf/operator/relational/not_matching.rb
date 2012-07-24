module Alf
  module Operator
    module Relational
      class NotMatching
        include Operator, Relational, Binary

        signature do |s|
        end

        def heading
          @heading ||= left.heading
        end

      end # class NotMatching
    end # module Relational
  end # module Operator
end # module Alf
