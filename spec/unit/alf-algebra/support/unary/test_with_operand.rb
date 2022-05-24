require 'spec_helper'
module Alf
  module Algebra
    describe Unary, "with_operand" do

      let(:operand_1){ an_operand }
      let(:operand_2){ an_operand }
      let(:extension){ TupleComputation.coerce({:big => "tested > 10"}) }

      let(:operator) { a_lispy.extend(operand_1, extension) }

      subject{ operator.with_operand(operand_2) }

      it{ should be_a(Extend) }

      specify{
        expect(subject.operand).to eq(operand_2)
        expect(subject.ext).to be(extension)
      }

      specify{
        expect(operator.operand).to eq(operand_1)
        expect(operator.ext).to be(extension)
      }

    end
  end
end
