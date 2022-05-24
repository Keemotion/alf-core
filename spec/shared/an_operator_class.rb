shared_examples_for "An operator class" do

  it "should have a public rubycase_name method" do
    expect(operator_class).to respond_to(:rubycase_name)
  end

  it "should have an arity class method" do
    expect(operator_class).to respond_to(:arity)
  end

  it "should have a unary? class method" do
    expect(operator_class).to respond_to(:unary?)
  end

  it "should have a binary? class method" do
    expect(operator_class).to respond_to(:binary?)
  end

  it "should have a nullary? class method" do
    expect(operator_class).to respond_to(:nullary?)
  end

  it "should have relational? and non_relational? methods" do
    expect(operator_class).to respond_to(:relational?)
    expect(operator_class).to respond_to(:non_relational?)
  end

  it "arity should be consistent with nullary?, unary?, binary?" do
    case operator_class.arity
    when 0
      expect(operator_class).to be_nullary
    when 1
      expect(operator_class).to be_unary
    when 2
      expect(operator_class).to be_binary
    else
      raise "Unexpected arity #{operator_class.arity} (#{operator_class})"
    end
  end

  it "should implement unary? and binary? consistently" do
    op = operator_class
    expect(op.nullary? || op.unary? || op.binary?).to be_truthy
    expect(op.nullary? && op.unary?).to be_falsey
    expect(op.nullary? && op.binary?).to be_falsey
    expect(op.unary? && op.binary?).to be_falsey
  end

end
