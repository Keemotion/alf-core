require 'spec_helper'
module Alf
  describe Summarization do

    describe "the class itself" do
      let(:type){ Summarization }
      def Summarization.exemplars
        [
          ["total", Aggregator.sum{ qty }]
        ].map{|x| Summarization.coerce(x)}
      end
      it_should_behave_like 'A valid type implementation'
    end

    specify "least -> happens -> finalize" do
      scope = Support::TupleScope.new
      summ = Summarization.coerce(["s", Aggregator.sum{ qty }, "m", Aggregator.max{ size }])
      expect((x = summ.least)).to eql(:s => 0, :m => nil)
      expect((x = summ.happens(x, scope.__set_tuple(:qty => 10, :size => 12)))).to eq(:s => 10, :m => 12)
      expect((x = summ.happens(x, scope.__set_tuple(:qty => 5, :size => 5)))).to eq(:s => 15, :m => 12)
      expect(summ.finalize(x)).to eq(:s => 15, :m => 12)
    end

  end
end
