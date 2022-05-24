shared_examples_for "a pass-through expression for restrict" do

  let(:the_predicate){
    defined?(predicate) ? predicate : Alf::Predicate.native(lambda{})
  }

  let(:restriction){
    restrict(subject, the_predicate)
  }

  let(:optimized){
    Alf::Optimizer::Restrict.new.call(restriction)
  }

  # before(:all) do
  #   puts Support.to_lispy(restriction)
  #   puts Support.to_lispy(optimized)
  # end

  specify "optimized leads to the initial operator" do
    expect(optimized).to be_kind_of(subject.class)
  end

  specify "optimized signature is unchanged" do
    expect(optimized.signature.collect_on(subject)).to eq(subject.signature.collect_on(subject))
  end

  specify "the restriction has been pushed with same predicate" do
    optimized.operands.each do |operand|
      expect(operand).to be_kind_of(Alf::Algebra::Restrict)
      repl = defined?(replaced_predicate) ? replaced_predicate : restriction.predicate
      expect(operand.predicate).to eq(repl)
    end
  end

end
