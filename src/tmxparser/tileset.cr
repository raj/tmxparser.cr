module Tmxparser
  class Tileset
    property firstgid : Int32
    property name : String
    property tilewidth : Int32
    property tileheight : Int32
    property spacing : Int32
    property margin : Int32
    property images : Array(Image)
    

    def initialize
      @tilewidth = 0
      @tileheight = 0
      @spacing = 0
      @margin = 0
      @firstgid = 0
      @name = ""
      @images = [] of Image
    end

    def self.from_xml(xml : XML::Node)
      tileset = Tileset.new
      tileset.firstgid = xml["firstgid"].to_i
      tileset.name = xml["name"]
      tileset.tilewidth = xml["tilewidth"].to_i
      tileset.tileheight = xml["tileheight"].to_i
      tileset.spacing = xml["spacing"].to_i
      tileset.margin = xml["margin"].to_i
      image_properties = xml.xpath_nodes("//image").not_nil!
      tileset.images = image_properties.map do |image_property|
        Image.from_xml(image_property)
      end
      tileset
    end
  end
end