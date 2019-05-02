require 'spec_helper'
module Alf
  class Predicate
    describe Predicate, "contradiction?" do

      subject{ pred.contradiction? }

      context "tautology" do
        subject{ Predicate.tautology }

        it{ should be_falsey }
      end

      context "contradiction" do
        subject{ Predicate.contradiction }

        it{ should be_truthy }
      end

      context "identifier" do
        subject{ Predicate.identifier(:x) }

        it{ should be_falsey }
      end

    end
  end
end
