module Tmxparser::Parser
  struct Map
    def self.load_from_xml(map_xml : String) : Tmxparser::Map
      document = XML.parse(map_xml)
      map_prs = document.xpath_nodes("//map").not_nil!
      
      map = Tmxparser::Map.new
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

      map_layers = document.xpath_nodes("//map/layer").not_nil!
      puts map_layers
      # map.layers = map_layers.map do |layer|
      #   Layer.from_xml(layer)
      # end

      # puts "version : #{map.version}"
      # puts "orientation : #{map.orientation}"
      # puts "tilewidth : #{map.tilewidth}"
      # puts "tileheight : #{map.tileheight}"
      # puts "width : #{map.width}"
      # puts "height : #{map.height}"
      # puts "layers : #{map.layers}"
      # puts "properties : #{map.properties}"
      # puts "tilesets : #{map.tilesets}"
      map
      #   JSON.parse(File.read(@file_path)).as(Map)
      

    end
  end
end