module Tmxparser
  enum RenderOrder
    RightDown
    RightUp
    LeftDown
    LeftUp

    def self.from_s(s : String) : RenderOrder
      case s
      when "right-down"
        RightDown
      when "right-up"
        RightUp
      when "left-down"
        LeftDown
      when "left-up"
        LeftUp
      else
        raise "Unknown render order: #{s}"
      end
    end
  end

  enum Orientation
    Orthogonal
    Isometric
    Staggered
    Hexagonal

    def self.from_s(s : String) : Orientation
      case s
      when "orthogonal"
        Orthogonal
      when "isometric"
        Isometric
      when "staggered"
        Staggered
      when "hexagonal"
        Hexagonal
      else
        raise "Unknown orientation: #{s}"
      end
    end
  end
end