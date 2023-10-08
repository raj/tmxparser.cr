require "./layer"
require "./tileset"

module Tmxparser::Parser
  struct Map
    def self.load_from_xml(map_xml : String) : Tmxparser::Map
      document = XML.parse(map_xml)
      map_prs = document.xpath_nodes("//map").not_nil!
      
      orientation = map_prs.first.attributes["orientation"].text
      version = map_prs.first.attributes["version"].text
      tilewidth = map_prs.first.attributes["tilewidth"].text.to_i
      tileheight = map_prs.first.attributes["tileheight"].text.to_i
      width = map_prs.first.attributes["width"].text.to_i
      height = map_prs.first.attributes["height"].text.to_i
      
      properties = document
        .xpath_nodes("//map/properties/property")
        .not_nil!
        .map do |property|
          { property.attributes["name"].text => property.attributes["value"].text }
        end

      tilesets = document
        .xpath_nodes("//map/tileset")
        .not_nil!
        .map do |tileset|
          Tmxparser::Parser::Tileset.from_xml(tileset)
        end

      layers = document
        .xpath_nodes("//map/layer")
        .not_nil!
        .map do |layer|
          Tmxparser::Parser::Layer.from_xml(layer)
        end

      Tmxparser::Map.new(
        version: map_prs.first.attributes["version"].text,
        tiledversion: "1.0.0",
        map_class: "map",
        orientation: orientation,
        renderorder: RenderOrder::RightDown,
        compressionlevel: 0,
        width: width,
        height: height,
        tilewidth: tilewidth,
        tileheight: tileheight,
        hexsidelength: 0,
        staggeraxis: "y",
        staggerindex: "odd",
        parallaxoriginx: 0,
        parallaxoriginy: 0,
        backgroundcolor: "#000000",
        nextlayerid: 1,
        nextobjectid: 1,
        infinite: false,
        properties: properties,
        tilesets: tilesets,
        layers: layers
      )

      # puts "version : #{map.version}"
      # puts "orientation : #{map.orientation}"
      # puts "tilewidth : #{map.tilewidth}"
      # puts "tileheight : #{map.tileheight}"
      # puts "width : #{map.width}"
      # puts "height : #{map.height}"
      # puts "layers : #{map.layers}"
      # puts "properties : #{map.properties}"
      # puts "tilesets : #{map.tilesets}"
      # map
      #   JSON.parse(File.read(@file_path)).as(Map)
      

    end
  end
end