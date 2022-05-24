require 'spec_helper'
module Alf
  module Relvar
    describe Virtual, 'OO relational language' do

      let(:expr){ Algebra::Operand::Named.new(:suppliers, self) }
      let(:base){ Base.new(expr)                                }
      let(:rv)  { Virtual.new(base)                             }

      subject{ rv.project([:sid]) }

      it 'is a relation variable' do
        expect(subject).to be_kind_of(Relvar)
      end

      it 'is a virtual relation variable' do
        expect(subject).to be_kind_of(Relvar::Virtual)
      end

      it 'should have a projection expression' do
        expect(subject.expr).to be_kind_of(Algebra::Project)
      end

      it 'should have the base relvar as projection operand' do
        expect(subject.expr.operand).to be(base)
      end

    end
  end
end
