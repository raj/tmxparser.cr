module Tmxparser
  class Image
    property source : String
    property width : Int32
    property height : Int32

    def initialize(source, width, height)
      @source = source
      @width = width
      @height = height
    end

    def self.from_xml(element)
      source = element.attributes["source"].text
      width = element.attributes["width"].text.to_i
      height = element.attributes["height"].text.to_i
      Image.new(source, width, height)
    end
  end
end