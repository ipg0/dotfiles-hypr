#!/usr/share/rvm/rubies/ruby-3.1.2/bin/ruby
# frozen_string_literal: true

PROFILES = {
  'performance': "󰓅\nPerformance",
  'balanced': "󰾅\nBalanced",
  'power-saver': "󰾆\nPower saver"
}.freeze

puts PROFILES[`powerprofilesctl get`.chomp.intern]
