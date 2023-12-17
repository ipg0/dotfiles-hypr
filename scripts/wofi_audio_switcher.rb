#!/usr/share/rvm/rubies/ruby-3.1.2/bin/ruby
# frozen_string_literal: true

# no external dependencies btw
require 'json'
require 'optparse'

# will be set by option parser
# false: selecting default sink
# true: selecting default source
source_selector = false

# will be set by option parser
# only applicable to sources
# false: show all sources
# true: exclude sources with device.class = "monitor"
hide_monitors = false

# parse commandline options
OptionParser.new do |opts|
  opts.banner = "Usage: #{$PROGRAM_NAME} [--source]"

  opts.on(
    '-s',
    '--source',
    'Show source selector (otherwise shows a sink selector)'
  ) do |value|
    source_selector = value
  end

  opts.on(
    '-m',
    '--hide-monitors',
    'Hide monitor sources (sources with device.class = "monitor")'
  ) do |value|
    hide_monitors = value
  end
end.parse!

# get current default source/sink
default = `pactl get-default-#{source_selector ? 'source' : 'sink'}`.chomp

# get all available sources/sinks
options = JSON.parse(
  `pactl --format json list #{source_selector ? 'sources' : 'sinks'}`
)

# if flag is set, exclude all monitor sources from the list
if source_selector && hide_monitors
  options.reject! { |opt| opt['properties']['device.class'] == 'monitor' }
end

# construct a wofi command and wait for user to respond
choice = `echo "#{
  options.map do |option|
    if option['name'] == default
      # make the currently selected option appear in bold
      # and have a check mark next to it

      # also, since wofi doesn't respect the input ordering
      # and itself sorts either randomly (default) or alphabetically,
      # but completely disregarding the markup not being content (alphabetical),
      # the currently selected option will always be on top of the list
      "<b>\uf42e #{option['description']}</b>"
    else
      option['description']
    end
  end.join "\n"
}" | wofi --show dmenu -p "Select audio #{
  source_selector ? 'input' : 'output'
}" -O alphabetical --allow-markup`

# try to find the selected sink/source, matching by description,
# because wofi doesn't support passing values separately
selected = options.find do |option|
  option['description'] == choice.chomp
end

# if selected option is not found, it means either:
# - that the user closed wofi without selecting an option
# - that the user chose the already selected option (inside the <b> tag)
# either way, the default sink/source stays the same
unless selected.nil?
  # run a pactl command to set the new default
  `pactl set-default-#{
    source_selector ? 'source' : 'sink'
  } "#{selected['name']}"`
end
