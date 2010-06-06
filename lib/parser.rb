require 'output_pattern'
require 'screen'
require 'translations'

class Parser
  attr_accessor :patterns

  def initialize screen
    @patterns = [
            OutputPattern.new('text', /^([^\e|\016|\017|\r]+)/) { |text| screen.text text },
            OutputPattern.new('set cursor', /^\e\[(\d+);(\d+)[H|f]/) { |y, x| screen.set_cursor x.to_i - 1, y.to_i - 1 },
            OutputPattern.new('erase to end of line', /^\e\[(\d)*([K|J])/) {
                    |direction, type| screen.send "erase_#{ERASE_DIRECTIONS[direction.to_i]}_of_#{ERASE_TYPES[type]}" },
            OutputPattern.new('home', /^\e\[[H|f]/) { screen.home_cursor },
            OutputPattern.new('weird newline ?', /^\r\000/) { screen.new_line },
            OutputPattern.new('move cursor', /^\e\[(\d+)([A|B|C|D])/) {
                    |delta, direction| screen.send "move_cursor_#{CURSOR_DIRECTION[direction]}", delta.to_i },
            OutputPattern.new('ignored set expanded mode', /^\e\[\?(\d+)h/) {},
            OutputPattern.new('ignored scroll region', /^\e\[(\d;)*(\d)*r/) {},
            OutputPattern.new('ignored set rendition', /^\e\[(\d+;)*(\d+)*m/) {},
            OutputPattern.new('ignored reset mode', /^\e\[(\d;)*(\d)*l/) {},
            OutputPattern.new('ignored reset rxpanded mode', /^\e\[\?(\d;)*(\d)*l/) {},
            OutputPattern.new('ignored ASCII - g0', /^\e\(B/) {},
            OutputPattern.new('ignored application keypad', /^\e=/) {},
            OutputPattern.new('ignored ?', /^\e\[(\d+)d/) {},
            OutputPattern.new('ignored ?', /^\e\[(\d+)G/) {},
    ]
    @non_matched = ""
  end

  def parse_token tokens
    rest_of_tokens = ""
    @patterns.each do |output_pattern|
      rest_of_tokens = output_pattern.match tokens
      return rest_of_tokens if rest_of_tokens
    end
    raise "didn't match '#{rest_of_tokens.inspect}'"
    nil
  end

  def read_tokens tokens
    loop do
      break if tokens == ''
      tokens = parse_token(tokens)
    end

  end

end