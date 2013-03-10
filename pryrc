require 'awesome_print'

def debug
  require 'pry-debugger'
  require 'pry-stack_explorer'
rescue
  puts 'Failed to load debugger gems.'
end
