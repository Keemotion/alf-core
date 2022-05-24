require 'spec_helper'
module Alf
  module Algebra
    describe Autonum do

      let(:operator_class){ Autonum }

      it_should_behave_like("An operator class")

      context "with default attribute name" do
        subject{ a_lispy.autonum(an_operand) }

        it{ should be_a(Autonum) }

        it 'has :autonum as attribute name' do
          expect(subject.as).to eq(:autonum)
        end
      end # default attribute name

      context "with explicit attribute name" do
        subject{ a_lispy.autonum(an_operand, :unique) }

        it{ should be_a(Autonum) }

        it 'has :unique as attribute name' do
          expect(subject.as).to eq(:unique)
        end
      end # explicit attribute name

    end
  end
end
