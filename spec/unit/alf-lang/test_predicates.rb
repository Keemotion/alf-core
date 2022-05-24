require 'spec_helper'
module Alf
  module Lang
    describe Predicates do
      include Predicates

      it "eq should factor a predicate" do
        expect(eq(:x, 12)).to be_kind_of(Alf::Predicate)
      end

      it "between should factor a predicate" do
        expect(between(:x, 2, 3)).to be_kind_of(Alf::Predicate)
      end

    end
  end
end
