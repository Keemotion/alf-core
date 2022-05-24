shared_examples_for "a Reader class" do

  it 'should be a subclass of Reader' do
    expect(described_class.ancestors).to include(Alf::Reader)
  end

  it "has a default mime type" do
    expect(described_class).to respond_to(:mime_type)
  end

  describe "an instance" do
    let(:reader){ described_class.new(StringIO.new("")) }

    it 'returns a Enumerator with #each without block' do
      expect(reader.each).to be_kind_of(Enumerator)
    end
  end

end
