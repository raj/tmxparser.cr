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

    def source_destination_indexes(tileset : Tileset, orientation : Orientation, tick : UInt64 = 0) : Array(SourceDestination)
      source_tw = (tileset.tilewidth || 1)
      source_th = (tileset.tileheight || 1)
      tile_offset = 0

      # this works for tilesets with only one tile animation
      is_tileset_animations = tileset.tiles.size == 1 && tileset.tiles[0].animations.size > 0
      if is_tileset_animations
        animation_duration = tileset.tiles[0].animations.first.frames.map { |x| x.duration }.sum
        tick = tick % animation_duration
        duration_count = 0
        # frame_count = tileset.tiles[0].animations.first.frames
        # puts "frame_count: #{frame_count.inspect}"
        tileset.tiles[0].animations.first.frames.each do |frame|
          duration_count += frame.duration
          if tick <= duration_count
            break
          end
          tile_offset = frame.tileid
        end
      end

      all_source_destinations = [] of SourceDestination
      all_data
        .map { |x|
          tile_number = x == 0 ? 0 : x - tileset.firstgid.to_i + 1 + tile_offset
          tileset.source_rect_from_tilenumber(tile_number) 
        }
        .each_slice(@width).each_with_index do |row_textures, index_row|
          row_textures.each_with_index do |texture_source, index_col|
            next if texture_source[0] == -1
            source_rect = Rectangle.new(
              x: texture_source[0],
              y: texture_source[1],
              w: source_tw,
              h: source_th
            )
            if (orientation == Orientation::Isometric)
              destination_rect = Rectangle.new(
                x: (index_col - index_row) * (source_tw / 2).to_i,
                y: (index_col + index_row) * (source_th / 2).to_i,
                w: source_tw,
                h: source_th
              )
            elsif (orientation == Orientation::Orthogonal)
              # puts "Orthogonal index_col: #{index_col},  x: #{index_col * source_tw}, y: #{index_row * source_th}, w: #{source_tw}, h: #{source_th}"
              destination_rect = Rectangle.new(
                x: index_col * source_tw,
                y: index_row * source_th,
                w: source_tw,
                h: source_th
              )
            else
              raise "Unsupported orientation #{orientation}"
            end
            all_source_destinations << SourceDestination.new(source_rect, destination_rect)
          end
      end
      all_source_destinations
    end
  end
end
