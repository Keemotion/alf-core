require 'spec_helper'
module Alf
  class Database
    describe Options, "install_options_from_hash" do

      let(:viewpoint){ Module.new{ include Viewpoint } }

      subject{ Options.new(h) }

      context 'when valid, coercable options with viewpoint' do
        let(:h){ {schema_cache: "false", viewpoint: viewpoint} }

        it 'sets the options as expected' do
          expect(subject.schema_cache?).to eq(false)
          expect(subject.viewpoint).to be(viewpoint)
          expect(subject.viewpoint).to be(viewpoint)
        end
      end

      context 'when valid, coercable options with viewpoint' do
        let(:h){ {schema_cache: "false", viewpoint: viewpoint} }

        it 'sets the options as expected' do
          expect(subject.schema_cache?).to eq(false)
          expect(subject.viewpoint).to be(viewpoint)
          expect(subject.viewpoint).to be(viewpoint)
        end
      end

      context 'when an option is not known' do
        let(:h){ {nosuchone: "blah"} }

        it 'raises an error' do
          expect(lambda{
            subject
          }).to raise_error(ConfigError, /No such option `nosuchone`/)
        end
      end

      context 'when an option cannot be coerced' do
        let(:h){ {schema_cache: "blah"} }

        it 'raises an error' do
          expect(lambda{
            subject
          }).to raise_error(ConfigError, /Invalid option value `schema_cache`: `blah`/)
        end
      end

      attr_writer :hello_world

      context 'when trying to cheat' do
        let(:h){ {hello_world: "blah"} }

        it 'raises an error' do
          expect(lambda{
            subject
          }).to raise_error(ConfigError, /No such option `hello_world`/)
        end
      end

    end
  end
end
