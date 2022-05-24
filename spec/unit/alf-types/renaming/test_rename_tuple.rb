require 'spec_helper'
module Alf
  describe Renaming, "rename_tuple" do

    let(:r){ Renaming.coerce(["old", "new"]) }

    it 'should rename correctly' do
      tuple    = {:old => :a, :other => :b}
      expected = {:new => :a, :other => :b}
      expect(r.rename_tuple(tuple)).to eq(expected)
    end

  end # Renaming
end # Alf
