require "./layer_data"

module Tmxparser::Parser
  struct Image
    def self.from_xml(element)
      source = element.attributes["source"].text
      width = element.attributes["width"].text.to_i
      height = element.attributes["height"].text.to_i
      Tmxparser::Image.new(source, width, height)
    end
  end
end