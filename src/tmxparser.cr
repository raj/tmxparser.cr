require "json"
require "xml"
require "./tmxparser/map"

module Tmxparser
  VERSION = "0.1.0"

  def self.load_xml(path)
    Tmxparser::Map.load_from_file(path)
  end
end

