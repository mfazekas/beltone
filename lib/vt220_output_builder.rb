class Vt220OutputBuilder

  CURSOR_DIRECTION = {:up => 'A',
                      :down => 'B',
                      :left => 'D',
                      :right => 'C', }

  ERASE_DIRECTIONS = {:to_end => '',
                      :to_beginning => '1',
                      :entire => '2', }

  ERASE_TYPES = {:line => 'K', :screen => 'J'}

  CURSOR_COMMAND = ['H', 'f'] #h and f at the end of a cursor command are equivalent


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

  def cursor_suffix
    CURSOR_COMMAND[rand 2]
  end

  def set_cursor(x, y)
    #all the beltone methods expect width, height vt220 actually uses height, width 
    @output << "\e[#{y};#{x}#{cursor_suffix}"
    self
  end

  def move_cursor(direction, delta = 1)
    @output << "\e[#{delta}#{CURSOR_DIRECTION[direction]}"
    self
  end

  def set_cursor_x position
    @output << "\e[#{position}G"
  end

  def home_cursor
    @output <<"\e[#{cursor_suffix}"
    self
  end

  def erase direction, type
    @output << "\e[#{ERASE_DIRECTIONS[direction]}#{ERASE_TYPES[type]}"
    self
  end

end