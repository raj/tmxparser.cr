module Tmxparser
  struct Image
    property source : String
    property width : Int32
    property height : Int32

    def initialize(source, width, height)
      @source = source
      @width = width
      @height = height
    end
  end
end