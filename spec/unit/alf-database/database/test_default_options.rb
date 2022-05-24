require 'spec_helper'
module Alf
  describe Database, 'default_options' do

    subject{ Database.new(Path.dir) }

    it_should_behave_like "a facade on database options"

    it 'should allow default options to be consulted' do
      expect(subject.default_options).to be_kind_of(Database::Options)
    end

  end
end
