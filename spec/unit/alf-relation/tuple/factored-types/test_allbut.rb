require 'spec_helper'
module Alf
  describe Tuple, '.allbut' do

    let(:type){ Tuple[name: String, status: Integer] }

    subject{ type.allbut(attr_list) }

    context 'with an empty attribute list' do
      let(:attr_list){ AttrList.new([]) }

      it 'allbuts as expected' do
        expect(subject).to be(type)
      end
    end

    context 'with an non empty attribute list' do
      let(:attr_list){ AttrList.new([:name]) }

      it 'allbuts as expected' do
        expect(subject).to eq(Tuple[status: Integer])
      end
    end

    context 'with a full attribute list' do
      let(:attr_list){ AttrList.new([:name, :status]) }

      it 'reuses the DUM class' do
        expect(subject).to be(Tuple::DUM.class)
      end
    end

  end
end
