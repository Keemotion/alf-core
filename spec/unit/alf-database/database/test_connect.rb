require 'spec_helper'
module Alf
  describe Database, 'connect' do

    context 'without a block' do
      subject{ Database.connect(Path.dir) }

      it{ should be_a(Database::Connection) }

      it 'should not be closed' do
        expect(subject).to_not be_closed
      end
    end

    context 'with a block' do
      subject{
        Database.connect(Path.dir){|c|
          expect(c).to be_kind_of(Database::Connection)
          expect(c).to_not be_closed
          @seen = c
        }
      }

      it 'yields the block with a connection instance' do
        subject
        expect(@seen).to be_kind_of(Database::Connection)
      end

      it 'close the connection at the end' do
        subject
        expect(@seen).to be_closed
      end
    end

    context 'when passing options' do
      subject{ Database.connect(Path.dir, schema_cache: false) }

      it 'overrides default options' do
        expect(subject.schema_cache?).to eq(false)
      end
    end

  end
end
