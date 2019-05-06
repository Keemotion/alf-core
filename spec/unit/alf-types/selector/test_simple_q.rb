require 'spec_helper'
module Alf
  describe Selector, "simple?" do

    subject{ selector.simple? }

    context 'on a single' do
      let(:selector){ Selector.coerce(:name) }

      it { should be_truthy }
    end

    context 'on a composite' do
      let(:selector){ Selector.coerce([:a, :name]) }

      it { should be_falsey }
    end

  end
end
