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
  end
end