require 'spec_helper'
module Alf
  module Support
    describe Scope, '__branch' do

      let(:scope) { Scope.new [ HelpersInScope ] }

      subject{ scope.__branch(arg) }

      context 'when branched with a Tuple' do
        let(:arg){ {:here => "here"} }

        it_behaves_like 'A scope'

        it 'responds to the tuple keys' do
          expect(subject.respond_to?(:here)).to be_truthy
          expect(subject.here).to eq("here")
        end

        it "responds to helper's methods" do
          expect(subject.respond_to?(:world)).to be_truthy
          expect(subject.world).to eq('world')
        end
      end

    end
  end
end
