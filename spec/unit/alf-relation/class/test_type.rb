require 'spec_helper'
module Alf
  describe Relation, '.type' do

    let(:heading){ {name: String, status: Integer} }
    subject{ Relation.type(heading) }

    it 'returns a subclass' do
      subject.should be_a(Class)
      subject.superclass.should be(Alf::Relation)
    end

    it 'coerces the heading' do
      subject.heading.should be_a(Heading)
    end

    it 'sets the heading correctly' do
      subject.heading.to_hash.should eq(heading)
    end

  end
end
