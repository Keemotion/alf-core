require 'spec_helper'
describe Alf, 'reader' do

  def reader(*args, &bl)
    Alf.reader(*args, &bl)
  end

  it 'supports a simple String' do
    expect(reader(File.expand_path('../example.rash', __FILE__))).to be_kind_of(Alf::Reader)
  end

  it 'supports a Path' do
    expect(reader(Path.dir/'example.rash')).to be_kind_of(Alf::Reader)
  end

  it 'supports a File' do
    (Path.dir/'example.rash').open('r') do |file|
      expect(reader(file)).to be_kind_of(Alf::Reader)
    end
  end

end
