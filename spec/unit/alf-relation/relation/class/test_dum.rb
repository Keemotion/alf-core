require 'spec_helper'
module Alf
  describe Relation, '.dum' do

    let(:type){ Relation[name: String, status: Integer] }

    subject{ type.dum }

    it 'returns a Relation' do
      expect(subject).to be_kind_of(type)
      expect(subject).to be_kind_of(Relation)
    end

    it 'is empty' do
      expect(subject).to be_empty
    end

  end
end
