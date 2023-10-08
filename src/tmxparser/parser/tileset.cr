require "./image"

module Tmxparser::Parser
  struct Tileset

    def self.from_file(file_path : String)

      file_content = File.read(file_path)
      puts file_content
      result = from_simple_xml(XML.parse(file_content))
      puts result
      file_content
    end

    def self.from_simple_xml(xml : XML::Node)
      node = xml.xpath_nodes("//tileset").not_nil!.first


      name = node.attributes["name"].text
      tilewidth = node.attributes["tilewidth"].text.to_i
      tileheight = node.attributes["tileheight"].text.to_i
      spacing = node.attributes["spacing"].text.to_i
      # margin = node.attributes["margin"].text.to_i
      image_properties = node.xpath_nodes("//image").not_nil!
      tileset_images = image_properties.map do |image_property|
        Tmxparser::Parser::Image.from_xml(image_property)
      end
      puts name
      tile_properties = node.xpath_nodes("//tile").not_nil!
      puts tile_properties.size

      

      {
        name: name,
        tilewidth: tilewidth,
        tileheight: tileheight,
        spacing: spacing,
        images: tileset_images || [] of Tmxparser::Image,
      }
    end

    def self.from_xml(xml : XML::Node, path : String)
      firstgid = xml["firstgid"].to_i
      all_attributes = xml.attributes.map { |a| a.name }
      with_external_source = all_attributes.index("source")

      tileset_class = all_attributes.index("class") ? xml["class"] : ""
      
      if with_external_source
        source = xml["source"]
        from_file(Path.new(path, source).to_s)
      else
        name = xml["name"]
        tilewidth = xml["tilewidth"].to_i
        tileheight = xml["tileheight"].to_i
        spacing = xml["spacing"].to_i
        margin = xml["margin"].to_i
        image_properties = xml.xpath_nodes("//image").not_nil!
        tileset_images = image_properties.map do |image_property|
          Tmxparser::Parser::Image.from_xml(image_property)
        end
      end
      
      Tmxparser::Tileset.new(
        firstgid: firstgid,
        source: source,
        name: name,
        tilewidth: tilewidth,
        tileheight: tileheight,
        spacing: spacing,
        margin: margin,
        images: tileset_images || [] of Tmxparser::Image,
        tileset_class: tileset_class,
        tilecount: 0,
        columns: 0,
      )
    end
  end
end