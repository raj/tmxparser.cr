module Tmxparser
  struct LayerData
    property encoding : String
    property compression : String
    property data : String

    def initialize(encoding, compression, data)
      @encoding = encoding
      @compression = compression
      @data = data
    end

    def self.from_xml(element)
      encoding = element.attributes["encoding"].text
      compression = element.attributes["compression"].text
      data = element.text
      LayerData.new(encoding, compression, data)
    end
  end
end