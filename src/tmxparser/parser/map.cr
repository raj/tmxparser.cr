require "./layer"
require "./tileset"

module Tmxparser::Parser
  struct Map
    def self.load_from_xml(map_xml : String) : Tmxparser::Map
      document = XML.parse(map_xml)
      node = document.xpath_nodes("//map").not_nil!
      all_map_attributes = node.first.attributes.map { |k| k.name }
      puts "all_map_attributes : #{all_map_attributes}"

      version = node.first.attributes["version"].text

      tiledversion =
        all_map_attributes.index("tiledversion") ? node.first.attributes["tiledversion"].text : "0.0.0"

      orientation = Orientation.from_s node.first.attributes["orientation"].text

      renderorder =
        all_map_attributes.index("renderorder") ? RenderOrder.from_s node.first.attributes["renderorder"].text : RenderOrder.from_s "right-down"

      compressionlevel =
        all_map_attributes.index("compressionlevel") ? node.first.attributes["compressionlevel"].text.to_i : nil

      tilewidth = node.first.attributes["tilewidth"].text.to_i
      tileheight = node.first.attributes["tileheight"].text.to_i
      width = node.first.attributes["width"].text.to_i
      height = node.first.attributes["height"].text.to_i

      hexsidelength =
        all_map_attributes.index("hexsidelength") ? node.first.attributes["hexsidelength"].text.to_i : nil

      staggeraxis =
        all_map_attributes.index("staggeraxis") ? StaggerAxis.from_s node.first.attributes["staggeraxis"].text : nil

      staggerindex =
        all_map_attributes.index("staggerindex") ? StaggerIndex.from_s node.first.attributes["staggerindex"].text : nil

      parallaxoriginx =
        all_map_attributes.index("parallaxoriginx") ? node.first.attributes["parallaxoriginx"].text.to_i : 0

      parallaxoriginy =
        all_map_attributes.index("parallaxoriginy") ? node.first.attributes["parallaxoriginy"].text.to_i : 0

      backgroundcolor =
        all_map_attributes.index("backgroundcolor") ? node.first.attributes["backgroundcolor"].text : "#000000"

      nextlayerid =
        all_map_attributes.index("nextlayerid") ? node.first.attributes["nextlayerid"].text.to_i : 1

      nextobjectid =
        all_map_attributes.index("nextobjectid") ? node.first.attributes["nextobjectid"].text.to_i : 1

      infinite =
        all_map_attributes.index("infinite") ? node.first.attributes["infinite"].text.to_i == 0 ? false : true : false

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
        version: node.first.attributes["version"].text,
        tiledversion: tiledversion,
        map_class: "map",
        orientation: orientation,
        renderorder: renderorder,
        compressionlevel: compressionlevel,
        width: width,
        height: height,
        tilewidth: tilewidth,
        tileheight: tileheight,
        hexsidelength: hexsidelength,
        staggeraxis: staggeraxis,
        staggerindex: staggerindex,
        parallaxoriginx: parallaxoriginx,
        parallaxoriginy: parallaxoriginy,
        backgroundcolor: backgroundcolor,
        nextlayerid: nextlayerid,
        nextobjectid: nextobjectid,
        infinite: infinite,
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
