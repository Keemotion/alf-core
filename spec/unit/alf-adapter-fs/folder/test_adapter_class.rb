require 'spec_helper'
module Alf
  class Adapter
    describe Folder do

      let(:adapter_class){ Folder }

      let(:recognized_conn_specs) do
        [ File.dirname(__FILE__), Path.dir ]
      end

      it_should_behave_like "an adapter class"

      describe "recognizes?" do

        it 'is not be too permissive' do
          expect(Folder.recognizes?("not/an/existing/one")).to be_falsey
        end
      end

    end # describe Folder
  end # class Adapter
end # module Alf
