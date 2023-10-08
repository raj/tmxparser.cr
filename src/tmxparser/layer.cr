module Tmxparser
  struct Layer
    property name : String
    property width : Int32
    property height : Int32
    property layer_data : LayerData?

    def initialize(name, width, height, data)
      @name = name
      @width = width
      @height = height
      @layer_data = data
    end

    def self.from_xml(element)
      name = element.attributes["name"].text
      width = element.attributes["width"].text.to_i
      height = element.attributes["height"].text.to_i
      layer_data = LayerData.from_xml element.xpath_nodes("//data").first
      Layer.new(name, width, height, layer_data)
    end
  end
end