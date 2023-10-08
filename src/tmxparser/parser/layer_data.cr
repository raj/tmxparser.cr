module Tmxparser::Parser
  struct LayerData

    def self.from_xml(element)
      encoding = element.attributes["encoding"].text
      compression = element.attributes["compression"].text
      data = element.text
      Tmxparser::LayerData.new(encoding, compression, data)
    end
  end
end