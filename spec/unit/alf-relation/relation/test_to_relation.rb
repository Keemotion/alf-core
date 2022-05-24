require 'spec_helper'
module Alf
  describe "Relation#to_relation" do

    let(:rel){ Relation(:sid => ['S1', 'S2', 'S3']) }

    subject{ rel.to_relation }

    it 'should return self' do
      expect(subject.object_id).to eq(rel.object_id)
    end

  end
end
