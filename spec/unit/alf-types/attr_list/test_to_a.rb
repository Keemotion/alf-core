require 'spec_helper'
module Alf
  describe AttrList, 'to_a' do

    it 'returns an array of symbols' do
      expect(AttrList[:a, :b].to_a).to eq([:a, :b])
    end

    it 'works on empty list' do
      expect(AttrList[].to_a).to eq([])
    end

  end
end
