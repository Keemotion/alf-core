require 'spec_helper'
module Alf
  describe "Support#coerce" do

    it 'coerces integers without trouble' do
      expect(Support.coerce("12", Integer)).to eql(12)
    end

    it 'coerces Time without trouble' do
      expect(Support.coerce("2012-05-11 12:00:00.000000+0200", Time)).to be_a(Time)
    end

    it 'coerces DateTime without trouble' do
      expect(Support.coerce("2012-05-11 12:00:00.000000+0200", DateTime)).to be_a(DateTime)
    end

    it 'should raise a TypeError in case of error' do
      expect(lambda{
        Support.coerce("abc", Integer)
      }).to raise_error(TypeError)
    end

  end
end
