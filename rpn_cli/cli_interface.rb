require_relative 'interface.rb'
require 'colorize'

class CliInterface < Interface

  INITIAL_PROMPT = '> '

  def prompt
    print INITIAL_PROMPT
  end

  def parse_input
    input = $stdin.gets.chomp.strip
  end

  def display(content)
    print content.colorize(content_color) + "\n"
  end

  def error(message)
    print "Error: #{message}".colorize(error_color) + "\n"
  end
end
