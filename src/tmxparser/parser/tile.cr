module Tmxparser::Parser

  struct AnimationFrame
    def self.from_xml(xml : XML::Node) : Tmxparser::AnimationFrame
      Tmxparser::AnimationFrame.new(
        xml.attributes["tileid"].text.to_i,
        xml.attributes["duration"].text.to_i
      )
    end
  end

  struct Animation
    def self.from_xml(xml : XML::Node) : Tmxparser::Animation
      Tmxparser::Animation.new(
        xml.xpath_nodes("//frame").map do |frame|
          Tmxparser::Parser::AnimationFrame.from_xml(frame)
        end
      )
    end
  end
  
  struct Tile
    def self.from_xml(xml : XML::Node) : Tmxparser::Tile
      Tmxparser::Tile.new(
        xml.attributes["id"].text.to_i,
        xml
          .xpath_nodes("//properties/property")
          .map do |property|
            {property.attributes["name"].text => property.attributes["value"].text}
          end,
        xml.xpath_nodes("//animation").map do |animation|
          Tmxparser::Parser::Animation.from_xml(animation)
        end
      )
    end
  end
end
