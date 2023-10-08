require "compress/zlib"
require "compress/gzip"
require "base64"

module Tmxparser::Parser
  struct LayerData

    def self.from_xml(element : XML::Node)
      encoding = element.attributes["encoding"].text
      compression = element.attributes["compression"].text
      data = decompress_data(element.text, compression, encoding)
      # puts "Decompressed data: #{data}"
      Tmxparser::LayerData.new(encoding, compression, data)
    end


    def self.decompress_data(raw_data : String, compression : String, encoding : String) : String
      clean_data = raw_data.lstrip.rstrip
      # puts "Decompressing data with #{encoding} and #{compression}"
      # puts "Raw data: #{clean_data}"
      if encoding == "base64" && compression == "zlib"
        return unpack_to_u32(inflate(clean_data)).join(",")
      else
        puts "Unknown encoding #{encoding} or compression #{compression}"
        return "error"
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


    def self.inflate(data : String) : String
      encoded_data = Base64.decode_string(data)
      # puts "Encoded data: #{encoded_data}"

      io = IO::Memory.new(encoded_data.to_slice)

      Compress::Zlib::Reader.open(io, &.gets_to_end)
    end


    def self.unpack_to_u32(input : String)
      nums = [] of UInt32 # This is a temporary store
      io = IO::Memory.new

      input.bytes.each_slice(4) do |this_slice|
          if this_slice.size == 4
            this_slice.map do |num|
              io.write_bytes num.to_u32, IO::ByteFormat::LittleEndian
            end
          end
      end
      # nums
      io.rewind
      io.to_s.bytes
    end
  end
end