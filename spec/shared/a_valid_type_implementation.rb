shared_examples_for "A valid type implementation" do

  it 'should have exemplars available' do
    expect(type.exemplars).to_not be_empty
    type.exemplars.each do |value|
      expect((type === value)).to be_truthy
    end
  end

  it 'should define dupable values' do
    type.exemplars.each do |ex|
      expect(ex.dup).to eq(ex)
      expect(ex.dup.object_id).to_not eq(ex.object_id)
    end
  end

  it 'should define values that appear same in arrays' do
    type.exemplars.each do |ex|
      expect([ex, ex.dup, ex].uniq).to eq([ex])
    end
  end

  it 'should define values with correct hash codes' do
    type.exemplars.each do |ex|
      expect(ex.dup.hash).to eq(ex.hash)
    end
  end

  it 'should define values that can be used as Hash keys' do
    type.exemplars.each do |ex|
      expect({ex => 1, ex.dup => 2}.size).to eq(1)
    end
  end

  it 'should define values respecting the :to_ruby_literal spec' do
    type.exemplars.each do |ex|
      begin
        expect(Kernel.eval(ex.to_ruby_literal)).to eq(ex)
      rescue NotImplementedError
      end
    end
  end

end
