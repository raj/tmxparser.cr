require "./parser/map"
require "./tileset"
require "./image"
require "./layer"
require "./enums"

module Tmxparser
  struct Map
    property version : String
    property tiledversion : String?
    property map_class : String?
    property orientation : Orientation
    property renderorder : RenderOrder
    property compressionlevel : Int32? # nil means -1
    property width : Int32
    property height : Int32
    property tilewidth : Int32
    property tileheight : Int32
    property hexsidelength : Int32?
    property staggeraxis : StaggerAxis?
    property staggerindex : StaggerIndex?
    property parallaxoriginx : Int32
    property parallaxoriginy : Int32
    property backgroundcolor : String?
    property nextlayerid : Int32?
    property nextobjectid : Int32?
    property infinite : Bool
    property properties : Array(Hash(String, String))
    property tilesets : Array(Tileset)
    property layers : Array(Layer)

    def initialize(
      @version,
      @tiledversion,
      @map_class,
      @orientation,
      @renderorder,
      @compressionlevel,
      @width,
      @height,
      @tilewidth,
      @tileheight,
      @hexsidelength,
      @staggeraxis,
      @staggerindex,
      @parallaxoriginx,
      @parallaxoriginy,
      @backgroundcolor,
      @nextlayerid,
      @nextobjectid,
      @infinite,
      @properties,
      @tilesets,
      @layers
    )
    end

    def self.load_from_file(path : String) : Map
      puts "Loading map from #{path}"
      xml = File.read(path)
      map = Tmxparser::Parser::Map.load_from_xml(xml, Path[path].parent.to_s)
      puts map.version
      puts map
      map
    end
  end
end
