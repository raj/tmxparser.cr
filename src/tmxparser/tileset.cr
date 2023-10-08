module Tmxparser
  struct Tileset
    property firstgid : Int32
    property source : String?
    property name : String?
    property tileset_class : String?
    property tilewidth : Int32?
    property tileheight : Int32?
    property spacing : Int32? 
    property margin : Int32?
    property tilecount : Int32?
    property columns : Int32?
    property objectalignment : String
    property tilerendersize : String
    property fillmode : String
    property images : Array(Image)
    

    def initialize
      @firstgid = 0
      @objectalignment = "unspecified"
      @tilerendersize = "tile"
      @fillmode = "stretch"
      @images = [] of Image
    end

    def self.from_xml(xml : XML::Node)
      tileset = Tileset.new
      tileset.firstgid = xml["firstgid"].to_i
      all_attributes = xml.attributes.map { |a| a.name }
      puts all_attributes
      with_external_source = all_attributes.index("source")
      puts with_external_source

      if with_external_source
        tileset.source = xml["source"]
      else
        tileset.name = xml["name"]
        tileset.tilewidth = xml["tilewidth"].to_i
        tileset.tileheight = xml["tileheight"].to_i
        tileset.spacing = xml["spacing"].to_i
        tileset.margin = xml["margin"].to_i
        image_properties = xml.xpath_nodes("//image").not_nil!
        tileset.images = image_properties.map do |image_property|
          Image.from_xml(image_property)
        end
      end
      
      tileset
    end
  end
end