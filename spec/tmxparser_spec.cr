require "./spec_helper"

describe Tmxparser do
  describe "#load tmx" do
    all_files = [
      # "example.tmx",
      # "map_csv.tmx",
      # "map_gzip.tmx",
      # "map_uncompressed.tmx",
      # "map_xml.tmx",
      # "map_zlib.tmx",
      # "map-isometric-staggered.tmx",
      # "map-source-tileset.tmx",
      "sample-map.tmx"
    ]
    maps = all_files.map { |file| "spec/fixtures/#{file}" }
    maps.each do |map|
      it "load from file #{map}" do
        tmx = Tmxparser.load_xml(map)
        tmx.should be_a(Tmxparser::Map)
      end
    end

    # it "decode data" do
    #   encoded_data = "eJzF0sEKACAIA1C1///nCApkTBtdCnZ7NDLDzAbEU9aJncoECbOd60y2ilOM6l7vOu9ijhnsYA5njsaJUd2tLzsv/hddt1cOXb/d2XWDWUxXtgF6"
    #   decoded_data = Tmxparser::Parser::LayerData.decompress_data(encoded_data, "zlib", "base64")
    #   expected = [2, 3, 3, 3, 3, 1, 1, 1, 0, 2, 2, 3, 3, 3, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 1, 1, 2, 2, 2, 2, 2, 3, 3, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 3, 3, 2, 2, 2, 2, 1, 2, 2, 3, 3, 2, 1, 2, 2, 2, 1, 2, 2, 3, 3, 1, 1, 1, 2, 1, 2, 2, 3, 1, 1, 1, 1, 2, 2, 1, 2, 2, 3, 1, 1, 1, 1, 2, 1, 2, 2, 3, 3, 1, 1, 1, 1, 2, 1, 1, 3, 3, 3, 1, 1, 1, 1, 2, 1, 3, 3, 3, 3, 1, 1, 1, 1, 2, 3, 3, 3, 3, 3, 1, 1, 1, 1, 2, 3, 3, 3, 3, 3, 1, 1, 1, 1, 2, 3, 3, 3, 3, 3, 1, 1, 1, 1, 2, 3, 3, 3, 3, 1, 0, 0, 1, 2, 2]
    #   result = decoded_data == expected
    #   result.should eq(true)
    # end

    # TODO : test map attributes
  end

  describe "#load json" do
    it "works" do
      true.should eq(true)
    end
  end
end
