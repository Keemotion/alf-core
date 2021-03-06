require 'spec_helper'
module Alf
  module Algebra
    describe Minus do

      let(:operator_class){ Minus }

      it_should_behave_like("An operator class")

      subject{ a_lispy.minus(an_operand, an_operand) }

      it{ should be_a(Minus) }

    end
  end
end
