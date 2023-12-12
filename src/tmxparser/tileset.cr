require "./image"

module Tmxparser

  struct AnimationFrame
    property tileid : Int32
    property duration : Int32
    def initialize(
      @tileid,
      @duration
    )
    end
  end

  struct Animation
    property frames : Array(AnimationFrame)
    def initialize(
      @frames = [] of AnimationFrame
    )
    end
  end


  struct Tile
    property id : Int32
    property properties : Array(Hash(String, String))
    property animations : Array(Animation)
    # add object_group : ObjectGroup?

    def initialize(
      @id,
      @properties = [] of Hash(String, String),
      @animations = [] of Animation
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
    property tiles : Array(Tile)
    

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