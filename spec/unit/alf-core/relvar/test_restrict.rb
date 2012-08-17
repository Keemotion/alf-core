require 'spec_helper'
module Alf
  describe Relvar, 'restrict' do

    let(:relvar){
      examples_database.relvar(:suppliers)
    }

    subject{ relvar.restrict(:city => "London") }

    it 'returns a Relvar' do
      subject.should be_a(Relvar)
    end

    it 'bounds the result correctly' do
      subject.expr.should be_a(Algebra::Restrict)
      subject.expr.operand.should eq(relvar.expr)
    end

  end
end