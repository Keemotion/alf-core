require 'spec_helper'
module Alf
  describe Ordering, "[]" do

    let(:ordering){ Ordering.new([[:a, :asc], [:b, :desc], [[:c, :d], :asc]]) }

    it 'return the direction when an attribute' do
      expect(ordering[:a]).to eq(:asc)
      expect(ordering[:b]).to eq(:desc)
      expect(ordering[Selector[:a]]).to eq(:asc)
      expect(ordering[Selector[:b]]).to eq(:desc)
      expect(ordering[Selector[[:c, :d]]]).to eq(:asc)
    end

    it 'return nil when not an attribute' do
      expect(ordering[:c]).to be_nil
    end

  end # Ordering
end # Alf
