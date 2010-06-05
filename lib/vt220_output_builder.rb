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

  def set_cursor(x, y)
    #all the beltone methods expect width, height vt220 actually uses height, width 
    @output << "\e[#{y};#{x}H"
    self
  end

  def 

end