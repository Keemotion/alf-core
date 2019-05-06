require 'spec_helper'
module Alf
  describe Heading, "===" do

    let(:h){ Heading[name: String, status: Integer] }

    subject{ h===tuple }

    context 'on a conforming Hash' do
      let(:tuple){ {name: "Smith", status: 20} }

      it{ should be_truthy }
    end

    context 'on a conforming Tuple' do
      let(:tuple){ Tuple(name: "Smith", status: 20) }

      it{ should be_truthy }
    end

    context 'on a non conforming Hash (missing attributes)' do
      let(:tuple){ {name: "Smith"} }

      it{ should be_falsey }
    end

    context 'on a non conforming Hash (too many attributes)' do
      let(:tuple){ {name: "Smith", status: 20, city: "London"} }

      it{ should be_falsey }
    end

    context 'on a non conforming Hash (type mismatch)' do
      let(:tuple){ {name: "Smith", status: "20"} }

      it{ should be_falsey }
    end

  end
end
