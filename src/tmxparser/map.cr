module Tmxparser
  struct Map
    property version : String
    property tiledversion : String?
    property map_class : String?
    property orientation : String
    property renderorder : RenderOrder
    property compressionlevel : Int32?
    property width : Int32
    property height : Int32
    property tilewidth : Int32
    property tileheight : Int32
    property hexsidelength : Int32?
    property staggeraxis : String?
    property staggerindex : String?
    property parallaxoriginx : Int32
    property parallaxoriginy : Int32
    property backgroundcolor : String?
    property nextlayerid : Int32?
    property nextobjectid : Int32?
    property infinite : Bool
    property properties : Array(Hash(String, String))
    property tilesets : Array(Tileset)
    property layers : Array(Layer)

    def initialize
      @version = ""
      @renderorder = RenderOrder::RightDown
      @orientation = ""
      @tilewidth = 0
      @tileheight = 0
      @width = 0
      @height = 0
      @parallaxoriginx = 0
      @parallaxoriginy = 0
      @infinite = false
      @properties = [] of Hash(String, String)
      @tilesets = [] of Tileset
      @layers = [] of Layer
    end

    def self.load_from_xml(xml : String) : Map
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
      map.tilesets = map_tilesets.map do |tileset|
        Tileset.from_xml(tileset)
      end

      # map_layers = document.xpath_nodes("//map/layer").not_nil!
      # map.layers = map_layers.map do |layer|
      #   Layer.from_xml(layer)
      # end

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