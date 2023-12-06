require "./layer_data"

module Tmxparser
  struct Rectangle
    property x : Int32
    property y : Int32
    property w : Int32
    property h : Int32

    def initialize(
      @x,
      @y,
      @w,
      @h
    )
    end
  end

  struct SourceDestination
    property source : Rectangle
    property destination : Rectangle

    def initialize(
      @source,
      @destination
    )
    end
  end

  struct Layer
    property name : String
    property width : Int32
    property height : Int32
    property layer_data : LayerData

    def initialize(
      @name,
      @width,
      @height,
      @layer_data
    )
    end

    def all_data
      layer_data.data.split(",").map { |x| begin x.to_i rescue 0 end }
    end

    def source_destination_indexes(
      tileset : Tileset,
      camera_x : Int32,
      camera_y : Int32,
      camera_width : Int32,
      camera_height : Int32,
      camera_zoom : Int32
    ) : Array(SourceDestination)

      source_tw = (tileset.tilewidth || 1)
      source_th = (tileset.tileheight || 1)

      all_source_destinations = [] of SourceDestination
      all_data
        .map { |x| source_rect_from_tilenumber(tileset,x) }
        .each_slice(@width).each_with_index do |row_textures, index_row|
          row_textures.each_with_index do |texture_source, index_col|
            next if texture_source[0] == -1
            source_rect = Rectangle.new(
              x: texture_source[0],
              y: texture_source[1],
              w: source_tw,
              h: source_th
            )

            dest_x = index_col * source_tw * camera_zoom
            dest_y = index_row * source_th * camera_zoom
            destination_rect = Rectangle.new(
              x: dest_x - camera_x,
              y: dest_y - camera_y,
              w: source_tw * camera_zoom,
              h: source_th * camera_zoom
            )
            all_source_destinations << SourceDestination.new(source_rect, destination_rect)
            # LibSDL.render_copy(@renderer, texture, pointerof(source_rect), pointerof(destination_rect))
          end
      end
      all_source_destinations
    end

    def source_rect_from_tilenumber(tileset : Tileset, tile_number : Int32) : Array(Int32) # [Int32, Int32]
      image_width = tileset.images.first.width
      if (tile_number == 0)
        return [-1, -1]
      end
      columns = ((image_width + (tileset.spacing || 0)) / ((tileset.tilewidth || 1) + (tileset.spacing || 0))).to_i
      position_x = tile_number % columns == 0 ? columns : tile_number % columns
      position_x = tile_number <= columns ? tile_number : position_x
      position_y = tile_number % columns == 0 ? (tile_number / columns).to_i : (tile_number / columns).to_i + 1
      position_y = tile_number <= columns ? 1 : position_y
      [
        (position_x - 1) * (tileset.tilewidth || 1) + (position_x - 1) * (tileset.spacing || 0),
        (position_y - 1) * (tileset.tileheight || 1) + (position_y - 1) * (tileset.spacing || 0),
      ]
    end
  end
end
