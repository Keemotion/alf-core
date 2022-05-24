require 'spec_helper'
module Alf
  describe Relation, '.type' do

    let(:heading){ {name: String, status: Integer} }
    subject{ Relation.type(heading) }

    it 'returns a subclass' do
      expect(subject).to be_kind_of(Class)
      expect(subject.superclass).to be(Alf::Relation)
    end

    it 'coerces the heading' do
      expect(subject.heading).to be_kind_of(Heading)
    end

    it 'sets the heading correctly' do
      expect(subject.heading.to_hash).to eq(heading)
    end

    it 'supports a tuple type' do
      expect(Relation[Tuple[heading]]).to eq(Relation[heading])
    end

    it 'is aliased as []' do
      expect(Relation[heading]).to be_kind_of(Class)
      expect(Relation[heading]).to eq(subject)
    end

  end
end
