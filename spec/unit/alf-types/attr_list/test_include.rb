require 'spec_helper'
module Alf
  describe AttrList, 'include?' do

    let(:list){ AttrList[:id, :name] }

    subject{ list.include?(attribute) }

    context 'when included' do
      let(:attribute){ :id }

      it{ should be_truthy }
    end

    context 'when not included' do
      let(:attribute){ :notthatone }

      it{ should be_falsey }
    end

  end
end
