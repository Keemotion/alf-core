require 'spec_helper'
module Alf
  describe "Relation#to_hash" do

    let(:rel){
      Alf::Relation([
        {sid: 'S1', name: 'Jones', city: 'London', status: 20},
        {sid: 'S2', name: 'Blake', city: 'London', status: 20},
      ])
    }

    specify "with :sid => :name" do
      expect(rel.to_hash(:sid => :name)).to eq('S1' => 'Jones', 'S2' => 'Blake')
    end

    specify "with :sid => :city" do
      expect(rel.to_hash(:sid => :city)).to eq('S1' => 'London', 'S2' => 'London')
    end

    specify "with :city => :sid" do
      expect{
        rel.to_hash(:city => :sid)
      }.to raise_error(/Key expected for `city`, divergence found on `London`/)
    end

    specify "with :city => :status" do
      expect(rel.to_hash(:city => :status)).to eq('London' => 20)
    end

    specify "with [:sid, :name] => :status" do
      expect(rel.to_hash([:sid, :name] => :status)).to eq(['S1', 'Jones'] => 20, ['S2', 'Blake'] => 20)
    end

    specify "with :sid => [:name, :status]" do
      expect(rel.to_hash(:sid => [:name, :status])).to eq('S1' => ['Jones', 20], 'S2' => ['Blake', 20])
    end

  end
end
