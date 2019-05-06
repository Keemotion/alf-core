require 'spec_helper'
module Alf
  module Algebra
    describe NotMatching, 'keys' do

      let(:left){
        an_operand.with_heading(:id => Integer, :name => String).with_keys([:id])
      }
      let(:right){
        an_operand.with_heading(:id => Integer, :foo => String)
      }

      let(:op){
        a_lispy.not_matching(left, right)
      }
      subject{ op.keys }

      let(:expected){
        Keys[ [:id] ]
      }

      it { should eq(expected) }

    end
  end
end
