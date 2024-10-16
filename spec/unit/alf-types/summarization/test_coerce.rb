require 'spec_helper'
module Alf
  describe Summarization, "coerce" do

    subject{ Summarization.coerce(arg) }

    describe "from a Summarization" do
      let(:arg){ Summarization.new(:s => Aggregator.sum{ qty }) }
      it{ should eq(arg) }
    end

    describe "from a Hash" do
      let(:arg){ { :s => Aggregator.sum{ qty }, :m => Aggregator.max{ size } } }
      it{ should be_a(Summarization) }
      specify{
        expect(subject.to_hash.keys.to_set).to eq([:s, :m].to_set)
        subject.to_hash.values.all?{|v| expect(v).to be_a(Aggregator) }
      }
    end

    describe "from an Array" do
      let(:arg){ ["s", Aggregator.sum{ qty }, "m", Aggregator.max{ size }] }
      it{ should be_a(Summarization) }
      specify{
        expect(subject.to_hash.keys.to_set).to eq([:s, :m].to_set)
        subject.to_hash.values.all?{|v| expect(v).to be_a(Aggregator) }
      }
    end

  end
end
