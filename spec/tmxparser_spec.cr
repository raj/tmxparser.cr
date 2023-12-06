require "./spec_helper"

describe Tmxparser do
  describe "#load tmx" do
    all_files = [
      "example.tmx",
      "map_csv.tmx",
      "map_gzip.tmx",
      "map_uncompressed.tmx",
      "map_xml.tmx",
      "map_zlib.tmx",
      "map-isometric-staggered.tmx",
      "map-source-tileset.tmx",
      "sample-map.tmx",
      "simple_test.tmx"
    ]
    maps = all_files.map { |file| "spec/fixtures/#{file}" }
    maps.each do |map|
      it "load from file #{map}" do
        tmx = Tmxparser.load_xml(map)
        tmx.should be_a(Tmxparser::Map)
      end
    end
  end

  describe "#load xml" do
    it "works" do
      map = Tmxparser.load_xml("spec/fixtures/sample-map.tmx")
      map.layers.size.should eq 2
      map.layers.first.name.should eq "Terrain"
    end
  end 

  describe "#load json" do
    it "works" do
      true.should eq(true)
    end
  end
end
