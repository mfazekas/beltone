require 'output_pattern'

class Parser

  attr_accessor :patterns

  def initialize
    @patterns = [OutputPattern.new('text', /^([^\e\016\017]+)/) { |text| puts "text = '#{text}'" },
                 OutputPattern.new('set cursor', /^\e\[(\d+);(\d+)[H|f]/) { |y, x| puts "setting cursor to #{x},#{y}" }
    ]
  end

  def parse_token tokens
    @patterns.each do |output_pattern|
      rest_of_tokens = output_pattern.match tokens
      return rest_of_tokens unless rest_of_tokens == false
    end
    return nil
  end

  def read_tokens tokens
    loop do
      tokens = parse_token(tokens)
      break unless tokens
    end

  end

end