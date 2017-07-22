module RpnCli
  class CliInterface < RpnCli::Interface

    def parse_input
      gets.chomp.strip
    end

    def display(content)
      puts content.colorize(content_color)
    end

    def error(message)
      puts 'Error: #{message}'.colorize(error_color)
    end
  end
end
