require 'spec_helper'
module Alf
  describe "Support#to_tuple" do

    let(:expected){
      Tuple(name: "Alf")
    }

    def to_tuple(x, &bl)
      Tuple(x, &bl) # Tuple(...) -> Alf::Tuple(...) -> Support.to_tuple(...)
    end

    it 'returns a tuple already' do
      expect(to_tuple(name: "Alf")).to eq(expected)
    end

    it 'symbolizes keys' do
      expect(to_tuple('name' => "Alf")).to eq(expected)
    end

    it 'supports a block that is delegated to remap' do
      expect(to_tuple('name' => "alf", 'version' => "foo"){|k,v|
        expect(k).to be_kind_of(Symbol)
        v.upcase
      }).to eq(Tuple(name: "ALF", version: "FOO"))
    end

  end
end
