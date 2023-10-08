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

  enum StaggerAxis
    X
    Y

    def self.from_s(s : String) : StaggerAxis
      case s
      when "x"
        X
      when "y"
        Y
      else
        raise "Unknown stagger axis: #{s}"
      end
    end
  end

  enum StaggerIndex
    Even
    Odd

    def self.from_s(s : String) : StaggerIndex
      case s
      when "even"
        Even
      when "odd"
        Odd
      else
        raise "Unknown stagger index: #{s}"
      end
    end
  end
end