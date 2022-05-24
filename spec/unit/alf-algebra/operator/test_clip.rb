require 'spec_helper'
module Alf
  module Algebra
    describe Clip do

      let(:operator_class){ Clip }

      it_should_behave_like("An operator class")

      context "--no-allbut" do
        subject{ a_lispy.clip(an_operand, [:a]) }

        it { should be_a(Clip) }

        it 'is !allbut by default' do
          expect(subject.allbut).to be_falsey
        end
      end # --no-allbut

      context "--allbut" do
        subject{ a_lispy.clip(an_operand, [:a], :allbut => true) }

        it { should be_a(Clip) }

        it 'is allbut' do
          expect(subject.allbut).to be_truthy
        end
      end # --allbut

    end
  end
end
