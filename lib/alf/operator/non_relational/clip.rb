module Alf
  module Operator::NonRelational
    # 
    # Clip input tuples to a subset of attributes
    #
    # SYNOPSIS
    #   #{program_name} #{command_name} [OPERAND] -- ATTR1 ATTR2 ...
    #
    # OPTIONS
    # #{summarized_options}
    #
    # API & EXAMPLE
    #
    #   # Keep only name and city attributes
    #   (clip :suppliers, [:name, :city])
    #
    #   # Keep all but name and city attributes
    #   (clip :suppliers, [:name, :city], true)
    #
    # DESCRIPTION
    #
    # This operator clips tuples on attributes whose names are specified as 
    # arguments. This is similar to the relational PROJECT operator, expect
    # that this one does not removed duplicates that can occur from clipping.
    # In other words, clipping may lead to bags of tuples instead of sets.
    # 
    # When used in shell, the clipping/projection key is simply taken from
    # commandline arguments:
    #
    #   alf clip suppliers -- name city
    #   alf clip suppliers --allbut -- name city
    #
    class Clip < Alf::Operator(__FILE__, __LINE__)
      include Operator::NonRelational, Operator::Transform
  
      signature [
        [:projection_key, ProjectionKey, []]
      ]
      
      # Builds a Clip operator instance
      def initialize(attributes = [], allbut = false)
        @projection_key = coerce(attributes, ProjectionKey)
        @allbut = allbut
      end
  
      # Installs the options
      options do |opt|
        opt.on('-a', '--allbut', 'Apply a ALLBUT clipping') do
          @allbut = true
        end
      end
  
      protected 
  
      # (see Operator::Transform#_tuple2tuple)
      def _tuple2tuple(tuple)
        @projection_key.project(tuple, @allbut)
      end
  
    end # class Clip
  end # module Operator::NonRelational
end # module Alf