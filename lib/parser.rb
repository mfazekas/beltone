require 'output_pattern'
require 'screen'
require 'translations'

class Parser
  attr_accessor :patterns

  def initialize screen
    @patterns = [OutputPattern.new('text', /^([^\e\016\017]+)/) { |text| screen.text text },
                 OutputPattern.new('set cursor', /^\e\[(\d+);(\d+)[H|f]/) { |y, x| screen.set_cursor x.to_i, y.to_i },
                 OutputPattern.new('erase to end of line', /^\e\[(\d)*([K|J])/) {
                         |direction, type| screen.erase ERASE_DIRECTIONS[direction.to_i], ERASE_TYPES[type] },
    ]
  end

  def parse_token tokens
    rest_of_tokens = ""
    @patterns.each do |output_pattern|
      rest_of_tokens = output_pattern.match tokens

      return rest_of_tokens if rest_of_tokens
    end
    raise "didn't match '#{tokens}'"
    nil
  end

  def read_tokens tokens
    loop do
      break if tokens == ''
      tokens = parse_token(tokens)
    end

  end

end