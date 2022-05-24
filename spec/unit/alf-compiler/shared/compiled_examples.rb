shared_examples_for 'a compiled' do

  it { should be_a(Alf::Compiler::Cog) }

  it 'should return self on to_cog' do
    expect(subject.to_cog).to be(subject)
  end

end

shared_examples_for 'a traceable compiled' do

  it_should_behave_like "a compiled"

  def has_tracking!(compiled)
    expect(compiled.expr).to_not be_nil
    case compiled
    when Alf::Engine::Leaf
      expect(compiled.expr).to be_kind_of(Alf::Algebra::Operand)
    when Alf::Engine::Cog
      expect(compiled.expr).to be_kind_of(Alf::Algebra::Operand)
      extract_operands(compiled).each do |op|
        has_tracking!(op)
      end
    else
      raise "Unexpected cog: #{compiled}"
    end
  end

  def extract_operands(compiled)
    return compiled.operands if compiled.respond_to?(:operands)
    return [compiled.operand] if compiled.respond_to?(:operand)
    []
  end

  it 'should have the compiler' do
    expect(subject.compiler).to be(compiler)
  end

  it 'should have traceability all way down expression' do
    has_tracking!(subject)
  end

end

shared_examples_for "a compiled not reusing a sub Sort" do

  it 'has a Sort as sub-cog' do
    expect(subject.operand).to be_kind_of(Alf::Engine::Sort)
    expect(subject.operand.ordering).to eq(ordering)
  end

  it 'has a Sort has sub-sub cog' do
    expect(subject.operand.operand).to be_kind_of(Alf::Engine::Sort)
    expect(subject.operand.operand.ordering).to be(subordering)
  end

  it 'has the leaf has sub-sub-sub cog' do
    expect(subject.operand.operand.operand).to be(leaf)
  end

end

shared_examples_for "a compiled based on an added sub Sort" do

  it 'has a Sort as sub-cog' do
    expect(subject.operand).to be_kind_of(Alf::Engine::Sort)
    expect(subject.operand.ordering).to eq(ordering)
  end

  it 'has the leaf has sub-sub cog' do
    expect(subject.operand.operand).to be(leaf)
  end

end

shared_examples_for "a compiled based on an added sub Sort with total ordering" do

  it 'has a Sort as sub-cog' do
    expect(subject.operand).to be_kind_of(Alf::Engine::Sort)
    expect(subject.operand.ordering).to eq(total_ordering)
  end

  it 'has the leaf has sub-sub cog' do
    expect(subject.operand.operand).to be(leaf)
  end

end

shared_examples_for "a compiled based on an added reversed Sort" do

  it 'has a Sort as sub-cog' do
    expect(subject.operand).to be_kind_of(Alf::Engine::Sort)
    expect(subject.operand.ordering).to eq(ordering.reverse)
  end

  it 'has the leaf has sub-sub cog' do
    expect(subject.operand.operand).to be(leaf)
  end

end

shared_examples_for "a compiled reusing a sub Sort" do

  it 'has the Sort as sub-cog' do
    expect(subject.operand).to be_kind_of(Alf::Engine::Sort)
    expect(subject.operand.ordering).to be(subordering)
    expect(subject.operand.operand).to be(leaf)
  end

end
