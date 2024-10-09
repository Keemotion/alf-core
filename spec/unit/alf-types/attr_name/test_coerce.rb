require 'spec_helper'
module Alf
  describe AttrName, "coerce" do

    it 'should work on valid attribute names' do
      expect(AttrName.coerce("city")).to eq(:city)
      expect(AttrName.coerce(:big?)).to eq(:big?)
    end

    it 'should raise ArgumentError otherwise' do
      expect{ AttrName.coerce("!123") }.to raise_error(TypeError)
      expect{ AttrName.coerce(:'!123') }.to raise_error(TypeError)
    end

  end
end
