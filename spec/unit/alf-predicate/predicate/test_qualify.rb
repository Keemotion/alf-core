require 'spec_helper'
module Alf
  class Predicate
    describe Predicate, "qualify" do

      let(:p){ Predicate }

      subject{ predicate.qualify(qualifier) }

      let(:qualifier) { {:x => :t} }

      context 'on a full AST predicate' do
        let(:predicate){ p.in(:x, [2]) & p.eq(:y, 3) }

        it{ should eq(p.in(Factory.qualified_identifier(:t, :x), [2]) & p.eq(:y, 3)) }

        specify "it should tag expressions correctly" do
          expect(subject.expr).to be_kind_of(Sexpr)
          expect(subject.expr).to be_kind_of(Expr)
          expect(subject.expr).to be_kind_of(And)
        end
      end

      context 'on a predicate that contains natives' do
        let(:predicate){ p.in(:x, [2]) & p.native(lambda{}) }

        it 'raises an error' do
          expect{
            subject
          }.to raise_error(NotSupportedError)
        end
      end

    end
  end
end
