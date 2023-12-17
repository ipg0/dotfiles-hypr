#!/usr/share/rvm/rubies/ruby-3.1.2/bin/ruby
# frozen_string_literal: true

OPTIONS = {
  'reboot': ' Reboot',
  'shutdown': '󰐥 Shutdown'
}.freeze

ORDER = {
  'reboot': 0,
  'shutdown': 1
}.freeze

# construct a wofi command and wait for user to respond
choice = `echo "#{
  OPTIONS.keys.map do |option|
    # a hack to order options in wofi
    "<!--#{ORDER[option]}-->#{OPTIONS[option]}"
  end.join "\n"
}" | wofi --show dmenu -p "Select an option" -O alphabetical --allow-markup`

# try to find the selected profile, matching by label,
# because wofi doesn't support passing values separately
selected = OPTIONS.keys.find do |option|
  "<!--#{ORDER[option]}-->#{OPTIONS[option]}" == choice.chomp
end

# if selected option is not found, it means either:
# - that the user closed wofi without selecting an option
# - that the user chose the already selected option (inside the <b> tag)
# either way, the profile stays the same
unless selected.nil?
  # run a command to set the new profile
  case selected
  when 'reboot'
    `reboot`
  when 'shutdown'
    `poweroff`
  end
end
