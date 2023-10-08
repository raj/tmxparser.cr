require "./parser/map"

module Tmxparser
  struct Map
    property version : String
    property tiledversion : String?
    property map_class : String?
    property orientation : String
    property renderorder : String
    property compressionlevel : Int32? # nil means -1
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
      @renderorder = "right-down"
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
      map = Tmxparser::Parser::Map.load_from_xml(xml)
      puts map.version
      puts map
      map
    end
  end
end