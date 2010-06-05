require 'cell'

class Screen

  attr_reader :content, :cursor_x, :cursor_y, :lines

  HEIGHT = 24
  WIDTH = 80

  def initialize
    @cursor_x = 0
    @cursor_y = 0
    @lines = Array.new

    WIDTH.times do
      vertical_line = Array.new
      HEIGHT.times do
        vertical_line << Cell.new
      end
      @lines << vertical_line
    end
  end

  def set_cursor x, y
    @cursor_x = x
    @cursor_y = y
  end

  def set_character character
    @lines[@cursor_x][@cursor_y].character= character
  end

  def text message
    message.each_byte do |char|
      set_character char.chr
      @cursor_x += +1
    end
  end

  def get_line line
    output = ""
    @lines.each do |vertical_line|
      output << vertical_line[line].to_s
    end
    output
  end

  def erase start, length, count

  end

  def erase_to_end_of_line
    count = WIDTH - @cursor_x
    (0..count-1).each do |index|
      @lines[@cursor_x + index][@cursor_y].erase
    end
  end

end