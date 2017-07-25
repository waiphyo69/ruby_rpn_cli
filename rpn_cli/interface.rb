class Interface

  def initialize(content_color = :blue, error_color = :red)
    @content_color = content_color
    @error_color = error_color
  end

  def prompt
    raise NotImplementedError
  end

  def parse_input
    raise NotImplementedError
  end

  def display(content)
    raise NotImplementedError
  end

  def error(message)
    raise NotImplementedError
  end

  private
  attr_reader :content_color, :error_color
end
