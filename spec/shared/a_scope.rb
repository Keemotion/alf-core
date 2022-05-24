shared_examples_for "A scope" do

  it 'responds to its own methods' do
    expect(subject.respond_to?(:respond_to?)).to be_truthy
    expect(subject.respond_to?(:evaluate)).to be_truthy
    expect(subject.respond_to?(:__eval_binding)).to be_truthy
  end

  it 'responds to needed kernel methods' do
    expect(subject.respond_to?(:lambda)).to be_truthy
  end

  it "responds to BasicObject's API" do
    expect(subject.respond_to?(:instance_eval)).to be_truthy
  end

  it 'does not respond to anything' do
    expect(subject.respond_to?(:anything_else)).to be_falsey
  end

end
