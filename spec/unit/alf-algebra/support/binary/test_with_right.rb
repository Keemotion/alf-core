require 'spec_helper'
module Alf
  module Algebra
    describe Binary, "with_right" do

      let(:operand_1){ an_operand }
      let(:operand_2){ an_operand }
      let(:operand_3){ an_operand }
      let(:operator) { a_lispy.union(operand_1, operand_2) }

      subject{ operator.with_right(operand_3) }

      it{ should be_a(Union) }

      specify{
        expect(subject.left).to eq(operand_1)
        expect(subject.right).to eq(operand_3)
      }

      specify{
        expect(operator.left).to eq(operand_1)
        expect(operator.right).to eq(operand_2)
      }

    end
  end
end
