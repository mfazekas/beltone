class Vt220OutputBuilder

  CURSOR_DIRECTION_TO_COMMAND = {:up => 'A',
                                 :down => 'B',
                                 :left => 'D',
                                 :right => 'C',}

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

  def move_cursor(direction, delta=1)
    @output << "\e[#{delta}#{CURSOR_DIRECTION_TO_COMMAND[direction]}"
    self
  end



end