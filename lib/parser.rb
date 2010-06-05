require 'output_pattern'

class Parser

 attr_accessor :patterns

  def initialize
    @patterns = [ OutputPattern.new('text', /^([^\e\016\017]+)/) { |text| puts text },
                  ]
  end

  def token tokens
    @patterns.each do | output_pattern |
      rest_of_tokens = output_pattern.match tokens
      return rest_of_tokens unless rest_of_tokens == false
    end
  end

end