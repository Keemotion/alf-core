require 'spec_helper'
module Alf
  class Database
    describe Options, "merge" do

      let(:opts){ Options.new(schema_cache: true) }

      subject{ opts.merge(schema_cache: false) }

      it{ should be_a(Options) }

      it 'is not the original' do
        expect(subject).to_not be(opts)
      end

      it 'merges the new options' do
        expect(subject.schema_cache?).to eq(false)
      end

      it 'does not touch the original' do
        expect(opts.schema_cache?).to eq(true)
      end

    end
  end
end
