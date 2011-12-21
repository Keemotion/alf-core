require 'spec_helper'
module Alf::Shell::Operator
  describe NotMatching do

    let(:left) { [{:left  => true}] }
    let(:right){ [{:right => true}] }
    subject{ NotMatching.run(argv) }

    context "the default config" do
      let(:argv){ [left, right] }
      specify{
        subject.should be_a(Alf::Operator::Relational::NotMatching)
        subject.operands.should eq([left, right])
      }
    end

  end
end