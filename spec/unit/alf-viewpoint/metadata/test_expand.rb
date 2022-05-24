require 'spec_helper'
module Alf
  module Viewpoint
    describe Metadata, ".reduce" do

      subject{ metadata.expand }

      let(:metadata) do
        @base  = base  = viewpoint{ }
        @user  = user  = viewpoint{ expects(base) }
        @util1 = util1 = viewpoint{ expects(base);  depends(:user, user) }
        @util2 = util2 = viewpoint{ expects(util1); depends(:user, user) }
        @term  = viewpoint{ expects(util2) }
        @term.metadata
      end

      it 'should be a Metadata' do
        expect(subject).to be_kind_of(Metadata)
      end

      it 'should have expected expectations' do
        expect(subject.expectations).to eq([ @base, @util1, @util2 ])
      end

      it 'should have expected dependencies' do
        expect(subject.dependencies).to eq(user: [ @user ])
      end

    end
  end
end
