require 'spec_helper'
module Alf
  describe "Relation#to_a" do

    let(:rel){Alf::Relation(sid: ['S2', 'S1', 'S3']) }

    specify "without an ordering key" do
      expect(rel.to_a.sort{|k1,k2| k1[:sid] <=> k2[:sid]}).to eq([
        {:sid => 'S1'},
        {:sid => 'S2'},
        {:sid => 'S3'}
      ])
    end

    specify "with an ordering key" do
      expect(rel.to_a([:sid])).to eq([
        {:sid => 'S1'},
        {:sid => 'S2'},
        {:sid => 'S3'}
      ])
      expect(rel.to_a([[:sid, :desc]])).to eq([
        {:sid => 'S3'},
        {:sid => 'S2'},
        {:sid => 'S1'}
      ])
    end

    specify "ON DUM" do
      expect(Relation::DUM.to_a).to eq([])
    end

    specify "ON DEE" do
      expect(Relation::DEE.to_a).to eq([{}])
    end

  end
end
