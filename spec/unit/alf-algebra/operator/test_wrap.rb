require 'spec_helper'
module Alf
  module Algebra
    describe Wrap do

      let(:operator_class){ Wrap }

      it_should_behave_like("An operator class")


      context '--no-allbut' do
        subject{ a_lispy.wrap(an_operand, [:a, :b], :wraped) }

        it { should be_a(Wrap) }

        it 'should not be allbut' do
          expect(subject.allbut).to be_falsey
        end
      end

      context '--allbut' do
        subject{ a_lispy.wrap(an_operand, [:a, :b], :wraped, :allbut => true) }

        it { should be_a(Wrap) }

        it 'should be allbut' do
          expect(subject.allbut).to be_truthy
        end
      end
    end
  end
end
