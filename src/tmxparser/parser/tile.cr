module Tmxparser::Parser
  struct Tile
    def self.from_xml(xml : XML::Node) : Tmxparser::Tile
      Tmxparser::Tile.new(
        xml.attributes["id"].text.to_i,
        xml
          .xpath_nodes("//properties/property")
          .map do |property|
            {property.attributes["name"].text => property.attributes["value"].text}
          end
      )
    end
  end
end
