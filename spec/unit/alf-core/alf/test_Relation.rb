require 'spec_helper'
module Alf
  describe "Relation" do

    let(:expected){ Alf::Relation([ {name: "Jones"} ]) }

    it 'works as expected on a tuple' do
      expect(Alf::Relation(:name => "Jones")).to eq(expected)
    end

    it 'works as expected on a Reader' do
      File.open(File.expand_path("../example.rash", __FILE__), "r") do |io|
        reader = Alf::Reader.rash(io)
        rel    = Alf::Relation(reader)
        expect(rel).to eq(expected)
      end
    end

    it 'supports a Path to a recognized file' do
      expect(Alf::Relation(Path.dir/'example.rash')).to eq(expected)
    end

    it 'supports a String to a recognized file' do
      expect(Alf::Relation(File.expand_path('../example.rash', __FILE__))).to eq(expected)
    end

  end
end
