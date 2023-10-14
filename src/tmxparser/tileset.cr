require "./image"

module Tmxparser
  struct Tile
    property id : Int32
    property properties : Array(Hash(String, String))
    
    def initialize(
      @id,
      @properties = [] of Hash(String, String)
    )
    end
  end

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
    

    def initialize(
      @firstgid,
      @source,
      @name,
      @tileset_class,
      @tilewidth,
      @tileheight,
      @spacing,
      @margin,
      @tilecount,
      @columns,
      @objectalignment = "unspecified",
      @tilerendersize = "tile",
      @fillmode = "stretch",
      @images = [] of Image,
      @tiles = [] of Tile
    )
    end
  end
end