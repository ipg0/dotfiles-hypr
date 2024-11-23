#!/bin/ruby
# frozen_string_literal: true

PROFILES = {
  'performance': '󰓅 Performance',
  'balanced': '󰾅 Balanced',
  'power-saver': '󰾆 Power saver'
}.freeze

ORDER = {
  'performance': 1,
  'balanced': 2,
  'power-saver': 3
}.freeze

current = `powerprofilesctl get`.chomp

# construct a wofi command and wait for user to respond
choice = `echo "#{
  PROFILES.keys.map do |profile|
    # a hack to order options in wofi
    if profile == current.intern
      "<!--#{ORDER[profile]}--><b>\uf42e #{PROFILES[profile]}</b>"
    else
      "<!--#{ORDER[profile]}-->#{PROFILES[profile]}"
    end
  end.join "\n"
}" | wofi --show dmenu -p "Select power profile" -O alphabetical --allow-markup`

# try to find the selected profile, matching by label,
# because wofi doesn't support passing values separately
selected = PROFILES.keys.find do |profile|
  "<!--#{ORDER[profile]}-->#{PROFILES[profile]}" == choice.chomp
end

# if selected option is not found, it means either:
# - that the user closed wofi without selecting an option
# - that the user chose the already selected option (inside the <b> tag)
# either way, the profile stays the same
unless selected.nil?
  # run a command to set the new profile
  `powerprofilesctl set "#{selected}"`
end
