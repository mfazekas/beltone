class Vt220OutputBuilder

  CURSOR_DIRECTION = {:up => 'A',
                      :down => 'B',
                      :left => 'D',
                      :right => 'C', }

  ERASE_DIRECTIONS = {:to_end => '',
                      :to_beginning => '1',
                      :entire => '2', }

  ERASE_TYPES = {:line => 'K', :screen => 'J'}


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
    @output << "\e[#{delta}#{CURSOR_DIRECTION[direction]}"
    self
  end

  def erase direction, type
    @output << "\e[#{ERASE_DIRECTIONS[direction]}#{ERASE_TYPES[type]}"
  end

end