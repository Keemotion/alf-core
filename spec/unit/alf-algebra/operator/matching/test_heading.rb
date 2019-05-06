require 'spec_helper'
module Alf
  module Algebra
    describe Matching, 'heading' do

      let(:left){
        an_operand.with_heading(:id => Integer, :name => String)
      }
      let(:right){
        an_operand.with_heading(:id => Integer, :foo => String)
      }

      let(:op){
        a_lispy.matching(left, right)
      }
      subject{ op.heading }

      let(:expected){
        Heading[:id => Integer, :name => String]
      }

      it { should eq(expected) }

    end
  end
end
