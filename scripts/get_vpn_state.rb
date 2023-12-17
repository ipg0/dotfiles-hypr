#!/usr/share/rvm/rubies/ruby-3.1.2/bin/ruby
# frozen_string_literal: true

require 'json'

connections = JSON.parse(`nmcli connection show --active | jc --nmcli`)

active_vpn = connections&.find { |conn| conn['type'] == 'vpn' }

puts "#{active_vpn['name']} 󰖂\n#{active_vpn['name']}" if active_vpn
