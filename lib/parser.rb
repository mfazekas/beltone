require 'output_pattern'
require 'screen'
require 'translations'

class Parser
  attr_accessor :patterns

  def initialize screen
    @patterns = [
            OutputPattern.new('printable text', /^([ -~\t]+)/) { |text| screen.text text },
            OutputPattern.new('set cursor', /^\e\[(\d+);(\d+)[H|f]/) {|y, x| screen.set_cursor x.to_i - 1, y.to_i - 1 },
            OutputPattern.new('erase to end of line', /^\e\[(\d)*([K|J])/) {
                    |direction, type| screen.send "erase_#{ERASE_DIRECTIONS[direction.to_i]}_of_#{ERASE_TYPES[type]}" },
            OutputPattern.new('home', /^\e\[[H|f]/) { screen.home_cursor },
            OutputPattern.new('weird newline ?', /^\r\000/) { screen.new_line },
            OutputPattern.new('newline 1', /^\r\r\n/) { screen.new_line },
            OutputPattern.new('newline 2', /^\r\n/) { screen.new_line },
            OutputPattern.new('move cursor', /^\e\[(\d+)([A|B|C|D])/) {
                    |delta, direction| screen.send "move_cursor_#{CURSOR_DIRECTION[direction]}", delta.to_i },
            OutputPattern.new('set cursor x',/^\e\[(\d+)G/) {|position| screen.set_cursor_x position.to_i - 1},

            OutputPattern.new('ignored set expanded mode', /^\e\[\?(\d+)h/) {},
            OutputPattern.new('ignored scroll region', /^\e\[(\d;)*(\d)*r/) {},
            OutputPattern.new('ignored set rendition', /^\e\[(\d+;)*(\d+)*m/) {},
            OutputPattern.new('ignored reset mode', /^\e\[(\d;)*(\d)*l/) {},
            OutputPattern.new('ignored reset rxpanded mode', /^\e\[\?(\d;)*(\d)*l/) {},
            OutputPattern.new('ignored ASCII - g0', /^\e\(B/) {},
            OutputPattern.new('ignored application keypad', /^\e=/) {},
            OutputPattern.new('ignored ?', /^\e\[(\d+)d/) {},
            OutputPattern.new('ignored ?', /^\e\[(\d+)G/) {},
            OutputPattern.new('backspace', /^[\b]/) { screen.backspace }
    ]
    @non_matched = ""
  end

  def parse_token tokens
    rest_of_tokens = ""
    @patterns.each do |output_pattern|
      rest_of_tokens = output_pattern.match tokens
      return rest_of_tokens if rest_of_tokens
    end
    puts "didn't match: #{tokens}"
    #raise "didn't match '#{rest_of_tokens.inspect}' input:'#{tokens}'"
    nil
  end

  def read_tokens tokens
    loop do
      break if (tokens == '' || tokens == nil)
      tokens = parse_token(tokens)
    end
  end

end

#Copyright 2010 Michael Bain
#This file is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
#http://www.apache.org/licenses/LICENSE-2.0
#Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.