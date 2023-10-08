require "json"
require "xml"
require "./tmxparser/*"

module Tmxparser
  VERSION = "0.1.0"

  def self.load_xml(path)
    Tmxparser::Map.load_from_xml(File.read(path))
  end
end

