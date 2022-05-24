require 'spec_helper'
module Alf
  module Algebra
    describe Operator, "with_operands" do

      let(:operand_1) { an_operand.with_heading(:id => Integer).with_keys([:id])    }
      let(:operand_2) { an_operand.with_heading(:name => String).with_keys([:name]) }

      let(:operator) { a_lispy.project(operand_1, [:foo], :allbut => true) }

      subject{ operator.with_operands(operand_2) }

      it{ should be_a(Project) }

      before do
        operator.heading
        operator.keys
      end

      it "replaces the operands but keeps params unchanged" do
        expect(subject.operands.first).to be(operand_2)
        expect(subject.attributes).to eq(AttrList[:foo])
        expect(subject.allbut).to be_truthy
      end

      it "keeps the original unchanged" do
        expect(operator.operands.first).to be(operand_1)
        expect(subject.attributes).to eq(AttrList[:foo])
        expect(subject.allbut).to be_truthy
      end

      it 'does not keep computed heading from the original' do
        expect(subject.heading).to eq(Heading.coerce(:name => String))
      end

      it 'does not keep computed keys from the original' do
        expect(subject.keys).to eq(Keys[ [:name] ])
      end

    end
  end
end
