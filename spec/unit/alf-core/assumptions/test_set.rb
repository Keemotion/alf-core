require 'spec_helper'
require 'set'
describe Set do

  specify "empty sets should be equal" do
    expect(Set.new([])).to eq(Set.new([]))
    expect(Set.new([])).to eql(Set.new([]))
  end

  describe "on DEE-like sets" do
    let(:dee){ Set.new([{}]) }

    specify "DEE sets should be equal" do
      expect(Set.new([{}])).to eq(dee)
      expect(Set.new([{}])).to eql(dee)
    end

    specify "DEE-like sets should be equal (1)" do
      arr = [{}]
      expect(Set.new(arr)).to eq(dee)
      expect(Set.new(arr)).to eql(dee)
    end

    specify "DEE-like sets should be equal (2)" do
      arr = [{}]
      expect(Set.new(arr.to_a)).to eq(dee)
      expect(Set.new(arr.to_a)).to eql(dee)
    end

    specify "DEE-like sets should be equal (3)" do
      arr = [{}]
      expect(arr.to_set).to eq(dee)
      expect(arr.to_set).to eql(dee)
    end

    specify "DEE-like sets should be equal (4)" do
      arr = [{}]
      expect(arr.to_set).to eq(dee)
      expect(arr.to_set).to eql(dee)
    end

    specify "DEE-like sets should be equal (5)" do
      arr = Object.new.extend(Enumerable)
      def arr.each
        yield({})
      end
      expect(arr.to_set).to eq(dee)
      expect(arr.to_set).to eql(dee)
    end

    specify "DEE-like sets should be equal (5)" do
      arr = Object.new.extend(Enumerable)
      def arr.each
        tuple = {:sid => "1"}
        tuple.delete(:sid)
        yield(tuple)
      end
      expect(arr.to_set).to eq(dee)
      expect(arr.to_set).to eql(dee)
    end

  end

end
