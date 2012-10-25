module Alf
  module Relvar
    include Algebra::Operand
    include Lang::ObjectOriented

    def type
      @type ||= Relation[heading]
    end

    def each(&bl)
      to_cog.each(&bl)
    end

    def empty?
      to_cog.each{|_| return false }
      true
    end

    def empty!(msg = "relvar is empty")
      raise FactAssertionError, msg unless empty?
      true
    end

    def not_empty!(msg = "relvar is not empty")
      raise FactAssertionError, msg if empty?
      true
    end

    def value
      to_relation
    end

    def affect(value)
      delete
      insert(value)
    end

    def to_relvar
      self
    end

    def to_relation
      type.new(to_cog.to_set)
    rescue NotSupportedError
      Relation.coerce(to_cog.each)
    end

  private

    def _operator_output(expr)
      Relvar::Virtual.new(expr, connection)
    end

  end # module Relvar
end # module Alf
require_relative 'relvar/base'
require_relative 'relvar/virtual'
require_relative 'relvar/read_only'
