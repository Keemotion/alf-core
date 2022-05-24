shared_examples_for "an optimizable expression for restrict" do

  let(:restriction){
    restrict(subject, predicate)
  }

  let(:optimized){
    Alf::Optimizer::Restrict.new.call(restriction)
  }

  let(:middle){
    optimized.operand
  }

  let(:inside){
    middle.operand
  }

  # before(:all) do
  #   puts "\n--------"
  #   puts Support.to_lispy(restriction)
  #   puts Support.to_lispy(optimized)
  # end

  specify "optimized leads to a restrict[initial[restrict[...]]]" do
    expect(optimized).to be_kind_of(Alf::Algebra::Restrict)
    expect(middle).to be_kind_of(subject.class)
    expect(inside).to be_kind_of(Alf::Algebra::Restrict)
  end

  specify "middle's signature is kept unchanged" do
    expect(middle.signature.collect_on(subject)).to eq(subject.signature.collect_on(subject))
  end

  specify "first restriction only applies on split attributes" do
    expect(optimized.predicate.free_variables).to eq(split_attributes)
  end

end
