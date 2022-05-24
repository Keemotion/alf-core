require 'spec_helper'
module Alf
  class Predicate
    describe Predicate, "hash and ==" do

      subject{ left == right }

      after do
        expect(left.hash).to eq(right.hash) if subject
      end

      describe "on equal predicates" do
        let(:left) { Predicate.coerce(:x => 2) }
        let(:right){ Predicate.coerce(:x => 2) }

        it{ should be_truthy }
      end

      describe "on non equal predicates" do
        let(:left) { Predicate.coerce(:x => 2) }
        let(:right){ Predicate.coerce(:x => 3) }

        it{ should be_falsey }
      end

    end
  end
end
