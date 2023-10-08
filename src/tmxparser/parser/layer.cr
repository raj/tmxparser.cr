require "./layer_data"

module Tmxparser::Parser
  struct Layer

    def self.from_xml(element)
      name = element.attributes["name"].text
      width = element.attributes["width"].text.to_i
      height = element.attributes["height"].text.to_i
      layer_data = Tmxparser::Parser::LayerData.from_xml element.xpath_nodes("//data").first
      Tmxparser::Layer.new(name, width, height, layer_data)
    end
  end
end