class Vt220OutputBuilder

  def initialize
    @output = ""
  end

  def text text_to_output
    @output << text_to_output
    self
  end

  def to_s
    @output
  end

end