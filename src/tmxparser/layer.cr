require "./layer_data"

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
  end
end