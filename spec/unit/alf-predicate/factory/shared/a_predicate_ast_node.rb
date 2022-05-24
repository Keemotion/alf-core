require 'spec_helper'
shared_examples_for "a predicate AST node" do

  it{ should be_a(Sexpr) }

  it{ should be_a(Alf::Predicate::Expr) }

  specify{
    expect((subject.tautology? == subject.is_a?(Alf::Predicate::Tautology))).to be_truthy
  }

  specify{
    expect((subject.contradiction? == subject.is_a?(Alf::Predicate::Contradiction))).to be_truthy
  }

  specify{
    expect(subject.free_variables).to be_kind_of(Alf::AttrList) unless subject.is_a?(Alf::Predicate::Native)
  }

end
