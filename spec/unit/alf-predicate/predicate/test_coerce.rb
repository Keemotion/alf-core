require 'spec_helper'
module Alf
  class Predicate
    describe Predicate, ".coerce" do

      subject{ Predicate.coerce(arg) }

      describe "from Predicate" do
        let(:arg){ Predicate.new(Factory.tautology) }

        it{ should be(arg) }
      end

      describe "from true" do
        let(:arg){ true }

        specify{
          expect(subject.expr).to be_kind_of(Tautology)
        }
      end

      describe "from false" do
        let(:arg){ false }

        specify{
          expect(subject.expr).to be_kind_of(Contradiction)
        }
      end

      describe "from Symbol" do
        let(:arg){ :status }

        specify{
          expect(subject.expr).to be_kind_of(Identifier)
          expect(subject.expr.name).to eq(arg)
        }
      end

      describe "from Proc" do
        let(:arg){ lambda{ status == 10 } }

        specify{
          expect(subject.expr).to be_kind_of(Native)
          expect(subject.to_proc).to be(arg)
        }
      end

      describe "from String" do
        let(:arg){ "status == 10" }

        it 'raises an error' do
          expect(lambda{
            subject
          }).to raise_error(ArgumentError)
        end
      end

      describe "from Hash (single)" do
        let(:arg){ {status: 10} }

        specify{
          expect(subject.expr).to be_kind_of(Eq)
          expect(subject.expr).to eq([:eq, [:identifier, :status], [:literal, 10]])
        }
      end

      describe "from Tuple (single)" do
        let(:arg){ Tuple(status: 10) }

        specify{
          expect(subject.expr).to be_kind_of(Eq)
          expect(subject.expr).to eq([:eq, [:identifier, :status], [:literal, 10]])
        }
      end

      describe "from Hash (multiple)" do
        let(:arg){ {status: 10, name: "Jones"} }

        specify{
          expect(subject).to eq(Predicate.eq(status: 10) & Predicate.eq(name: "Jones"))
        }
      end

      describe "from Tuple (multiple)" do
        let(:arg){ Tuple(status: 10, name: "Jones") }

        specify{
          expect(subject).to eq(Predicate.eq(status: 10) & Predicate.eq(name: "Jones"))
        }
      end

      describe "from Relation::DUM" do
        let(:arg){ Relation::DUM }

        specify{
          expect(subject).to eq(Predicate.contradiction)
        }
      end

      describe "from Relation::DEE" do
        let(:arg){ Relation::DEE }

        specify{
          expect(subject).to eq(Predicate.tautology)
        }
      end

      describe "from Relation (arity=1)" do
        let(:arg){ Relation(status: [10, 20]) }

        specify{
          expect(subject).to eq(Predicate.in(:status, [10, 20]))
        }
      end

      describe "from Relation (arity>1)" do
        let(:arg){ Relation([
          {status: 1, city: "London"},
          {status: 2, city: "Paris"}
        ]) }
        let(:expected){
          Predicate.eq({status: 1, city: "London"}) | Predicate.eq({status: 2, city: "Paris"})
        }

        specify{
          expect(subject).to eq(expected)
        }
      end

    end
  end
end
