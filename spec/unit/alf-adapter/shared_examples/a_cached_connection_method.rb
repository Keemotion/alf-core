shared_examples_for 'a cached connection method' do

  let(:connection){
    meth = connection_method
    Class.new(Alf::Adapter::Connection) do
      define_method(meth) do |name|
        raise unless @seen.nil?
        @seen = [ name ]
      end
    end.new(nil)
  }
  let(:cached)     { Alf::Adapter::Connection::SchemaCached.new(connection) }
  let(:relvar_name){ :a_relvar_name }
  let(:expected)   { [relvar_name]  }

  def subject
    cached.send(connection_method, relvar_name)
  end

  it 'delegates the call to the connection' do
    expect(subject).to eq(expected)
  end

  it 'does caches the result' do
    expect(subject).to eq(expected)
    expect(subject).to eq(expected)
    expect(subject).to eq(expected)
  end

end
