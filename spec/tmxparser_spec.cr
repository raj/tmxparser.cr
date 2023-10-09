require "./spec_helper"

describe Tmxparser do
  # TODO: Write tests

  it "works" do
    true.should eq(true)
  end

  describe "#load" do
    it "load from file" do
      # maps = ["spec/fixtures/map_xml.tmx", "spec/fixtures/map-source-tileset.tmx"]
      # maps = ["spec/fixtures/map_xml.tmx", "spec/fixtures/map-source-tileset.tmx"]
      # maps = ["spec/fixtures/map_csv_unc.tmx"]
      maps = ["spec/fixtures/map-isometric-staggered.tmx"]
      maps.each do |map|
        tmx = Tmxparser.load_xml(map)
        # tmx.should be_a(Tmxparser::Map)
      end
      # tmx = Tmxparser.load_xml("spec/fixtures/map_xml.tmx")
      # tmx.should be_a(Tmxparser::Map)
    end

    it "decode data" do
      encoded_data = "eJzF0sEKACAIA1C1///nCApkTBtdCnZ7NDLDzAbEU9aJncoECbOd60y2ilOM6l7vOu9ijhnsYA5njsaJUd2tLzsv/hddt1cOXb/d2XWDWUxXtgF6"
      decoded_data = Tmxparser::Parser::LayerData.decompress_data(encoded_data, "zlib", "base64")
      expected = [2, 3, 3, 3, 3, 1, 1, 1, 0, 2, 2, 3, 3, 3, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 1, 1, 2, 2, 2, 2, 2, 3, 3, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 3, 3, 2, 2, 2, 2, 1, 2, 2, 3, 3, 2, 1, 2, 2, 2, 1, 2, 2, 3, 3, 1, 1, 1, 2, 1, 2, 2, 3, 1, 1, 1, 1, 2, 2, 1, 2, 2, 3, 1, 1, 1, 1, 2, 1, 2, 2, 3, 3, 1, 1, 1, 1, 2, 1, 1, 3, 3, 3, 1, 1, 1, 1, 2, 1, 3, 3, 3, 3, 1, 1, 1, 1, 2, 3, 3, 3, 3, 3, 1, 1, 1, 1, 2, 3, 3, 3, 3, 3, 1, 1, 1, 1, 2, 3, 3, 3, 3, 3, 1, 1, 1, 1, 2, 3, 3, 3, 3, 1, 0, 0, 1, 2, 2]
      result = decoded_data == expected
      result.should eq(true)
    end
  end
end
