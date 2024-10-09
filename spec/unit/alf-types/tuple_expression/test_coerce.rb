require 'spec_helper'
module Alf
  describe TupleExpression, "coerce" do

    let(:scope) {
      Support::TupleScope.new(:status => 10)
    }

    subject{ TupleExpression.coerce(arg) }

    describe "with nil" do
      let(:arg){ nil }
      specify{ expect{ subject }.to raise_error(ArgumentError) }
    end

    describe "with a Symbol" do
      let(:arg){ :status }
      it { should be_a(TupleExpression) }
      specify{
        expect(subject.evaluate(scope)).to eql(10)
        expect(subject.source).to eq("t.status")
      }
    end

    describe "with a Proc" do
      let(:arg){ lambda{ :hello } }
      it { should be_a(TupleExpression) }
      specify{
        expect(subject.evaluate(scope)).to eql(:hello)
        expect(subject.source).to be_nil
      }
    end

  end # TupleExpression
end # Alf
