require "./image"

module Tmxparser::Parser
  struct Tileset

    def self.from_xml(xml : XML::Node)
      firstgid = xml["firstgid"].to_i
      all_attributes = xml.attributes.map { |a| a.name }
      with_external_source = all_attributes.index("source")
      
      if with_external_source
        source = xml["source"]
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
        tileset_class: "Tileset",
        tilecount: 0,
        columns: 0,
      )
    end
  end
end