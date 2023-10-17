require "compress/zlib"
require "compress/gzip"
require "base64"

module Tmxparser::Parser
  struct LayerData

    def self.from_xml(element : XML::Node)
      encoding = element.attributes["encoding"].text
      all_element_attributes = element.attributes.map { |k| k.name }
      compression = all_element_attributes.includes?("compression") ? element.attributes["compression"].text : "none"
      data = decompress_data(element.text, compression, encoding)
      Tmxparser::LayerData.new(encoding, compression, data.join(","))
    end


    def self.decompress_data(raw_data : String, compression : String, encoding : String) : Array(UInt32)
      clean_data = raw_data.lstrip.rstrip
      if encoding == "base64" && compression == "zlib"
        return decompress_base64(clean_data)
      elsif encoding == "csv" && compression == "none"
        return clean_data.split(",").map { |d| d.to_u32 }
      else
        puts "Unknown encoding #{encoding} or compression #{compression}"
        return [UInt32.new(0)]
      end
      # io = IO::Memory.new

      # case encoding
      # when "csv"
      #   puts "Unknown encoding #{encoding}"
      # when "base64"
      #   # Base64.decode_string(raw_data.chomp)
      #   Base64.decode("eJxjYKAc9AJxHxXMwWWuCB3skwFiWSCWwyEvCcRSQCyNQ14PiPWB2ACHvDYQ6wCxLh43OCKxOZCwOFQsAEp3AnEXFv3BWMSMkNgw/fuB+ACUzUghVqUjFobSamji6Hx09fgwAPQOECE=", io)
      # else
      #   puts "Unknown encoding #{encoding}"
      # end
      
      # case compression
      # when "zlib"
      #   return Compress::Zlib::Reader.open(io) do |d| d.gets_to_end end
      # when "gzip"
      #   # return Compress::Gzip::Reader.open(String::Builder.new(decoded_data)) do |d| d.gets_to_end end
      #   return raw_data
      # when "zstd"
      #   return raw_data
      # else
      #   return raw_data
      # end
    end

    def self.decompress_base64(encoded_data) : Array(UInt32)
      nums = [] of UInt32
      decoded = Base64.decode_string(encoded_data)
      io = IO::Memory.new(decoded.to_slice)
      reader = Compress::Zlib::Reader.open(io, &.gets_to_end)
      reader.bytes.each_slice(4) do |this_slice|
        nums << this_slice.first.to_u32
      end
      nums
    end

  end
end