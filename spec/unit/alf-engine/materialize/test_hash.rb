require 'spec_helper'
module Alf
  module Engine
    describe Materialize::Hash do

      let(:operand){[
        {:name => "Smith", :city => "London"},
        {:name => "Jones", :city => "Paris"},
        {:name => "Smith", :city => "Athens"},
      ]}

      it 'should act as a normal cog' do
        op = Materialize::Hash.new(operand, AttrList[:name])
        expect(op.to_set).to eq(operand.to_set)
      end

      it 'should allow allbut hashing' do
        op = Materialize::Hash.new(operand, AttrList[:city], true)
        expect(op.to_set).to eq(operand.to_set)
      end

      it 'should allow lazy projection attributes' do
        op = Materialize::Hash.new(operand, lambda{|tuple|
          expect(tuple).to eq({:name => "Smith", :city => "London"})
          AttrList[:name]
         })
        expect(op.to_set).to eq(operand.to_set)
      end

      it 'should have a each_pair method' do
        op = Materialize::Hash.new(operand, AttrList[:name])
        seen = []
        op.each_pair do |k,v|
          seen << [k,v]
        end
        expect(seen.to_set).to eq([
          [{:name => "Smith"}, operand.select{|t| t[:name] == "Smith"}],
          [{:name => "Jones"}, operand.select{|t| t[:name] == "Jones"}]
        ].to_set)
      end

      describe "the indexed access" do

        it 'should return the expected tuples' do
          op = Materialize::Hash.new(operand, AttrList[:name])
          expect(op[{:name => "Jones"}].to_a).to eq([
            {:name => "Jones", :city => "Paris"},
          ])
          expect(op[{:name => "Smith"}].to_a).to eq([
            {:name => "Smith", :city => "London"},
            {:name => "Smith", :city => "Athens"},
          ])
          expect(op[{:name => "NoSuchOne"}].to_a).to eq([])
        end

        it 'should allow late projection' do
          op = Materialize::Hash.new(operand, AttrList[:name])
          expect(op[{:name => "Smith", :city => "London"}, true].to_a).to eq([
            {:name => "Smith", :city => "London"},
            {:name => "Smith", :city => "Athens"},
          ])
        end

        it 'late projection should work with allbut indexing' do
          op = Materialize::Hash.new(operand, AttrList[:city], true)
          expect(op[{:name => "Smith", :city => "London"}, true].to_a).to eq([
            {:name => "Smith", :city => "London"},
            {:name => "Smith", :city => "Athens"},
          ])
        end

      end

    end
  end # module Engine
end # module Alf
