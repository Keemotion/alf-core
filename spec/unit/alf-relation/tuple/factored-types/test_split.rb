require 'spec_helper'
module Alf
  describe Tuple, 'split' do

    let(:type){ Tuple[name: String, status: Integer] }

    subject{ type.split(attr_list) }

    context 'with an empty attribute list' do
      let(:attr_list){ AttrList.new([]) }

      it 'splits as expected' do
        subject.should eq([ Tuple[{}], type ])
      end

      it 'reuses the initial instance' do
        subject.last.should be(type)
      end
    end

    context 'with an non empty attribute list' do
      let(:attr_list){ AttrList.new([:name]) }

      it 'splits as expected' do
        subject.should eq([ Tuple[name: String], Tuple[status: Integer] ])
      end
    end

  end
end
