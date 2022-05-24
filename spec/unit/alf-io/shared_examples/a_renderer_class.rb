shared_examples_for "a Renderer class" do

  it 'should be a subclass of Renderer' do
    expect(subject.ancestors).to include(Alf::Renderer)
  end

  it "has a default mime type" do
    expect(subject).to respond_to(:mime_type)
  end

  describe "an instance" do
    let(:renderer){ subject.new([{id: 1}]) }

    it 'renders and returns a buffer with #execute' do
      buf = ""
      expect(renderer.execute(buf)).to be(buf)
    end

    it 'returns a Enumerator with #each without block' do
      expect(renderer.each).to be_kind_of(Enumerator)
    end
  end

end
