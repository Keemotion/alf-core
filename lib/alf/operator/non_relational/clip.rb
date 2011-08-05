module Alf
  module Operator::NonRelational
    class Clip < Alf::Operator()
      include Operator::NonRelational, Operator::Transform
  
      signature do |s|
        s.argument :attr_list, AttrList, []
        s.option :allbut, Boolean, false, "Apply an allbut clipping?"
      end
      
      protected 
  
      # (see Operator::Transform#_tuple2tuple)
      def _tuple2tuple(tuple)
        @attr_list.project(tuple, @allbut)
      end
  
    end # class Clip
  end # module Operator::NonRelational
end # module Alf
