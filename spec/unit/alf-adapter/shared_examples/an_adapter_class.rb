shared_examples_for "an adapter class" do

  describe 'recognizes?' do

    it 'returns true on recognized connection specifications' do
      recognized_conn_specs.each do |c|
        expect(adapter_class.recognizes?(c)).to be_truthy
      end
    end
  end

  describe 'new' do

    it 'returns an instance on recognized connection specifications' do
      recognized_conn_specs.each do |c|
        expect(adapter_class.new(c)).to be_kind_of(adapter_class)
      end
    end
  end

end
