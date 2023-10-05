module Tmxparser
  class Map
    property version : String
    property orientation : String
    property tilewidth : Int32
    property tileheight : Int32
    property width : Int32
    property height : Int32
    property layers : Array(Hash(String, String))
    property properties : Array(Hash(String, String))
    property tilesets : Array(Tileset)

    def initialize
      @version = ""
      @orientation = ""
      @tilewidth = 0
      @tileheight = 0
      @width = 0
      @height = 0
      @layers = [] of Hash(String, String)
      @properties = [] of Hash(String, String)
      @tilesets = [] of Tileset
    end

    def self.load_from_xml(xml)
      document = XML.parse(xml)
      map_prs = document.xpath_nodes("//map").not_nil!
      
      
      map = Map.new
      map.orientation = map_prs.first.attributes["orientation"].text
      map.version = map_prs.first.attributes["version"].text
      map.tilewidth = map_prs.first.attributes["tilewidth"].text.to_i
      map.tileheight = map_prs.first.attributes["tileheight"].text.to_i
      map.width = map_prs.first.attributes["width"].text.to_i
      map.height = map_prs.first.attributes["height"].text.to_i

      map_properties = document.xpath_nodes("//map/properties/property").not_nil!
      map.properties = map_properties.map do |property|
        {property.attributes["name"].text => property.attributes["value"].text}
      end
      map_tilesets = document.xpath_nodes("//map/tileset").not_nil!
      # puts map_prs
      map.tilesets = map_tilesets.map do |tileset|
        Tileset.from_xml(tileset)
      end

      puts "version : #{map.version}"
      puts "orientation : #{map.orientation}"
      puts "tilewidth : #{map.tilewidth}"
      puts "tileheight : #{map.tileheight}"
      puts "width : #{map.width}"
      puts "height : #{map.height}"
      puts "layers : #{map.layers}"
      puts "properties : #{map.properties}"
      puts "tilesets : #{map.tilesets}"
      map
      #   JSON.parse(File.read(@file_path)).as(Map)
      
    end
  end
end