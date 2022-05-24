require 'spec_helper'
module Alf
  class Predicate
    describe Predicate, "factory methods" do

      before do
        expect(subject).to be_kind_of(Predicate)
        expect(subject.expr).to be_kind_of(Expr)
      end

      context "tautology" do
        subject{ Predicate.tautology }

        specify{ expect(subject.to_ruby_code).to eq("->(t){ true }") }
      end

      context "contradiction" do
        subject{ Predicate.contradiction }

        specify{ expect(subject.to_ruby_code).to eq("->(t){ false }") }
      end

      context "identifier" do
        subject{ Predicate.identifier(:x) }

        specify{ expect(subject.to_ruby_code).to eq("->(t){ t.x }") }
      end

      context "eq" do
        subject{ Predicate.eq(:x, 2) }

        specify{ expect(subject.to_ruby_code).to eq("->(t){ t.x == 2 }") }
      end

      context "neq" do
        subject{ Predicate.neq(:x, 2) }

        specify{ expect(subject.to_ruby_code).to eq("->(t){ t.x != 2 }") }
      end

      context "lt" do
        subject{ Predicate.lt(:x, 2) }

        specify{ expect(subject.to_ruby_code).to eq("->(t){ t.x < 2 }") }
      end

      context "lte" do
        subject{ Predicate.lte(:x, 2) }

        specify{ expect(subject.to_ruby_code).to eq("->(t){ t.x <= 2 }") }
      end

      context "gt" do
        subject{ Predicate.gt(:x, 2) }

        specify{ expect(subject.to_ruby_code).to eq("->(t){ t.x > 2 }") }
      end

      context "gte" do
        subject{ Predicate.gte(:x, 2) }

        specify{ expect(subject.to_ruby_code).to eq("->(t){ t.x >= 2 }") }
      end

      context "literal" do
        subject{ Predicate.literal(2) }

        specify{ expect(subject.to_ruby_code).to eq("->(t){ 2 }") }
      end

      context "native" do
        subject{ Predicate.native(lambda{}) }

        specify{ expect(subject.expr).to be_kind_of(Native) }
      end

    end
  end
end
