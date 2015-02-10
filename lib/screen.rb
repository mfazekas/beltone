require 'cell'

class Screen

  attr_reader :content, :cursor_x, :cursor_y, :lines

  HEIGHT = 24
  WIDTH = 80

  def initialize(options={})
    @cursor_x = 0
    @cursor_y = 0
    @width = options[:width] || WIDTH
    @height = options[:height] || HEIGHT
    erase_entire_of_screen
  end

  def set_cursor x, y = @cursor_y
    x = 0 unless (0...@width).include?(x)
    y = 0 unless (0...@height).include?(y)

    @cursor_x = x
    @cursor_y = y
  end

  def set_cursor_x position
    set_cursor position
  end

  def move_cursor_right delta = 1
    set_cursor @cursor_x + delta 
  end

  def backspace
    set_character ' '
    set_cursor @cursor_x - 1
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
    byebug if line.nil?
    output = ""
    @lines.each do |vertical_line|
      output << vertical_line[line].to_s if  vertical_line[line]
      byebug unless  vertical_line[line]
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

    @width.times do
      vertical_line = Array.new
      @height.times do
        vertical_line << Cell.new
      end
      @lines << vertical_line
    end
    set_cursor 0, 0
  end

  def erase_to_end_of_line
    count = @width - @cursor_x
    (0..count-1).each do |index|
      @lines[@cursor_x + index][@cursor_y].erase
    end
  end

  def display
    output = '#' * (@width + 2) + "\n"
    (0..(@height - 1)).each do |y_index|
      output << "##{line y_index}#\n"
    end
    output << '#' * (@width + 2)
    output
  end

  def to_s
    output = ''
    (0..(@height - 1)).each do |y_index|
      output << "#{line(y_index)}\n"
    end
    output
  end
end

#Copyright 2010 Michael Bain
#This file is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
#http://www.apache.org/licenses/LICENSE-2.0
#Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.


