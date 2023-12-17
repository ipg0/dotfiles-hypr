#!/usr/share/rvm/rubies/ruby-3.1.2/bin/ruby
# frozen_string_literal: true

require 'json'

dump = `pw-dump`

# fix weird behaviour of pw-dump spitting out invalid JSON
invalid_idx = /\](\s*)\[/.match(dump)&.offset 1

# slice! does the opposite
dump = dump.slice 0..invalid_idx[0] unless invalid_idx.nil?

@pw_nodes = JSON.parse(dump)

def get_client(stream)
  id = stream["info"]&.[]("props")&.[]("client.id")
  @pw_nodes.find do |node|
    node["id"] == id
  end&.[]("info")&.[]("props")&.[]("application.name") || "Unknown"
end

# screen capture clients
# for some reason, web camera clients don't have this media class,
# which is handy
video_streams = @pw_nodes.filter do |node|
  node["info"]&.[]("props")&.[]("media.class") == 'Stream/Input/Video'
end

# mic clients
audio_streams = @pw_nodes.filter do |node|
  node["info"]&.[]("props")&.[]("media.class") == 'Stream/Input/Audio'
end

# the webcam has its own light,
# and geolocation doesn't fucking work anyways,
# so that's probably enough

# now get clients from the same dump

result = {}

unless audio_streams.count.zero? && video_streams.count.zero?
  result["text"] = "Sharing #{
    '󰄘' unless video_streams.count.zero?
  }#{
    ' 󰍬' unless audio_streams.count.zero?
  }"
  
  result["tooltip"] = "#{
    video_streams.map do |stream|
      "#{get_client(stream)} 󰄘"
    end.join "\n"
  }\n#{
    audio_streams.map do |stream|
      "#{get_client(stream)} 󰍬"
    end.join "\n"
  }"
end

puts JSON.unparse(result)
