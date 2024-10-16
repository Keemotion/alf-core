require 'spec_helper'
module Alf
  describe Summarization, "least" do

    it 'should invoke least on each aggregator' do
      sum = Summarization.coerce(["s", Aggregator.avg{ qty }, "m", Aggregator.max{ size }])
      expect(sum.least).to eq({:s => [0.0, 0.0], :m => nil})
    end

  end
end
