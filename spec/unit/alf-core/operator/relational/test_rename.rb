require 'spec_helper'
module Alf
  module Operator::Relational
    describe Rename do

      let(:operator_class){ Rename }
      it_should_behave_like("An operator class")

      let(:input) {[
        {:a => "a", :b => "b"},
      ]}

      let(:expected){[
        {:z => "a", :b => "b"},
      ]}

      subject{ operator.to_a }

      context "with Lispy" do 
        let(:operator){ Lispy.rename(input, {:a => :z}) }
        it{ should == expected }
      end

      context "with .run" do
        let(:operator){ Rename.run([input, '--', 'a', 'z']) }
        it{ should == expected }
      end

    end 
  end
end
