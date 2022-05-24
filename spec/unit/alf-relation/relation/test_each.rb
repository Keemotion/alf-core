require 'spec_helper'
module Alf
  describe "Relation#each" do

    let(:rel){ Relation(:sid => ['S1', 'S2', 'S3']) }

    it 'iterates tuples' do
      count = 0
      rel.each do |t|
        expect(t).to be_kind_of(Tuple)
        count += 1
      end
      expect(count).to eq(3)
    end

    it 'iterates tuples of exact same class' do
      clazz = nil
      rel.each do |t|
        clazz = t.class unless clazz
        expect(t.class.object_id).to eq(clazz.object_id)
      end
    end

  end
end
