require 'spec_helper'
describe Alf, '.connect' do

  it "recognizes an existing folder" do
    db = Alf.connect(File.dirname(__FILE__))
    expect(db).to be_kind_of(Alf::Database::Connection)
  end

  it "recognizes an existing folder through a Path instance" do
    db = Alf.connect(Path.dir)
    expect(db).to be_kind_of(Alf::Database::Connection)
  end

  it 'yields the connection if a block and returns its result' do
    seen = nil
    res  = Alf.connect(Path.dir) do |db|
      expect(db).to be_kind_of(Alf::Database::Connection)
      seen = db
      12
    end
    expect(res).to eq(12)
    expect(seen).to_not be_nil
  end

end
