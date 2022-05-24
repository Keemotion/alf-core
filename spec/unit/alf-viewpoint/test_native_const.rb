require 'spec_helper'
module Alf
  describe Viewpoint, "NATIVE" do

    subject{ Viewpoint::NATIVE }

    it{ should be_a(Module) }

    it 'converts unknown names as named operands' do
      expect(subject.parse{
        suppliers
      }).to be_kind_of(Algebra::Operand::Named)
    end

    it 'should allow being used in a Lispy' do
      expect(Lang::Parser::Lispy.new([subject]).parse{
        suppliers
      }).to be_kind_of(Algebra::Operand::Named)
    end

  end
end
