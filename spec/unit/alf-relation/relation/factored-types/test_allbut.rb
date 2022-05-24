require 'spec_helper'
module Alf
  describe Relation, '.allbut' do

    let(:type){ Relation[name: String, status: Integer] }

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
        expect(subject).to eq(Relation[status: Integer])
      end
    end

    context 'with a full attribute list' do
      let(:attr_list){ AttrList.new([:name, :status]) }

      it 'reuses the type of DUM' do
        expect(subject).to be(Relation::DUM.class)
      end
    end

  end
end
