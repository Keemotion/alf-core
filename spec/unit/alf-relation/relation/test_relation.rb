require 'spec_helper'
module Alf
  describe Relation do

    let(:tuples){[
      {:sid => 'S1', :name => 'Smith', :status => 20, :city => 'London'},
      {:sid => 'S2', :name => 'Jones', :status => 10, :city => 'Paris'},
      {:sid => 'S3', :name => 'Blake', :status => 30, :city => 'Paris'}
    ]}
    let(:tuples2){ tuples.sort{|t1,t2| t1[:name] <=> t2[:name]} }

    let(:rel1){ Relation.coerce(tuples) }
    let(:rel2){ Relation.coerce(tuples2) }
    let(:rel3){ Relation.coerce(tuples[0..1]) }

    it "should have a cardinality method" do
      expect(rel1.cardinality).to eq(3)
    end

    it "should have an empty? method" do
      expect(Alf::Relation::DUM).to be_empty
      expect(Alf::Relation::DEE).to_not be_empty
      expect(rel1).to_not be_empty
    end

    it "should define == correctly" do
      expect(rel1).to eq(rel2)
      expect(rel2).to eq(rel1)
      expect(rel3).to_not eq(rel1)
    end

    it "should define eql? correctly" do
      expect(rel1).to eql(rel2)
      expect(rel2).to eql(rel1)
      expect(rel3).to_not eql(rel1)
    end

    it "should define hash correctly" do
      expect(rel1.hash).to eq(rel2.hash)
    end

    it "should allow putting them in hashes" do
      h = {}
      h[rel1] = 1
      h[rel2] = 2
      h[rel3] = 3
      expect(h.size).to eq(2)
      expect(h[rel1]).to eq(2)
    end

    describe "rel1" do
      subject{ rel1 }
      it_should_behave_like "A value"
    end

    describe "DUM" do
      subject{ Relation::DUM }
      it_should_behave_like "A value"
      specify{
        expect(subject.cardinality).to eq(0)
        expect(subject.to_a).to eq([])
        expect(subject).to be_empty
      }
    end

    describe "DEE" do
      subject{ Relation::DEE }
      it_should_behave_like "A value"
      specify{
        expect(subject.cardinality).to eq(1)
        expect(subject.to_a).to eq([{}])
        expect(subject).to_not be_empty
      }
    end

  end
end
