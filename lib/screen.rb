require 'cell'

class Screen

  attr_reader :content, :cursor_x, :cursor_y, :lines

  HEIGHT = 24
  WIDTH = 80

  def initialize
    @cursor_x = 0
    @cursor_y = 0
    erase_entire_of_screen
  end

  def set_cursor x, y = @cursor_y
    x = 0 unless (0...WIDTH).include?(x)
    y = 0 unless (0...HEIGHT).include?(y)

    @cursor_x = x
    @cursor_y = y
  end

  def move_cursor_right delta = 1
    set_cursor @cursor_x + delta 
  end

  def set_character character
    @lines[@cursor_x][@cursor_y].character= character
  end

  def text message
    message.each_byte do |char|
      set_character char.chr
      set_cursor @cursor_x + 1
    end
  end

  def line line
    output = ""
    @lines.each do |vertical_line|
      output << vertical_line[line].to_s
    end
    output
  end

  def home_cursor
    @cursor_x = 0
  end

  def new_line
    set_cursor 0, @cursor_y + 1
  end

  def erase_entire_of_screen
    @lines = Array.new

    WIDTH.times do
      vertical_line = Array.new
      HEIGHT.times do
        vertical_line << Cell.new
      end
      @lines << vertical_line
    end
  end

  def erase_to_end_of_line
    count = WIDTH - @cursor_x
    (0..count-1).each do |index|
      @lines[@cursor_x + index][@cursor_y].erase
    end
  end

  def display
    output = '#' * (WIDTH + 2) + "\n"
    (0..(HEIGHT - 1)).each do |y_index|
      output << "##{line y_index}#\n"
    end
    output << '#' * (WIDTH + 2)
    output
  end

  def to_s
    output = ''
    (0..(HEIGHT - 1)).each do |y_index|
      output << "#{line(y_index)}\n"
    end
    output
  end
end


