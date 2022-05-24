require 'spec_helper'
module Alf
  describe Ordering, "compare" do

    it "should work on a singleton ordering" do
      key = Ordering.coerce [:a]
      expect(key.compare({:a => 1}, {:a => 2})).to eq(-1)
      expect(key.compare({:a => 1}, {:a => 1})).to eq(0)
      expect(key.compare({:a => 2}, {:a => 1})).to eq(1)
    end

    it "should work on singleton when :desc" do
      key = Ordering.coerce [[:a, :desc]]
      expect(key.compare({:a => 1}, {:a => 2})).to eq(1)
      expect(key.compare({:a => 1}, {:a => 1})).to eq(0)
      expect(key.compare({:a => 2}, {:a => 1})).to eq(-1)
    end

    it "should work with multiple keys" do
      key = Ordering.coerce [[:a, :asc], [:b, :desc]]
      expect(key.compare({:a => 1, :b => 1}, {:a => 0, :b => 1})).to eq(1)
      expect(key.compare({:a => -1, :b => 1}, {:a => 0, :b => 1})).to eq(-1)
      expect(key.compare({:a => 0, :b => 1}, {:a => 0, :b => 0})).to eq(-1)
      expect(key.compare({:a => 1, :b => 1}, {:a => 1, :b => 2})).to eq(1)
      expect(key.compare({:a => 1, :b => 1}, {:a => 1, :b => 1})).to eq(0)
    end

    it "should work when nils are involved" do
      key = Ordering.coerce [:a]
      expect(key.compare({:a => nil}, {:a => nil})).to eq(0)
      expect(key.compare({:a => 1}, {:a => nil})).to eq(1)
      expect(key.compare({:a => nil}, {:a => 1})).to eq(-1)
    end

  end # compare
end # Alf
