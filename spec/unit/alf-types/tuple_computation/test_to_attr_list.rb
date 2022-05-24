require 'spec_helper'
module Alf
  describe TupleComputation, "to_attr_list" do

    it 'should return the correct list of attribute names' do
      list = TupleComputation[
        :big? => lambda{ status > 20 },
        :who  => lambda{ "#{first} #{last}" }
      ].to_attr_list
      expect(list).to be_kind_of(AttrList)
      expect(list.to_a.to_set).to eq([:big?, :who].to_set)
    end

  end
end
