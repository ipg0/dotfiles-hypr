#!/usr/share/rvm/rubies/ruby-3.1.2/bin/ruby
# frozen_string_literal: true

require 'json'

ICON_MUTED = '󰍭'
ICON = '󰍬'

pw_string = `wpctl get-volume @DEFAULT_AUDIO_SOURCE@`

values = pw_string.split

puts values[2] == '[MUTED]' ? ICON_MUTED : "#{(values[1].to_f * 100).to_i}% #{ICON}"

# get current default source/sink
default = `pactl get-default-source`.chomp

# get all available sources/sinks
sources = JSON.parse(
  `pactl --format json list sources`
)

current = sources.find do |source|
  source['name'] == default
end

puts current&.[]('description')
