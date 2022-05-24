require 'spec_helper'
module Alf
  describe Tuple, '.project' do

    let(:type){ Tuple[name: String, status: Integer] }

    subject{ type.project(attr_list) }

    context 'with an empty attribute list' do
      let(:attr_list){ AttrList.new([]) }

      it 'projects as expected' do
        expect(subject).to be(Tuple::EMPTY.class)
      end
    end

    context 'with an non empty attribute list' do
      let(:attr_list){ AttrList.new([:name]) }

      it 'projects as expected' do
        expect(subject).to eq(Tuple[name: String])
      end
    end

    context 'with a full attribute list' do
      let(:attr_list){ AttrList.new([:name, :status]) }

      it 'reuses the initial instance' do
        expect(subject).to be(type)
      end
    end

  end
end
