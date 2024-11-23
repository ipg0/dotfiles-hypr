#!/bin/ruby
# frozen_string_literal: true

vpn_procs = `ps -e -o ucmd | grep -E 'xray|openvpn|wireguard'`

puts vpn_procs.empty? ? '' : 'Connected 󰖂'
# puts "#{active_vpn['name']} 󰖂\n#{active_vpn['name']}" if active_vpn
