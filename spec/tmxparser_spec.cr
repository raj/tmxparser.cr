require "./spec_helper"

describe Tmxparser do
  describe "#load tmx" do
    all_files = [
      "example.tmx", # content for all api
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

  # describe "#load json" do
  #   it "works" do
  #     true.should eq(true)
  #   end
  # end

  describe "#load api" do
    it "works" do
      map = Tmxparser.load_xml("spec/fixtures/example.tmx")
      map.layers.size.should eq 6
      map.layers.first.name.should eq "Testing Name 1"
      map.tilesets.size.should eq 2
      map.tilesets.first.name.should eq "tmw_desert_spacing"
      animation_tileset = map.tilesets.last
      animation_tileset.tiles.size.should eq 1
      # test animation
      animation_tileset = map.tilesets.last
      animation_tileset.name.should eq "torches"
      animation_tileset.tiles.last.animations.size.should eq 1
      animation_tileset.tiles.last.animations.first.frames.size.should eq 4
      # puts animation_tileset.tiles.last.animations.inspect

    end
  end
end
