shared_examples_for "an adapter with readable cogs" do

  let(:connection){ adapter.connection }

  before do
    expect(connection).to be_kind_of(Alf::Adapter::Connection)
  end

  after do
    connection.close if connection
  end

  describe 'knows?' do

    it 'respond true to known cogs' do
      readable_cogs.each do |cog_name|
        expect(connection.knows?(cog_name)).to be_truthy
      end
    end
  end

  describe 'cog' do

    it 'returns a Cog instance' do
      readable_cogs.each do |cog_name|
        expect(connection.cog(nil, Alf::Algebra::Operand::Named.new(cog_name))).to be_kind_of(Alf::Engine::Cog)
      end
    end
  end

end
