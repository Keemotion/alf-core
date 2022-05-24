require 'spec_helper'
module Alf
  class Database
    describe Connection, "options" do

      subject{ sap_conn }

      it_should_behave_like "a facade on database options"

      it 'should allow options to be consulted' do
        expect(subject.options).to be_kind_of(Database::Options)
      end

    end
  end
end
