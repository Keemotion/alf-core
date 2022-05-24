require 'spec_helper'
module Alf
  describe "(restrict xxx, :keyword => ...)" do

    it "should support using a keyword on Relation" do
      rel = Relation(when: "now")
      expect(rel.restrict(when: "now")).to eq(rel)
    end

    it "should support using a keyword on Lispy" do
      expect(Alf.examples.query do
        (restrict (extend suppliers, {:when => lambda{"notnow"}}), {:when => "now"})
      end).to eq(Relation::DUM)
    end

  end
end
