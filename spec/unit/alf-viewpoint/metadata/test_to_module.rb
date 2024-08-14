require 'spec_helper'
module Alf
  module Viewpoint
    describe Metadata, "#to_module" do

      subject{ metadata.to_module }

      let(:metadata) do
        @base  = base = viewpoint{ }
        @user  = user = viewpoint{ expects(base) }
        @util1 = util = viewpoint{ expects(base); depends(:user, user) }
        @util2 = viewpoint{ expects(base); depends(:user, user) }
        @term  = viewpoint{ expects(util) }
        @term.metadata
      end

      it 'should be a Module' do
        expect(subject).to be_kind_of(Module)
      end

      it 'should include Alf::Viewpoint' do
        expect(subject).to include(Alf::Viewpoint)
      end

      it 'should include util1' do
        expect(subject).to include(@util1)
      end

      it 'should have a user method' do
        expect{
          subject.parser.user
        }.to_not raise_error
      end

    end
  end
end
