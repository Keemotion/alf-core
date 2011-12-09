module Alf
  module Engine
    class Summarize::Cesure < Cog
      include Engine::Cesure

      # @return [Enumerable] The operand
      attr_reader :operand

      # @return [AttrList] Summarization key
      attr_reader :by

      # @return [Summarization] The summarization to use
      attr_reader :summarization

      # @return [Boolean] Make an allbut summarization?
      attr_reader :allbut

      # Creates an Aggregate instance
      def initialize(operand, by, summarization, allbut)
        @operand = operand
        @by = by
        @summarization = summarization
        @allbut = allbut
      end

      protected

      # (see Cesure#project)
      def project(tuple)
        @by.project_tuple(tuple, @allbut)
      end
      
      # (see Cesure#start_cesure)
      def start_cesure(key, receiver)
        @aggs = @summarization.least
      end

      # (see Cesure#accumulate_cesure)
      def accumulate_cesure(tuple, receiver)
        @aggs = @summarization.happens(@aggs, tuple)
      end

      # (see Cesure#flush_cesure)
      def flush_cesure(key, receiver)
        @aggs = @summarization.finalize(@aggs)
        receiver.call key.merge(@aggs)
      end

    end # class Summarize::Cesure
  end # module Engine
end # module Alf