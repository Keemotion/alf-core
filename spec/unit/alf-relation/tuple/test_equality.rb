require 'spec_helper'
module Alf
  describe Tuple, 'equality' do

    let(:tuple){ Tuple[id: Integer].new(id: 12) }

    subject{ tuple == other }

    context 'on purely equal tuple' do
      let(:other){ Tuple[id: Integer].new(id: 12) }

      it{ should be_truthy }
    end

    context 'on equal tuple but a subtype' do
      let(:other){ Tuple[id: Integer].new(id: 12) }

      it{ should be_truthy }
    end

    context 'on equal tuple but a supertype' do
      let(:other){ Tuple[id: Numeric].new(id: 12) }

      it{ should be_truthy }
    end

  end
end
