shared_examples_for "an adapter" do

  describe 'connection' do
    subject{ adapter.connection }
    after  { subject.close      }

    it{ should be_a(Alf::Adapter::Connection) }
  end

  describe 'connect' do
    subject{ adapter.connect{|c| @seen = c} }

    it 'yields a connection object' do
      subject
      expect(@seen).to be_kind_of(Alf::Adapter::Connection)
    end

    it 'closes the connection afterwards' do
      subject
      expect(@seen).to be_closed
    end

    it 'closes the connection even in case of a failure' do
      expect{
        adapter.connect{|c|
          @seen = c
          raise ArgumentError, "connection closes on failure"
        }
      }.to raise_error(ArgumentError, "connection closes on failure")
      expect(@seen).to be_closed
    end
  end

end
