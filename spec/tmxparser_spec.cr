require "./spec_helper"

describe Tmxparser do
  # TODO: Write tests

  it "works" do
    true.should eq(true)
  end

  describe "#load" do
    it "load from file" do
      maps = ["spec/fixtures/map_xml.tmx", "spec/fixtures/map-source-tileset.tmx"]
      maps.each do |map|
        tmx = Tmxparser.load_xml(map)
        tmx.should be_a(Tmxparser::Map)
      end
      # tmx = Tmxparser.load_xml("spec/fixtures/map_xml.tmx")
      # tmx.should be_a(Tmxparser::Map)
    end
  end
end
