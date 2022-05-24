shared_examples_for "A value" do

  it "should have a inspect/class.parse that lead to equal values" do
    expect(Kernel.eval(subject.inspect)).to eq(subject)
  end

  it "should act a valid Hash keys" do
     dup = Kernel.eval(subject.inspect)
     expect({subject => true, dup => false}.size).to eq(1)
  end

end
