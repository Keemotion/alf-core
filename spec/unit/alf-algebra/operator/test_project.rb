require 'spec_helper'
module Alf
  module Algebra
    describe Project do

      let(:operator_class){ Project }

      it_should_behave_like("An operator class")

      context "--no-allbut" do
        subject{ a_lispy.project(an_operand, [:a]) }

        it { should be_a(Project) }

        it 'is !allbut by default' do
          expect(subject.allbut).to be_falsey
        end
      end # --no-allbut

      context "--allbut" do
        subject{ a_lispy.project(an_operand, [:a], :allbut => true) }

        it { should be_a(Project) }

        it 'is allbut' do
          expect(subject.allbut).to be_truthy
        end
      end # --allbut

    end
  end
end
