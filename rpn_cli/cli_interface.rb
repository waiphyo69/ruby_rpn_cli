require_relative 'interface.rb'
require 'colorize'

class CliInterface < Interface
  def prompt
    print '> '
  end

  def parse_input
    input = gets.chomp.strip
  end

  def display(content)
    print content.colorize(content_color) + "\n"
  end

  def error(message)
    print "Error: #{message}".colorize(error_color) + "\n"
  end
end
