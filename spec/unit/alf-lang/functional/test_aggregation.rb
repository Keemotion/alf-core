require 'spec_helper'
module Alf
  module Lang
    describe "Aggregation methods" do
      include Functional

      let(:input){[
        {:tested => 1,  :other => "b"},
        {:tested => 30, :other => "a"},
      ]}

      let(:expected){[
        {:tested => 30, :other => "a", :upcase => "A"},
      ]}

      context 'on sum' do
        it "should have sum with immediate block" do
          expect(sum{|t| t.qty }).to be_kind_of(Aggregator::Sum)
        end

        it "should have sum with a Proc" do
          expect(sum(->(t){ qty })).to be_kind_of(Aggregator::Sum)
        end
      end

      context 'on concat' do
        it "should have concat with immediate block" do
          expect(concat{|t| t.name }).to be_kind_of(Aggregator::Concat)
        end

        it "should have sum with a Proc" do
          agg = concat(->(t){ t.name }, between: ', ')
          expect(agg).to be_kind_of(Aggregator::Concat)
          expect(agg.options[:between]).to eq(', ')
        end
      end

    end
  end
end
